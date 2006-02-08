Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWBHGns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWBHGns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWBHGnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:46 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64130 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161025AbWBHGn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:28 -0500
Message-Id: <20060208064915.644489000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 19/23] [PATCH] bridge: netfilter races on device removal
Content-Disposition: inline; filename=bridge-netfilter-races-on-device-removal.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix bridge netfilter to handle case where interface is deleted
from bridge while packet is being processed (on other CPU).

Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=5803

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/bridge/br_netfilter.c |   55 +++++++++++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 17 deletions(-)

Index: linux-2.6.15.3/net/bridge/br_netfilter.c
===================================================================
--- linux-2.6.15.3.orig/net/bridge/br_netfilter.c
+++ linux-2.6.15.3/net/bridge/br_netfilter.c
@@ -47,9 +47,6 @@
 #define store_orig_dstaddr(skb)	 (skb_origaddr(skb) = (skb)->nh.iph->daddr)
 #define dnat_took_place(skb)	 (skb_origaddr(skb) != (skb)->nh.iph->daddr)
 
-#define has_bridge_parent(device)	((device)->br_port != NULL)
-#define bridge_parent(device)		((device)->br_port->br->dev)
-
 #ifdef CONFIG_SYSCTL
 static struct ctl_table_header *brnf_sysctl_header;
 static int brnf_call_iptables = 1;
@@ -94,6 +91,12 @@ static struct rtable __fake_rtable = {
 	.rt_flags	= 0,
 };
 
+static inline struct net_device *bridge_parent(const struct net_device *dev)
+{
+	struct net_bridge_port *port = rcu_dereference(dev->br_port);
+
+	return port ? port->br->dev : NULL;
+}
 
 /* PF_BRIDGE/PRE_ROUTING *********************************************/
 /* Undo the changes made for ip6tables PREROUTING and continue the
@@ -185,11 +188,15 @@ static int br_nf_pre_routing_finish_brid
 	skb->nf_bridge->mask ^= BRNF_NF_BRIDGE_PREROUTING;
 
 	skb->dev = bridge_parent(skb->dev);
-	if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
-		skb_pull(skb, VLAN_HLEN);
-		skb->nh.raw += VLAN_HLEN;
+	if (!skb->dev)
+		kfree_skb(skb);
+	else {
+		if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
+			skb_pull(skb, VLAN_HLEN);
+			skb->nh.raw += VLAN_HLEN;
+		}
+		skb->dst->output(skb);
 	}
-	skb->dst->output(skb);
 	return 0;
 }
 
@@ -266,7 +273,7 @@ bridged_dnat:
 }
 
 /* Some common code for IPv4/IPv6 */
-static void setup_pre_routing(struct sk_buff *skb)
+static struct net_device *setup_pre_routing(struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = skb->nf_bridge;
 
@@ -278,6 +285,8 @@ static void setup_pre_routing(struct sk_
 	nf_bridge->mask |= BRNF_NF_BRIDGE_PREROUTING;
 	nf_bridge->physindev = skb->dev;
 	skb->dev = bridge_parent(skb->dev);
+
+	return skb->dev;
 }
 
 /* We only check the length. A bridge shouldn't do any hop-by-hop stuff anyway */
@@ -372,7 +381,8 @@ static unsigned int br_nf_pre_routing_ip
  	nf_bridge_put(skb->nf_bridge);
 	if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
 		return NF_DROP;
-	setup_pre_routing(skb);
+	if (!setup_pre_routing(skb))
+		return NF_DROP;
 
 	NF_HOOK(PF_INET6, NF_IP6_PRE_ROUTING, skb, skb->dev, NULL,
 		br_nf_pre_routing_finish_ipv6);
@@ -409,7 +419,6 @@ static unsigned int br_nf_pre_routing(un
 
 		if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
 			skb_pull(skb, VLAN_HLEN);
-			(skb)->nh.raw += VLAN_HLEN;
 		}
 		return br_nf_pre_routing_ipv6(hook, skb, in, out, okfn);
 	}
@@ -426,7 +435,6 @@ static unsigned int br_nf_pre_routing(un
 
 	if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
 		skb_pull(skb, VLAN_HLEN);
-		(skb)->nh.raw += VLAN_HLEN;
 	}
 
 	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
@@ -456,7 +464,8 @@ static unsigned int br_nf_pre_routing(un
  	nf_bridge_put(skb->nf_bridge);
 	if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
 		return NF_DROP;
-	setup_pre_routing(skb);
+	if (!setup_pre_routing(skb))
+		return NF_DROP;
 	store_orig_dstaddr(skb);
 
 	NF_HOOK(PF_INET, NF_IP_PRE_ROUTING, skb, skb->dev, NULL,
@@ -530,11 +539,16 @@ static unsigned int br_nf_forward_ip(uns
 	struct sk_buff *skb = *pskb;
 	struct nf_bridge_info *nf_bridge;
 	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
+	struct net_device *parent;
 	int pf;
 
 	if (!skb->nf_bridge)
 		return NF_ACCEPT;
 
+	parent = bridge_parent(out);
+	if (!parent)
+		return NF_DROP;
+
 	if (skb->protocol == __constant_htons(ETH_P_IP) || IS_VLAN_IP)
 		pf = PF_INET;
 	else
@@ -555,8 +569,8 @@ static unsigned int br_nf_forward_ip(uns
 	nf_bridge->mask |= BRNF_BRIDGED;
 	nf_bridge->physoutdev = skb->dev;
 
-	NF_HOOK(pf, NF_IP_FORWARD, skb, bridge_parent(in),
-		bridge_parent(out), br_nf_forward_finish);
+	NF_HOOK(pf, NF_IP_FORWARD, skb, bridge_parent(in), parent,
+		br_nf_forward_finish);
 
 	return NF_STOLEN;
 }
@@ -679,6 +693,8 @@ static unsigned int br_nf_local_out(unsi
 		goto out;
 	}
 	realoutdev = bridge_parent(skb->dev);
+	if (!realoutdev)
+		return NF_DROP;
 
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	/* iptables should match -o br0.x */
@@ -692,9 +708,11 @@ static unsigned int br_nf_local_out(unsi
 	/* IP forwarded traffic has a physindev, locally
 	 * generated traffic hasn't. */
 	if (realindev != NULL) {
-		if (!(nf_bridge->mask & BRNF_DONT_TAKE_PARENT) &&
-		    has_bridge_parent(realindev))
-			realindev = bridge_parent(realindev);
+		if (!(nf_bridge->mask & BRNF_DONT_TAKE_PARENT) ) {
+			struct net_device *parent = bridge_parent(realindev);
+			if (parent)
+				realindev = parent;
+		}
 
 		NF_HOOK_THRESH(pf, NF_IP_FORWARD, skb, realindev,
 			       realoutdev, br_nf_local_out_finish,
@@ -734,6 +752,9 @@ static unsigned int br_nf_post_routing(u
 	if (!nf_bridge)
 		return NF_ACCEPT;
 
+	if (!realoutdev)
+		return NF_DROP;
+
 	if (skb->protocol == __constant_htons(ETH_P_IP) || IS_VLAN_IP)
 		pf = PF_INET;
 	else

--
