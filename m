Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbRGLEwU>; Thu, 12 Jul 2001 00:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbRGLEwA>; Thu, 12 Jul 2001 00:52:00 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:23944 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267426AbRGLEvu>; Thu, 12 Jul 2001 00:51:50 -0400
Message-ID: <3B4D2D37.9440B48D@uow.edu.au>
Date: Thu, 12 Jul 2001 14:53:11 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Peter Zaitsev <pz@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: message from Andrew Morton on Thursday July 12,
		<1011478953412.20010705152412@spylog.ru>
		<15172.22988.643481.421716@notabene.cse.unsw.edu.au>
		<11486070195.20010705172249@spylog.ru>
		<15180.63984.722843.539959@notabene.cse.unsw.edu.au>
		<3B4D01E3.1A2F534F@uow.edu.au> <15181.6162.414864.195108@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> --- drivers/md/raid1.c  2001/07/12 02:00:35     1.1
> +++ drivers/md/raid1.c  2001/07/12 02:01:42
> @@ -83,6 +83,7 @@
>                         cnt--;
>                 } else {
>                         PRINTK("raid1: waiting for %d bh\n", cnt);
> +                       run_task_queue(&tq_disk);
>                         wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
>                 }
>         }
> @@ -170,6 +171,7 @@
>                         memset(r1_bh, 0, sizeof(*r1_bh));
>                         return r1_bh;
>                 }
> +               run_task_queue(&tq_disk);
>                 wait_event(conf->wait_buffer, conf->freer1);
>         } while (1);
>  }
> 
> This is needed anyway to be "correct", as you should always unplug
> the queues before waiting for IO to complete.

The problem with this approach is the waitqueue - you get several
tasks on the waitqueue, and bdflush loses the race - some other
thread steals the r1bh and bdflush goes back to sleep.

Replacing the wait_event() with a special raid1_wait_event()
which unplugs *each time* the caller is woken does help - but
it is still easy to deadlock the system.

Clearly this approach is racy: it assumes that the reserved buffers have
actually been submitted when we unplug - they may not yet have been.
But the lockup is too easy to trigger for that to be a satisfactory
explanation.

The most effective, aggressive, successful and grotty fix for this
problem is to remove the wait_event altogether and replace it with:

	run_task_queue(tq_disk);
	current->policy |= SCHED_YIELD;
	__set_current_state(TASK_RUNNING);
	schedule();

This can still deadlock in bad OOM situations, but I think we're
dead anyway.  A combination of this approach plus the PF_FLUSH
reservations would work even better, but I found the PF_FLUSH
stuff was sufficient.

> Mind you, if I was really serious about being
> gentle on the memory allocation, I would use
>    kmem_cache_alloc(bh_cachep,SLAB_whatever)
> instead of
>    kmalloc(sizeof(struct buffer_head), GFP_whatever)

get/put_unused_buffer_head() should be exported API functions.

-
