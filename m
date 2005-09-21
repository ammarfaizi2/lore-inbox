Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVIUUsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVIUUsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVIUUsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:48:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964817AbVIUUsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:48:13 -0400
Date: Wed, 21 Sep 2005 13:47:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, torvalds@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
 atomic
Message-Id: <20050921134724.52603016.akpm@osdl.org>
In-Reply-To: <200509212222.50653.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172908.10219.57644.stgit@zion.home.lan>
	<20050921124957.437cf069.akpm@osdl.org>
	<200509212222.50653.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> > "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> > The in_atomic() test in x86's do_page_fault() is in fact a message passed
> > into it from filemap.c's kmap_atomic().
> Ok, this can be ok, but:
> > It has accidental side-effects, 
> > such as making copy_to_user() fail if inside spinlocks when
> > CONFIG_PREEMPT=y.
> Sorry, but should it ever succeed inside spinlocks? I mean, should it ever 
> call down() inside spinlocks? (We never do down_trylock, and ever if we did 
> the x86 trick, that wouldn't make the whole thing safe at all - they still 
> take the spinlock and potentially sleep. And it's legal only if no spinlock 
> is held).

Not sure what you're asking here.

copy_to/from_user() will fail inside spinlock if CONFIG_PREMPT=y and if the
copy happens to cause a fault.  Otherwise it will succeed inside spinlock,
and it won't spew a sleeping-while-atomic warning, because that uses
in_atomic() too.  It might deadlock if we schedule away and try to retake
the same lock.

> Even if spinlocks don't always trigger in_atomic() - which means that we'd 
> need to have a better fix for this.

The patch you have will correctly cause copy_*_user()->pagefault to fail
the copy if the caller has run inc_preempt_count().  It will not cause
copy_*_user()->pagefault to fail inside spinlocks unless UML does
inc_preempt_count() in its spinlock implementation.

> (Btw, I took the above reasoning from something said, as an aside, on LWN.net 
> kernel page, about the FUTEX deadlock on mm->mmap_sem of ~ 2.6.8 - yes, it 
> wasn't the full truth, but not totally dumb).
> 
> > So I think this change is only needed if UML implements kmap_atomic, as in
> > arch/i386/mm/highmem.c, which it surely does not do?
> NACK, see above.

Yup, the patch is needed for the futex code, and for general correct
implementation of inc_preempt_count()'s intended effect.

