Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136217AbRARXZi>; Thu, 18 Jan 2001 18:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136237AbRARXZ3>; Thu, 18 Jan 2001 18:25:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57035 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136223AbRARXZT>;
	Thu, 18 Jan 2001 18:25:19 -0500
Message-Id: <200101182311.PAA00858@zeus.kernel.org>
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 18 Jan 2001 23:12:18 +0000
Reply-To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
X-Mailer: PMMail 1.96a For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [PATCH] i91uscsi.c misreads BIOS settings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch for i91uscsi.c as delivered with the 2.4.0 kernel to correct the problem 
of it reading the BIOS settings for double the SCSI id that it should be looking at.

This is a two liner to correct this problem but I've done some fairly major cosmetic 
surgery on the rest of the driver - it currently uses two header files, i91uscsi.h and 
ini9100u.h - and these contain duplicate definitions of the same structs but with 
different contents. 

This sounds to me like a recipe for problems so I've combined the two header files 
and eliminated the duplication. I've also added /proc fs support. The resulting patch 
is too big to post to a mailing list and a complete replacement of the source can be 
found on http://www.os2warp.org/sysbench/i91uv104.tar.gz - this
adds ini9100_proc.c but i91uscsi.h can be rm'ed as no longer required. This 
replacement has been tested on 2.2.13, 2.2.18 and 2.4.0 compiled into the
kernel and also on 2.4.0 as a module.

--- /backup/linuxold/drivers/scsi/i91uscsi.c	Mon Aug 23 17:23:23 1999
+++ /backup/linux/drivers/scsi/i91uscsi.c	Thu Jan 18 21:42:52 2001
@@ -590,7 +590,7 @@
 int init_tulip(HCS * pCurHcb, SCB * scbp, int tul_num_scb, BYTE * pbBiosAdr, int seconds)
 {
 	int i;
-	WORD *pwFlags;
+	BYTE *pwFlags;
 	BYTE *pbHeads;
 	SCB *pTmpScb, *pPrevScb = NULL;
 
@@ -674,7 +674,7 @@
 	       ((pCurHcb->HCS_Config & HCC_AUTO_TERM) >> 4) | (TUL_RD(pCurHcb->HCS_Base, TUL_GCTRL1) & 0xFE));
 
 	for (i = 0,
-	     pwFlags = (WORD *) & (i91unvramp->NVM_SCSIInfo[0].NVM_Targ0Config),
+	     pwFlags = & (i91unvramp->NVM_SCSIInfo[0].NVM_Targ0Config),
 	     pbHeads = pbBiosAdr + 0x180;
 	     i < pCurHcb->HCS_MaxTar;
 	     i++, pwFlags++) {


Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
