Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSGTUgV>; Sat, 20 Jul 2002 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSGTUgV>; Sat, 20 Jul 2002 16:36:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55815 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317489AbSGTUgV>; Sat, 20 Jul 2002 16:36:21 -0400
Date: Sat, 20 Jul 2002 13:40:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>,
       <riel@conectiva.com.br>, <wli@holomorphy.com>
Subject: Re: [PATCH] generalized spin_lock_bit
In-Reply-To: <1027196511.1555.767.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207201335560.1492-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 Jul 2002, Robert Love wrote:
>
> The attached patch implements bit-sized spinlocks via the following
> interfaces:

I'm not entirely convinced.

Some architectures simply aren't good at doing bitwise locking, and we may
have to change the current "pte_chain_lock()" to a different
implementation.

In particular, with the current pte_chain_lock() interface, it will be
_trivial_ to turn that bit in page->flags to be instead a hash based on
the page address into an array of spinlocks. Which is a lot more portable
than the current code.

(The current code works, but look at what it generates on old sparcs, for
example).

Your patch, while it cleans up some things, makes it a lot harder to do
those kinds of changes later.

So I would suggest (at least for now) to _not_ get rid of the
pte_chain_lock() abstraction, and re-doing your patch with that in mind.
Gettign rid of the (unnecessary) UP locking is good, but getting rid of
the abstraction doesn't look like a wonderful idea to me.

		Linus

