Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTIBBTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 21:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTIBBTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 21:19:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:2023 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263403AbTIBBTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 21:19:53 -0400
Date: Mon, 1 Sep 2003 18:19:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Olien <dmo@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse change to understand additional postix expressions.
In-Reply-To: <20030902005349.GA10260@osdl.org>
Message-ID: <Pine.LNX.4.44.0309011803300.3186-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Sep 2003, Dave Olien wrote:
> 
> This patch makes a cast expression followed by an initializer list into
> a postfix expression that can be dereferenced as a structure or an array.
> There are approximately 7 instances of these expressions in the Linux kernel,
> that give warnings about "expected lvalue for member dereference".

Ok.

I was actually planning on not supporting this gcc feature and trying to
discontinue its use in the kernel (gcc itself has quite often generated
bad code for it, and we've historically had to remove some of the uses
because of gcc flakiness), but your implementation is pretty clean, so..

> The approach involved introducing a new "stack-based temporary" symbol
> of the same type as the cast expression

This is what gcc does too. However, the liveness analysis ends up being 
nasty, especially with inline functions that return one of these beasts. 
So from a code generation standpoint it can be quite problematic.

(Obviously, the current sparse "code generation" in show-parse.c is so 
broken that we don't much care, and right now there are no real back-ends 
using sparse, but I still hope that some day we'll get a back-end too. If 
only because it will be the only way to _really_ figure out whether sparse 
is doing the right thing or not).

Damn, but it shouldn't be that hard for somebody who likes back-ends to
write a bad (non-optimizing) one. I'd actually like to make the tree
linearization be phase #6 of the sparse phase tree, because we can't even
do trivial dead code removal without it.

(The kernel depends on dead-code removal for several things, and I'd 
actually want several warnings to only happen for reachable code. So 
having dead-code removal actually helps sparse even from a pure checking 
standpoint: I'd love to have something like

	static inline struct page *alloc_pages(unsigned int mask, unsigned int order)
	{
		if (__builtin_constant_p(mask) && (mask & __GFP_ATOMIC))
			return alloc_pages_atomic(mask,order);
		return alloc_pages_cansleep(mask,order);
	}

and then have sparse know about sleeping/nonsleeping contexts, and warn 
about calling "alloc_pages()" within a locked context when it might sleep.

See how the above requires trivial dead code removal to work from a 
warning standpoint?

		Linus

