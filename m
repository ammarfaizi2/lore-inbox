Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUHaA0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUHaA0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 20:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUHaA0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 20:26:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:44236 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265770AbUHaA0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 20:26:19 -0400
Date: Mon, 30 Aug 2004 17:25:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: What policy for BUG_ON()?
In-Reply-To: <20040830201519.GH12134@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0408301718040.2295@ppc970.osdl.org>
References: <20040830201519.GH12134@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Aug 2004, Adrian Bunk wrote:
>
> Let me try to summarize the different options regarding BUG_ON, 
> concerning whether the argument to BUG_ON might contain side effects, 
> and whether it should be allowed in some "do this only if you _really_ 
> know what you are doing" situations to let BUG_ON do nothing.
> 
> Options:
> 1. BUG_ON must not be defined to do nothing
> 1a. side effects are allowed in the argument of BUG_ON
> 1b. side effects are not allowed in the argument of BUG_ON
> 2. BUG_ON is allowed to be defined to do nothing
> 2a. side effects are allowed in the argument of BUG_ON
> 2b. side effects are not allowed in the argument of BUG_ON
> 
> It would be good if there was a decision which of the four choices 
> should become documented policy.

I'd suggest we strongly discourage side-effects in BUG_ON(). 

That said, it might be safest to just go for 1b - we make side-effects of 
BUG_ON() be _documented_ as a bug, but just for safety, I'd suggest doing

	#define BUG_ON(x) (void)(x)

anyway, if somebody wants to compile without debugging. That will still 
make the side-effects happen if somebody has them (and if there are none, 
the compiler will not generate any code anyway).

In other words: nobody should _depend_ on the side effects, and we should 
flame people who have them. A quick grep shows this:

	mm/slab.c:      BUG_ON(spin_trylock(&cachep->spinlock));

which makes no real sense - it looks like slab really wants to use 
"spin_is_locked()".

I could make some sparse extension that warns about side effects. I 
already calculate the "side-effectiveness" of an expression for other 
reasons..

		Linus
