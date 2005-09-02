Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbVIBW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVIBW7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbVIBW7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:59:05 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:13192 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161106AbVIBW7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:59:01 -0400
Date: Sat, 3 Sep 2005 00:56:16 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pascal.chapperon@wanadoo.fr,
       lars.vahlenberg@mandator.com, Alexey Dobriyan <adobriyan@gmail.com>,
       apatard@mandriva.com, jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.13-git3 3/5] sis190: make 10Mbps the default when handling the StationControl register
Message-ID: <20050902225616.GD25687@electric-eye.fr.zoreil.com>
References: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does three things:
- widen the access to the StationControl register (note the SIS_W16
  versus SIS_W32 change);
- default to 10Mbps half duplex when the LPA can not be evaluated
  (reg31->ctl is identical for both). It can be argued that it makes
  sense as the lowest common denominator when everything else failed.
  Btw it works better than the current code. :o)
- remove some enums: they do not document anymore.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN a/drivers/net/sis190.c~sis190-190 b/drivers/net/sis190.c
--- a/drivers/net/sis190.c~sis190-190	2005-09-02 23:27:44.715929373 +0200
+++ b/drivers/net/sis190.c	2005-09-02 23:27:44.741925171 +0200
@@ -179,14 +179,6 @@ enum sis190_register_content {
 	TxInterFrameGapShift	= 24,
 	TxDMAShift		= 8, /* DMA burst value (0-7) is shift this many bits */
 
-	/* StationControl */
-	_1000bpsF		= 0x1c00,
-	_1000bpsH		= 0x0c00,
-	_100bpsF		= 0x1800,
-	_100bpsH		= 0x0800,
-	_10bpsF			= 0x1400,
-	_10bpsH			= 0x0400,
-
 	LinkStatus		= 0x02,		// unused
 	FullDup			= 0x01,		// unused
 
@@ -886,11 +878,6 @@ static void sis190_hw_start(struct net_d
 
 	SIS_W32(IntrStatus, 0xffffffff);
 	SIS_W32(IntrMask, 0x0);
-	/*
-	 * Default is 100Mbps.
-	 * A bit strange: 100Mbps is 0x1801 elsewhere -- FR 2005/06/09
-	 */
-	SIS_W16(StationControl, 0x1901);
 	SIS_W32(GMIIControl, 0x0);
 	SIS_W32(TxMacControl, 0x60);
 	SIS_W16(RxMacControl, 0x02);
@@ -937,29 +924,23 @@ static void sis190_phy_task(void * data)
 		/* Rejoice ! */
 		struct {
 			int val;
+			u32 ctl;
 			const char *msg;
-			u16 ctl;
 		} reg31[] = {
-			{ LPA_1000XFULL | LPA_SLCT,
-				"1000 Mbps Full Duplex",
-				0x01 | _1000bpsF },
-			{ LPA_1000XHALF | LPA_SLCT,
-				"1000 Mbps Half Duplex",
-				0x01 | _1000bpsH },
-			{ LPA_100FULL,
-				"100 Mbps Full Duplex",
-				0x01 | _100bpsF },
-			{ LPA_100HALF,
-				"100 Mbps Half Duplex",
-				0x01 | _100bpsH },
-			{ LPA_10FULL,
-				"10 Mbps Full Duplex",
-				0x01 | _10bpsF },
-			{ LPA_10HALF,
-				"10 Mbps Half Duplex",
-				0x01 | _10bpsH },
-			{ 0, "unknown", 0x0000 }
-		}, *p;
+			{ LPA_1000XFULL | LPA_SLCT, 0x07000c00 | 0x00001000,
+				"1000 Mbps Full Duplex" },
+			{ LPA_1000XHALF | LPA_SLCT, 0x07000c00,
+				"1000 Mbps Half Duplex" },
+			{ LPA_100FULL, 0x04000800 | 0x00001000,
+				"100 Mbps Full Duplex" },
+			{ LPA_100HALF, 0x04000800,
+				"100 Mbps Half Duplex" },
+			{ LPA_10FULL, 0x04000400 | 0x00001000,
+				"10 Mbps Full Duplex" },
+			{ LPA_10HALF, 0x04000400,
+				"10 Mbps Half Duplex" },
+			{ 0, 0x04000400, "unknown" }
+ 		}, *p;
 		u16 adv;
 
 		val = mdio_read(ioaddr, phy_id, 0x1f);
@@ -972,12 +953,15 @@ static void sis190_phy_task(void * data)
 
 		val &= adv;
 
-		for (p = reg31; p->ctl; p++) {
+		for (p = reg31; p->val; p++) {
 			if ((val & p->val) == p->val)
 				break;
 		}
-		if (p->ctl)
-			SIS_W16(StationControl, p->ctl);
+
+		p->ctl |= SIS_R32(StationControl) & ~0x0f001c00;
+
+		SIS_W32(StationControl, p->ctl);
+
 		net_link(tp, KERN_INFO "%s: link on %s mode.\n", dev->name,
 			 p->msg);
 		netif_carrier_on(dev);

_
