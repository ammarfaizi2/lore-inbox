Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVAHPsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVAHPsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVAHPsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:48:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:20411 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261195AbVAHPrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:47:42 -0500
X-Authenticated: #13409387
Message-ID: <41E07F55.8030803@gmx.net>
Date: Sat, 08 Jan 2005 16:48:21 -0800
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH-2.6.10] ide-lib printk readability fix
Content-Type: multipart/mixed;
 boundary="------------020005070803060102020306"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005070803060102020306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this improves logic and readability:
- remove blank from: AbortedCommand (as other flags)
- add blank and {} to error= line
- clean up: remove 2 lines and extra printk

before:
  hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
  hdd: status error: error=0x7fIllegalLengthIndication EndOfMedia 
Aborted Command MediaChangeRequested LastFailedSense 0x07


after:
  hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
  hdd: status error: error=0x7f { IllegalLengthIndication EndOfMedia 
AbortedCommand MediaChangeRequested LastFailedSense=0x07 }

Please apply.
-
Gunther

--- linux-2.6.10/drivers/ide/ide-lib.c-orig     2004-12-24 
13:35:39.000000000 -0800
+++ linux-2.6.10/drivers/ide/ide-lib.c  2005-01-08 16:04:35.977731896 -0800
@@ -462,8 +462,7 @@
 
        status.all = stat;
        local_irq_set(flags);
-       printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-       printk(" { ");
+       printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
        if (status.b.bsy)
                printk("Busy ");
        else {
@@ -475,18 +474,17 @@
                if (status.b.idx)       printk("Index ");
                if (status.b.check)     printk("Error ");
        }
-       printk("}");
-       printk("\n");
+       printk("}\n");
        if ((status.all & (status.b.bsy|status.b.check)) == 
status.b.check) {
                error.all = HWIF(drive)->INB(IDE_ERROR_REG);
-               printk("%s: %s: error=0x%02x", drive->name, msg, error.all);
+               printk("%s: %s: error=0x%02x { ", drive->name, msg, 
error.all);
                if (error.b.ili)        printk("IllegalLengthIndication ");
                if (error.b.eom)        printk("EndOfMedia ");
-               if (error.b.abrt)       printk("Aborted Command ");
+               if (error.b.abrt)       printk("AbortedCommand ");
                if (error.b.mcr)        printk("MediaChangeRequested ");
-               if (error.b.sense_key)  printk("LastFailedSense 0x%02x ",
+               if (error.b.sense_key)  printk("LastFailedSense=0x%02x ",
                                                error.b.sense_key);
-               printk("\n");
+               printk("}\n");
        }
        local_irq_restore(flags);
        return error.all;


--------------020005070803060102020306
Content-Type: text/plain;
 name="gmdiff-lx2610-ide-lib-error-readability-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gmdiff-lx2610-ide-lib-error-readability-fix"

--- linux-2.6.10/drivers/ide/ide-lib.c-orig	2004-12-24 13:35:39.000000000 -0800
+++ linux-2.6.10/drivers/ide/ide-lib.c	2005-01-08 16:04:35.977731896 -0800
@@ -462,8 +462,7 @@
 
 	status.all = stat;
 	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-	printk(" { ");
+	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (status.b.bsy)
 		printk("Busy ");
 	else {
@@ -475,18 +474,17 @@
 		if (status.b.idx)	printk("Index ");
 		if (status.b.check)	printk("Error ");
 	}
-	printk("}");
-	printk("\n");
+	printk("}\n");
 	if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
 		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, error.all);
+		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
 		if (error.b.ili)	printk("IllegalLengthIndication ");
 		if (error.b.eom)	printk("EndOfMedia ");
-		if (error.b.abrt)	printk("Aborted Command ");
+		if (error.b.abrt)	printk("AbortedCommand ");
 		if (error.b.mcr)	printk("MediaChangeRequested ");
-		if (error.b.sense_key)	printk("LastFailedSense 0x%02x ",
+		if (error.b.sense_key)	printk("LastFailedSense=0x%02x ",
 						error.b.sense_key);
-		printk("\n");
+		printk("}\n");
 	}
 	local_irq_restore(flags);
 	return error.all;

--------------020005070803060102020306--
