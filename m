Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbRGFL25>; Fri, 6 Jul 2001 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266421AbRGFL2r>; Fri, 6 Jul 2001 07:28:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12384 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266410AbRGFL2c>; Fri, 6 Jul 2001 07:28:32 -0400
Date: Fri, 6 Jul 2001 13:28:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ville Nummela <ville.nummela@mail.necsom.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: tasklets in 2.4.6
Message-ID: <20010706132813.F2425@athlon.random>
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4563D5.89A1ACA3@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jul 06, 2001 at 03:08:05AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 03:08:05AM -0400, Jeff Garzik wrote:
> Ville Nummela wrote:
> > In kernel/softirq.c, line 178:
> > 
> >                 if (test_bit(TASKLET_STATE_SCHED, &t->state))
> >                         tasklet_schedule(t);
> > 
> > What's the idea behind this line? If the tasklet is already scheduled,
> > schedule it again? This does not make much sense to me.
> > 
> > Also, few lines before:
> > 
> >                        if (test_bit(TASKLET_STATE_SCHED, &t->state))
> >                                 goto repeat;
> > 
> > Here we'll loop forever if the tasklet should schedule itself.
> 
> hmmm, it looks almost ok to me.
> 
> The tasklet is locked before the "repeat" label, so any tasklet
> scheduling itself will set the bit, but NOT actually schedule iteself. 
> For this see the tasket_schedule code, for the case where the bit is not
> set, but the tasklet is locked.
> 
> The first statement above schedules the tasklet if the bit was set while
> the tasklet was locked.  The second statement, as the comment right
> above it indicates, causes the tasklet to repeat itself.
> 
> The only thing that appears fishy is that if the tasklet constantly
> reschedules itself, it will never leave the loop AFAICS.  This affects
> tasklet_hi_action as well as tasklet_action.

another bug triggers when the tasklet is re-enabled by another cpu in
this point:

			if (test_bit(TASKLET_STATE_SCHED, &t->state))
				goto repeat;
		}
		XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx
		tasklet_unlock(t);
		if (test_bit(TASKLET_STATE_SCHED, &t->state))
			tasklet_schedule(t);

then the check for test_bit(TASKLET_STATE_SCHED, &t->state) will
trigger, but the tasklet_schedule won't queue the tasklet because
TASKLET_STATE_SCHED is just set in t->state.

This is fixed in my ksoftirqd patch. However one thing I'd like to
change in my patch is to add the BUG() that triggers in the case
mentioned yesterday.

Andrea
