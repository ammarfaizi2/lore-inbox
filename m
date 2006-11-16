Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162243AbWKPCr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162243AbWKPCr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162256AbWKPCrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:47:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10632 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162254AbWKPCr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:47:29 -0500
Message-Id: <20061116024633.882512000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Larry Woodman <lwoodman@redhat.com>
Subject: [patch 14/30] NET: __alloc_pages() failures reported due to fragmentation
Content-Disposition: inline; filename=net-__alloc_pages-failures-reported-due-to-fragmentation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

We have seen a couple of __alloc_pages() failures due to
fragmentation, there is plenty of free memory but no large order pages
available.  I think the problem is in sock_alloc_send_pskb(), the
gfp_mask includes __GFP_REPEAT but its never used/passed to the page
allocator.  Shouldnt the gfp_mask be passed to alloc_skb() ?

Signed-off-by: Larry Woodman <lwoodman@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

---
 net/core/sock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.2.orig/net/core/sock.c
+++ linux-2.6.18.2/net/core/sock.c
@@ -1164,7 +1164,7 @@ static struct sk_buff *sock_alloc_send_p
 			goto failure;
 
 		if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
-			skb = alloc_skb(header_len, sk->sk_allocation);
+			skb = alloc_skb(header_len, gfp_mask);
 			if (skb) {
 				int npages;
 				int i;

--
