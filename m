Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947521AbWLHX5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947521AbWLHX5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 18:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947517AbWLHX51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:57:27 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60320 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947516AbWLHX5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:57:25 -0500
Message-Id: <20061208235826.505730000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:52 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [patch 01/32] IPV6 NDISC: Calculate packet length correctly for allocation.
Content-Disposition: inline; filename=ndisc-calculate-packet-length-correctly-for-allocation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

MAX_HEADER does not include the ipv6 header length in it,
so we need to add it in explicitly.

With help from YOSHIFUJI Hideaki.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit 6e38433357e2381bb278a418fb7e2fd201475101
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sat Dec 2 21:00:06 2006 -0800

 net/ipv6/ndisc.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.19.orig/net/ipv6/ndisc.c
+++ linux-2.6.19/net/ipv6/ndisc.c
@@ -472,7 +472,9 @@ static void ndisc_send_na(struct net_dev
 			inc_opt = 0;
 	}
 
-	skb = sock_alloc_send_skb(sk, MAX_HEADER + len + LL_RESERVED_SPACE(dev),
+	skb = sock_alloc_send_skb(sk,
+				  (MAX_HEADER + sizeof(struct ipv6hdr) +
+				   len + LL_RESERVED_SPACE(dev)),
 				  1, &err);
 
 	if (skb == NULL) {
@@ -561,7 +563,9 @@ void ndisc_send_ns(struct net_device *de
 	if (send_llinfo)
 		len += ndisc_opt_addr_space(dev);
 
-	skb = sock_alloc_send_skb(sk, MAX_HEADER + len + LL_RESERVED_SPACE(dev),
+	skb = sock_alloc_send_skb(sk,
+				  (MAX_HEADER + sizeof(struct ipv6hdr) +
+				   len + LL_RESERVED_SPACE(dev)),
 				  1, &err);
 	if (skb == NULL) {
 		ND_PRINTK0(KERN_ERR
@@ -636,7 +640,9 @@ void ndisc_send_rs(struct net_device *de
 	if (dev->addr_len)
 		len += ndisc_opt_addr_space(dev);
 
-        skb = sock_alloc_send_skb(sk, MAX_HEADER + len + LL_RESERVED_SPACE(dev),
+        skb = sock_alloc_send_skb(sk,
+				  (MAX_HEADER + sizeof(struct ipv6hdr) +
+				   len + LL_RESERVED_SPACE(dev)),
 				  1, &err);
 	if (skb == NULL) {
 		ND_PRINTK0(KERN_ERR
@@ -1446,7 +1452,9 @@ void ndisc_send_redirect(struct sk_buff 
 	rd_len &= ~0x7;
 	len += rd_len;
 
-	buff = sock_alloc_send_skb(sk, MAX_HEADER + len + LL_RESERVED_SPACE(dev),
+	buff = sock_alloc_send_skb(sk,
+				   (MAX_HEADER + sizeof(struct ipv6hdr) +
+				    len + LL_RESERVED_SPACE(dev)),
 				   1, &err);
 	if (buff == NULL) {
 		ND_PRINTK0(KERN_ERR

--
