Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbTDUWrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTDUWrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:47:40 -0400
Received: from zero.aec.at ([193.170.194.10]:63496 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262599AbTDUWrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:47:39 -0400
Date: Tue, 22 Apr 2003 00:59:38 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030421225938.GA14947@averell>
References: <20030421221146.GA14283@averell> <Pine.LNX.4.44.0304211514200.17938-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211514200.17938-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 12:23:10AM +0200, Linus Torvalds wrote:
> 
> On Tue, 22 Apr 2003, Andi Kleen wrote:
> > 
> > At least on Athlon/Opteron these sequences are the fastest because they are
> > special cased in the decoder and do not consume any execution resources.  
> 
> Is that true even on the 32-bit Athlons, especially the older ones?

It is not the recommended form for Athlons (see my other mail) 
But I doubt it's a big issue. The Athlon has a pretty good decoder.

> 
> I can understand the special-casing on Opteron, since in 64-bit mode
> you'll see more of the prefixes, but for older K7s?

64bit mode needs it special cased anyways because the common
xchg ax,ax nop would not be a nop (it would zero extend the register to
64bit) 

> I think the P3 (which is still Intel's "current" offering as it comes to 
> the mobile Pentium-M side) has problems. And there are still people who 
> use even older chips.

P3 should be fine now.

> > I'm using the GAS sequences for the Intel case Ulrich pointed out now,
> > but only upto 4 bytes (memory barrier only needs 3 bytes currently). 
> > This will hopefully satisfy all nop optimizers ;)
> 
> Looks good to me.
> 
> I do have _one_ more small niggling issue - I think this patch also makes
> the CONFIG_X86_SSE2 define be a thing of the past. Or is it used for
> something else still? It would be good to remove it, and try to make most
> of the architecture choices be pure optimization hints (apart from some of
> the more painful architecture updates like the broken write protect on the
> original 386). That will make it easier for distribution makers.

CONFIG_X86_SSE2 is a nop now yes. But it does not matter because 
the user cannot set it directly. I can remove it in a followup patch.

I'm thinking of using it for the prefetches in the future
I wrote prefetch using versions of these for 64bit and it
helps, so it may make sense to port it over.

I also experiemented with replacing the local_irq_restore with
an P4 optimized version (bt $9,oldflags ; jnc 1f ; sti ; 1: instead
of pushl oldflags ; popfl) which is 60cycles -> 47cycles, but I ran
into weird binutils problems and it bloated the code quite a lot
(2 bytes -> 7 bytes) for only a few cycles so I dropped it again.

But please put the first version of the patch in first so that
we get the infrastructure for future work.

-Andi


