Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUC1UJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUC1UJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:09:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:21772 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262428AbUC1UJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:09:42 -0500
Date: Sun, 28 Mar 2004 22:09:32 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH-2.4.26] ip6tables cleanup
Message-ID: <20040328200932.GA19852@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet> <20040328115439.GA24421@pcw.home.local> <m2d66wsrg2.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2d66wsrg2.fsf@p4.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 09:27:09PM +0200, Peter Osterlund wrote:
> Willy TARREAU <willy@w.ods.org> writes:
> 
> > 2.4.26-rc1 returned this warning compiling ip6_tables :
> > 
> > ip6_tables.c: In function `tcp_match':
> > ip6_tables.c:1596: warning: implicit declaration of function `ipv6_skip_exthdr'
> > 
> > I had to add a cast because ipv6_skip_exthdr() expects a 'struct sk_buff*' while
> > its caller uses a 'const struct sk_buff*'. Here is a cleanup patch.
> 
> I think it would be better to change the ipv6_skip_exthdr() function
> to take a const struct sk_buff* instead. Unnecessary casts are evil.

At first I didn't want to do this because it would have needed to recurse
down to other users of skb. But I've just checked and noticed that indeed,
only skb_copy_bits() uses the skb, and this one already expects a const. So
you're right, and I should have checked further. My bad.

Marcelo, could you please use this simpler patch instead ?

Thanks,
Willy

diff -urN linux-2.4.26-rc1/net/ipv6/exthdrs.c linux-2.4.26-rc1-skb/net/ipv6/exthdrs.c
--- linux-2.4.26-rc1/net/ipv6/exthdrs.c	Sat Mar 20 10:08:21 2004
+++ linux-2.4.26-rc1-skb/net/ipv6/exthdrs.c	Sun Mar 28 22:07:21 2004
@@ -783,7 +783,7 @@
  * --ANK (980726)
  */
 
-int ipv6_skip_exthdr(struct sk_buff *skb, int start, u8 *nexthdrp, int len)
+int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp, int len)
 {
 	u8 nexthdr = *nexthdrp;
 
