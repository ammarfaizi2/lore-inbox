Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWFUVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWFUVIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWFUVIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:08:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44451 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030307AbWFUVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:08:02 -0400
Subject: Re: PATA driver patch for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e79a9e$2kt$1@sea.gmane.org>
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <e79a9e$2kt$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 22:23:22 +0100
Message-Id: <1150925002.15275.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 21:12 +0400, ysgrifennodd Andrey Borzenkov:
> Running vanilla 2.6.17 + ide1 patch on ALi M5229 does not find CD-ROM.
> Notice "ata2: command 0xa0 timeout" below.

Not sure immediately but does the following help

--- ../libata-devo/drivers/scsi/pata_ali.c	2006-06-20 11:50:15.000000000 +0100
+++ drivers/scsi/pata_ali.c	2006-06-21 21:42:27.458542280 +0100
@@ -181,11 +181,12 @@
 	u8 fifo;
 	int shift = 4 * adev->devno;
 
-	/* Bits 3:2 (7:6 for slave) control the PIO. 00 is off 01
-	   is on. The FIFO must not be used for ATAPI. We preserve
-	   BIOS set thresholds */
+	/* ATA - FIFO on set nibble to 0x05, ATAPI - FIFO off, set nibble to
+	   0x00. Not all the docs agree but the behaviour we now use is the
+	   one stated in the BIOS Programming Guide */
+	   
 	pci_read_config_byte(pdev, pio_fifo, &fifo);
-	fifo &= ~(0x0C << shift);
+	fifo &= ~(0x0F << shift);
 	if (on)
 		fifo |= (on << shift);
 	pci_write_config_byte(pdev, pio_fifo, fifo);
@@ -261,10 +262,10 @@
 
 	/* PIO FIFO is only permitted on ATA disk */
 	if (adev->class != ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0);
+		ali_fifo_control(ap, adev, 0x00);
 	ali_program_modes(ap, adev, &t, 0);
 	if (adev->class == ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0x04);
+		ali_fifo_control(ap, adev, 0x05);
 
 }
 

