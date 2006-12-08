Return-Path: <linux-kernel-owner+w=401wt.eu-S1947536AbWLIAJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947536AbWLIAJA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947519AbWLHX6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:58:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37403 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947522AbWLHX6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:58:42 -0500
Message-Id: <20061209000030.357789000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, Bart De Schuymer <bdschuym@pandora.be>
Subject: [patch 14/32] NETFILTER: bridge netfilter: deal with martians correctly
Content-Disposition: inline; filename=netfilter-bridge-netfilter-deal-with-martians-correctly.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Bart De Schuymer <bdschuym@pandora.be>

The attached patch resolves an issue where a IP DNATed packet with a
martian source is forwarded while it's better to drop it. It also
resolves messages complaining about ip forwarding being disabled while
it's actually enabled. Thanks to lepton <ytht.net@gmail.com> for
reporting this problem.

This is probably a candidate for the -stable release.

Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit bb01f827bae980efdecc33fbcdc1b90f1c355b3e
tree 432a8f2843b47ccac094efea35da6f19731ed834
parent 14f5487cb9bd34cd59360d2cac7dccac9b27e8ce
author Bart De Schuymer <bdschuym@pandora.be> Mon, 04 Dec 2006 12:19:46 +0100
committer Patrick McHardy <kaber@trash.net> Mon, 04 Dec 2006 12:19:46 +0100

 net/bridge/br_netfilter.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- linux-2.6.19.orig/net/bridge/br_netfilter.c
+++ linux-2.6.19/net/bridge/br_netfilter.c
@@ -34,6 +34,7 @@
 #include <linux/netfilter_ipv6.h>
 #include <linux/netfilter_arp.h>
 #include <linux/in_route.h>
+#include <linux/inetdevice.h>
 
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -222,10 +223,14 @@ static void __br_dnat_complain(void)
  *
  * Otherwise, the packet is considered to be routed and we just
  * change the destination MAC address so that the packet will
- * later be passed up to the IP stack to be routed.
+ * later be passed up to the IP stack to be routed. For a redirected
+ * packet, ip_route_input() will give back the localhost as output device,
+ * which differs from the bridge device.
  *
  * Let us now consider the case that ip_route_input() fails:
  *
+ * This can be because the destination address is martian, in which case
+ * the packet will be dropped.
  * After a "echo '0' > /proc/sys/net/ipv4/ip_forward" ip_route_input()
  * will fail, while __ip_route_output_key() will return success. The source
  * address for __ip_route_output_key() is set to zero, so __ip_route_output_key
@@ -238,7 +243,8 @@ static void __br_dnat_complain(void)
  *
  * --Lennert, 20020411
  * --Bart, 20020416 (updated)
- * --Bart, 20021007 (updated) */
+ * --Bart, 20021007 (updated)
+ * --Bart, 20062711 (updated) */
 static int br_nf_pre_routing_finish_bridge(struct sk_buff *skb)
 {
 	if (skb->pkt_type == PACKET_OTHERHOST) {
@@ -265,15 +271,15 @@ static int br_nf_pre_routing_finish(stru
 	struct net_device *dev = skb->dev;
 	struct iphdr *iph = skb->nh.iph;
 	struct nf_bridge_info *nf_bridge = skb->nf_bridge;
+	int err;
 
 	if (nf_bridge->mask & BRNF_PKT_TYPE) {
 		skb->pkt_type = PACKET_OTHERHOST;
 		nf_bridge->mask ^= BRNF_PKT_TYPE;
 	}
 	nf_bridge->mask ^= BRNF_NF_BRIDGE_PREROUTING;
-
 	if (dnat_took_place(skb)) {
-		if (ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev)) {
+		if ((err = ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))) {
 			struct rtable *rt;
 			struct flowi fl = {
 				.nl_u = {
@@ -284,19 +290,33 @@ static int br_nf_pre_routing_finish(stru
 				},
 				.proto = 0,
 			};
+			struct in_device *in_dev = in_dev_get(dev);
+
+			/* If err equals -EHOSTUNREACH the error is due to a
+			 * martian destination or due to the fact that
+			 * forwarding is disabled. For most martian packets,
+			 * ip_route_output_key() will fail. It won't fail for 2 types of
+			 * martian destinations: loopback destinations and destination
+			 * 0.0.0.0. In both cases the packet will be dropped because the
+			 * destination is the loopback device and not the bridge. */
+			if (err != -EHOSTUNREACH || !in_dev || IN_DEV_FORWARD(in_dev))
+				goto free_skb;
 
 			if (!ip_route_output_key(&rt, &fl)) {
 				/* - Bridged-and-DNAT'ed traffic doesn't
-				 *   require ip_forwarding.
-				 * - Deal with redirected traffic. */
-				if (((struct dst_entry *)rt)->dev == dev ||
-				    rt->rt_type == RTN_LOCAL) {
+				 *   require ip_forwarding. */
+				if (((struct dst_entry *)rt)->dev == dev) {
 					skb->dst = (struct dst_entry *)rt;
 					goto bridged_dnat;
 				}
+				/* we are sure that forwarding is disabled, so printing
+				 * this message is no problem. Note that the packet could
+				 * still have a martian destination address, in which case
+				 * the packet could be dropped even if forwarding were enabled */
 				__br_dnat_complain();
 				dst_release((struct dst_entry *)rt);
 			}
+free_skb:
 			kfree_skb(skb);
 			return 0;
 		} else {

--
