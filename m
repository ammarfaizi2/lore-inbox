Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWJJCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWJJCTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWJJCTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:19:40 -0400
Received: from alnrmhc11.comcast.net ([204.127.225.91]:57276 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751983AbWJJCTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:19:40 -0400
Message-ID: <452B033A.3080404@comcast.net>
Date: Mon, 09 Oct 2006 22:19:38 -0400
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: patch to 2.6.18-mm3 for missing libata Kconfig options
Content-Type: multipart/mixed;
 boundary="------------030401070702070102020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401070702070102020904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  I believe the following options are missing in the current setup of 
how libata is configured and selected in the kernel config program.  
First, a clarification as to just what needs to be selected to actually 
use libata governed drives. Second, since libata is being treated as a 
alternative to scsi and ide, it should have the same options as those 
until it fully replaces ide and the general blk devices can be moved to 
a "shared" config option.

So I just wrote up a little patch to the ata driver's Kconfig that adds 
in the "missing" blk dev selection options so a user doesn't have to do 
what they had to do when ata was under scsi's low level drivers in the 
first place, which somewhat negates the whole movement of ata out of 
scsi.   This should clear up a lot of confusion among users who are 
coming to libata from ide and dont really get or want to get why it has 
anything to do with selecting scsi drivers.   

Hopefully this shared code between scsi and ata will be moved to a more 
"general block device" option when ide is removed and everything is seen 
as scsi devices anyway so we wont have to refer to them as "scsi devices". 

this patch is against 2.6.18-mm3.  

--------------030401070702070102020904
Content-Type: text/plain;
 name="libata_kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata_kconfig.patch"

--- ./linux-2.6.18/drivers/ata/Kconfig	2006-10-09 22:09:35.000000000 -0400
+++ ../linux-2.6.18/drivers/ata/Kconfig	2006-10-09 22:04:02.000000000 -0400
@@ -15,9 +15,38 @@
 	  the name of your ATA host adapter (the card inside your computer
 	  that "speaks" the ATA protocol, also called ATA controller),
 	  because you will be asked for it.
+	  NOTE: 
+	  You will also need to select the ata device interface drivers below, 
+	  to actually use the drives that libata detects.
 
 if ATA
 
+config ATA_DISK
+	tristate "ATA Disk Support"
+	select BLK_DEV_SD
+	depends on SCSI
+	---help---
+	    Select this if you have ata disk drives. Devices will be
+	    connected to traditional scsi device nodes. eg. sda
+
+	
+config ATA_OPTICAL
+	tristate "ATA CD/DVD Rom Support"
+	select BLK_DEV_SR
+	depends on SCSI
+	---help---
+	    Select this if you have ata CD/DVD optical drives. Devices 
+	    will be connected to traditional scsi device nodes. eg. sr0
+	
+config ATA_GENERIC
+	tristate "ATA Generic support (CD/DVD Writer)"
+	select BLK_DEV_SG
+	depends on SCSI
+	---help---
+	    Select this if you have ata optical writers or anything 
+	    supported by libata that's not a disk drive. Devices will be 
+	    connected to the traditional scsi device nodes. eg. sg0
+	    
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI

--------------030401070702070102020904--
