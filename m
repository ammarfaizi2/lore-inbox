Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946511AbWKAFyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946511AbWKAFyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946378AbWKAFhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:37:20 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65168 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946274AbWKAFhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:37:02 -0500
Message-Id: <20061101053706.952829000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:54 -0800
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
Subject: [PATCH 14/61] sky2: accept multicast pause frames
Content-Disposition: inline; filename=sky2-accept-multicast-pause-frames.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

When using flow control, the PHY needs to accept multicast pause frames.
Without this fix, these frames were getting discarded by the PHY before
doing any flow control.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/net/sky2.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.18.1.orig/drivers/net/sky2.c
+++ linux-2.6.18.1/drivers/net/sky2.c
@@ -2745,6 +2745,14 @@ static int sky2_set_mac_address(struct n
 	return 0;
 }
 
+static void inline sky2_add_filter(u8 filter[8], const u8 *addr)
+{
+	u32 bit;
+
+	bit = ether_crc(ETH_ALEN, addr) & 63;
+	filter[bit >> 3] |= 1 << (bit & 7);
+}
+
 static void sky2_set_multicast(struct net_device *dev)
 {
 	struct sky2_port *sky2 = netdev_priv(dev);
@@ -2753,6 +2761,7 @@ static void sky2_set_multicast(struct ne
 	struct dev_mc_list *list = dev->mc_list;
 	u16 reg;
 	u8 filter[8];
+	static const u8 pause_mc_addr[ETH_ALEN] = { 0x1, 0x80, 0xc2, 0x0, 0x0, 0x1 };
 
 	memset(filter, 0, sizeof(filter));
 
@@ -2763,16 +2772,17 @@ static void sky2_set_multicast(struct ne
 		reg &= ~(GM_RXCR_UCF_ENA | GM_RXCR_MCF_ENA);
 	else if ((dev->flags & IFF_ALLMULTI) || dev->mc_count > 16)	/* all multicast */
 		memset(filter, 0xff, sizeof(filter));
-	else if (dev->mc_count == 0)	/* no multicast */
+	else if (dev->mc_count == 0 && !sky2->rx_pause)
 		reg &= ~GM_RXCR_MCF_ENA;
 	else {
 		int i;
 		reg |= GM_RXCR_MCF_ENA;
 
-		for (i = 0; list && i < dev->mc_count; i++, list = list->next) {
-			u32 bit = ether_crc(ETH_ALEN, list->dmi_addr) & 0x3f;
-			filter[bit / 8] |= 1 << (bit % 8);
-		}
+		if (sky2->rx_pause)
+			sky2_add_filter(filter, pause_mc_addr);
+
+		for (i = 0; list && i < dev->mc_count; i++, list = list->next)
+			sky2_add_filter(filter, list->dmi_addr);
 	}
 
 	gma_write16(hw, port, GM_MC_ADDR_H1,

--
