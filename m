Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUITVQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUITVQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUITVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:16:13 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:11138 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266555AbUITVQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:16:05 -0400
Date: Mon, 20 Sep 2004 23:15:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Lutomirski <luto@myrealbox.com>, Hans-Frieder Vogt <hfvogt@arcor.de>,
       Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Message-ID: <20040920211500.GA15946@electric-eye.fr.zoreil.com>
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com> <20040917160151.GA29337@electric-eye.fr.zoreil.com> <414DF773.7060402@myrealbox.com> <20040919213952.GA32570@electric-eye.fr.zoreil.com> <414E46F1.9050309@pobox.com> <20040920071743.GA7115@electric-eye.fr.zoreil.com> <414F1A8C.10803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F1A8C.10803@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Let me know what happens :)

Nothing conclusive so far.

I applied patch below on my 32bit system on top of current 2.6.9-rc2-mm1 + 
patch issued yesterday + extra hack to force PCI DAC on 32 bit system.
It does not help if I force PCI DAC.
It does not change anything if PCI DAC is not enabled.


diff -puN drivers/net/r8169.c~r8169-145b-4 drivers/net/r8169.c
--- linux-2.6.9-rc2/drivers/net/r8169.c~r8169-145b-4	2004-09-20 21:39:20.000000000 +0200
+++ linux-2.6.9-rc2-fr/drivers/net/r8169.c	2004-09-20 21:39:20.000000000 +0200
@@ -1483,6 +1483,11 @@ rtl8169_hw_start(struct net_device *dev)
 	void *ioaddr = tp->mmio_addr;
 	u32 i;
 
+	RTL_W32(TxDescStartAddrLow, ((u64) tp->TxPhyAddr & DMA_32BIT_MASK));
+	RTL_W32(TxDescStartAddrHigh, ((u64) tp->TxPhyAddr >> 32));
+	RTL_W32(RxDescAddrLow, ((u64) tp->RxPhyAddr & DMA_32BIT_MASK));
+	RTL_W32(RxDescAddrHigh, ((u64) tp->RxPhyAddr >> 32));
+
 	/* Soft reset the chip. */
 	RTL_W8(ChipCmd, CmdReset);
 
@@ -1494,7 +1499,6 @@ rtl8169_hw_start(struct net_device *dev)
 	}
 
 	RTL_W8(Cfg9346, Cfg9346_Unlock);
-	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
 	RTL_W8(EarlyTxThres, EarlyTxThld);
 
 	// For gigabit rtl8169
@@ -1509,24 +1513,9 @@ rtl8169_hw_start(struct net_device *dev)
 	RTL_W32(TxConfig,
 		(TX_DMA_BURST << TxDMAShift) | (InterFrameGap <<
 						TxInterFrameGapShift));
-	tp->cp_cmd |= RTL_R16(CPlusCmd);
-	RTL_W16(CPlusCmd, tp->cp_cmd);
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_D) {
-		dprintk(KERN_INFO PFX "Set MAC Reg C+CR Offset 0xE0. "
-			"Bit-3 and bit-14 MUST be 1\n");
-		tp->cp_cmd |= (1 << 14) | PCIMulRW;
-		RTL_W16(CPlusCmd, tp->cp_cmd);
-	}
-
 	tp->cur_rx = 0;
 
-	RTL_W32(TxDescStartAddrLow, ((u64) tp->TxPhyAddr & DMA_32BIT_MASK));
-	RTL_W32(TxDescStartAddrHigh, ((u64) tp->TxPhyAddr >> 32));
-	RTL_W32(RxDescAddrLow, ((u64) tp->RxPhyAddr & DMA_32BIT_MASK));
-	RTL_W32(RxDescAddrHigh, ((u64) tp->RxPhyAddr >> 32));
 	RTL_W8(Cfg9346, Cfg9346_Lock);
-	udelay(10);
 
 	RTL_W32(RxMissed, 0);
 
@@ -1538,6 +1527,17 @@ rtl8169_hw_start(struct net_device *dev)
 	/* Enable all known interrupts by setting the interrupt mask. */
 	RTL_W16(IntrMask, rtl8169_intr_mask);
 
+	tp->cp_cmd |= RTL_R16(CPlusCmd);
+
+	if (tp->mac_version == RTL_GIGA_MAC_VER_D) {
+		dprintk(KERN_INFO PFX "Set MAC Reg C+CR Offset 0xE0. "
+			"Bit-3 and bit-14 MUST be 1\n");
+		tp->cp_cmd |= (1 << 14) | PCIMulRW;
+	}
+
+	RTL_W16(CPlusCmd, tp->cp_cmd);
+	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
+
 	netif_start_queue(dev);
 }
 

_
