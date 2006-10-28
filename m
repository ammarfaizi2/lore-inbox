Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWJ1AMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWJ1AMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 20:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWJ1AMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 20:12:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51336
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751003AbWJ1AMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 20:12:20 -0400
Date: Fri, 27 Oct 2006 17:12:10 -0700 (PDT)
Message-Id: <20061027.171210.41635662.davem@davemloft.net>
To: stefanr@s5r6.in-berlin.de
Cc: simoneau@ele.uri.edu, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
From: David Miller <davem@davemloft.net>
In-Reply-To: <452CE492.2080607@s5r6.in-berlin.de>
References: <20061010132943.GB18539@ele.uri.edu>
	<20061010.151751.90998930.davem@davemloft.net>
	<452CE492.2080607@s5r6.in-berlin.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Wed, 11 Oct 2006 14:33:22 +0200

> Please keep linux1394-devel informed too. (Now added to Cc list.)

No problem.

Here is the current patch I have Will testing.  It should fix
all the unaligned u64 pointer dereferences.

Do you guys mind if I push this into my next batch of 2.6.19-rcX
networking bug fixes, assuming that testing goes alright for
Will?

Thanks.

diff --git a/drivers/ieee1394/eth1394.c b/drivers/ieee1394/eth1394.c
index 8a7b8fa..31e5cc4 100644
--- a/drivers/ieee1394/eth1394.c
+++ b/drivers/ieee1394/eth1394.c
@@ -64,6 +64,7 @@ #include <linux/bitops.h>
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
 #include <asm/delay.h>
+#include <asm/unaligned.h>
 #include <net/arp.h>
 
 #include "config_roms.h"
@@ -491,7 +492,7 @@ static void ether1394_reset_priv (struct
 	int i;
 	struct eth1394_priv *priv = netdev_priv(dev);
 	struct hpsb_host *host = priv->host;
-	u64 guid = *((u64*)&(host->csr.rom->bus_info_data[3]));
+	u64 guid = get_unaligned((u64*)&(host->csr.rom->bus_info_data[3]));
 	u16 maxpayload = 1 << (host->csr.max_rec + 1);
 	int max_speed = IEEE1394_SPEED_MAX;
 
@@ -514,8 +515,8 @@ static void ether1394_reset_priv (struct
 				      ETHER1394_GASP_OVERHEAD)));
 
 		/* Set our hardware address while we're at it */
-		*(u64*)dev->dev_addr = guid;
-		*(u64*)dev->broadcast = ~0x0ULL;
+		memcpy(dev->dev_addr, &guid, sizeof(u64));
+		memset(dev->broadcast, 0xff, sizeof(u64));
 	}
 
 	spin_unlock_irqrestore (&priv->lock, flags);
@@ -894,6 +895,7 @@ static inline u16 ether1394_parse_encap(
 		u16 maxpayload;
 		struct eth1394_node_ref *node;
 		struct eth1394_node_info *node_info;
+		__be64 guid;
 
 		/* Sanity check. MacOSX seems to be sending us 131 in this
 		 * field (atleast on my Panther G5). Not sure why. */
@@ -902,8 +904,9 @@ static inline u16 ether1394_parse_encap(
 
 		maxpayload = min(eth1394_speedto_maxpayload[sspd], (u16)(1 << (max_rec + 1)));
 
+		guid = get_unaligned(&arp1394->s_uniq_id);
 		node = eth1394_find_node_guid(&priv->ip_node_list,
-					      be64_to_cpu(arp1394->s_uniq_id));
+					      be64_to_cpu(guid));
 		if (!node) {
 			return 0;
 		}
@@ -931,10 +934,9 @@ static inline u16 ether1394_parse_encap(
 		arp_ptr += arp->ar_pln;		/* skip over sender IP addr */
 
 		if (arp->ar_op == htons(ARPOP_REQUEST))
-			/* just set ARP req target unique ID to 0 */
-			*((u64*)arp_ptr) = 0;
+			memset(arp_ptr, 0, sizeof(u64));
 		else
-			*((u64*)arp_ptr) = *((u64*)dev->dev_addr);
+			memcpy(arp_ptr, dev->dev_addr, sizeof(u64));
 	}
 
 	/* Now add the ethernet header. */
@@ -1675,8 +1677,10 @@ #endif
 		if (max_payload < dg_size + hdr_type_len[ETH1394_HDR_LF_UF])
 			priv->bc_dgl++;
 	} else {
+		__be64 guid = get_unaligned((u64 *)eth->h_dest);
+
 		node = eth1394_find_node_guid(&priv->ip_node_list,
-					      be64_to_cpu(*(u64*)eth->h_dest));
+					      be64_to_cpu(guid));
 		if (!node) {
 			ret = -EAGAIN;
 			goto fail;
