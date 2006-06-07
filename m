Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWFGF3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWFGF3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWFGF3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:29:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750910AbWFGF3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:29:53 -0400
Date: Tue, 6 Jun 2006 22:29:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, paulus@samba.org
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
Message-Id: <20060606222942.43ed6437.akpm@osdl.org>
In-Reply-To: <1149656647.27572.128.camel@localhost.localdomain>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<1149652378.27572.109.camel@localhost.localdomain>
	<20060606212930.364b43fa.akpm@osdl.org>
	<1149656647.27572.128.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 15:04:07 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > Either whack the PIC in setup_arch() or reorganise start_kernel() in some
> > appropriate manner.
> 
> Neither would be satisfactory. Whacking the PIC means accessing
> hardware, which for a lot of architectures means having page tables up,
> some kind of ioremap, etc... Hence the bunch of workarounds done by
> various archs like having their PTE allocation function do horrors like
> if (mem_init_done) kmalloc() else alloc_bootmem().

Why on earth does the PIC come up pulling an interrupt when it hasn't been
spoken to yet?

> It would make so much more sense to have the init code do something
> like:
> 
>  setup_arch();
>  init_basic_kernel_services(); <--- that's the blob you spotted with mem
> init, slab init, ...
>  init_arch(); <--- new arch hook
> 
> and later on, as part of the various inits, you get init_IRQ() and so
> on...
> 
> In my example, init_arch() would be where the arch code moves the bits
> currently in setup_arch() that do things like ioremap system devices and
> do things that may want to use the slab etc... thus leaving setup_arch()
> to very basic initialisations.
> 
> Not being able to do all of those because we have this
> hyper-optimized-mutex-blah thing that hard enables interrupt all over
> the place seems like a stupid thing to me. In fact, as you mentioned, it
> only affects a debug code path which thus could perfectly take the
> performance hit.

Nonsense.  mutex_lock() can sleep.  Sleeping will enable interrupts. 
Therefore, hence, ergo ipso facto mutex_lock() can enable interrupts. QED,
that's it.

But now, because some broken piece of hardware is coming out of
reset/firmware asserting an interrupt we need to change the rules to be
"mutex_lock() must preserve local interrupts if the lock is uncontended". 
Ditto down(), down_read() and down_write().

And why does this bizarre restriction upon the implementation of our
locking primtives exist?  Because of your broken PIC and because of our
inability to sort out the early boot code.  And because the early boot code
has this implicit knowledge that the locks will be uncontended, else we're
toast.

We're doing mutex_lock(), down(), down_read() and down_write() with local
interrupts disabled, which is a bug.  We have explicit code in there to
*disable* our runtime debugging checks because we know about this bug but
don't know how to fix it.

I call that sucky.

> > But I'll be merging
> > work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
> > so we'll just continue to suck I guess.
> 
> How so ? Can you tell me how making the mutex debug code path do
> something sane makes it 'suck' ? Don't argue about the couple of cycles
> benefit, as you mentionned yourself, it's a debug code path.
> 

Would you prefer "wildly idiotic"?

