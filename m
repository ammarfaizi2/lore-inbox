Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCOMVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCOMVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCOMVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:21:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41485 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261189AbVCOMUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:20:20 -0500
Date: Tue, 15 Mar 2005 13:20:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/802/fc.c: remove fc_type_trans
Message-ID: <20050315122017.GF3189@stusta.de>
References: <20050306205754.GO5070@stusta.de> <20050314214940.4947ccd9.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314214940.4947ccd9.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 09:49:40PM -0800, David S. Miller wrote:
> On Sun, 6 Mar 2005 21:57:54 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > The only user of fc_type_trans (drivers/net/fc/iph5526.c) is BROKEN in 
> > 2.6 and removed in -mm.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> That driver isn't in Linus's tree any longer either.  Just delete
> the thing altogether instead of #if 0'ing it.
>...

Updated patch:


<--  snip  -->


The only user of fc_type_trans (drivers/net/fc/iph5526.c) is removed in 
Linus' tree.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/fcdevice.h |    2 --
 net/802/fc.c             |   34 ----------------------------------
 2 files changed, 36 deletions(-)

--- linux-2.6.11-mm1-full/include/linux/fcdevice.h.old	2005-03-06 21:40:36.000000000 +0100
+++ linux-2.6.11-mm1-full/include/linux/fcdevice.h	2005-03-06 21:41:07.000000000 +0100
@@ -24,12 +24,10 @@
 #define _LINUX_FCDEVICE_H
 
 
 #include <linux/if_fc.h>
 
 #ifdef __KERNEL__
-extern unsigned short	fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
-
 extern struct net_device *alloc_fcdev(int sizeof_priv);
 #endif
 
 #endif	/* _LINUX_FCDEVICE_H */
--- linux-2.6.11-mm3-full/net/802/fc.c.old	2005-03-15 13:02:13.000000000 +0100
+++ linux-2.6.11-mm3-full/net/802/fc.c	2005-03-15 13:02:34.000000000 +0100
@@ -97,40 +97,6 @@
 #endif
 }
 
-unsigned short
-fc_type_trans(struct sk_buff *skb, struct net_device *dev)
-{
-	struct fch_hdr *fch = (struct fch_hdr *)skb->data;
-	struct fcllc *fcllc;
-
-	skb->mac.raw = skb->data;
-	fcllc = (struct fcllc *)(skb->data + sizeof (struct fch_hdr) + 2);
-	skb_pull(skb, sizeof (struct fch_hdr) + 2);
-
-	if (*fch->daddr & 1) {
-		if (!memcmp(fch->daddr, dev->broadcast, FC_ALEN))
-			skb->pkt_type = PACKET_BROADCAST;
-		else
-			skb->pkt_type = PACKET_MULTICAST;
-	} else if (dev->flags & IFF_PROMISC) {
-		if (memcmp(fch->daddr, dev->dev_addr, FC_ALEN))
-			skb->pkt_type = PACKET_OTHERHOST;
-	}
-
-	/*
-	 * Strip the SNAP header from ARP packets since we don't pass
-	 * them through to the 802.2/SNAP layers.
-	 */
-	if (fcllc->dsap == EXTENDED_SAP &&
-	    (fcllc->ethertype == ntohs(ETH_P_IP) ||
-	     fcllc->ethertype == ntohs(ETH_P_ARP))) {
-		skb_pull(skb, sizeof (struct fcllc));
-		return fcllc->ethertype;
-	}
-
-	return ntohs(ETH_P_802_2);
-}
-
 static void fc_setup(struct net_device *dev)
 {
 	dev->hard_header	= fc_header;

