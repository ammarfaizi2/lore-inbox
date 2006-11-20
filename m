Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966416AbWKTSoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966416AbWKTSoc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966418AbWKTSoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:44:32 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:8222 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S966416AbWKTSob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:44:31 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Nov 2006 10:44:29 -0800
Message-ID: <adaslgegdpu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Nov 2006 18:44:29.0997 (UTC) FILETIME=[E99705D0:01C70CD3]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes one small fixes for 2.6.19-rc6:

Michael S. Tsirkin (1):
      IPoIB: Clear high octet in QP number

 drivers/infiniband/ulp/ipoib/ipoib_main.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)


commit 073ae841d6a5098f7c6e17fc1f329350d950d1ce
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Thu Nov 16 10:59:12 2006 +0200

    IPoIB: Clear high octet in QP number
    
    IPoIB assumes that high (reserved) octet in the hardware address is 0,
    and copies it into the QPN.  This violates RFC 4391 (which requires
    that the high 8 bits are ignored on receive), and will result in an
    invalid QPN being used when interoperating with IPoIB connected mode.
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 1eaf00e..85522da 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -49,6 +49,8 @@ #include <linux/in.h>
 
 #include <net/dst.h>
 
+#define IPOIB_QPN(ha) (be32_to_cpup((__be32 *) ha) & 0xffffff)
+
 MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("IP-over-InfiniBand net driver");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -520,8 +522,7 @@ static void neigh_add_path(struct sk_buf
 		memcpy(&neigh->dgid.raw, &path->pathrec.dgid.raw,
 		       sizeof(union ib_gid));
 
-		ipoib_send(dev, skb, path->ah,
-			   be32_to_cpup((__be32 *) skb->dst->neighbour->ha));
+		ipoib_send(dev, skb, path->ah, IPOIB_QPN(skb->dst->neighbour->ha));
 	} else {
 		neigh->ah  = NULL;
 		__skb_queue_tail(&neigh->queue, skb);
@@ -599,8 +600,7 @@ static void unicast_arp_send(struct sk_b
 		ipoib_dbg(priv, "Send unicast ARP to %04x\n",
 			  be16_to_cpu(path->pathrec.dlid));
 
-		ipoib_send(dev, skb, path->ah,
-			   be32_to_cpup((__be32 *) phdr->hwaddr));
+		ipoib_send(dev, skb, path->ah, IPOIB_QPN(phdr->hwaddr));
 	} else if ((path->query || !path_rec_start(dev, path)) &&
 		   skb_queue_len(&path->queue) < IPOIB_MAX_PATH_REC_QUEUE) {
 		/* put pseudoheader back on for next time */
@@ -661,8 +661,7 @@ static int ipoib_start_xmit(struct sk_bu
 				goto out;
 			}
 
-			ipoib_send(dev, skb, neigh->ah,
-				   be32_to_cpup((__be32 *) skb->dst->neighbour->ha));
+			ipoib_send(dev, skb, neigh->ah, IPOIB_QPN(skb->dst->neighbour->ha));
 			goto out;
 		}
 
@@ -694,7 +693,7 @@ static int ipoib_start_xmit(struct sk_bu
 					   IPOIB_GID_FMT "\n",
 					   skb->dst ? "neigh" : "dst",
 					   be16_to_cpup((__be16 *) skb->data),
-					   be32_to_cpup((__be32 *) phdr->hwaddr),
+					   IPOIB_QPN(phdr->hwaddr),
 					   IPOIB_GID_RAW_ARG(phdr->hwaddr + 4));
 				dev_kfree_skb_any(skb);
 				++priv->stats.tx_dropped;
@@ -777,7 +776,7 @@ static void ipoib_neigh_destructor(struc
 
 	ipoib_dbg(priv,
 		  "neigh_destructor for %06x " IPOIB_GID_FMT "\n",
-		  be32_to_cpup((__be32 *) n->ha),
+		  IPOIB_QPN(n->ha),
 		  IPOIB_GID_RAW_ARG(n->ha + 4));
 
 	spin_lock_irqsave(&priv->lock, flags);
