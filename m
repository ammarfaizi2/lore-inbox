Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269007AbRG3Sbv>; Mon, 30 Jul 2001 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269074AbRG3Sbl>; Mon, 30 Jul 2001 14:31:41 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:62391 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S269007AbRG3Sba>; Mon, 30 Jul 2001 14:31:30 -0400
Message-Id: <4.3.1.0.20010730110208.05e62260@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Mon, 30 Jul 2001 11:32:11 -0700
To: kuznet@ms2.inr.ac.ru
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com, davem@redhat.com (Dave Miller)
In-Reply-To: <200107281741.VAA12995@ms2.inr.ac.ru>
In-Reply-To: <4.3.1.0.20010727141716.05651ac0@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > tasklet_schedule calls tasklet_unlock after it schedules tasklet,
>
>Hmm... but this opens one more bug: are schedules not lost, when
>they are made while tasklet is running ?
Yes it does.

btw Here is an idea. May be we should reschedule tasklet on the same cpu it's running on.
It should probably improve cache usage and stuff. 
I'm thinking about something like this.

static inline void tasklet_schedule(struct tasklet_struct *t)
{
         if (test_bit(TASKLET_STATE_RUN, &t->state)) {
                 set_bit(TASKLET_NEED_RESCHED, &t->state);
         } else if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
                 int cpu = smp_processor_id();
                 unsigned long flags;

                 local_irq_save(flags);
                 t->next = tasklet_vec[cpu].list;
                 tasklet_vec[cpu].list = t;
                 cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
                 local_irq_restore(flags);
         }
}

static void tasklet_action(struct softirq_action *a)
{
         int cpu = smp_processor_id();
         struct tasklet_struct *list;

         local_irq_disable();
         list = tasklet_vec[cpu].list;
         tasklet_vec[cpu].list = NULL;
         local_irq_enable();

         while (list) {
                 struct tasklet_struct *t = list;

                 list = list->next;

                 if (tasklet_trylock(t)) {
                         if (!atomic_read(&t->count)) {
                                 if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
                                         BUG();
                                 t->func(t->data);
                                 tasklet_unlock(t);
                                 if (test_and_clear_bit(TASKLET_NEED_RESCHED, &t->state)
                                    goto resched;
                                 continue;
                         }
                         tasklet_unlock(t);
                 }

resched:
                 local_irq_disable();
                 t->next = tasklet_vec[cpu].list;
                 tasklet_vec[cpu].list = t;
                 cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
                 local_irq_enable();
         }
}

There is small window there but this is just rfc. So if tasklet is already running we set NEED_RESCHED bit and tasklet_action
reschedules tasklet on the same cpu. (currently we may reschedule it on anther cpu).
Comments ?

Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

