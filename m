Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVBWVN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVBWVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVBWVLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:11:17 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:11931 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261596AbVBWVIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:08:16 -0500
Date: Wed, 23 Feb 2005 22:03:50 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jdmason@us.ibm.com,
       rich@phekda.gotadsl.co.uk, jgarzik@pobox.com
Subject: [patch 2.6.11-rc4-mm1 2/2] r8169: factor out some code.
Message-ID: <20050223210350.GA31312@electric-eye.fr.zoreil.com>
References: <20050222234810.GA17303@electric-eye.fr.zoreil.com> <20050222172935.30e43270.akpm@osdl.org> <20050223085921.GA22268@electric-eye.fr.zoreil.com> <20050223010948.6f2aa542.akpm@osdl.org> <20050223205853.GA30109@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223205853.GA30109@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out some code

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/net/r8169.c~r8169-460 drivers/net/r8169.c
--- a/drivers/net/r8169.c~r8169-460	2005-02-23 21:35:28.715271999 +0100
+++ b/drivers/net/r8169.c	2005-02-23 21:35:28.720271177 +0100
@@ -495,6 +495,13 @@ static void rtl8169_irq_mask_and_ack(voi
 	RTL_W16(IntrStatus, 0xffff);
 }
 
+static void rtl8169_asic_down(void __iomem *ioaddr)
+{
+	RTL_W8(ChipCmd, 0x00);
+	rtl8169_irq_mask_and_ack(ioaddr);
+	RTL_R16(CPlusCmd);
+}
+
 static unsigned int rtl8169_tbi_reset_pending(void __iomem *ioaddr)
 {
 	return RTL_R32(TBICSR) & TBIReset;
@@ -2260,8 +2267,10 @@ rtl8169_interrupt(int irq, void *dev_ins
 
 		handled = 1;
 
-		if (unlikely(!netif_running(dev)))
-			goto out_asic_stop;
+		if (unlikely(!netif_running(dev))) {
+			rtl8169_asic_down(ioaddr);
+			goto out;
+		}
 
 		status &= tp->intr_mask;
 		RTL_W16(IntrStatus,
@@ -2310,12 +2319,6 @@ rtl8169_interrupt(int irq, void *dev_ins
 	}
 out:
 	return IRQ_RETVAL(handled);
-
-out_asic_stop:
-	RTL_W8(ChipCmd, 0x00);
-	rtl8169_irq_mask_and_ack(ioaddr);
-	RTL_R16(CPlusCmd);
-	goto out;
 }
 
 #ifdef CONFIG_R8169_NAPI
@@ -2363,11 +2366,7 @@ static void rtl8169_down(struct net_devi
 core_down:
 	spin_lock_irq(&tp->lock);
 
-	/* Stop the chip's Tx and Rx DMA processes. */
-	RTL_W8(ChipCmd, 0x00);
-
-	/* Disable interrupts by clearing the interrupt mask. */
-	RTL_W16(IntrMask, 0x0000);
+	rtl8169_asic_down(ioaddr);
 
 	/* Update the error counts. */
 	tp->stats.rx_missed_errors += RTL_R32(RxMissed);

_
