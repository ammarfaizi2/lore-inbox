Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVKJMGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKJMGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKJMGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:06:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9399 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750796AbVKJMGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:06:11 -0500
Date: Thu, 10 Nov 2005 13:06:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051110120624.GB32672@elte.hu>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109185645.39329151.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > But I think either a big patch or 2.95.x abandonment is preferable to this
> > > approach.
> > 
> > Hmm, that's a pity.
> 
> Well plan B is to kill spinlock_t.break_lock.  That fixes everything 
> and has obvious beneficial side-effects.

i'd really, really love to have this solved without restricting the type 
flexibility of spinlocks.

do we really need 2.95.x support? gcc now produces smaller code with -S.

> a) x86 spinlock_t is but one byte.  Can we stuff break_lock into the
>    same word?
> 
>    (Yes, there's also a >128 CPUs spinlock overflow problem to solve, 
>    but perhaps we can use lock;addw?)

the >128 CPUs spinlock overflow problem is solved by going to 32-bit ops 
(patch has been posted to lkml recently). 16-bit ops are out of 
question. While byte ops are frequently optimized for (avoiding partial 
register access related stalls), the same is not true for 16-bit 
prefixed instructions! Mixing 32-bit with 16-bit code is going to suck 
on a good number of x86 CPUs. It also bloats the instruction size of 
spinlocks, due to the 16-bit prefix. (while byte access has its own 
opcode)

also, there are arches where the only atomic op available is a 32-bit 
one. So trying to squeeze the break_lock flag into the spinlock field is 
i think unrobust.

> b) Redesign the code somehow.  Currently break_lock means "there's
>    someone waiting for this lock".
> 
>    But if we were to leave the lock in a decremented state while
>    spinning (as we've always done), that info is still present via the
>    value of spinlock_t.slock.   Hence: bye-bye break_lock.

this wont work on arches that dont have atomic-decrement based 
spinlocks. (some arches dont even have such an instruction) This means 
those arches would have to implement a "I'm spinning" flag in the word, 
which might or might not work (if the arch doesnt have an atomic 
instruction that works on the owner bit only then it becomes impossible) 
- but in any case it would need very fragile per-arch assembly work to 
pull off.

> c) Make the break_lock stuff a new config option,
>    CONFIG_SUPER_LOW_LATENCY_BLOATS_STRUCT_PAGE.
> 
> d) Revert it wholesale, have sucky SMP worst-case latency ;)

yuck. What is the real problem btw? AFAICS there's enough space for a 
2-word spinlock in struct page for pagetables. We really dont want to 
rewrite spinlocks (or remove features) just to keep gcc 2.95 supported 
for some more time. In fact, is there any 2.6 based distro that uses gcc 
2.95?

	Ingo
