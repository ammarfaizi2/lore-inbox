Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVE3DMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVE3DMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 23:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVE3DMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 23:12:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31187
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261505AbVE3DMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 23:12:01 -0400
Date: Sun, 29 May 2005 20:11:04 -0700 (PDT)
Message-Id: <20050529.201104.59476605.davem@davemloft.net>
To: akpm@osdl.org
Cc: phdm@macqel.be, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: PATCH : ppp + big-endian = kernel crash
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050529195245.33f36253.akpm@osdl.org>
References: <200505292138.j4TLcrJ28536@mail.macqel.be>
	<20050529.145509.82051753.davem@davemloft.net>
	<20050529195245.33f36253.akpm@osdl.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 29 May 2005 19:52:45 -0700

> > All these patches to PPP and friends are merely papering over the
> > larger problem.
> 
> It's not a thing we want to do in the general case, sure.  But it's
> reasonable to identify those bits of net code which the nommu people care
> about and look to see if there's some sane workaround to get them going.
> 
> Otherwise, things like PPP will simply unavailable to some architectures...

Some time ago there was a proposal that would allow appropriate
handling of these sorts of things.

Accessors to packet headers would go through a macro, and this
along with some other defines would allow an architecture to
decide between two schemes:

1) Use normal loads and stores, let trap handler take care of
   unaligned cases.
2) Use something akin to get_unaligned(), no trap handler stuff.

Sure, to make things faster we can do something like this PPP
patch, but it needs lots of work, first of all you need to
replace this:

	for ( ... )
		p[i-1] = p[i];

stuff with a proper memmove() call.
