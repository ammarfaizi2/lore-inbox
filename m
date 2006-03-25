Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWCYEL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWCYEL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWCYEL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:11:56 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:9375 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750781AbWCYELy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:11:54 -0500
Date: Fri, 24 Mar 2006 20:11:32 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       kuznet@ms2.inr.ac.ru
Subject: [PATCH 06/08] TCP: Do not use inet->id of global tcp_socket when sending RST (CVE-2006-1242)
Message-ID: <20060325041132.GG16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>


The problem is in ip_push_pending_frames(), which uses:

        if (!df) {
                __ip_select_ident(iph, &rt->u.dst, 0);
        } else {
                iph->id = htons(inet->id++);
        }

instead of ip_select_ident().

Right now I think the code is a nonsense. Most likely, I copied it from
old ip_build_xmit(), where it was really special, we had to decide
whether to generate unique ID when generating the first (well, the last)
fragment.

In ip_push_pending_frames() it does not make sense, it should use plain
ip_select_ident() instead.

Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/ipv4/ip_output.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.15.6.orig/net/ipv4/ip_output.c
+++ linux-2.6.15.6/net/ipv4/ip_output.c
@@ -1237,11 +1237,7 @@ int ip_push_pending_frames(struct sock *
 	iph->tos = inet->tos;
 	iph->tot_len = htons(skb->len);
 	iph->frag_off = df;
-	if (!df) {
-		__ip_select_ident(iph, &rt->u.dst, 0);
-	} else {
-		iph->id = htons(inet->id++);
-	}
+	ip_select_ident(iph, &rt->u.dst, sk);
 	iph->ttl = ttl;
 	iph->protocol = sk->sk_protocol;
 	iph->saddr = rt->rt_src;
