Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160996AbWJDN7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbWJDN7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030846AbWJDN7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:59:06 -0400
Received: from havoc.gtf.org ([69.61.125.42]:9357 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030834AbWJDN7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:59:03 -0400
Date: Wed, 4 Oct 2006 09:58:19 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>, ecashin@coraid.com
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/block/aoe: handle sysfs errors
Message-ID: <20061004135819.GA29526@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/block/aoe/aoeblk.c |   64 +++++++++++++++++++++++++++++++++------------
 1 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 393b86a..04f9b03 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -64,13 +64,36 @@ static struct disk_attribute disk_attr_f
 	.show = aoedisk_show_fwver
 };
 
-static void
+static int
 aoedisk_add_sysfs(struct aoedev *d)
 {
-	sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
-	sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
-	sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
-	sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
+	int err;
+
+	err = sysfs_create_file(&d->gd->kobj, &disk_attr_state.attr);
+	if (err)
+		return err;
+
+	err = sysfs_create_file(&d->gd->kobj, &disk_attr_mac.attr);
+	if (err)
+		goto err_out_state;
+
+	err = sysfs_create_file(&d->gd->kobj, &disk_attr_netif.attr);
+	if (err)
+		goto err_out_mac;
+
+	err = sysfs_create_file(&d->gd->kobj, &disk_attr_fwver.attr);
+	if (err)
+		goto err_out_netif;
+
+	return 0;
+
+err_out_netif:
+	sysfs_remove_link(&d->gd->kobj, "netif");
+err_out_mac:
+	sysfs_remove_link(&d->gd->kobj, "mac");
+err_out_state:
+	sysfs_remove_link(&d->gd->kobj, "state");
+	return err;
 }
 void
 aoedisk_rm_sysfs(struct aoedev *d)
@@ -205,24 +228,18 @@ aoeblk_gdalloc(void *vp)
 	if (gd == NULL) {
 		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate disk "
 			"structure for %ld.%ld\n", d->aoemajor, d->aoeminor);
-		spin_lock_irqsave(&d->lock, flags);
-		d->flags &= ~DEVFL_GDALLOC;
-		spin_unlock_irqrestore(&d->lock, flags);
-		return;
+		goto err_out;
 	}
 
 	d->bufpool = mempool_create_slab_pool(MIN_BUFS, buf_pool_cache);
 	if (d->bufpool == NULL) {
 		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate bufpool "
 			"for %ld.%ld\n", d->aoemajor, d->aoeminor);
-		put_disk(gd);
-		spin_lock_irqsave(&d->lock, flags);
-		d->flags &= ~DEVFL_GDALLOC;
-		spin_unlock_irqrestore(&d->lock, flags);
-		return;
+		goto err_out_put;
 	}
 
 	spin_lock_irqsave(&d->lock, flags);
+
 	blk_queue_make_request(&d->blkq, aoeblk_make_request);
 	gd->major = AOE_MAJOR;
 	gd->first_minor = d->sysminor * AOE_PARTITIONS;
@@ -231,16 +248,29 @@ aoeblk_gdalloc(void *vp)
 	gd->capacity = d->ssize;
 	snprintf(gd->disk_name, sizeof gd->disk_name, "etherd/e%ld.%ld",
 		d->aoemajor, d->aoeminor);
-
 	gd->queue = &d->blkq;
+
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	if (aoedisk_add_sysfs(d))
+		goto err_out_put;
+
+	spin_lock_irqsave(&d->lock, flags);
 	d->gd = gd;
 	d->flags &= ~DEVFL_GDALLOC;
 	d->flags |= DEVFL_UP;
-
 	spin_unlock_irqrestore(&d->lock, flags);
 
 	add_disk(gd);
-	aoedisk_add_sysfs(d);
+
+	return;
+
+err_out_put:
+	put_disk(gd);
+err_out:
+	spin_lock_irqsave(&d->lock, flags);
+	d->flags &= ~DEVFL_GDALLOC;
+	spin_unlock_irqrestore(&d->lock, flags);
 }
 
 void
