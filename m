Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUDNR3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUDNR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:29:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41936 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264285AbUDNR3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:29:19 -0400
Date: Wed, 14 Apr 2004 10:28:02 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com, mhw@wittsend.com
Subject: Re: [PATCH 2.6.5] Add class support to drivers/char/ip2main.c
Message-ID: <126220000.1081963681@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20040413173406.6d62c782.rddunlap@osdl.org>
References: <116700000.1081902014@w-hlinder.beaverton.ibm.com> <20040413173406.6d62c782.rddunlap@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, April 13, 2004 05:34:06 PM -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

> * use consistent spacing (lines) before labels.  None needed here (before out_chrdev:).

Thanks for the comments Randy, I have made all the changes you suggested. I have 
also recompiled and tested this patch. Here it is.

Hanna Linder
IBM Linux Technology Center
------
diff -Nrup -Xdontdiff linux-2.6.5/drivers/char/ip2main.c linux-2.6.5p/drivers/char/ip2main.c
--- linux-2.6.5/drivers/char/ip2main.c	2004-04-03 19:38:27.000000000 -0800
+++ linux-2.6.5p/drivers/char/ip2main.c	2004-04-14 10:08:00.000000000 -0700
@@ -99,6 +99,7 @@
 #include <linux/slab.h>
 #include <linux/major.h>
 #include <linux/wait.h>
+#include <linux/device.h>
 
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -301,6 +302,9 @@ static int iindx;
 static char rirqs[IP2_MAX_BOARDS];
 static int Valid_Irqs[] = { 3, 4, 5, 7, 10, 11, 12, 15, 0};
 
+/* for sysfs class support */
+static struct class_simple *ip2_class;
+
 // Some functions to keep track of what irq's we have
 
 static int __init
@@ -411,7 +415,9 @@ cleanup_module(void)
 			iiResetDelay( i2BoardPtrTable[i] );
 			/* free io addresses and Tibet */
 			release_region( ip2config.addr[i], 8 );
+			class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i)); 
 			devfs_remove("ip2/ipl%d", i);
+			class_simple_device_remove(MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
 			devfs_remove("ip2/stat%d", i);
 		}
 		/* Disable and remove interrupt handler. */
@@ -420,6 +426,7 @@ cleanup_module(void)
 			clear_requested_irq( ip2config.irq[i]);
 		}
 	}
+	class_simple_destroy(ip2_class);
 	devfs_remove("ip2");
 	if ( ( err = tty_unregister_driver ( ip2_tty_driver ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister tty driver (%d)\n", err);
@@ -494,7 +501,7 @@ int
 ip2_loadmain(int *iop, int *irqp, unsigned char *firmware, int firmsize) 
 {
 	int i, j, box;
-	int err;
+	int err = 0;
 	int status = 0;
 	static int loaded;
 	i2eBordStrPtr pB = NULL;
@@ -683,7 +690,14 @@ ip2_loadmain(int *iop, int *irqp, unsign
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
@@ -700,13 +714,27 @@ ip2_loadmain(int *iop, int *irqp, unsign
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
@@ -759,8 +787,14 @@ retry:
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

