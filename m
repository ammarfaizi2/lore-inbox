Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWDMXIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWDMXIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWDMXIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:08:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:37829 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964998AbWDMXIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:36 -0400
Date: Thu, 13 Apr 2006 16:07:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, Patrick McHardy <kaber@trash.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/22] NETFILTER: Fix fragmentation issues with bridge netfilter
Message-ID: <20060413230728.GG5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="netfilter-fix-fragmentation-issues-with-bridge-netfilter.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
[NETFILTER]: Fix fragmentation issues with bridge netfilter

The conntrack code doesn't do re-fragmentation of defragmented packets
anymore but relies on fragmentation in the IP layer. Purely bridged
packets don't pass through the IP layer, so the bridge netfilter code
needs to take care of fragmentation itself.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/net/ip.h          |    1 +
 net/bridge/br_netfilter.c |   13 +++++++++++--
 net/ipv4/ip_output.c      |    6 +++---
 3 files changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.16.5.orig/include/net/ip.h
+++ linux-2.6.16.5/include/net/ip.h
@@ -95,6 +95,7 @@ extern int		ip_local_deliver(struct sk_b
 extern int		ip_mr_input(struct sk_buff *skb);
 extern int		ip_output(struct sk_buff *skb);
 extern int		ip_mc_output(struct sk_buff *skb);
+extern int		ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff *));
 extern int		ip_do_nat(struct sk_buff *skb);
 extern void		ip_send_check(struct iphdr *ip);
 extern int		ip_queue_xmit(struct sk_buff *skb, int ipfragok);
--- linux-2.6.16.5.orig/net/bridge/br_netfilter.c
+++ linux-2.6.16.5/net/bridge/br_netfilter.c
@@ -739,6 +739,15 @@ out:
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
@@ -798,7 +807,7 @@ static unsigned int br_nf_post_routing(u
 		realoutdev = nf_bridge->netoutdev;
 #endif
 	NF_HOOK(pf, NF_IP_POST_ROUTING, skb, NULL, realoutdev,
-	        br_dev_queue_push_xmit);
+	        br_nf_dev_queue_xmit);
 
 	return NF_STOLEN;
 
@@ -843,7 +852,7 @@ static unsigned int ip_sabotage_out(unsi
 	if ((out->hard_start_xmit == br_dev_xmit &&
 	    okfn != br_nf_forward_finish &&
 	    okfn != br_nf_local_out_finish &&
-	    okfn != br_dev_queue_push_xmit)
+	    okfn != br_nf_dev_queue_xmit)
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	    || ((out->priv_flags & IFF_802_1Q_VLAN) &&
 	    VLAN_DEV_INFO(out)->real_dev->hard_start_xmit == br_dev_xmit)
--- linux-2.6.16.5.orig/net/ipv4/ip_output.c
+++ linux-2.6.16.5/net/ipv4/ip_output.c
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
@@ -673,6 +671,8 @@ fail:
 	return err;
 }
 
+EXPORT_SYMBOL(ip_fragment);
+
 int
 ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk_buff *skb)
 {

--
