Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280670AbRKJQjZ>; Sat, 10 Nov 2001 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280684AbRKJQjO>; Sat, 10 Nov 2001 11:39:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14912 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280670AbRKJQjC>; Sat, 10 Nov 2001 11:39:02 -0500
Date: Sat, 10 Nov 2001 17:37:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mathijs Mohlmann <mathijs@knoware.nl>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011110173751.C1381@athlon.random>
In-Reply-To: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl> <20011110.053720.55510115.davem@redhat.com> <20011110160301.B1381@athlon.random> <20011110152845.8328F231A4@brand.mmohlmann.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl>; from mathijs@knoware.nl on Sat, Nov 10, 2001 at 04:29:00PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 04:29:00PM +0100, Mathijs Mohlmann wrote:
> On Saturday 10 November 2001 16:03, Andrea Arcangeli wrote:
> > just playing with the "softirq_raise" would be much simpler but I can
> > see only one problem: we don't know what cpu the tasklet is scheduled
> > into, so we don't know where to signal the local softirq.
> >
> > So it seems to fix the looping problem of disabled tasklets we should
> > really dschedule the tasklet in tasklet_disable (and of course to forbid
> > it to be scheduled when disabled in tasklet_schedule) and later to
> > reschedule it in tasklet_enable.
> 
> Or add a cpu field to struct tasklet_struct.

of course, but that has to be maintained with locking too that
invalidates the simplicity of such approch. My point was that if we have
to play with the tasklet locking I guess we can as well drop the tasklet
from the queue and be more scalable so you can schedule thousand of
disabled tasklets at zero do_softirq cost (that was first Dave
suggestion).

> > Infact at the moment it's even impossible to remove a tasklet from the
> > queue if it remains disabled forever. tasklet_kill will deadlock on a
> > tasklet that is disabled.
> I think this is the responsability of the device driver writer (or who ever 
> uses it). AFAIK there is no defined behavior for this case. I vote for 
> removing the tasklet without it ever being run.

yes, dropping it only after it run is an implementation detail, it can
delay a bit but it doesn't matter much. If we change the "disabled
tasklet" case (also for tasklet_kill, so you can kill also a disabled
tasklet) it may end to be more handy to also kill a scheduled tasklet
before it run, these will be more implementation details too and I agree
with you and Alan that here the semantics of running the tasklet before
killing it or not doesn't matter and should be considered undefined
behaviour. The only semantics of tasklet_kill are that the tasklet will
stop running after tasklet_kill returned and as Alan noted it depends on
the timing anyways.

btw, the patches I seen floating around checking the ->count before
tasking are racy.

Andrea
