Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270565AbTGNMHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270571AbTGNMH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:07:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36740
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270565AbTGNME4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:04:56 -0400
Date: Mon, 14 Jul 2003 13:18:56 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141218.h6ECIuGP030848@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: run late loaded ide modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/ide/ide.c linux.22-pre5-ac1/drivers/ide/ide.c
--- linux.22-pre5/drivers/ide/ide.c	2003-07-14 12:27:35.000000000 +0100
+++ linux.22-pre5-ac1/drivers/ide/ide.c	2003-07-09 13:07:39.000000000 +0100
@@ -2221,6 +2221,7 @@
  */
 
 static __initdata ide_driver_call ide_scan[NUM_DRIVER];
+static int drivers_run = 0;
 
 void __init ide_register_driver(ide_driver_call scan)
 {
@@ -2228,6 +2229,11 @@
 	if(ide_scans == NUM_DRIVER)
 		panic("Too many IDE drivers");
 	ide_scan[ide_scans++]=scan;
+	if(drivers_run)
+	{
+		printk(KERN_ERR "ide: late registration of driver.\n");
+		scan();
+	}
 }
 
 EXPORT_SYMBOL(ide_register_driver);
@@ -2240,6 +2246,7 @@
 		(ide_scan[i])();
 		i++;
 	}
+	drivers_run = 1;
 }
 
 /*
