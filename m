Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUJTAbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUJTAbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270103AbUJTAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:31:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:8372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267283AbUJTATa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315061566@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <10982315062289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.9.8, 2004/09/29 16:14:12-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: schedule_timeout() issues.

Need to set current state and check signals.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/dscore.c    |   13 ++++++++++---
 drivers/w1/w1.c        |   20 +++++++++++++++-----
 drivers/w1/w1_family.c |   11 +++++++++--
 drivers/w1/w1_int.c    |   11 +++++++++--
 4 files changed, 43 insertions(+), 12 deletions(-)


diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2004-10-19 16:54:19 -07:00
+++ b/drivers/w1/dscore.c	2004-10-19 16:54:19 -07:00
@@ -727,11 +727,18 @@
 {
 	struct ds_device *dev;
 	
-	dev = usb_get_intfdata (intf);
-	usb_set_intfdata (intf, NULL);
+	dev = usb_get_intfdata(intf);
+	usb_set_intfdata(intf, NULL);
 
-	while(atomic_read(&dev->refcnt))
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting for DS to become free: refcnt=%d.\n",
+				atomic_read(&dev->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
 
 	usb_put_dev(dev->udev);
 	kfree(dev);
diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-10-19 16:54:19 -07:00
+++ b/drivers/w1/w1.c	2004-10-19 16:54:19 -07:00
@@ -449,8 +449,15 @@
 	
 	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
 
-	while (atomic_read(&sl->refcnt))
-		schedule_timeout(10);
+	while (atomic_read(&sl->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+				sl->name, atomic_read(&sl->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
 
 	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
 	device_remove_file(&sl->dev, &sl->attr_name);
@@ -507,8 +514,8 @@
 			 * All who don't sleep must send ID bit and COMPLEMENT ID bit.
 			 * They actually are ANDed between all senders.
 			 */
-			id_bit = w1_read_bit(dev);
-			comp_bit = w1_read_bit(dev);
+			id_bit = w1_touch_bit(dev, 1);
+			comp_bit = w1_touch_bit(dev, 1);
 
 			if (id_bit && comp_bit)
 				break;
@@ -539,7 +546,10 @@
 			 * and make all who don't have "search_bit" in "i"'th position
 			 * in it's registration number sleep.
 			 */
-			w1_write_bit(dev, search_bit);
+			if (dev->bus_master->touch_bit)
+				w1_touch_bit(dev, search_bit);
+			else
+				w1_write_bit(dev, search_bit);
 
 		}
 #endif
diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2004-10-19 16:54:19 -07:00
+++ b/drivers/w1/w1_family.c	2004-10-19 16:54:19 -07:00
@@ -84,8 +84,15 @@
 
 	spin_unlock(&w1_flock);
 
-	while (atomic_read(&fent->refcnt))
-		schedule_timeout(10);
+	while (atomic_read(&fent->refcnt)) {
+		printk(KERN_INFO "Waiting for family %u to become free: refcnt=%d.\n",
+				fent->fid, atomic_read(&fent->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
 }
 
 /*
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-10-19 16:54:19 -07:00
+++ b/drivers/w1/w1_int.c	2004-10-19 16:54:19 -07:00
@@ -181,8 +181,15 @@
 			 "%s: Failed to send signal to w1 kernel thread %d.\n",
 			 __func__, dev->kpid);
 
-	while (atomic_read(&dev->refcnt))
-		schedule_timeout(10);
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+				dev->name, atomic_read(&dev->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
 
 	msg.id.mst.id = dev->id;
 	msg.id.mst.pid = dev->kpid;

