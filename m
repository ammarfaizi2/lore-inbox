Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRKLN6h>; Mon, 12 Nov 2001 08:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280787AbRKLN6R>; Mon, 12 Nov 2001 08:58:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:62793 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280784AbRKLN6L>; Mon, 12 Nov 2001 08:58:11 -0500
Date: Mon, 12 Nov 2001 14:57:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mathijs Mohlmann <mathijs@knoware.nl>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112145738.Q1381@athlon.random>
In-Reply-To: <20011112021142.O1381@athlon.random> <Pine.BSI.4.05L.10111120819290.9564-100000@utopia.knoware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.BSI.4.05L.10111120819290.9564-100000@utopia.knoware.nl>; from mathijs@knoware.nl on Mon, Nov 12, 2001 at 08:42:27AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 08:42:27AM +0100, Mathijs Mohlmann wrote:
> 
> 
> On Mon, 12 Nov 2001, Andrea Arcangeli wrote:
> > Mathijs, can you verify that? If my theory is right need_resched isn't
> > set even if ksoftirqd loops forever. It could be one of those two
> > possibilities:
> > 
> > 1) the timer irq isn't running yet
> > 2) "current" isn't functional
> 
> well, i'm at work now, no sparc32's here. But during my debugging i made
> a piece of code that counted to times a process was selected by schedule.
> A custom SysRq key read the values. What i saw during the deadlock was
> that there where three processes running allready and scheduling seemed to
> work find. keventd got selected everytime i pressed SysRq and ksoftirqd

so "current" was _always_ "keventd" every time you press SYSRQ+P? sounds
like you deadlocked in keventd then.

> got selected during idle time.
> 
> This (to me) proves that "current" is working just fine. Not quite sure
> about the timer irq. I will look at that tonight. But i'm pretty sure
> need_resched is set again and again.
> 
> Even if the timer irq is working fine, the sun should not enable the 
> keyboard irq without the tasklet being enabled. Initializing the keyboard

scheduling the tasklet without it being enabled is perfect, there's no
problem at all if the scheduler is functional by the time
spwan_ksoftirqd is executed.

All issues mentioned so far about the softirq should only to deal with
performance, not with deadlocking. If it deadlocks that's a sparc32 bug,
messing the softirq code can only hide the real bug.

> tasklet enabled got the sun to boot just fine for me.
> 
> But i feel that this is fixing the symptoms. If this turns out to be the
> problem, it should be fixed, but i feel the softirq code needs some good 
> looking over with respect to disabled tasklets as well. (tasklet_enable 

As we said several times so far, tasklets should remain disabled only
for a little time during production (aka during the benchmarks), and
it's a matter of the user to tasklet_kill only enabled tasklets (it's
like quitting a function without a local_irq_restore, no surprise if irq
remains stuck if you forget to reenable irq/tasklets).

As Linus said tasklet_disable is the same thing of __cli() (or if you
prefer as Alexey said, it's like local_bh_disable()), you shouldn't __cli()
or local_bh_disable() for a long time, it's worthless to optimize for
very long critical sections, tasklet_disable is just to serialize within
a critical section. The boot case doesn't matter either, it doesn't
matter if at boot we waste a couple of cpu cycles, boot time won't
change anyways because of that (boot time is all cpu idle time waiting
those scsi things).

But again, those softirq issues are only performance issues, they cannot
explain a deadlock in spwan_ksoftirqd, that is a sparc32 bug, period.

So please fix the bug, then we can discuss the rest, but whatever we
change it won't be for the boot process, the only thing that matters is
production, even if ksoftirqd loops for seconds during the boot process
it doesn't matter at all.

> without a tasket_schedule and then a tasklet_kill will loop as well,
> wont it?)
> 
> 	me (everything IMVHO)


Andrea
