Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUB0Vg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUB0VeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:34:03 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:30896 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263136AbUB0Vdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:33:31 -0500
Date: Fri, 27 Feb 2004 19:22:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix tty drivers which dont set tty_driver->devfs_name
In-Reply-To: <20040227204817.A4877@infradead.org>
Message-ID: <Pine.LNX.4.58L.0402271912430.19454@logos.cnet>
References: <Pine.LNX.4.58L.0402271831080.19454@logos.cnet>
 <20040227204817.A4877@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, fix the drivers instead.

Agreed.

The following patches fixes tty drivers which dont set devfs_name. Not
doing so will cause the tty layer to create "/dev/<NULL>x" entries when
devfs is being used.

I used "drivername/" in isicom and pcxe because the letter used to
identify them are already used by other drivers.

Please apply.


diff -Nur linux-2.6.3.orig/drivers/char/cyclades.c linux-2.6.3-devfs/drivers/char/cyclades.c
--- linux-2.6.3.orig/drivers/char/cyclades.c	2004-02-24 17:51:48.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/cyclades.c	2004-02-27 19:12:22.812325016 -0300
@@ -5452,6 +5452,7 @@
     cy_serial_driver->owner = THIS_MODULE;
     cy_serial_driver->driver_name = "cyclades";
     cy_serial_driver->name = "ttyC";
+    cy_serial_driver->devfs_name = "tts/C";
     cy_serial_driver->major = CYCLADES_MAJOR;
     cy_serial_driver->minor_start = 0;
     cy_serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff -Nur linux-2.6.3.orig/drivers/char/epca.c linux-2.6.3-devfs/drivers/char/epca.c
--- linux-2.6.3.orig/drivers/char/epca.c	2004-02-24 17:51:49.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/epca.c	2004-02-27 19:02:04.632302664 -0300
@@ -1644,6 +1644,7 @@

 	pc_driver->owner = THIS_MODULE;
 	pc_driver->name = "ttyD";
+	pc_driver->devfs_name = "tts/D";
 	pc_driver->major = DIGI_MAJOR;
 	pc_driver->minor_start = 0;
 	pc_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff -Nur linux-2.6.3.orig/drivers/char/esp.c linux-2.6.3-devfs/drivers/char/esp.c
--- linux-2.6.3.orig/drivers/char/esp.c	2004-02-24 17:51:48.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/esp.c	2004-02-27 19:02:54.077785808 -0300
@@ -2498,6 +2498,7 @@

 	esp_driver->owner = THIS_MODULE;
 	esp_driver->name = "ttyP";
+	esp_driver->devfs_name = "tts/P";
 	esp_driver->major = ESP_IN_MAJOR;
 	esp_driver->minor_start = 0;
 	esp_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff -Nur linux-2.6.3.orig/drivers/char/isicom.c linux-2.6.3-devfs/drivers/char/isicom.c
--- linux-2.6.3.orig/drivers/char/isicom.c	2004-02-24 17:51:48.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/isicom.c	2004-02-27 19:05:07.553494416 -0300
@@ -1653,6 +1653,7 @@

 	isicom_normal->owner	= THIS_MODULE;
 	isicom_normal->name 	= "ttyM";
+	isicom_normal->devfs_name = "isicom/";
 	isicom_normal->major	= ISICOM_NMAJOR;
 	isicom_normal->minor_start	= 0;
 	isicom_normal->type	= TTY_DRIVER_TYPE_SERIAL;
diff -Nur linux-2.6.3.orig/drivers/char/moxa.c linux-2.6.3-devfs/drivers/char/moxa.c
--- linux-2.6.3.orig/drivers/char/moxa.c	2004-02-24 17:51:49.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/moxa.c	2004-02-27 19:05:55.203250552 -0300
@@ -304,6 +304,7 @@
 	init_MUTEX(&moxaBuffSem);
 	moxaDriver->owner = THIS_MODULE;
 	moxaDriver->name = "ttya";
+	moxaDriver->devfs_name = "tts/a";
 	moxaDriver->major = ttymajor;
 	moxaDriver->minor_start = 0;
 	moxaDriver->type = TTY_DRIVER_TYPE_SERIAL;
diff -Nur linux-2.6.3.orig/drivers/char/pcxx.c linux-2.6.3-devfs/drivers/char/pcxx.c
--- linux-2.6.3.orig/drivers/char/pcxx.c	2004-02-24 17:51:49.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/pcxx.c	2004-02-27 19:09:55.318747448 -0300
@@ -1145,6 +1145,7 @@

 	pcxe_driver->owner = THIS_MODULE;
 	pcxe_driver->name = "ttyD";
+	pcxe_driver->devfs_name = "pcxe/";
 	pcxe_driver->major = DIGI_MAJOR;
 	pcxe_driver->minor_start = 0;
 	pcxe_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff -Nur linux-2.6.3.orig/drivers/char/riscom8.c linux-2.6.3-devfs/drivers/char/riscom8.c
--- linux-2.6.3.orig/drivers/char/riscom8.c	2004-02-24 17:51:49.000000000 -0300
+++ linux-2.6.3-devfs/drivers/char/riscom8.c	2004-02-27 19:11:24.860135088 -0300
@@ -1696,6 +1696,7 @@
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	riscom_driver->owner = THIS_MODULE;
 	riscom_driver->name = "ttyL";
+	riscom_driver->devfs_name = "tts/L";
 	riscom_driver->major = RISCOM8_NORMAL_MAJOR;
 	riscom_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	riscom_driver->subtype = SERIAL_TYPE_NORMAL;

