Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUENXOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUENXOk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUENXOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:14:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:59868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264319AbUENXIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:14 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760411194@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <1084576042887@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.14, 2004/05/02 20:28:58-07:00, hannal@us.ibm.com

[PATCH] Add class support to drivers/char/ip2main.c


 drivers/char/ip2main.c |   44 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 39 insertions(+), 5 deletions(-)


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Fri May 14 15:59:27 2004
+++ b/drivers/char/ip2main.c	Fri May 14 15:59:27 2004
@@ -99,6 +99,7 @@
 #include <linux/slab.h>
 #include <linux/major.h>
 #include <linux/wait.h>
+#include <linux/device.h>
 
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -301,6 +302,9 @@
 static char rirqs[IP2_MAX_BOARDS];
 static int Valid_Irqs[] = { 3, 4, 5, 7, 10, 11, 12, 15, 0};
 
+/* for sysfs class support */
+static struct class_simple *ip2_class;
+
 // Some functions to keep track of what irq's we have
 
 static int __init
@@ -411,7 +415,9 @@
 			iiResetDelay( i2BoardPtrTable[i] );
 			/* free io addresses and Tibet */
 			release_region( ip2config.addr[i], 8 );
+			class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i)); 
 			devfs_remove("ip2/ipl%d", i);
+			class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
 			devfs_remove("ip2/stat%d", i);
 		}
 		/* Disable and remove interrupt handler. */
@@ -420,6 +426,7 @@
 			clear_requested_irq( ip2config.irq[i]);
 		}
 	}
+	class_simple_destroy(ip2_class);
 	devfs_remove("ip2");
 	if ( ( err = tty_unregister_driver ( ip2_tty_driver ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister tty driver (%d)\n", err);
@@ -494,7 +501,7 @@
 ip2_loadmain(int *iop, int *irqp, unsigned char *firmware, int firmsize) 
 {
 	int i, j, box;
-	int err;
+	int err = 0;
 	int status = 0;
 	static int loaded;
 	i2eBordStrPtr pB = NULL;
@@ -683,7 +690,14 @@
 	/* Register the IPL driver. */
 	if ( ( err = register_chrdev ( IP2_IPL_MAJOR, pcIpl, &ip2_ipl ) ) ) {
 		printk(KERN_ERR "IP2: failed to register IPL device (%d)\n", err );
-	} else
+	} else {
+		/* create the sysfs class */
+		ip2_class = class_simple_create(THIS_MODULE, "ip2");
+		if (IS_ERR(ip2_class)) {
+			err = PTR_ERR(ip2_class);
+			goto out_chrdev;	
+		}
+	}
 	/* Register the read_procmem thing */
 	if (!create_proc_info_entry("ip2mem",0,&proc_root,ip2_read_procmem)) {
 		printk(KERN_ERR "IP2: failed to register read_procmem\n");
@@ -700,13 +714,27 @@
 			}
 
 			if ( NULL != ( pB = i2BoardPtrTable[i] ) ) {
-				devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
+				class_simple_device_add(ip2_class, MKDEV(IP2_IPL_MAJOR, 
+						4 * i), NULL, "ipl%d", i);
+				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
 						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
 						"ip2/ipl%d", i);
+				if (err) {
+					class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 
+						4 * i));
+					goto out_class;
+				}
 
-				devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
+				class_simple_device_add(ip2_class, MKDEV(IP2_IPL_MAJOR, 
+						4 * i + 1), NULL, "stat%d", i);
+				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
 						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
 						"ip2/stat%d", i);
+				if (err) {
+					class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 
+						4 * i + 1));
+					goto out_class;
+				}
 
 			    for ( box = 0; box < ABS_MAX_BOXES; ++box )
 			    {
@@ -759,8 +787,14 @@
 		}
 	}
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_RETURN, 0 );
+	goto out;
 
-	return 0;
+out_class:
+	class_simple_destroy(ip2_class);
+out_chrdev:
+	unregister_chrdev(IP2_IPL_MAJOR, "ip2");
+out:
+	return err;
 }
 
 EXPORT_SYMBOL(ip2_loadmain);

