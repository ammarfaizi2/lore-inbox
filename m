Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280676AbRKJPDj>; Sat, 10 Nov 2001 10:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280679AbRKJPDa>; Sat, 10 Nov 2001 10:03:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30514 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280674AbRKJPDT>; Sat, 10 Nov 2001 10:03:19 -0500
Date: Sat, 10 Nov 2001 16:03:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011110160301.B1381@athlon.random>
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl> <20011110.053720.55510115.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011110.053720.55510115.davem@redhat.com>; from davem@redhat.com on Sat, Nov 10, 2001 at 05:37:20AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 05:37:20AM -0800, David S. Miller wrote:
>    From: Mathijs Mohlmann <mathijs@knoware.nl>
>    Date: Sat, 10 Nov 2001 13:21:56 +0100
>    
>    	i'm not sure about the enable_tasklet bit. I think it will prevent
>    people from calling tasklet_enable from within an interrupt handler. But then
>    again, why do you want to do that? Thanx, velco and
>    	
>    	Any comments?
> 
> I've been looking at this and I sent Andrea+Linus private mail on this
> to try and work out a fix.
> 
> You can't simply stop enabling the softirq when you hit the "locked
> tasklet" condition.  That could deadlock the tasklet.
> 
> What really needs to happen is:
> 
> 1) If tasklet is scheduled, but disabled, simply ignore it
>    during tasklet processing.  Do not resignal softirq.
>    But do leave it on the pending lists.
> 
> 2) When tasklet enable brings t->count back to zero and
>    tasklet is found to be scheduled, signal a local softirq.
> 
> To me, that would be the proper fix.  But I still haven't heard back
> from Andrea or Linus yet :-)

just playing with the "softirq_raise" would be much simpler but I can
see only one problem: we don't know what cpu the tasklet is scheduled
into, so we don't know where to signal the local softirq.

So it seems to fix the looping problem of disabled tasklets we should
really dschedule the tasklet in tasklet_disable (and of course to forbid
it to be scheduled when disabled in tasklet_schedule) and later to
reschedule it in tasklet_enable.

The looping of disabled tasklets was intentional though, it's true as
you noted that if somebody disable a tasklet we'll keep wasting time on
it (ksofitrqd or not, we would waste time anyways at every irq etc..,
ksoftirqd just makes it visible with top which is a good thing rather
than having the overhead hided in the irq handler and in the scheduler),
but the idea was that by design disabled tasklets should remain disabled
for a little time.

Infact at the moment it's even impossible to remove a tasklet from the
queue if it remains disabled forever. tasklet_kill will deadlock on a
tasklet that is disabled.

Comments Linus?

Andrea
