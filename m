Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946542AbWKAFwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946542AbWKAFwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946534AbWKAFlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:41:42 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34962 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946524AbWKAFlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:41:36 -0500
Message-Id: <20061101054143.953390000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:16 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 36/61] sky2: 88E803X transmit lockup (2.6.18)
Content-Disposition: inline; filename=sky2-88e803x-transmit-lockup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

The reason sky2 driver was locking up on transmit on the Yukon-FE chipset
is that it was misconfiguring the internal RAM buffer so the transmitter
and receiver were sharing the same space.  It is a wonder it worked at all!

This patch addresses this, and fixes an easily reproducible hang on Transmit.
Only the Yukon-FE chip is Marvell 88E803X (10/100 only) are affected.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/net/sky2.c |   33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

--- linux-2.6.18.1.orig/drivers/net/sky2.c
+++ linux-2.6.18.1/drivers/net/sky2.c
@@ -690,16 +690,10 @@ static void sky2_mac_init(struct sky2_hw
 
 }
 
-/* Assign Ram Buffer allocation.
- * start and end are in units of 4k bytes
- * ram registers are in units of 64bit words
- */
-static void sky2_ramset(struct sky2_hw *hw, u16 q, u8 startk, u8 endk)
+/* Assign Ram Buffer allocation in units of 64bit (8 bytes) */
+static void sky2_ramset(struct sky2_hw *hw, u16 q, u32 start, u32 end)
 {
-	u32 start, end;
-
-	start = startk * 4096/8;
-	end = (endk * 4096/8) - 1;
+	pr_debug(PFX "q %d %#x %#x\n", q, start, end);
 
 	sky2_write8(hw, RB_ADDR(q, RB_CTRL), RB_RST_CLR);
 	sky2_write32(hw, RB_ADDR(q, RB_START), start);
@@ -708,7 +702,7 @@ static void sky2_ramset(struct sky2_hw *
 	sky2_write32(hw, RB_ADDR(q, RB_RP), start);
 
 	if (q == Q_R1 || q == Q_R2) {
-		u32 space = (endk - startk) * 4096/8;
+		u32 space = end - start + 1;
 		u32 tp = space - space/4;
 
 		/* On receive queue's set the thresholds
@@ -1090,19 +1084,16 @@ static int sky2_up(struct net_device *de
 
 	sky2_mac_init(hw, port);
 
-	/* Determine available ram buffer space (in 4K blocks).
-	 * Note: not sure about the FE setting below yet
-	 */
-	if (hw->chip_id == CHIP_ID_YUKON_FE)
-		ramsize = 4;
-	else
-		ramsize = sky2_read8(hw, B2_E_0);
+	/* Determine available ram buffer space in qwords.  */
+	ramsize = sky2_read8(hw, B2_E_0) * 4096/8;
 
-	/* Give transmitter one third (rounded up) */
-	rxspace = ramsize - (ramsize + 2) / 3;
+	if (ramsize > 6*1024/8)
+		rxspace = ramsize - (ramsize + 2) / 3;
+	else
+		rxspace = ramsize / 2;
 
-	sky2_ramset(hw, rxqaddr[port], 0, rxspace);
-	sky2_ramset(hw, txqaddr[port], rxspace, ramsize);
+	sky2_ramset(hw, rxqaddr[port], 0, rxspace-1);
+	sky2_ramset(hw, txqaddr[port], rxspace, ramsize-1);
 
 	/* Make sure SyncQ is disabled */
 	sky2_write8(hw, RB_ADDR(port == 0 ? Q_XS1 : Q_XS2, RB_CTRL),

--
