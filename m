Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbVBEGYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbVBEGYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbVBEGX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:23:58 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:46762
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263129AbVBEGVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:21:15 -0500
Date: Fri, 4 Feb 2005 22:13:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-Id: <20050204221344.247548cb.davem@davemloft.net>
In-Reply-To: <20050205061110.GA18275@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
	<20050205052407.GA17266@gondor.apana.org.au>
	<20050204213813.4bd642ad.davem@davemloft.net>
	<20050205061110.GA18275@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 17:11:10 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> You're right of course.  I thought they were all harmless but I was
> obviously wrong about this one.
> 
> So here is a patch that essentially reverts the split devices
> semantics introduced by these two changesets:
> 
>   [IPV6] addrconf_dst_alloc() to allocate new route for local address.
>   [IPV6] take rt6i_idev into account when looking up routes.
> 
> Signed-off-by: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>

Ok.

But Herbert, let's take a step back real quick because I want
to point something out.  IPv6 does try to handle the dangling
mismatched idev's, in route.c:ip6_dst_ifdown(), this is called
via net/core/dst.c:dst_ifdown(), and this releases the ipv6
idev correctly in the split device case.

Did your analysis of this bridging release bug take this into
account?  That's why we added this dst->ops method, specifically
to handle this problem.

This was added by Yoshifuji-san in ChangeSet 1.1722.137.17 which
has the checking comment:

[NET]: Add dst->ifdown callback.

Use it to release protocol specific objects that may be
tied to a dst cache object, at ifdown time.  Currently
this is used to release ipv4/ipv6 specific device state.
