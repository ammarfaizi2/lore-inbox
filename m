Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSAGR0h>; Mon, 7 Jan 2002 12:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283268AbSAGR02>; Mon, 7 Jan 2002 12:26:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12960 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282978AbSAGR0U>;
	Mon, 7 Jan 2002 12:26:20 -0500
Date: Mon, 7 Jan 2002 20:23:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: [patch] O(1) scheduler, -D0, 2.5.2-pre9, 2.4.17
Message-ID: <Pine.LNX.4.33.0201071952270.11688-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded an updated O(1) scheduler patch:

 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-D0.patch
 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-D0.patch

this release uses Linus' idea of merging RT task priorities into the
normal scheduler priority bitspace. This allowed the removal of all the
ugly RT-related special-case code: the RT and non-RT schedulers are united
again. It's all just one kind of task - an RT task is 'just' a task with
lower priority. The RT locking/unlocking code is completely gone.
rt_schedule() is gone. There is only a single rt_task() branch in the
scheduler hotpaths.

I cannot overemphasize the level of cleanups this enabled. Eg. schedule()
itself has become a very simple, 60 lines long function. If compiled with
a gcc 3.1-ish compiler that knows about likely()/unlikely() the schedule()
function has just a two taken branches in the hotpath! The rest is
straight fall-through code. Altogether, the cleanups reduced sched.c's
source code size by more than 10%!

to enable the fast searching of the 100 + 40 bits bitmap, i've shifted the
SCHED_OTHER bitspace to 128-167. The RT task queues are in bit 0-99. The
100-128 bits are in essence unused. This way the bit-searching can be done
very quickly for the common (no RT) case, on x86:

  static inline int sched_find_first_zero_bit(char *bitmap)
  {
          unsigned int *b = (unsigned int *)bitmap;
          unsigned int rt;

          rt = b[0] & b[1] & b[2] & b[3];
          if (unlikely(rt != 0xffffffff))
                  return find_first_zero_bit(bitmap, MAX_RT_PRIO);

          if (b[4] != ~0)
                  return ffz(b[4]) + MAX_RT_PRIO;
          return ffz(b[5]) + 32 + MAX_RT_PRIO;
  }

also, the layout of the 'normal' task queues is thus cacheline aligned.
(and even in the RT case the find_first_zero_bit() is hand-optimized
assembly code as well.) There is no measurable difference between the
context-switch times of the -C1 patch and this patch, both do 1.57 usecs
on a 466 MHz Celeron.

RT tasks can still be made 'global' at any later point, by doing directed
wakeups towards lower priority CPUs. (The wakeup path has a rt_task()
branch already so there would be no wakeup overhead for normal tasks.)

The patch is stable on my boxes, and two alpha-testers reported that this
patch fixes the crashes they saw with earlier patches.

Changelog:

 - export set_user_nice (Jens Axboe)

 - report correctly scaled priorities via /proc. (this unbreaks 'top'
   priority output.)

 - speeded up the task-load estimator a bit.

 - cleaned up slip.c's and reiserfs/buffer2.c's scheduler usage.

 - lock both runqueues in init_idle(), this could explain some of the
   boot-time SMP crashes Anton saw.

	Ingo

