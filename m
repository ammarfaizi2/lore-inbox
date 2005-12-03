Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVLCMc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVLCMc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVLCMc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:32:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65028 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751246AbVLCMc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:32:28 -0500
Date: Sat, 3 Dec 2005 13:32:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/: fix the WIRELESS_EXT abuse
Message-ID: <20051203123229.GG31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using WIRELESS_EXT instead of CONFIG_NET_RADIO is simply ugly.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/core/dev.c       |   10 ++++------
 net/core/net-sysfs.c |    8 --------
 net/socket.c         |    9 +++------
 3 files changed, 7 insertions(+), 20 deletions(-)

--- linux-2.6.15-rc3-mm1/net/core/dev.c.old	2005-12-03 03:04:37.000000000 +0100
+++ linux-2.6.15-rc3-mm1/net/core/dev.c	2005-12-03 03:05:12.000000000 +0100
@@ -109,10 +109,8 @@
 #include <linux/netpoll.h>
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
-#ifdef CONFIG_NET_RADIO
-#include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
+#include <linux/wireless.h>
 #include <net/iw_handler.h>
-#endif	/* CONFIG_NET_RADIO */
 #include <asm/current.h>
 
 /*
@@ -2032,7 +2030,7 @@
 	.release = seq_release,
 };
 
-#ifdef WIRELESS_EXT
+#ifdef CONFIG_NET_RADIO
 extern int wireless_proc_init(void);
 #else
 #define wireless_proc_init() 0
@@ -2585,7 +2583,7 @@
 					ret = -EFAULT;
 				return ret;
 			}
-#ifdef WIRELESS_EXT
+#ifdef CONFIG_NET_RADIO
 			/* Take care of Wireless Extensions */
 			if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) {
 				/* If command is `set a parameter', or
@@ -2606,7 +2604,7 @@
 					ret = -EFAULT;
 				return ret;
 			}
-#endif	/* WIRELESS_EXT */
+#endif	/* CONFIG_NET_RADIO */
 			return -EINVAL;
 	}
 }
--- linux-2.6.15-rc3-mm1/net/core/net-sysfs.c.old	2005-12-03 03:05:22.000000000 +0100
+++ linux-2.6.15-rc3-mm1/net/core/net-sysfs.c	2005-12-03 03:06:55.000000000 +0100
@@ -306,7 +306,6 @@
 	.attrs  = netstat_attrs,
 };
 
-#ifdef WIRELESS_EXT
 /* helper function that does all the locking etc for wireless stats */
 static ssize_t wireless_show(struct class_device *cd, char *buf,
 			     ssize_t (*format)(const struct iw_statistics *,
@@ -366,7 +365,6 @@
 	.name = "wireless",
 	.attrs = wireless_attrs,
 };
-#endif
 
 #ifdef CONFIG_HOTPLUG
 static int netdev_uevent(struct class_device *cd, char **envp,
@@ -419,10 +417,8 @@
 	if (net->get_stats)
 		sysfs_remove_group(&class_dev->kobj, &netstat_group);
 
-#ifdef WIRELESS_EXT
 	if (net->get_wireless_stats)
 		sysfs_remove_group(&class_dev->kobj, &wireless_group);
-#endif
 	class_device_del(class_dev);
 
 }
@@ -452,7 +448,6 @@
 	    (ret = sysfs_create_group(&class_dev->kobj, &netstat_group)))
 		goto out_unreg; 
 
-#ifdef WIRELESS_EXT
 	if (net->get_wireless_stats &&
 	    (ret = sysfs_create_group(&class_dev->kobj, &wireless_group)))
 		goto out_cleanup; 
@@ -461,9 +456,6 @@
 out_cleanup:
 	if (net->get_stats)
 		sysfs_remove_group(&class_dev->kobj, &netstat_group);
-#else
-	return 0;
-#endif
 
 out_unreg:
 	printk(KERN_WARNING "%s: sysfs attribute registration failed %d\n",
--- linux-2.6.15-rc3-mm1/net/socket.c.old	2005-12-03 03:06:03.000000000 +0100
+++ linux-2.6.15-rc3-mm1/net/socket.c	2005-12-03 03:06:36.000000000 +0100
@@ -84,10 +84,7 @@
 #include <linux/compat.h>
 #include <linux/kmod.h>
 #include <linux/audit.h>
-
-#ifdef CONFIG_NET_RADIO
-#include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
-#endif	/* CONFIG_NET_RADIO */
+#include <linux/wireless.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -844,11 +841,11 @@
 	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		err = dev_ioctl(cmd, argp);
 	} else
-#ifdef WIRELESS_EXT
+#ifdef CONFIG_NET_RADIO
 	if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) {
 		err = dev_ioctl(cmd, argp);
 	} else
-#endif	/* WIRELESS_EXT */
+#endif	/* CONFIG_NET_RADIO */
 	switch (cmd) {
 		case FIOSETOWN:
 		case SIOCSPGRP:

