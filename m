Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265672AbSKAKK1>; Fri, 1 Nov 2002 05:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265673AbSKAKK1>; Fri, 1 Nov 2002 05:10:27 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:34472 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265672AbSKAKKZ>; Fri, 1 Nov 2002 05:10:25 -0500
Date: Fri, 1 Nov 2002 03:16:38 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: alan@redhat.com, slouken@cs.ucdavis.edu, kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.45/net/ipv4/ dst.pmtu compilation fixes
Message-ID: <20021101031638.A349@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.45 appears to have replaced dst_entry.pmtu with
dst_entry.metrics[RTAX_PMTU] and created a helper function
dst_pmtu(struct dst_entry*), presumably to simplify future changes
like this one.  Here are patches to places in three files that were
apparently missed, preventing the files from compiling.  Now the
files compile.  That is as much as I have tested.

	I am not currently familiar with this code, so I could easily
have misunderstood something in my patch.

	I would appreciate it if the appropriate maintainer(s) would
examine this patch and forward it to Linus it seems OK.  If there is
something else I should do, please let me know.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pmtu.diff"

--- linux-2.5.45/net/ipv4/ipmr.c	2002-10-30 16:42:55.000000000 -0800
+++ linux/net/ipv4/ipmr.c	2002-10-31 02:47:37.000000000 -0800
@@ -1111,7 +1111,7 @@
 {
 	struct dst_entry *dst = skb->dst;
 
-	if (skb->len <= dst->pmtu)
+	if (skb->len <= dst_pmtu(dst))
 		return dst->output(skb);
 	else
 		return ip_fragment(skb, dst->output);
@@ -1167,7 +1167,7 @@
 
 	dev = rt->u.dst.dev;
 
-	if (skb->len+encap > rt->u.dst.pmtu && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst_pmtu(&rt->u.dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		   allow to send ICMP, so that packets will disappear
 		   to blackhole.
--- linux-2.5.45/net/ipv4/ip_gre.c	2002-10-30 16:43:34.000000000 -0800
+++ linux/net/ipv4/ip_gre.c	2002-11-01 03:04:16.000000000 -0800
@@ -523,11 +523,11 @@
 
 	/* change mtu on this route */
 	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
-		if (rel_info > skb2->dst->pmtu) {
+		if (rel_info > dst_pmtu(skb2->dst)) {
 			kfree_skb(skb2);
 			return;
 		}
-		skb2->dst->pmtu = rel_info;
+		skb2->dst->metrics[RTAX_PMTU] = rel_info;
 		rel_info = htonl(rel_info);
 	} else if (type == ICMP_TIME_EXCEEDED) {
 		struct ip_tunnel *t = (struct ip_tunnel*)skb2->dev->priv;
--- linux-2.5.45/net/ipv4/ipip.c	2002-10-30 16:43:48.000000000 -0800
+++ linux/net/ipv4/ipip.c	2002-11-01 03:03:45.000000000 -0800
@@ -452,11 +452,11 @@
 
 	/* change mtu on this route */
 	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
-		if (rel_info > skb2->dst->pmtu) {
+		if (rel_info > dst_pmtu(skb2->dst)) {
 			kfree_skb(skb2);
 			return;
 		}
-		skb2->dst->pmtu = rel_info;
+		skb2->dst->metrics[RTAX_PMTU] = rel_info;
 		rel_info = htonl(rel_info);
 	} else if (type == ICMP_TIME_EXCEEDED) {
 		struct ip_tunnel *t = (struct ip_tunnel*)skb2->dev->priv;

--bg08WKrSYDhXBjb5--
