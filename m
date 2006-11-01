Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752460AbWKAVhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbWKAVhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbWKAVhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:37:33 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42209 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1752460AbWKAVhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:37:33 -0500
Date: Wed, 1 Nov 2006 22:35:09 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Darren Salt <linux@youmustbejoking.demon.co.uk>
Cc: buytenh@wantstofly.org, g.liakhovetski@gmx.de, romieu@fr.zoreil.com,
       torvalds@osdl.org, bunk@stusta.de, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, tmattox@gmail.com, spiky.kiwi@gmail.com,
       r.bhatia@ipax.at, syed.azam@hp.com
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061101213509.GA3212@electric-eye.fr.zoreil.com>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange> <20061030120158.GA28123@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange> <20061030234425.GB6038@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610312000160.5223@poirot.grange> <20061031230538.GA4329@electric-eye.fr.zoreil.com> <4E7F16C676%linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E7F16C676%linux@youmustbejoking.demon.co.uk>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Salt <linux@youmustbejoking.demon.co.uk> :
[...]
> (This is one of two possible fixes, the other being the removal of the if()
> guarding the other tx/rx-enable call. Both work here.)

I'll update the patch with your change but the removal of the if() would
not match Realtek's init sequence.

Lennert, I have compared 2.6.19-rc4 + 0001-r8169-perform-a-PHY-reset-etc
with the serie of patches against 2.6.18-rc4 which was reported to work
on your n2100 (thread on netdev around 05/09/2006). Can you:

- apply the patch below on top of 2.6.19-rc4 + 0001 and see if it works ?
  Don't apply 0002, it is not required.

- if it works (it should if I have not messed it again), can you check
  that it still works if you do not apply the first hunk ? It should as
  well.

If everything went fine this far, it would be nice to know if both the
move of the write to ChipCmd and the mdio_write are required to fix
your issue (I'd expect the move alone to not be enough as 0002 got this
part right for the 8110sb).

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 50b753d..b2fdbb8 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -491,7 +491,7 @@ static int rtl8169_poll(struct net_devic
 #endif
 
 static const u16 rtl8169_intr_mask =
-	SYSErr | LinkChg | RxOverflow | RxFIFOOver | TxErr | TxOK | RxErr | RxOK;
+	LinkChg | RxOverflow | RxFIFOOver | TxErr | TxOK | RxErr | RxOK;
 static const u16 rtl8169_napi_event =
 	RxOK | RxOverflow | RxFIFOOver | TxOK | TxErr;
 static const unsigned int rtl8169_rx_config =
@@ -1283,11 +1283,6 @@ static void rtl8169_hw_phy_config(struct
 	/* Shazam ! */
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_04) {
-		mdio_write(ioaddr, 31, 0x0001);
-		mdio_write(ioaddr,  9, 0x273a);
-		mdio_write(ioaddr, 14, 0x7bfb);
-		mdio_write(ioaddr, 27, 0x841e);
-
 		mdio_write(ioaddr, 31, 0x0002);
 		mdio_write(ioaddr,  1, 0x90d0);
 		mdio_write(ioaddr, 31, 0x0000);
@@ -1855,6 +1850,8 @@ rtl8169_hw_start(struct net_device *dev)
 
 
 	RTL_W8(Cfg9346, Cfg9346_Unlock);
+
+	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
 	RTL_W8(EarlyTxThres, EarlyTxThld);
 
 	/* Low hurts. Let's disable the filtering. */
@@ -1895,7 +1892,7 @@ rtl8169_hw_start(struct net_device *dev)
 	RTL_W32(TxDescStartAddrLow, ((u64) tp->TxPhyAddr & DMA_32BIT_MASK));
 	RTL_W32(RxDescAddrHigh, ((u64) tp->RxPhyAddr >> 32));
 	RTL_W32(RxDescAddrLow, ((u64) tp->RxPhyAddr & DMA_32BIT_MASK));
-	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
+
 	RTL_W8(Cfg9346, Cfg9346_Lock);
 
 	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
