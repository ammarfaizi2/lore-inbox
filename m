Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVBXPVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVBXPVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVBXPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:20:25 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:41097 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262386AbVBXPRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:17:02 -0500
Message-ID: <421DEFA1.1040601@pobox.com>
Date: Thu, 24 Feb 2005 10:15:45 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11+ sata_qstor] libata: sata_qstor cosmetic fixes
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru> <421D1113.9030502@pobox.com> <421D6442.3030308@pobox.com>
In-Reply-To: <421D6442.3030308@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------050000000208080802030300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050000000208080802030300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Mark Lord wrote:
> 
>> Minor patch for new 2.6.xx sata_qstor driver attached,
>> as per Alexey's fine-toothed comb!  :)
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> I had to apply this manually, since your mailer "corrupts" the patch by 
> encoding text/plain as base64.  Please fix your mailer...

Mmm.. first time that's ever happened here.
It's not the mailer, but the mime-types,
which must have gotten confused by the ".patch1"
extension, as opposed to the normal ".patch".

Here it is again, renamed to avoid the faulty mime handling.

Signed-off-by: Mark Lord <mlord@pobox.com>

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


--------------050000000208080802030300
Content-Type: text/x-patch;
 name="sata_qstor-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_qstor-1.patch"

--- linux/drivers/scsi/sata_qstor.c.orig	2005-02-16 20:31:57.000000000 -0500
+++ linux/drivers/scsi/sata_qstor.c	2005-02-23 18:19:31.000000000 -0500
@@ -261,11 +261,11 @@
 		u32 len;
 
 		addr = sg_dma_address(sg);
-		*(u64 *)prd = cpu_to_le64(addr);
+		*(__le64 *)prd = cpu_to_le64(addr);
 		prd += sizeof(u64);
 
 		len = sg_dma_len(sg);
-		*(u32 *)prd = cpu_to_le32(len);
+		*(__le32 *)prd = cpu_to_le32(len);
 		prd += sizeof(u64);
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
@@ -298,10 +298,10 @@
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(u32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
-	*(u32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(__le32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
-	*(u64 *)(&buf[16]) = cpu_to_le64(addr);
+	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
 
 	/* device control block (DCB) */
 	buf[24] = QS_DCB_HDR;
@@ -566,10 +566,10 @@
 	int rc, have_64bit_bus = (bus_info & QS_HPHY_64BIT);
 
 	if (have_64bit_bus &&
-	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): 64-bit DMA enable failed\n",
@@ -578,14 +578,14 @@
 			}
 		}
 	} else {
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): 32-bit DMA enable failed\n",
 				pci_name(pdev));
 			return rc;
 		}
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): 32-bit consistent DMA enable failed\n",

--------------050000000208080802030300--
