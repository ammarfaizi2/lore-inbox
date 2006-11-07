Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWKGGsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWKGGsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbWKGGsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:48:24 -0500
Received: from mail01.verismonetworks.com ([164.164.99.228]:20381 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751601AbWKGGsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:48:23 -0500
Subject: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
From: Amol Lad <amol@verismonetworks.com>
To: James.Bottomley@steeleye.com, akpm@osdl.org
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 12:21:26 +0530
Message-Id: <1162882286.22062.150.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced calls with save_flags()/cli() pair with
spi_lock_irqsave()/spin_unlock_irqrestore()

Tested:
1. compilation only 
2. Code review to verify that the change does not result in a recursive
locking

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
Andrew, 
Please add this to -mm
---
--- linux-2.6.19-rc4-orig/drivers/scsi/mca_53c9x.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc4/drivers/scsi/mca_53c9x.c	2006-11-06 18:03:22.000000000 +0530
@@ -341,9 +341,7 @@ static void dma_init_read(struct NCR_ESP
 {
 	unsigned long flags;
 
-
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(esp->ehost->host_lock, flags);
 
 	mca_disable_dma(esp->dma);
 	mca_set_dma_mode(esp->dma, MCA_DMA_MODE_XFER | MCA_DMA_MODE_16 |
@@ -352,16 +350,14 @@ static void dma_init_read(struct NCR_ESP
 	mca_set_dma_count(esp->dma, length / 2); /* !!! */
 	mca_enable_dma(esp->dma);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(esp->ehost->host_lock, flags);
 }
 
 static void dma_init_write(struct NCR_ESP *esp, __u32 addr, int length)
 {
 	unsigned long flags;
 
-
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(esp->ehost->host_lock, flags);
 
 	mca_disable_dma(esp->dma);
 	mca_set_dma_mode(esp->dma, MCA_DMA_MODE_XFER | MCA_DMA_MODE_WRITE |
@@ -370,7 +366,7 @@ static void dma_init_write(struct NCR_ES
 	mca_set_dma_count(esp->dma, length / 2); /* !!! */
 	mca_enable_dma(esp->dma);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(esp->ehost->host_lock, flags);
 }
 
 static void dma_ints_off(struct NCR_ESP *esp)


