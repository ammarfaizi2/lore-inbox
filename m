Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWB0WrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWB0WrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWB0Wqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:46:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17281 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751750AbWB0WbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:18 -0500
Message-Id: <20060227223401.685778000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:29 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [patch 29/39] [PATCH] skge: speed setting
Content-Disposition: inline; filename=skge-speed-setting.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This is a clone of John Linville's fixed for speed setting on sky2 driver.
The skge driver has the same code (and bug). It would not allow manually forcing
100 and 10 mbit.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/skge.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

--- linux-2.6.15.4.orig/drivers/net/skge.c
+++ linux-2.6.15.4/drivers/net/skge.c
@@ -1698,6 +1698,7 @@ static void yukon_mac_init(struct skge_h
 	skge_write32(hw, SK_REG(port, GPHY_CTRL), reg | GPC_RST_SET);
 	skge_write32(hw, SK_REG(port, GPHY_CTRL), reg | GPC_RST_CLR);
 	skge_write32(hw, SK_REG(port, GMAC_CTRL), GMC_PAUSE_ON | GMC_RST_CLR);
+
 	if (skge->autoneg == AUTONEG_DISABLE) {
 		reg = GM_GPCR_AU_ALL_DIS;
 		gma_write16(hw, port, GM_GP_CTRL,
@@ -1705,16 +1706,23 @@ static void yukon_mac_init(struct skge_h
 
 		switch (skge->speed) {
 		case SPEED_1000:
+			reg &= ~GM_GPCR_SPEED_100;
 			reg |= GM_GPCR_SPEED_1000;
-			/* fallthru */
+			break;
 		case SPEED_100:
+			reg &= ~GM_GPCR_SPEED_1000;
 			reg |= GM_GPCR_SPEED_100;
+			break;
+		case SPEED_10:
+			reg &= ~(GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100);
+			break;
 		}
 
 		if (skge->duplex == DUPLEX_FULL)
 			reg |= GM_GPCR_DUP_FULL;
 	} else
 		reg = GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100 | GM_GPCR_DUP_FULL;
+
 	switch (skge->flow_control) {
 	case FLOW_MODE_NONE:
 		skge_write32(hw, SK_REG(port, GMAC_CTRL), GMC_PAUSE_OFF);

--
