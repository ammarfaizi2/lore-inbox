Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVFVFcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVFVFcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVFVFa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:30:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:38295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262752AbVFVFMR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:17 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Adds a default family so that new slave families will show up in sysfs.
In-Reply-To: <11194171271795@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <11194171272630@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Adds a default family so that new slave families will show up in sysfs.

Adds a default family so that new slave families will show up in sysfs.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 99c5bfe993af1af37ddd615e72207dc7220dc526
tree 922369315ceb918b8c4a8a8749a5547497033874
parent 2a9d0c178158da4a9bcf22311a414c26a8102d13
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sat, 04 Jun 2005 01:31:26 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:11 -0700

 drivers/w1/w1.c |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -59,6 +59,19 @@ static pid_t control_thread;
 static int control_needs_exit;
 static DECLARE_COMPLETION(w1_control_complete);
 
+/* stuff for the default family */
+static ssize_t w1_famdefault_read_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	return(sprintf(buf, "%s\n", sl->name));
+}
+static struct w1_family_ops w1_default_fops = {
+	.rname = &w1_famdefault_read_name,
+};
+static struct w1_family w1_default_family = {
+	.fops = &w1_default_fops,
+};
+
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
@@ -360,14 +373,16 @@ static int __w1_attach_slave_device(stru
 		return err;
 	}
 
-	err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
-	if (err < 0) {
-		dev_err(&sl->dev,
-			"sysfs file creation for [%s] failed. err=%d\n",
-			sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_unregister(&sl->dev);
-		return err;
+	if ( sl->attr_bin.read ) {
+		err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
+		if (err < 0) {
+			dev_err(&sl->dev,
+				"sysfs file creation for [%s] failed. err=%d\n",
+				sl->dev.bus_id, err);
+			device_remove_file(&sl->dev, &sl->attr_name);
+			device_unregister(&sl->dev);
+			return err;
+		}
 	}
 
 	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
@@ -403,12 +418,10 @@ static int w1_attach_slave_device(struct
 	spin_lock(&w1_flock);
 	f = w1_family_registered(rn->family);
 	if (!f) {
-		spin_unlock(&w1_flock);
+		f= &w1_default_family;
 		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
 			  rn->family, rn->family,
 			  (unsigned long long)rn->id, rn->crc);
-		kfree(sl);
-		return -ENODEV;
 	}
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
@@ -449,7 +462,9 @@ static void w1_slave_detach(struct w1_sl
 			flush_signals(current);
 	}
 
-	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	if ( sl->attr_bin.read ) {
+		sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	}
 	device_remove_file(&sl->dev, &sl->attr_name);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);

