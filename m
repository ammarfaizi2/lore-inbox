Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVD0KsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVD0KsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVD0KsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:48:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:53470 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261398AbVD0Krp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:47:45 -0400
Date: Wed, 27 Apr 2005 12:49:11 +0200
From: Jiri Benc <jbenc@suse.cz>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-Id: <20050427124911.6212670f@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With integrated ALi/ULi M5261 ethernet controller using tulip driver,
autonegotation doesn't work and card is forced to 10 Mbps half-duplex mode.

I found two problems with tulip driver regarding ULi5261.

1. In tulip_up() media selection does not work properly. No media from
EEPROM media list is set as default in ULi's EEPROM. In such case tulip
driver searches for first non-fullduplex media.

I have no idea why the search is not performed for MII capable media first.
Maybe because of problems with some other cards?

EEPROM media list is reported to be as follows:

tulip0:  EEPROM default media type Autosense.
tulip0:  MII interface PHY 1, setup/reset sequences 0/2 long, capabilities 00 01.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  Index #1 - Media 10baseT (#0) described by a <unknown> (128) block.
tulip0:  Index #2 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #3 - Media 10base2 (#1) described by a 21140 non-MII (0) block.
tulip0:  Index #4 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
tulip0:  Index #5 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.

I added code that performs search for MII capable media in case of ULi5261
card. Shouldn't it be performed generally?

2. PHY chip DM9161E used on my M5261 seems to claim (in BMCR register) that
autonegotiation is enabled after initialization, but it needs to set
BMCR_ANRESTART for autonegotiation to work. Without forcing of restart of
autonegotiation, MII_LPA returns always 0.

Is there any way to detect that DM9161E is used? It may be used with another
ethernet cards (and there may be another PHY used in M5261 as well), so
restarting autonegotiation in case of ULi5261 doesn't seem to be
a solution.

The only way I see is to always restart autonegotiation in tulip_find_mii().
It probably has the side-effect that other cards with autonegotiation
enabled by default will perform autonegotiation twice.

Thanks for your suggestions.


--- linux-2.6.12-rc3/drivers/net/tulip/media.c
+++ linux-2.6.12-rc3-patched/drivers/net/tulip/media.c
@@ -517,10 +517,11 @@ void __devinit tulip_find_mii (struct ne
 		/* Enable autonegotiation: some boards default to off. */
 		if (tp->default_port == 0) {
 			new_bmcr = mii_reg0 | BMCR_ANENABLE;
-			if (new_bmcr != mii_reg0) {
-				new_bmcr |= BMCR_ANRESTART;
-				ane_switch = 1;
-			}
+			/* DM9161E PHY seems to need to restart
+			 * autonegotiation even if it defaults to enabled.
+			 */
+			new_bmcr |= BMCR_ANRESTART;
+			ane_switch = 1;
 		}
 		/* ...or disable nway, if forcing media */
 		else {
--- linux-2.6.12-rc3/drivers/net/tulip/tulip_core.c
+++ linux-2.6.12-rc3-patched/drivers/net/tulip/tulip_core.c
@@ -383,6 +383,11 @@ static void tulip_up(struct net_device *
 				goto media_picked;
 			}
 	}
+	if (tp->chip_id == ULI526X) {
+		for (i = tp->mtable->leafcount - 1; i >= 0; i--)
+			if (tulip_media_cap[tp->mtable->mleaf[i].media] & MediaIsMII)
+				goto media_picked;
+	}
 	/* Start sensing first non-full-duplex media. */
 	for (i = tp->mtable->leafcount - 1;
 		 (tulip_media_cap[tp->mtable->mleaf[i].media] & MediaAlwaysFD) && i > 0; i--)


--
Jiri Benc
SUSE Labs
