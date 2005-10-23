Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVJWHcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVJWHcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 03:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVJWHcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 03:32:24 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:20230 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751428AbVJWHcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 03:32:23 -0400
Date: Sun, 23 Oct 2005 17:32:15 +1000
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       acme@conectiva.com.br, davem@davemloft.net, greearb@candelatech.com
Subject: [2/3] [NEIGH] Fix add_timer race in neigh_add_timer
Message-ID: <20051023073215.GB17626@gondor.apana.org.au>
References: <43534273.2050106@reub.net> <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[NEIGH] Fix add_timer race in neigh_add_timer

neigh_add_timer cannot use add_timer unconditionally.  The reason is that
by the time it has obtained the write lock someone else (e.g., neigh_update)
could have already added a new timer.

So it should only use mod_timer and deal with its return value accordingly.

This bug would have led to rare neighbour cache entry leaks.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p2.patch"

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -816,10 +816,10 @@ static void neigh_timer_handler(unsigned
 	}
 
 	if (neigh->nud_state & NUD_IN_TIMER) {
-		neigh_hold(neigh);
 		if (time_before(next, jiffies + HZ/2))
 			next = jiffies + HZ/2;
-		neigh_add_timer(neigh, next);
+		if (!mod_timer(&neigh->timer, next))
+			neigh_hold(neigh);
 	}
 	if (neigh->nud_state & (NUD_INCOMPLETE | NUD_PROBE)) {
 		struct sk_buff *skb = skb_peek(&neigh->arp_queue);

--+g7M9IMkV8truYOl--
