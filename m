Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVHYGKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVHYGKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVHYGKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:10:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750829AbVHYGKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:10:45 -0400
Date: Thu, 25 Aug 2005 08:10:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
Message-ID: <20050825061034.GN28272@suse.de>
References: <20050824174702.GL28272@suse.de> <Pine.OSF.4.05.10508242321500.13279-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10508242321500.13279-100000@da410.phys.au.dk>
X-IMAPbase: 1124875140 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24 2005, Esben Nielsen wrote:
> On Wed, 24 Aug 2005, Jens Axboe wrote:
> 
> > On Wed, Aug 24 2005, Lee Revell wrote:
> > > Just found this in dmesg.
> > > 
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
> > which is equivelant to spin_lock_irqsave() in mainline being illegal in
> > -RT, is that correct? 
> 
> I can easily answer this for Ingo.
> 
> Yes, spin_lock(lock) is blocking since lock is mutex, not a spinlock under
> preempt-rt. But isn't it easy to fix? Replace the two lines by
> spin_lock_irqsave(flags). That would work for both preempt-rt
> and !preempt-rt.

Well, it might and it might not be. There's a correctness and
optimization side to it. For this case it is probably doable, but I have
to say that the new semantics defy normal logic.

> You supposed to ask if the macro name spin_lock() isn't confusing. It very
> much is, but one of Ingo's aims is not to change existing code too much.
> The purist would probably change all instances of spin_lock() to lock() or
> down() to stop refering to a specific lock type when it can be changed
> with config-options. That would, however, require a large patch,
> which does the preempt-rt branch harder to merge with the main-line.

I can certainly understand Ingo's point of view, as long as he is
maintaining the patch outside of the kernel. Where it ever to go in,
this would have to change.

-- 
Jens Axboe

