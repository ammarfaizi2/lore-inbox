Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWEAUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWEAUnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWEAUnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:43:11 -0400
Received: from cicero2.cybercity.dk ([212.242.40.53]:7108 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S932248AbWEAUnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:43:09 -0400
Date: Mon, 1 May 2006 21:35:12 +0100 (BST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.rutgers.edu
cc: Neela Syam Kolli <Neela.Kolli@engenio.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH] MegaRAID driver management char device moved to misc
Message-ID: <Pine.LNX.4.40.0605012101470.18899-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MegaRAID driver's common management module (megaraid_mm.c) creates
a char device used by the management tool "megarc" from LSI Logic (and
possibly other management tools).

In 2.6 with udev, this device doesn't get created because it is not
registered in sysfs.

I first fixed this by registering a class "megaraid_mm", but realized
that this should probably be moved to misc devices, instead of taking
up a char major. This is because only 1 device is used, even if there
are multiple adapters - the minor is never used (the adapter info is
in the ioctl block sent to the driver, not detected based on the minor
number as one might think). So it is a complete waste to have an
entire major taken by this.

So it now uses a misc device which I named "megadev0" (the name that megarc
expects), and has a dynamic minor (previoulsy a dynamic major was used).

I have tested this on my own system with the megarc tool, and it works
just as fine as before (only now the device gets created correctly by
udev).

Please CC any replies to thomas dot horsten, at gmail.com, since my
main mailbox is flooded with spam and I'll probably not see your mail
if you're not in my whitelist.

Patch below:

diff -u linux-2.6.16.11/drivers/scsi/megaraid/megaraid_mm.c linux/drivers/scsi/megaraid/megaraid_mm.c
--- linux-2.6.16.11/drivers/scsi/megaraid/megaraid_mm.c	2006-04-24 21:20:24.000000000 +0100
+++ linux/drivers/scsi/megaraid/megaraid_mm.c	2006-05-01 21:22:41.000000000 +0100
@@ -59,7 +59,6 @@
 EXPORT_SYMBOL(mraid_mm_unregister_adp);
 EXPORT_SYMBOL(mraid_mm_adapter_app_handle);

-static int majorno;
 static uint32_t drvr_ver	= 0x02200206;

 static int adapters_count_g;
@@ -76,6 +75,12 @@
 	.owner	= THIS_MODULE,
 };

+static struct miscdevice megaraid_mm_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name   = "megadev0",
+	.fops   = &lsi_fops,
+};
+
 /**
  * mraid_mm_open - open routine for char node interface
  * @inod	: unused
@@ -1197,15 +1202,16 @@
 static int __init
 mraid_mm_init(void)
 {
+	int err;
+
 	// Announce the driver version
 	con_log(CL_ANN, (KERN_INFO "megaraid cmm: %s %s\n",
 		LSI_COMMON_MOD_VERSION, LSI_COMMON_MOD_EXT_VERSION));

-	majorno = register_chrdev(0, "megadev", &lsi_fops);
-
-	if (majorno < 0) {
-		con_log(CL_ANN, ("megaraid cmm: cannot get major\n"));
-		return majorno;
+	err = misc_register(&megaraid_mm_dev);
+	if (err < 0) {
+		con_log(CL_ANN, ("megaraid cmm: cannot register misc device\n"));
+		return err;
 	}

 	init_waitqueue_head(&wait_q);
@@ -1240,7 +1246,7 @@
 {
 	con_log(CL_DLEVEL1 , ("exiting common mod\n"));

-	unregister_chrdev(majorno, "megadev");
+	misc_deregister(&megaraid_mm_dev);
 }

 module_init(mraid_mm_init);
Only in linux/drivers/scsi/megaraid/: megaraid_mm.c.orig
Only in linux/drivers/scsi/megaraid/: megaraid_mm.c.th1
Only in linux/drivers/scsi/megaraid/: megaraid_mm.c~
diff -u linux-2.6.16.11/drivers/scsi/megaraid/megaraid_mm.h linux/drivers/scsi/megaraid/megaraid_mm.h
--- linux-2.6.16.11/drivers/scsi/megaraid/megaraid_mm.h	2006-04-24 21:20:24.000000000 +0100
+++ linux/drivers/scsi/megaraid/megaraid_mm.h	2006-05-01 21:12:33.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/list.h>
+#include <linux/miscdevice.h>

 #include "mbox_defs.h"
 #include "megaraid_ioctl.h"


