Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSBIOsw>; Sat, 9 Feb 2002 09:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBIOsm>; Sat, 9 Feb 2002 09:48:42 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:30738 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S288685AbSBIOse>;
	Sat, 9 Feb 2002 09:48:34 -0500
Message-ID: <3C6536BA.1935956B@yahoo.com>
Date: Sat, 09 Feb 2002 09:48:26 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: torvalds@transmeta.com, davem@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.4pre5 scsi/aha1542.c & DMA changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are a couple of errors in the DMA changes to the 
aha1542.c driver that appeared in 2.5.4pre3: 

- a typo (BUF vs BUS)
- a macro handed a page instead of a scatterlist
- printk format length mismatch

Paul.

--- drivers/scsi/aha1542.c~	Fri Feb  8 06:38:42 2002
+++ drivers/scsi/aha1542.c	Sat Feb  9 09:36:48 2002
@@ -58,7 +58,7 @@
 {
 	printk(KERN_CRIT "buf vaddress %p paddress 0x%lx length %d\n",
 	       address,
-	       SCSI_BUS_PA(address),
+	       SCSI_BUF_PA(address),
 	       length);
 	panic("Buffer at physical address > 16Mb used for aha1542");
 }
@@ -68,7 +68,7 @@
 		       int nseg,
 		       int badseg)
 {
-	printk(KERN_CRIT "sgpnt[%d:%d] page %p/0x%lx length %d\n",
+	printk(KERN_CRIT "sgpnt[%d:%d] page %p/0x%x length %d\n",
 	       badseg, nseg,
 	       page_address(sgpnt[badseg].page) + sgpnt[badseg].offset,
 	       SCSI_SG_PA(&sgpnt[badseg]),
@@ -727,7 +727,7 @@
 				panic("Foooooooood fight!");
 			};
 			any2scsi(cptr[i].dataptr, SCSI_SG_PA(&sgpnt[i]));
-			if (SCSI_SG_PA(&sgpnt[i].page) + sgpnt[i].length - 1 > ISA_DMA_THRESHOLD)
+			if (SCSI_SG_PA(&sgpnt[i]) + sgpnt[i].length - 1 > ISA_DMA_THRESHOLD)
 				BAD_SG_DMA(SCpnt, sgpnt, SCpnt->use_sg, i);
 			any2scsi(cptr[i].datalen, sgpnt[i].length);
 		};



