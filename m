Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVHXVfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVHXVfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVHXVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:35:30 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:31402 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932266AbVHXVf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:35:28 -0400
Date: Wed, 24 Aug 2005 23:35:13 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Jens Axboe <axboe@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs
 disabled
In-Reply-To: <20050824174702.GL28272@suse.de>
Message-Id: <Pine.OSF.4.05.10508242321500.13279-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2005, Jens Axboe wrote:

> On Wed, Aug 24 2005, Lee Revell wrote:
> > Just found this in dmesg.
> > 
> > BUG: scheduling with irqs disabled: libc6.postinst/0x20000000/13229
> > caller is ___down_mutex+0xe9/0x1a0
> >  [<c029c1f9>] schedule+0x59/0xf0 (8)
> >  [<c029ced9>] ___down_mutex+0xe9/0x1a0 (28)
> >  [<c0221832>] cfq_exit_single_io_context+0x22/0xa0 (84)
> >  [<c02218ea>] cfq_exit_io_context+0x3a/0x50 (16)
> >  [<c021db84>] exit_io_context+0x64/0x70 (16)
> >  [<c011efda>] do_exit+0x5a/0x3e0 (20)
> >  [<c011f3ca>] do_group_exit+0x2a/0xb0 (24)
> >  [<c0103039>] syscall_call+0x7/0xb (20)
> 
> Hmm, Ingo I seem to remember you saying that the following construct:
> 
>         local_irq_save(flags);
>         spin_lock(lock);
> 
> which is equivelant to spin_lock_irqsave() in mainline being illegal in
> -RT, is that correct? 

I can easily answer this for Ingo.

Yes, spin_lock(lock) is blocking since lock is mutex, not a spinlock under
preempt-rt. But isn't it easy to fix? Replace the two lines by
spin_lock_irqsave(flags). That would work for both preempt-rt
and !preempt-rt.

You supposed to ask if the macro name spin_lock() isn't confusing. It very
much is, but one of Ingo's aims is not to change existing code too much.
The purist would probably change all instances of spin_lock() to lock() or
down() to stop refering to a specific lock type when it can be changed
with config-options. That would, however, require a large patch,
which does the preempt-rt branch harder to merge with the main-line.

Esben


> This is what cfq uses right now for an exiting
> task, as the above trace indicates.
> 
> -- 
> Jens Axboe

