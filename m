Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270515AbTHQTRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270518AbTHQTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:17:15 -0400
Received: from codepoet.org ([166.70.99.138]:44178 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270515AbTHQTRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:17:07 -0400
Date: Sun, 17 Aug 2003 13:17:02 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 9/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817191701.GA23859@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing a bit of additional testing and I noticed that I had
neglected to fixup the various ide raid drivers.  This was mainly
since linux/drivers/ide/raid went missing in 2.5.32 when the 2.5
IDE layer was reverted to a "late 2.4.19-pre-acX version" and has
been gone ever since...  Any particular reason the baby was
tossed out with the proverbial bathwater?

Anyway, this patch fixes up the 2.4.x ide raid drivers so they
compile up with the latest and greatest.  I will leave it to 
others to decide if the pdcraid and silraid superblocks might
be located somewhere past the capacity of an unsigned long...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux/drivers/ide/raid/hptraid.c.orig	2003-08-17 12:45:01.000000000 -0600
+++ linux/drivers/ide/raid/hptraid.c	2003-08-17 12:45:17.000000000 -0600
@@ -594,7 +594,7 @@
 		return 0;
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity);
+	lba = (ideinfo->capacity64);
 
 	return lba;
 }
--- linux/drivers/ide/raid/pdcraid.c.orig	2003-08-17 11:04:31.000000000 -0600
+++ linux/drivers/ide/raid/pdcraid.c	2003-08-17 13:04:50.000000000 -0600
@@ -28,6 +28,7 @@
 
 #include <linux/ide.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #include "ataraid.h"
 
@@ -345,7 +346,7 @@
 
 static unsigned long calc_pdcblock_offset (int major,int minor)
 {
-	unsigned long lba = 0;
+	u64 lba = 0;
 	kdev_t dev;
 	ide_drive_t *ideinfo;
 	
@@ -360,11 +361,13 @@
 		return 0;
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+	lba = ideinfo->capacity64;
+	do_div(lba, ideinfo->head*ideinfo->sect); /* macro warning, cannot combine steps */
 	lba = lba * (ideinfo->head*ideinfo->sect);
 	lba = lba - ideinfo->sect;
 
-	return lba;
+	/* I guess pdc raids do not get especially large... */ 
+	return (unsigned long)lba;
 }
 
 
--- linux/drivers/ide/raid/silraid.c.orig	2003-08-17 12:45:31.000000000 -0600
+++ linux/drivers/ide/raid/silraid.c	2003-08-17 13:09:12.000000000 -0600
@@ -34,6 +34,7 @@
 
 #include <linux/ide.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #include "ataraid.h"
 
@@ -248,7 +249,7 @@
 
 static unsigned long calc_silblock_offset (int major,int minor)
 {
-	unsigned long lba = 0, cylinders;
+	u64 lba = 0, cylinders;
 	kdev_t dev;
 	ide_drive_t *ideinfo;
 	
@@ -263,13 +264,15 @@
 		return 0;
 	if (ideinfo->sect==0)
 		return 0;
-	cylinders = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+	cylinders = ideinfo->capacity64;
+	do_div(cylinders, ideinfo->head*ideinfo->sect); /* macro warning, cannot combine steps */
 	lba = (cylinders - 1) * (ideinfo->head*ideinfo->sect);
 	lba = lba - ideinfo->head -1;
 	
 //	return 80417215;  
-	printk("Guestimating sector %li for superblock\n",lba);
-	return lba;
+	printk("Guestimating sector %llu for superblock\n",lba);
+	/* I guess sil raids do not get especially large... */ 
+	return (unsigned long)lba;
 
 }
 
