Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVLNVj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVLNVj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVLNVj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:39:26 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:49692 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S965005AbVLNVj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:39:26 -0500
Date: Wed, 14 Dec 2005 22:39:23 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, stelian@popies.net, kernel-stuff@comcast.net
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch driver
Message-ID: <20051214213923.GB17548@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch> <1134568620.3875.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134568620.3875.6.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for relayfs to the appletouch driver to make
debugging easier.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
---
Updated to make the relayfs parameter readonly.

diff -Npur linux-2.6.15-rc5.orig/Documentation/input/appletouch.txt linux-2.6.15-rc5/Documentation/input/appletouch.txt
--- linux-2.6.15-rc5.orig/Documentation/input/appletouch.txt	2005-12-13 00:09:24.000000000 +0100
+++ linux-2.6.15-rc5/Documentation/input/appletouch.txt	2005-12-13 21:28:26.000000000 +0100
@@ -77,6 +78,8 @@ full tracing (each sample is being trace
 		or
 	echo "1" > /sys/module/appletouch/parameters/debug
 
+To make debugging easier, the driver also supports the relayfs filesystem.
+
 Links:
 ------

diff -Npur linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.txt linux-2.6.15-rc5/drivers/usb/input/appletouch.txt
--- linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c	2005-12-13 00:09:24.000000000 +0100
+++ linux-2.6.15-rc5/drivers/usb/input/appletouch.c	2005-12-13 22:41:28.000000000 +0100
@@ -6,9 +6,18 @@
  * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
+ * Copyright (C) 2005      Parag Warudkar (parag.warudkar@gmail.com)
+ * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
+ * Nov 2005 - Parag Warudkar 
+ *  o Added ability to export data via relayfs
+ *
+ * Nov/Dec 2005 - Michael Hanselmann
+ *  o Compile relayfs support only if enabled in the kernel
+ *  o Enable relayfs only if requested by the user
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -35,6 +44,10 @@
 #include <linux/input.h>
 #include <linux/usb_input.h>
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+#include <linux/relayfs_fs.h>
+#endif
+
 /* Apple has powerbooks which have the keyboard with different Product IDs */
 #define APPLE_VENDOR_ID		0x05AC
 
@@ -57,6 +70,11 @@ static struct usb_device_id atp_table []
 };
 MODULE_DEVICE_TABLE (usb, atp_table);
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+struct rchan* rch = NULL;
+struct rchan_callbacks* rcb = NULL;
+#endif
+
 /* size of a USB urb transfer */
 #define ATP_DATASIZE	81
 
@@ -73,6 +91,7 @@ MODULE_DEVICE_TABLE (usb, atp_table);
 
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
+
 /*
  * multiplication factor for the X and Y coordinates.
  * We try to keep the touchpad aspect ratio while still doing only simple
@@ -124,7 +143,7 @@ struct atp {
 		if (debug) printk(format, ##a);				\
 	} while (0)
 
-MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
+MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Parag Warudkar, Michael Hanselmann");
 MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
 MODULE_LICENSE("GPL");
 
@@ -132,6 +151,12 @@ static int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+static int relayfs = 0;
+module_param(relayfs, int, 0444);
+MODULE_PARM_DESC(relayfs, "Activate relayfs support");
+#endif
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -194,6 +219,13 @@ static void atp_complete(struct urb* urb
 		goto exit;
 	}
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+	/* "rch" is NULL if relayfs is not enabled */
+	if (rch && dev->data) {
+		relay_write(rch, dev->data, dev->urb->actual_length);
+	}
+#endif
+
 	/* reorder the sensors values */
 	for (i = 0; i < 8; i++) {
 		/* X values */
@@ -463,11 +495,43 @@ static struct usb_driver atp_driver = {
 
 static int __init atp_init(void)
 {
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+	rcb = NULL;
+	rch = NULL;
+
+	if (relayfs) {
+		rcb = kmalloc(sizeof(struct rchan_callbacks), GFP_KERNEL);
+		if (!rcb)
+			return -ENOMEM;
+
+		rcb->subbuf_start = NULL;
+		rcb->buf_mapped = NULL;
+		rcb->buf_unmapped = NULL;
+
+		rch = relay_open("atpdata", NULL, 256, 256, NULL);
+		if (!rch) {
+			kfree(rcb);
+			return -ENOMEM;
+		}
+
+		printk("appletouch: Relayfs enabled.\n");
+	} else {
+		printk("appletouch: Relayfs disabled.\n");
+	}
+#endif
+
 	return usb_register(&atp_driver);
 }
 
 static void __exit atp_exit(void)
 {
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+	if(rch)
+		relay_close(rch);
+	if(rcb)
+		kfree(rcb);
+#endif
+
 	usb_deregister(&atp_driver);
 }
 
