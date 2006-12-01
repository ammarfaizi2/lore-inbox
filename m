Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758878AbWLAEWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878AbWLAEWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 23:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758877AbWLAEWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 23:22:07 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:23696
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758875AbWLAEWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 23:22:04 -0500
Date: Thu, 30 Nov 2006 20:22:06 -0800 (PST)
Message-Id: <20061130.202206.25410613.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kaber@trash.net, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely
 duplicate route_reverse function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061129065146.GA20681@gondor.apana.org.au>
References: <E1GpHVB-0005CB-00@gondolin.me.apana.org.au>
	<20061128.210416.59658806.davem@davemloft.net>
	<20061129065146.GA20681@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 29 Nov 2006 17:51:46 +1100

> I'm just emphasising that LL_MAX_HEADER is by no means the *maximum*
> header size in a Linux system.

But it is the maximum "link level" singular header size.

It is MAX_HEADER which is the hack and the main issue.

What MAX_HEADER's setting is trying to do is optimistically allocate
enough for a single level of tunnelling.  It does not handle nested
tunneling at all, of course.

> As to getting rid of those ifdefs, here is one idea.  We keep a
> read-mostly global variable that represents the actual current
> maximum LL header size.  Everytime a new device appears (or if
> its hard header size changes) we update this variable if needed.
> 
> Hmm, we don't actually update the hard header size should the
> underlying device change for tunnels.  Good thing the tunnels
> only use that as a hint and reallocate if necessary :)
> 
> This is not optimal in that it never decreases, but it's certainly
> better than a compile-time constant (e.g., people using distribution
> kernels don't necessarily use tunnels).

I like this idea for the most part.  It also deals nicely with, as you
alude to, how the MAX_HEADER scheme uses the space even if you don't
configure any tunnels at all.

Actually, I wonder how antiquated this all is.  I bet we could get rid
of MAX_HEADER, then if we have to realloc headroom, we adjust some
per-device header thing which will behave like your global value idea
does.  On the next allocation, we'll do the right thing.  Although I
cannot come up with a scheme that works without reintroducing another
net_device pointer to sk_buff, which seems necessary to handle arbitrary
nesting. :-/

