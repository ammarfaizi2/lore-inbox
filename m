Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWDBTTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWDBTTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDBTTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 15:19:32 -0400
Received: from stinky.trash.net ([213.144.137.162]:17621 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751272AbWDBTTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 15:19:32 -0400
Message-ID: <443023C2.6020401@trash.net>
Date: Sun, 02 Apr 2006 21:19:30 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: bridge+netfilter broken for IP fragments in 2.6.16?
References: <20060401143011.GA28333@swan.nt.tuwien.ac.at>
In-Reply-To: <20060401143011.GA28333@swan.nt.tuwien.ac.at>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090401080106020801050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090401080106020801050701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thomas Zeitlhofer wrote:
> I have set up a bridge with two ports:
> 
> # brctl show br0
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.000021f23d58       no              eth1
>                                                         tap1
> 
> Using 2.6.16/.1 non fragmented IP packets are passing the bridge without
> problems, but fragmented IP packets do not show up on the outgoing
> interface. E.g., for fragmented traffic coming in from tap1 and going
> out via eth1 tcpdump shows:
> 
>   1) on tap1: fragmented packets
>   2) on br0: the defragmented packet (connection tracking)
>   3) on eth1: no packet!?
> 
> This breaks IPsec connections for example.
> 
> 
> Doing the same on 2.6.15.x shows:
> 
>   1) on tap1: fragmented packets
>   2) on br0: the defragmented packet (connection tracking)
>   3) on eth1: fragmented packets

Are you sure this is correct? I think in 2.6.15 you should see
the fragments on br0 already.

Anyway, since 2.6.16 ip_conntrack doesn't do refragmentation anymore
but relies on fragmentation in the IP layer. Purely bridged packets
don't go through the IP layer, so the bridge netfilter code needs to
take care of fragmentation itself. Please try if this patch helps.

> and IPsec connections are ok.

This is probably a different issue. Please describe your setup
(IPsec, NAT and filtering).


--------------090401080106020801050701
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix fragmentation issues with bridge netfilter

The conntrack code doesn't do re-fragmentation of defragmented packets
anymore but relies on fragmentation in the IP layer. Purely bridged
packets don't pass through the IP layer, so the bridge netfilter code
needs to take care of fragmentation itself.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 1e6bb6c683e418cf4ae6f69b7005edcfe29bc882
tree 2b7e567935658cee4ec169dab56ff8fd592c2d36
parent 9a1875e60e61b563737d8d1fc3876b279710fe93
author Patrick McHardy <kaber@trash.net> Sun, 02 Apr 2006 21:17:14 +0200
committer Patrick McHardy <kaber@trash.net> Sun, 02 Apr 2006 21:17:14 +0200

 include/net/ip.h          |    1 +
 net/bridge/br_netfilter.c |   13 +++++++++++--
 net/ipv4/ip_output.c      |    4 +---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 8fe6156..3d2e5ca 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -95,6 +95,7 @@ extern int		ip_local_deliver(struct sk_b
 extern int		ip_mr_input(struct sk_buff *skb);
 extern int		ip_output(struct sk_buff *skb);
 extern int		ip_mc_output(struct sk_buff *skb);
+extern int		ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff *));
 extern int		ip_do_nat(struct sk_buff *skb);
 extern void		ip_send_check(struct iphdr *ip);
 extern int		ip_queue_xmit(struct sk_buff *skb, int ipfragok);
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index f29450b..3da9264 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -765,6 +765,15 @@ out:
 	return NF_STOLEN;
 }
 
+static int br_nf_dev_queue_xmit(struct sk_buff *skb)
+{
+	if (skb->protocol == htons(ETH_P_IP) &&
+	    skb->len > skb->dev->mtu &&
+	    !(skb_shinfo(skb)->ufo_size || skb_shinfo(skb)->tso_size))
+		return ip_fragment(skb, br_dev_queue_push_xmit);
+	else
+		return br_dev_queue_push_xmit(skb);
+}
 
 /* PF_BRIDGE/POST_ROUTING ********************************************/
 static unsigned int br_nf_post_routing(unsigned int hook, struct sk_buff **pskb,
@@ -824,7 +833,7 @@ static unsigned int br_nf_post_routing(u
 		realoutdev = nf_bridge->netoutdev;
 #endif
 	NF_HOOK(pf, NF_IP_POST_ROUTING, skb, NULL, realoutdev,
-		br_dev_queue_push_xmit);
+		br_nf_dev_queue_xmit);
 
 	return NF_STOLEN;
 
@@ -869,7 +878,7 @@ static unsigned int ip_sabotage_out(unsi
 
 	if ((out->hard_start_xmit == br_dev_xmit &&
 	     okfn != br_nf_forward_finish &&
-	     okfn != br_nf_local_out_finish && okfn != br_dev_queue_push_xmit)
+	     okfn != br_nf_local_out_finish && okfn != br_nf_dev_queue_xmit)
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	    || ((out->priv_flags & IFF_802_1Q_VLAN) &&
 		VLAN_DEV_INFO(out)->real_dev->hard_start_xmit == br_dev_xmit)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index f75ff1d..af6a106 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -86,8 +86,6 @@
 
 int sysctl_ip_default_ttl = IPDEFTTL;
 
-static int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff*));
-
 /* Generate a checksum for an outgoing IP datagram. */
 __inline__ void ip_send_check(struct iphdr *iph)
 {
@@ -421,7 +419,7 @@ static void ip_copy_metadata(struct sk_b
  *	single device frame, and queue such a frame for sending.
  */
 
-static int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff*))
+int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff*))
 {
 	struct iphdr *iph;
 	int raw = 0;

--------------090401080106020801050701--
