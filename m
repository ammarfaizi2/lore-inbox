Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292017AbSBAUxE>; Fri, 1 Feb 2002 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292015AbSBAUwz>; Fri, 1 Feb 2002 15:52:55 -0500
Received: from air-1.osdl.org ([65.201.151.5]:1408 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292013AbSBAUwp>;
	Fri, 1 Feb 2002 15:52:45 -0500
Date: Fri, 1 Feb 2002 12:52:34 -0800
From: Bob Miller <rem@osdl.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3 remove global semaphore_lock spin lock.
Message-ID: <20020201125234.A1418@doc.pdx.osdl.net>
In-Reply-To: <20020131150139.A1345@doc.pdx.osdl.net> <3C59D956.4F2B85DB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C59D956.4F2B85DB@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 03:55:02PM -0800, Andrew Morton wrote:
> Bob Miller wrote:
> > 
> > Below is a patch for i386 that replaces the global spin lock semaphore_lock,
> > with the rwlock_t embedded in the wait_queue_head_t in the struct semaphore.
> > 
> 
> Looks sane.  In practice, the speedup is unmeasurable, but...
> 
> > ...
> > +       unsigned long flags;
> > +       wq_write_lock_irqsave(&sem->wait.lock, flags);
> > -       spin_lock_irq(&semaphore_lock);
> 
> I rather dislike spin_lock_irq(), because it's fragile (makes
> assumptions about the caller's state).  But in this case,
> it's probably a reasonable micro-optimisation to not have to
> save the flags.  Nobody should be calling down() with local
> interrupts disabled.
> 
> > ...
> > +/*
> > + * Same as __wake_up but called with the wait_queue_head_t lock held
> > + * in at least read mode.
> > + */
> > +void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr)
> > +{
> > +       if (q) {
> 
> I don't think we need to test `q' here.  It's a new function,
> and we don't need to support broken callers.  So __wake_up_locked()
> can become a macro direct call to __wake_up_common().
> 
> > +               __wake_up_common(q, mode, nr, 0);
> 
> This one breaks the camel's back :)
> 
> Let's un-inline __wake_up_common and EXPORT_SYMBOL it.
> 
> It'd be good if you could also verify that the code still
> works when the use-rwlocks-for-waitqueues option is turned
> on.   (wait.h:USE_RW_WAIT_QUEUE_SPINLOCK)
> 
>  
Thanks for the feed back. I've incorporated your comments.  Also, at your
suggestion I set wait.h:USE_RW_WAIT_QUEUE_SPINLOCK on a clean 2.5.3 system
to test.  The problem is that it OOPs on startup.  After I track that down
and test with my stuff I'll resubmit the patch.

Thanks for taking the time...

-- 
Bob Miller					Email: rem@osdl.org
Open Software Development Lab			Phone: 503.626.2455 Ext. 17
