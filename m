Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVLMV4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVLMV4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVLMV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:56:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:20384 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030192AbVLMV4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:56:32 -0500
Date: Tue, 13 Dec 2005 22:56:10 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       dhowells@redhat.com, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org, rth@redhat.com
Subject: Using C99 in the kernel was Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213215610.GX23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <Pine.LNX.4.64.0512130812020.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512130812020.15597@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[dropping linux-arch because it seems to generate bounces]

On Tue, Dec 13, 2005 at 08:16:39AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 13 Dec 2005, Andi Kleen wrote:
> > 
> > Remove -Wdeclaration-after-statement
> 
> Please don't.
> 
> It's a coding style issue. We put our variable declarations where people 
> can _find_ them, not in random places in the code.
> 
> Putting variables in the middle of code only improves readability when you 
> have messy code. 

I like it when the scopes for variables are as small as possible because then 
I also find it good documentation when the first initialization
of a variable also has the type. 

While it's possible with nested {} blocks too that imho makes the code ugly
because you either end up with non syntactic elements with wrong 
indentation (driving emacs/indent etc crazy) or with too much
indentation.

I can see Ingo's argument about catching merging mistakes though -
that is a good point against it that I didn't consider.

> 
> Now, one feature that _may_ be worth it is the loop counter thing:
> 
> 	for (int i = 10; i; i--)
> 		...
> 
> kind of syntax actually makes sense and is a real feature (it makes "i" 
> local to the loop, and can actually help people avoid bugs - you can't use 
> "i" by mistake after the loop).
> 
> But I think you need "--std=c99" for gcc to take that.

Ok. So should we enable that?  Or rather --std=gnu99

But actually I tried it and it causes lots of

mm/page_alloc.c:49: error: initializer element is not constant

It looks like casts in constant initializers for global structures are not 
allowed anymore: struct foo x = (struct foo) { ... }; warns.  That's
not good because when the (struct foo){} is generated in a macro
then it's the only easy way to allow initialization outside a declaration.

Common case is SPIN_LOCK_UNLOCKED() / DEFINE_SPINLOCK().

Richard, any comments on that? 

P.S.: Linus, I wish you weren't so fond of using downcounting loops: I find
them always slightly confusing (or rather they need more consideration
than a standard upcounting loop to understand) and gcc is perfectly
capable of reversing loops when suitable on its own.

-Andi

