Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSCSTl6>; Tue, 19 Mar 2002 14:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSCSTlw>; Tue, 19 Mar 2002 14:41:52 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:39148 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S292150AbSCSTlm>; Tue, 19 Mar 2002 14:41:42 -0500
Message-Id: <5.1.0.14.2.20020319105838.02f70cf0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 19 Mar 2002 11:41:18 -0800
To: jt@hpl.hp.com
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: Killing tasklet from interrupt
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20020318153347.A26715@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Sounds like what you need is tasklet_disable.
> > tasklet_kill needs process context so you can't use it in timer.
> >
> > >It's a shame that the code doesn't explitely allow for it (i.e. you will
> > >deadlock every time
> > >in tasklet_unlock_wait(t);).
> > Use tasklet_disable_nosync within the tasklet itself.
>
>         Well. I thought about that. Not possible.
>         tasklet_disable is not the answer, because if the tasklet was
>scheduled, it will stay forever in the tasklet queue. Also, I need to
>forget forever about getting rid of the tasklet within the tasklet
>itself, because it will just crash.
How about something like this ?

void tasklet_kill_from_interrupt(struct tasklet_struct *t)
{
         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state));
         tasklet_unlock_wait(t);
}

So, in your timer you would do:
         set_bit(CLOSING_PLEASE_DONT_SCHEDULE_ANYTHING, something->state);
         tasklet_kill_from_interrupt(something->tasklet);
         /* cleanup/kfree/etc */

>         Look below, comments by me (you've got to love uncommented
>code). So, it's not today that I will use tasklets.
Well, I use them without any problems in Bluetooth code. May be you should
redesign your code a bit. For example don't kill tasklets from the timer.

>P.S. : By the way, regarding flow control between TCP and netdevice
>(our previous e-mail exchange with Paul), have you investigated the
>effect of skb->destructor; (for example sock_wfree()).
I'm sorry I must have missed skb->destructor part. How sock_wfree could 
affect flow ctl between TCP and netdev ?
sock_wfree just wakes up process sleeping in sock_alloc_send_skb or alike.

>-------------------------------------------------------------
>
>static void tasklet_action(struct softirq_action *a)
>{
>         int cpu = smp_processor_id();
>         struct tasklet_struct *list;
>
>         local_irq_disable();
>         list = tasklet_vec[cpu].list;
>         tasklet_vec[cpu].list = NULL;
>         local_irq_enable();
>
>         while (list) {
>                 struct tasklet_struct *t = list;
>
>                 list = list->next;
>
>                 if (tasklet_trylock(t)) {
>                         if (!atomic_read(&t->count)) {
>                                 if 
> (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
>                                         BUG();
>         // Call tasklet handler
>                                 t->func(t->data);
>         // If tasklet was killed/destroyed/kfree above, we will die
>                                 tasklet_unlock(t);
>                                 continue;
>                         }
>                         tasklet_unlock(t);
>                 }
"kill" means "wait until tasklet terminates and is not in the queue". So 
it's not a problem
And you would not want to destroy _locked_ tasklet. You'd wait until it's 
unlocked.

Max

