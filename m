Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWH3RdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWH3RdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWH3RdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:33:05 -0400
Received: from mail.inphase-tech.com ([66.17.172.42]:15113 "EHLO
	mail.inphase-tech.com") by vger.kernel.org with ESMTP
	id S1751207AbWH3RdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:33:01 -0400
From: "Erik Habbinga" <erikhabbinga@inphase-tech.com>
To: <eric.moore@lsil.com>
Cc: <james.bottomley@steeleye.com>, <trivial@kernel.org>,
       "'Erik Habbinga'" <erikhabbinga@inphase-tech.com>,
       <linux-kernel@vger.kernel.org>
Subject: [patch 1/1] SCSI: improve endian handling in LSI fusion firmware mpt_downloadboot
Date: Wed, 30 Aug 2006 11:32:47 -0600
Message-ID: <000b01c6cc5a$52cedf10$2018010a@inphasetech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mpt_downloadboot function in drivers/message/fusion/mptbase.c doesn't work correctly on big endian systems (powerpc in my case).
I've added appropriate le32_to_cpu calls to correctly translate little endian firmware file data into cpu endian format before
getting written to little endian PCI registers.  This patch has been tested successfully on a powerpc target and an Intel target.

Signed-off-by: Erik Habbinga <erikhabbinga@inphase-tech.com>

--- a/drivers/message/fusion/mptbase.c.orig	2006-08-23 15:16:33.000000000 -0600
+++ b/drivers/message/fusion/mptbase.c	2006-08-30 10:28:39.000000000 -0600
@@ -2915,7 +2915,7 @@
 	u32 			 ioc_state=0;
 
 	ddlprintk((MYIOC_s_INFO_FMT "downloadboot: fw size 0x%x (%d), FW Ptr %p\n",
-				ioc->name, pFwHeader->ImageSize, pFwHeader->ImageSize, pFwHeader));
+				ioc->name, le32_to_cpu(pFwHeader->ImageSize), le32_to_cpu(pFwHeader->ImageSize), pFwHeader));
 
 	CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
 	CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
@@ -2968,7 +2968,7 @@
 	/* Set the DiagRwEn and Disable ARM bits */
 	CHIPREG_WRITE32(&ioc->chip->Diagnostic, (MPI_DIAG_RW_ENABLE | MPI_DIAG_DISABLE_ARM));
 
-	fwSize = (pFwHeader->ImageSize + 3)/4;
+	fwSize = (le32_to_cpu(pFwHeader->ImageSize) + 3)/4;
 	ptrFw = (u32 *) pFwHeader;
 
 	/* Write the LoadStartAddress to the DiagRw Address Register
@@ -2977,23 +2977,23 @@
 	if (ioc->errata_flag_1064)
 		pci_enable_io_access(ioc->pcidev);
 
-	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, pFwHeader->LoadStartAddress);
+	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, le32_to_cpu(pFwHeader->LoadStartAddress));
 	ddlprintk((MYIOC_s_INFO_FMT "LoadStart addr written 0x%x \n",
-		ioc->name, pFwHeader->LoadStartAddress));
+		ioc->name, le32_to_cpu(pFwHeader->LoadStartAddress)));
 
 	ddlprintk((MYIOC_s_INFO_FMT "Write FW Image: 0x%x bytes @ %p\n",
 				ioc->name, fwSize*4, ptrFw));
 	while (fwSize--) {
-		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, *ptrFw++);
+		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, le32_to_cpu(*ptrFw++));
 	}
 
-	nextImage = pFwHeader->NextImageHeaderOffset;
+	nextImage = le32_to_cpu(pFwHeader->NextImageHeaderOffset);
 	while (nextImage) {
 		pExtImage = (MpiExtImageHeader_t *) ((char *)pFwHeader + nextImage);
 
-		load_addr = pExtImage->LoadStartAddress;
+		load_addr = le32_to_cpu(pExtImage->LoadStartAddress);
 
-		fwSize = (pExtImage->ImageSize + 3) >> 2;
+		fwSize = (le32_to_cpu(pExtImage->ImageSize) + 3) >> 2;
 		ptrFw = (u32 *)pExtImage;
 
 		ddlprintk((MYIOC_s_INFO_FMT "Write Ext Image: 0x%x (%d) bytes @ %p load_addr=%x\n",
@@ -3001,18 +3001,18 @@
 		CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, load_addr);
 
 		while (fwSize--) {
-			CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, *ptrFw++);
+			CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, le32_to_cpu(*ptrFw++));
 		}
-		nextImage = pExtImage->NextImageHeaderOffset;
+		nextImage = le32_to_cpu(pExtImage->NextImageHeaderOffset);
 	}
 
 	/* Write the IopResetVectorRegAddr */
-	ddlprintk((MYIOC_s_INFO_FMT "Write IopResetVector Addr=%x! \n", ioc->name, 	pFwHeader->IopResetRegAddr));
-	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, pFwHeader->IopResetRegAddr);
+	ddlprintk((MYIOC_s_INFO_FMT "Write IopResetVector Addr=%x! \n", ioc->name, 	le32_to_cpu(pFwHeader->IopResetRegAddr)));
+	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwAddress, le32_to_cpu(pFwHeader->IopResetRegAddr));
 
 	/* Write the IopResetVectorValue */
-	ddlprintk((MYIOC_s_INFO_FMT "Write IopResetVector Value=%x! \n", ioc->name, pFwHeader->IopResetVectorValue));
-	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, pFwHeader->IopResetVectorValue);
+	ddlprintk((MYIOC_s_INFO_FMT "Write IopResetVector Value=%x! \n", ioc->name, le32_to_cpu(pFwHeader->IopResetVectorValue)));
+	CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, le32_to_cpu(pFwHeader->IopResetVectorValue));
 
 	/* Clear the internal flash bad bit - autoincrementing register,
 	 * so must do two writes.

