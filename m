Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRG1RmV>; Sat, 28 Jul 2001 13:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266974AbRG1RmM>; Sat, 28 Jul 2001 13:42:12 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:58892 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S266970AbRG1RmE>;
	Sat, 28 Jul 2001 13:42:04 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107281741.VAA12995@ms2.inr.ac.ru>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
To: maxk@qualcomm.com (Maksim Krasnyanskiy)
Date: Sat, 28 Jul 2001 21:41:41 +0400 (MSK DST)
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com, davem@redhat.com (Dave Miller)
In-Reply-To: <4.3.1.0.20010727141716.05651ac0@mail1> from "Maksim Krasnyanskiy" at Jul 27, 1 05:52:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Here is how it should work (Alex correct me if I'm wrong here).

You _were_ right. Now... I still do not know, I can only comment
and state that current code really looks funny. :-)


> Purpose of STATE_SCHED is to protect tasklet from being _scheduled_ on the several cpus at the same time. 

Rather its purpose was not protective. When it was set, it meaned that
the function _will_ be run. tasklet_action was allowed to reset it
at any time before function is called. But not after, of course.


> When we run a tasklet we unlink it from the queue and clear STATE_SCHED to allow it to be scheduled again.

This can be made later, but before the function is called.


> tasklet_schedule calls tasklet_unlock after it schedules tasklet,

Hmm... but this opens one more bug: are schedules not lost, when
they are made while tasklet is running?


> we're not gonna schedule tasklet. And there is no point in locking tasklet on the UP machines.

It can be converted to spinlock. I felt a discomfort creating spinlock,
which never spins. :-)


And one more question:

> -               cpu_raise_softirq(cpu, TASKLET_SOFTIRQ); <<<<
> -               tasklet_unlock(t);
> -       }
> -       local_irq_restore(flags);			   <<<<

But Andrea has just tought me that this is invalid to call cpu_raise_softirq
in such context. No differences of netif_rx() here, all the issues are
the same.


>  (Alex you can safely boot latest kernels now :)).

Thank you. I am not afraid of booting not-working kernels, even like this. :-)
I am afraid, when do not feel ground. After your analysis even direction to
ground is lost. :-)

Alexey
