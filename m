Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291173AbSBGSXS>; Thu, 7 Feb 2002 13:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBGSXI>; Thu, 7 Feb 2002 13:23:08 -0500
Received: from ns.caldera.de ([212.34.180.1]:41908 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291173AbSBGSW4>;
	Thu, 7 Feb 2002 13:22:56 -0500
Date: Thu, 7 Feb 2002 19:22:42 +0100
Message-Id: <200202071822.g17IMgS14802@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: Martin.Wirth@dlr.de (Martin Wirth)
Cc: akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, rml@tech9.net,
        nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New locking primitive for 2.5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C629F91.2869CB1F@dlr.de> you wrote:
> The new lock uses a combination of a spinlock and a (mutex-)semaphore.
> You can lock it for short-term issues in a spin-lock mode:
>
>         combi_spin_lock(struct combilock *x)
>         combi_spin_unlock(struct combilock *x)
>
> and for longer lasting tasks in a sleeping mode by:
>
>         combi_mutex_lock(struct combilock *x)
>         combi_mutex_unlock(struct combilock *x)

I think this API is really ugly.  If both pathes actually do the same,
just with different defaults, one lock function with a flag would be
much nicer.  Also why do we need two unlock functions?

What about the following instead:

	combi_lock(struct combilock *x, int spin);
	combi_unlock(struct combilock *x);

> If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> attempt also sleeps i.e. behaves like a semaphore.
> If you gained ownership of the lock, you can switch between spin-mode
> and mutex-(ie.e sleeping) mode by calling:
>
>         combi_to_mutex_mode(struct combilock *x)
>         combi_to_spin_mode(struct combilock *x)
>
> without loosing the lock. So you may start with a spin-lock and relax
> to a sleeping lock if for example you need to call a non-atomic kmalloc.

This looks really ugly.  I'd really prefer an automatic fallback from
spinning to sleeping after some timeout like e.g. solaris adaptive
mutices.

>   * Does it make sense to also provide irq-save versions of the
>     locking functions? This means you could use the unlock functions
>     from interrupt context. But the main use in this situation is
>     completion handling and there are already (new) completion handlers
>     available. So I don't think this is a must have.

You are no supposed to sleep in irq context, so irq-save combi-locks
don't make that much sense, IMHO.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
