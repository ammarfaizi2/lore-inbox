Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUHZGPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUHZGPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 02:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUHZGPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 02:15:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8861 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267678AbUHZGPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 02:15:46 -0400
Date: Wed, 25 Aug 2004 23:15:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lkml@rtr.ca, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
Message-Id: <20040825231520.71974d02.davem@redhat.com>
In-Reply-To: <20040825231407.058b3ea6.davem@redhat.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	<412D6FF9.7070001@rtr.ca>
	<20040825231407.058b3ea6.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 23:14:07 -0700
"David S. Miller" <davem@redhat.com> wrote:

> 
> Known problem, tonights BK sync has the fix.  Included below for
> your convenience:

Duh, the actual patch this time.
:)

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/25 20:20:04-07:00 laforge@netfilter.org 
#   [NETFILTER]: Fix ip_nat_find_helper() locking.
#   
#   Signed-off-by: Harald Welte <laforge@netfilter.org>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# net/ipv4/netfilter/ip_nat_standalone.c
#   2004/08/25 20:19:30-07:00 laforge@netfilter.org +2 -0
#   [NETFILTER]: Fix ip_nat_find_helper() locking.
# 
# net/ipv4/netfilter/ip_nat_helper.c
#   2004/08/25 20:19:30-07:00 laforge@netfilter.org +7 -1
#   [NETFILTER]: Fix ip_nat_find_helper() locking.
# 
# net/ipv4/netfilter/ip_nat_core.c
#   2004/08/25 20:19:30-07:00 laforge@netfilter.org +1 -1
#   [NETFILTER]: Fix ip_nat_find_helper() locking.
# 
# include/linux/netfilter_ipv4/ip_nat_helper.h
#   2004/08/25 20:19:30-07:00 laforge@netfilter.org +3 -0
#   [NETFILTER]: Fix ip_nat_find_helper() locking.
# 
diff -Nru a/include/linux/netfilter_ipv4/ip_nat_helper.h b/include/linux/netfilter_ipv4/ip_nat_helper.h
--- a/include/linux/netfilter_ipv4/ip_nat_helper.h	2004-08-25 23:15:04 -07:00
+++ b/include/linux/netfilter_ipv4/ip_nat_helper.h	2004-08-25 23:15:04 -07:00
@@ -44,6 +44,9 @@
 extern struct ip_nat_helper *
 ip_nat_find_helper(const struct ip_conntrack_tuple *tuple);
 
+extern struct ip_nat_helper *
+__ip_nat_find_helper(const struct ip_conntrack_tuple *tuple);
+
 /* These return true or false. */
 extern int ip_nat_mangle_tcp_packet(struct sk_buff **skb,
 				struct ip_conntrack *ct,
diff -Nru a/net/ipv4/netfilter/ip_nat_core.c b/net/ipv4/netfilter/ip_nat_core.c
--- a/net/ipv4/netfilter/ip_nat_core.c	2004-08-25 23:15:04 -07:00
+++ b/net/ipv4/netfilter/ip_nat_core.c	2004-08-25 23:15:04 -07:00
@@ -635,7 +635,7 @@
 
 	/* If there's a helper, assign it; based on new tuple. */
 	if (!conntrack->master)
-		info->helper = ip_nat_find_helper(&reply);
+		info->helper = __ip_nat_find_helper(&reply);
 
 	/* It's done. */
 	info->initialized |= (1 << HOOK2MANIP(hooknum));
diff -Nru a/net/ipv4/netfilter/ip_nat_helper.c b/net/ipv4/netfilter/ip_nat_helper.c
--- a/net/ipv4/netfilter/ip_nat_helper.c	2004-08-25 23:15:04 -07:00
+++ b/net/ipv4/netfilter/ip_nat_helper.c	2004-08-25 23:15:04 -07:00
@@ -421,12 +421,18 @@
 }
 
 struct ip_nat_helper *
+__ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
+{
+	return LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
+}
+
+struct ip_nat_helper *
 ip_nat_find_helper(const struct ip_conntrack_tuple *tuple)
 {
 	struct ip_nat_helper *h;
 
 	READ_LOCK(&ip_nat_lock);
-	h = LIST_FIND(&helpers, helper_cmp, struct ip_nat_helper *, tuple);
+	h = __ip_nat_find_helper(tuple);
 	READ_UNLOCK(&ip_nat_lock);
 
 	return h;
diff -Nru a/net/ipv4/netfilter/ip_nat_standalone.c b/net/ipv4/netfilter/ip_nat_standalone.c
--- a/net/ipv4/netfilter/ip_nat_standalone.c	2004-08-25 23:15:04 -07:00
+++ b/net/ipv4/netfilter/ip_nat_standalone.c	2004-08-25 23:15:04 -07:00
@@ -394,4 +394,6 @@
 EXPORT_SYMBOL(ip_nat_mangle_tcp_packet);
 EXPORT_SYMBOL(ip_nat_mangle_udp_packet);
 EXPORT_SYMBOL(ip_nat_used_tuple);
+EXPORT_SYMBOL(ip_nat_find_helper);
+EXPORT_SYMBOL(__ip_nat_find_helper);
 MODULE_LICENSE("GPL");
