Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUBMTVS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUBMTVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:21:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:7578 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267183AbUBMTVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:21:16 -0500
Date: Fri, 13 Feb 2004 11:21:00 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Tommi Virtanen <tv@tv.debian.net>, Greg KH <greg@kroah.com>
Cc: Leann Ogasawara <ogasawara@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] propogate errors from misc_register to caller
Message-Id: <20040213112100.4f42abc2@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040213102755.27cf4fcd.shemminger@osdl.org>
References: <20040213102755.27cf4fcd.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch to check for / in class_device is not enough.
The misc_register function needs to check return value of the things it calls!

diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Fri Feb 13 11:15:29 2004
+++ b/drivers/char/misc.c	Fri Feb 13 11:15:29 2004
@@ -212,6 +212,9 @@
 int misc_register(struct miscdevice * misc)
 {
 	struct miscdevice *c;
+	struct class_device *class;
+	dev_t dev;
+	int err;
 	
 	down(&misc_sem);
 	list_for_each_entry(c, &misc_list, list) {
@@ -240,19 +243,30 @@
 		snprintf(misc->devfs_name, sizeof(misc->devfs_name),
 				"misc/%s", misc->name);
 	}
+	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-	class_simple_device_add(misc_class, MKDEV(MISC_MAJOR, misc->minor),
-				misc->dev, misc->name);
-	devfs_mk_cdev(MKDEV(MISC_MAJOR, misc->minor),
-			S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, misc->devfs_name);
+	class = class_simple_device_add(misc_class, dev,
+					misc->dev, misc->name);
+	if (IS_ERR(class)) {
+		err = PTR_ERR(class);
+		goto out;
+	}
+
+	err = devfs_mk_cdev(dev, S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, 
+			    misc->devfs_name);
+	if (err) {
+		class_simple_device_remove(dev);
+		goto out;
+	}
 
 	/*
 	 * Add it to the front, so that later devices can "override"
 	 * earlier defaults
 	 */
 	list_add(&misc->list, &misc_list);
+ out:
 	up(&misc_sem);
-	return 0;
+	return err;
 }
 
 /**
