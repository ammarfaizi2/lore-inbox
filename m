Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUCPBDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUCPAQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:16:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:19631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262894AbUCPACT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:19 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951472319@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:07 -0800
Message-Id: <10793951472400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.7, 2004/03/10 17:34:33-08:00, ogasawara@osdl.org

[PATCH] Add sysfs simple class support for netlink

Patch adds sysfs simple class support for netlink character device
(Major 36).  Feedback appreciated.  Thanks,


 net/netlink/netlink_dev.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)


diff -Nru a/net/netlink/netlink_dev.c b/net/netlink/netlink_dev.c
--- a/net/netlink/netlink_dev.c	Mon Mar 15 15:29:27 2004
+++ b/net/netlink/netlink_dev.c	Mon Mar 15 15:29:27 2004
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/bitops.h>
 #include <asm/system.h>
@@ -34,6 +35,7 @@
 
 static long open_map;
 static struct socket *netlink_user[MAX_LINKS];
+static struct class_simple *netlink_class;
 
 /*
  *	Device operations
@@ -229,17 +231,26 @@
 		return -EIO;
 	}
 
+	netlink_class = class_simple_create(THIS_MODULE, "netlink");
+	if (IS_ERR(netlink_class)) {
+		printk (KERN_ERR "Error creating netlink class.\n");
+		unregister_chrdev(NETLINK_MAJOR, "netlink");
+		return PTR_ERR(netlink_class);
+	}
+
 	devfs_mk_dir("netlink");
 
 	/*  Someone tell me the official names for the uppercase ones  */
 	for (i = 0; i < ARRAY_SIZE(entries); i++) {
 		devfs_mk_cdev(MKDEV(NETLINK_MAJOR, entries[i].minor),
 			S_IFCHR|S_IRUSR|S_IWUSR, "netlink/%s", entries[i].name);
+		class_simple_device_add(netlink_class, MKDEV(NETLINK_MAJOR, entries[i].minor), NULL, "%s", entries[i].name);
 	}
 
 	for (i = 0; i < 16; i++) {
 		devfs_mk_cdev(MKDEV(NETLINK_MAJOR, i + 16),
 			S_IFCHR|S_IRUSR|S_IWUSR, "netlink/tap%d", i);
+		class_simple_device_add(netlink_class, MKDEV(NETLINK_MAJOR, i + 16), NULL, "tap%d", i);
 	}
 
 	return 0;
@@ -249,11 +260,16 @@
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(entries); i++)
+	for (i = 0; i < ARRAY_SIZE(entries); i++) {
 		devfs_remove("netlink/%s", entries[i].name);
-	for (i = 0; i < 16; i++)
+		class_simple_device_remove(MKDEV(NETLINK_MAJOR, entries[i].minor));
+	}
+	for (i = 0; i < 16; i++) {
 		devfs_remove("netlink/tap%d", i);
+		class_simple_device_remove(MKDEV(NETLINK_MAJOR, i + 16));
+	}
 	devfs_remove("netlink");
+	class_simple_destroy(netlink_class);
 	unregister_chrdev(NETLINK_MAJOR, "netlink");
 }
 

