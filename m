Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVHYGWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVHYGWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbVHYGWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:22:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7098 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751250AbVHYGWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:22:07 -0400
Date: Thu, 25 Aug 2005 08:22:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
Message-ID: <20050825062207.GO28272@suse.de>
References: <1124899329.3855.12.camel@mindpipe> <20050824174702.GL28272@suse.de> <20050825060958.GB26398@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825060958.GB26398@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25 2005, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > > BUG: scheduling with irqs disabled: libc6.postinst/0x20000000/13229
> > > caller is ___down_mutex+0xe9/0x1a0
> > >  [<c029c1f9>] schedule+0x59/0xf0 (8)
> > >  [<c029ced9>] ___down_mutex+0xe9/0x1a0 (28)
> > >  [<c0221832>] cfq_exit_single_io_context+0x22/0xa0 (84)
> > >  [<c02218ea>] cfq_exit_io_context+0x3a/0x50 (16)
> > >  [<c021db84>] exit_io_context+0x64/0x70 (16)
> > >  [<c011efda>] do_exit+0x5a/0x3e0 (20)
> > >  [<c011f3ca>] do_group_exit+0x2a/0xb0 (24)
> > >  [<c0103039>] syscall_call+0x7/0xb (20)
> > 
> > Hmm, Ingo I seem to remember you saying that the following construct:
> > 
> >         local_irq_save(flags);
> >         spin_lock(lock);
> > 
> > which is equivelant to spin_lock_irqsave() in mainline being illegal 
> > in -RT, is that correct? This is what cfq uses right now for an 
> > exiting task, as the above trace indicates.
> 
> yes, that's correct. Mainline's exit_io_contexts() uses the above 
> construct because there's no task_lock_irqsave(current, flags) API.
> 
> note that recent -RT kernels are a lot less drastic about these cases 
> and print a once-per-bootup warning, not a scary message like above.  
> This message should not happen in recent -RT kernels.
> 
> The problem was this piece of code in exit_io_contexts():
> 
>         local_irq_save(flags);
>         task_lock(current);
>         ioc = current->io_context;
>         current->io_context = NULL;
>         ioc->task = NULL;
>         task_unlock(current);
>         local_irq_restore(flags);
> 
> i understand the detached use of flags, but i'm also wondering why irqs 
> have to be disabled here in the first place? At this point in do_exit() 
> we should normally not have any pending IO attached to our io_context.  
> What am i missing?

There can quite easily be lots of pending IO for the io_context (and, in
CFQ's case, below cfq_io_contexts), task exiting is completely decoupled
from any pending io.

Then there's the cfq_exit_io_context() locking. I have to ponder this a
bit, I cannot even convince myself that it is currently safe right now.

-- 
Jens Axboe

