Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRGFHIg>; Fri, 6 Jul 2001 03:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbRGFHI0>; Fri, 6 Jul 2001 03:08:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28349 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264193AbRGFHIQ>;
	Fri, 6 Jul 2001 03:08:16 -0400
Message-ID: <3B4563D5.89A1ACA3@mandrakesoft.com>
Date: Fri, 06 Jul 2001 03:08:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Nummela <ville.nummela@mail.necsom.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: tasklets in 2.4.6
In-Reply-To: <7an16iy2wa.fsf@necsom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Nummela wrote:
> In kernel/softirq.c, line 178:
> 
>                 if (test_bit(TASKLET_STATE_SCHED, &t->state))
>                         tasklet_schedule(t);
> 
> What's the idea behind this line? If the tasklet is already scheduled,
> schedule it again? This does not make much sense to me.
> 
> Also, few lines before:
> 
>                        if (test_bit(TASKLET_STATE_SCHED, &t->state))
>                                 goto repeat;
> 
> Here we'll loop forever if the tasklet should schedule itself.

hmmm, it looks almost ok to me.

The tasklet is locked before the "repeat" label, so any tasklet
scheduling itself will set the bit, but NOT actually schedule iteself. 
For this see the tasket_schedule code, for the case where the bit is not
set, but the tasklet is locked.

The first statement above schedules the tasklet if the bit was set while
the tasklet was locked.  The second statement, as the comment right
above it indicates, causes the tasklet to repeat itself.

The only thing that appears fishy is that if the tasklet constantly
reschedules itself, it will never leave the loop AFAICS.  This affects
tasklet_hi_action as well as tasklet_action.

> repeat:
>                 if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
>                         BUG();
>                 if (!atomic_read(&t->count)) {
>                         local_irq_enable();
>                         t->func(t->data);
>                         local_irq_disable();
>                         /*
>                          * One more run if the tasklet got reactivated:
>                          */
>                         if (test_bit(TASKLET_STATE_SCHED, &t->state))
>                                 goto repeat;
>                 }


	Jeff


-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
