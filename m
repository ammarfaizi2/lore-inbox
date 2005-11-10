Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbVKJC5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbVKJC5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbVKJC5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:57:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751675AbVKJC5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:57:05 -0500
Date: Wed, 9 Nov 2005 18:56:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051109185645.39329151.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
	<Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Wed, 9 Nov 2005, Andrew Morton wrote:
> > 
> > It does everything we want.
> 
> I don't think so: the union leaves us just as vulnerable to some
> subsystem using fields of the other half of the union, doesn't it?

Yes, spose so.

> Which is not really a problem, but is a part of what's worrying you.

yes, with either approach it remans the case that someone could write some
code which works just fine on their setup but explodes gorridly fomr
someone else who has a different config/arch which has a larger spinlock_t.

> > Of course, it would be nice to retain 2.95.x support.  The reviled
> > page_private(() would help us do that.  But the now-to-be-reviled
> > page_mapping() does extraneous stuff, and we'd need a ton of page_lru()'s.
> > 
> > So it'd be a big patch, converting page->lru to page->u.s.lru in lots of
> > places.
> > 
> > But I think either a big patch or 2.95.x abandonment is preferable to this
> > approach.
> 
> Hmm, that's a pity.

Well plan B is to kill spinlock_t.break_lock.  That fixes everything and
has obvious beneficial side-effects.

a) x86 spinlock_t is but one byte.  Can we stuff break_lock into the
   same word?

   (Yes, there's also a >128 CPUs spinlock overflow problem to solve,
   but perhaps we can use lock;addw?)

b) Redesign the code somehow.  Currently break_lock means "there's
   someone waiting for this lock".

   But if we were to leave the lock in a decremented state while
   spinning (as we've always done), that info is still present via the
   value of spinlock_t.slock.   Hence: bye-bye break_lock.

c) Make the break_lock stuff a new config option,
   CONFIG_SUPER_LOW_LATENCY_BLOATS_STRUCT_PAGE.

d) Revert it wholesale, have sucky SMP worst-case latency ;)
