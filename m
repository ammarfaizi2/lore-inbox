Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424153AbWKIWQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424153AbWKIWQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424178AbWKIWQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:16:35 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:727 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1424153AbWKIWQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:16:34 -0500
Date: Thu, 9 Nov 2006 23:13:38 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       buytenh@wantstofly.org
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)]
Message-ID: <20061109221338.GA17722@electric-eye.fr.zoreil.com>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20061108203546.GA32247@kos.to>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Riku Voipio <riku.voipio@iki.fi> :
[...]
> I took 2.6.19-rc5 as there was no changes in this driver relative to -rc4. 
> applied Francois's 0001-r8169-perform-a-PHY-reset.. and finally the
> patch in this mail. And networking _does_not_ work on Thecus N2100.

It sucks.

Can you try against 2.6.18-rc4 the patch at:

http://www.fr.zoreil.com/people/francois/misc/20061109-2.6.18-rc4-r8169-test.patch

If it does not work, apply on top of 2.6.18-rc4 the serie available at:
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.18-rc4/r8169
plus the attached patch.

-- 
Ueimor

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0010-r8169-quirk-for-the-8110sb-on-arm-platform.txt"

>From 20f33886d041e00cde9c6339ff4d724d992c99bc Mon Sep 17 00:00:00 2001
From: Francois Romieu <romieu@fr.zoreil.com>
Date: Mon, 11 Sep 2006 20:10:58 +0200
Subject: [PATCH] r8169: quirk for the 8110sb on arm platform

Inverting the write ordering of the TxDescAddr{High/Low} registers
suffices to trigger a sabbat of PCI errors which make the device
completely dysfunctional. The issue has not been reported on a
different platform.

Switching from MMIO accesses to I/O ones as done in Realtek's
own driver fixes (papers over ?) the bug as well but I am not
thrilled to see everyone pay the I/O price for an obscure bug.

This is the minimal change to handle the issue.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 drivers/net/r8169.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 7ab79db..582b116 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -1868,10 +1868,15 @@ rtl8169_hw_start(struct net_device *dev)
 	 */
 	RTL_W16(IntrMitigate, 0x0000);
 
-	RTL_W32(TxDescStartAddrLow, ((u64) tp->TxPhyAddr & DMA_32BIT_MASK));
+	/*
+	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
+	 * register to be written before TxDescAddrLow to work.
+	 * Switching from MMIO to I/O access fixes the issue as well.
+	 */
 	RTL_W32(TxDescStartAddrHigh, ((u64) tp->TxPhyAddr >> 32));
-	RTL_W32(RxDescAddrLow, ((u64) tp->RxPhyAddr & DMA_32BIT_MASK));
+	RTL_W32(TxDescStartAddrLow, ((u64) tp->TxPhyAddr & DMA_32BIT_MASK));
 	RTL_W32(RxDescAddrHigh, ((u64) tp->RxPhyAddr >> 32));
+	RTL_W32(RxDescAddrLow, ((u64) tp->RxPhyAddr & DMA_32BIT_MASK));
 	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
 	RTL_W8(Cfg9346, Cfg9346_Lock);
 
-- 
1.4.2.4


--HlL+5n6rz5pIUxbD--
