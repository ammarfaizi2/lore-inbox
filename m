Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWCVPUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWCVPUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCVPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:20:33 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12932 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750776AbWCVPUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:20:31 -0500
Date: Wed, 22 Mar 2006 16:20:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: [patch 12/24] s390: remove dynamic dasd ioctls.
Message-ID: <20060322152058.GL5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[patch 12/24] s390: remove dynamic dasd ioctls.

Now that there are no more users of the awkward dynamic ioctl hack we
can remove the code to support it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_int.h   |   11 ------
 drivers/s390/block/dasd_ioctl.c |   69 ----------------------------------------
 2 files changed, 80 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-03-22 14:36:21.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-03-22 14:36:23.000000000 +0100
@@ -69,15 +69,6 @@
  */
 struct dasd_device;
 
-typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
-
-struct dasd_ioctl {
-	struct list_head list;
-	struct module *owner;
-	int no;
-	dasd_ioctl_fn_t handler;
-};
-
 typedef enum {
 	dasd_era_fatal = -1,	/* no chance to recover		     */
 	dasd_era_none = 0,	/* don't recover, everything alright */
@@ -524,8 +515,6 @@ int dasd_scan_partitions(struct dasd_dev
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
-int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
-int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
 long dasd_compat_ioctl(struct file *, unsigned int, unsigned long);
 
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-03-22 14:36:23.000000000 +0100
@@ -24,59 +24,6 @@
 
 #include "dasd_int.h"
 
-/*
- * SECTION: ioctl functions.
- */
-static struct list_head dasd_ioctl_list = LIST_HEAD_INIT(dasd_ioctl_list);
-
-/*
- * Find the ioctl with number no.
- */
-static struct dasd_ioctl *
-dasd_find_ioctl(int no)
-{
-	struct dasd_ioctl *ioctl;
-
-	list_for_each_entry (ioctl, &dasd_ioctl_list, list)
-		if (ioctl->no == no)
-			return ioctl;
-	return NULL;
-}
-
-/*
- * Register ioctl with number no.
- */
-int
-dasd_ioctl_no_register(struct module *owner, int no, dasd_ioctl_fn_t handler)
-{
-	struct dasd_ioctl *new;
-	if (dasd_find_ioctl(no))
-		return -EBUSY;
-	new = kmalloc(sizeof (struct dasd_ioctl), GFP_KERNEL);
-	if (new == NULL)
-		return -ENOMEM;
-	new->owner = owner;
-	new->no = no;
-	new->handler = handler;
-	list_add(&new->list, &dasd_ioctl_list);
-	return 0;
-}
-
-/*
- * Deregister ioctl with number no.
- */
-int
-dasd_ioctl_no_unregister(struct module *owner, int no, dasd_ioctl_fn_t handler)
-{
-	struct dasd_ioctl *old = dasd_find_ioctl(no);
-	if (old == NULL)
-		return -ENOENT;
-	if (old->no != no || old->handler != handler || owner != old->owner)
-		return -EINVAL;
-	list_del(&old->list);
-	kfree(old);
-	return 0;
-}
 
 static int
 dasd_ioctl_api_version(void __user *argp)
@@ -429,8 +376,6 @@ dasd_ioctl(struct inode *inode, struct f
 	struct block_device *bdev = inode->i_bdev;
 	struct dasd_device *device = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
-	struct dasd_ioctl *ioctl;
-	int rc;
 
 	if (!device)
                 return -ENODEV;
@@ -477,17 +422,6 @@ dasd_ioctl(struct inode *inode, struct f
 				return rval;
 		}
 
-		/* else resort to the deprecated dynamic ioctl list */
-		list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
-			if (ioctl->no == cmd) {
-				/* Found a matching ioctl. Call it. */
-				if (!try_module_get(ioctl->owner))
-					continue;
-				rc = ioctl->handler(bdev, cmd, arg);
-				module_put(ioctl->owner);
-				return rc;
-			}
-		}
 		return -EINVAL;
 	}
 }
@@ -503,6 +437,3 @@ dasd_compat_ioctl(struct file *filp, uns
 
 	return (rval == -EINVAL) ? -ENOIOCTLCMD : rval;
 }
-
-EXPORT_SYMBOL(dasd_ioctl_no_register);
-EXPORT_SYMBOL(dasd_ioctl_no_unregister);
