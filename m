Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVFQWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVFQWjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVFQWj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:39:26 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:1757 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261297AbVFQWi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:38:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WuBPdI6r3yfznH33Fu69rKQO/UUtTNgBhnVIIwl0/WlHaQPI9Ab3S1YZKb+lOQ8r9oqhD6eoz/mhocnzvxVH3i8xlsBVhooAkxCDexYfMFH1FkzVaVKD130VWFMjxSy0yuMYfPwMqzGYJQtmpgG5MkLZmVTNe36WKDI6LP0xN58=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Donald.Huang@ite.com.tw, akpm@osdl.org
Subject: [PATCH 3/3] iteraid: remove home-grown memmove()
Date: Sat, 18 Jun 2005 02:42:35 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506180242.35178.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/iteraid.c |   46 ++++++----------------------------------------
 1 files changed, 6 insertions(+), 40 deletions(-)

Index: linux-iteraid/drivers/scsi/iteraid.c
===================================================================
--- linux-iteraid.orig/drivers/scsi/iteraid.c	2005-06-18 02:00:27.000000000 +0400
+++ linux-iteraid/drivers/scsi/iteraid.c	2005-06-18 02:20:45.000000000 +0400
@@ -3194,36 +3194,6 @@ static u8 IdeVerify(PChannel pChan, PSCS
 	return SRB_STATUS_PENDING;
 }				/* end IdeVerify */
 
-/************************************************************************
- * This function is used to copy memory with overlapped destination and
- * source. I guess ScsiPortMoveMemory cannot handle this well. Can it?
- ************************************************************************/
-static void
-IT8212MoveMemory(unsigned char *DestAddr, unsigned char *SrcAddr, u32 ByteCount)
-{
-	long i;
-
-	dprintk("IT8212MoveMemory: DestAddr=0x%p, SrcAddr=0x%p, "
-		"ByteCount=0x%x\n", DestAddr, SrcAddr, ByteCount);
-	if (DestAddr > SrcAddr) {
-
-		/*
-		 * If Destination Area is in the back of the Source Area, copy
-		 * from the end of the requested area.
-		 */
-		for (i = (ByteCount - 1); i >= 0; i--)
-			*(DestAddr + i) = *(SrcAddr + i);
-	} else if (DestAddr < SrcAddr) {
-
-		/*
-		 * If Destination Area is in the front of the Source Area, copy
-		 * from the begin of the requested area.
-		 */
-		for (i = 0; i < ByteCount; i++)
-			*(DestAddr + i) = *(SrcAddr + i);
-	}
-}				/* end IT8212MoveMemory */
-
 /*
  * Convert SCSI packet command to Atapi packet command.
  */
@@ -3349,16 +3319,12 @@ static void Scsi2Atapi(PChannel pChan, P
 			    sizeof(SCSI_MODE_PARAMETER_HEADER6) -
 			    sizeof(SCSI_MODE_PARAMTER_BLOCK_DESCRIPTER);
 			if (byteCount > 0) {
-				IT8212MoveMemory((unsigned char *)header10 +
-						 sizeof
-						 (SCSI_MODE_PARAMETER_HEADER10),
-						 (unsigned char *)header10 +
-						 sizeof
-						 (SCSI_MODE_PARAMETER_HEADER6)
-						 +
-						 sizeof
-						 (SCSI_MODE_PARAMTER_BLOCK_DESCRIPTER),
-						 byteCount);
+				memmove((unsigned char *)header10 +
+					sizeof(SCSI_MODE_PARAMETER_HEADER10),
+					(unsigned char *)header10 +
+					sizeof(SCSI_MODE_PARAMETER_HEADER6) +
+					sizeof(SCSI_MODE_PARAMTER_BLOCK_DESCRIPTER),
+					byteCount);
 			}
 
 			/*
