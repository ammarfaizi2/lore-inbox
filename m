Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVEVElV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVEVElV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 00:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEVElV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 00:41:21 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:39456 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261583AbVEVElI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 00:41:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JYIglByRu9KG/w+Vmbu3pC5g4AGoeNXALHwnVm2ZWMEGewel64dz6Mhav3HI3kZVwuOYjRN/z+YXnj/wZQUHICeugTLGDYIMaCBJbGEn846NJRiaF3SQuv0Il/j8R4D42Bbx/OGI2tjf+JshNmaFlyKkGZhferK3lK1zuy3RDIA=
Message-ID: <855e4e460505212141105e6b43@mail.gmail.com>
Date: Sat, 21 May 2005 21:41:07 -0700
From: Chen Shang <shangcs@gmail.com>
Reply-To: Chen Shang <shangcs@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Cc: Con Kolivas <kernel@kolivas.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, rml@tech9.net,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050520113448.GA20486@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <855e4e4605051909561f47351@mail.gmail.com>
	 <855e4e46050520001215be7cde@mail.gmail.com>
	 <20050520094909.GA16923@elte.hu>
	 <200505202040.51329.kernel@kolivas.org>
	 <20050520113448.GA20486@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*===== ISSUE ====*/
My second version of patch has a defect.

+  if (unlikely(old_prio != next->prio))             {
+      dequeue_task(next, array);  --> ### dequeue should against
old_prio, NOT next->prio ###
+      enqueue_task(next, array);
+  }

unforunately, dequeue_task does not accept the third parameter to make
adjustment. Personally, I feel it's good to add extra function as my
first version of patch to combine dequeue and enqueue together.
Reasons as following:
1) adding the third parameter to dequeue_task() would cause other
places' code change;
2) for schedule functions, performance is the first consideration.
Notice both dequeue_task() and enqueue_task() are NOT inline.
Combining those two in one saves one function call overhead;


/* ===== NEW PATCH ===== */
The new patch, see below, adds new function change_queue_task() to
dequeue from "old_prio queue" and enqueue the "next task" to
"next->prio queue".

The patch also inlines requeue_task().

The patch has been tested with 2.6.11.10, looks good. -For somehow,
2.6.12-rc4 is still not stable on my machine (Fedora 3).


/* ===== [PATCH 2.6.11.?] kernel/sched.c =====*/
--- linux-2.6.12-rc4.orig/kernel/sched.c	2005-05-06 22:20:31.000000000 -0700
+++ linux12/kernel/sched.c	2005-05-21 16:19:11.000000000 -0700
@@ -556,11 +556,23 @@
 	p->array = array;
 }
 
+static void change_queue_task(struct task_struct *p, prio_array_t
*array, int old_prio)
+{
+	list_del(&p->run_list);
+	if (list_empty(array->queue + old_prio))
+		__clear_bit(old_prio, array->bitmap);
+
+	sched_info_queued(p);
+	list_add_tail(&p->run_list, array->queue + p->prio);
+	__set_bit(p->prio, array->bitmap);
+	p->array = array;
+}
+
 /*
  * Put task to the end of the run list without the overhead of dequeue
  * followed by enqueue.
  */
-static void requeue_task(struct task_struct *p, prio_array_t *array)
+static inline void requeue_task(struct task_struct *p, prio_array_t *array)
 {
 	list_move_tail(&p->run_list, array->queue + p->prio);
 }
@@ -2613,7 +2625,7 @@
 	struct list_head *queue;
 	unsigned long long now;
 	unsigned long run_time;
-	int cpu, idx;
+	int cpu, idx, old_prio;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2735,9 +2747,14 @@
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
 		array = next->array;
-		dequeue_task(next, array);
+		old_prio = next->prio;
+
 		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+		
+		if (unlikely(old_prio != next->prio)) 
+			change_queue_task(next, array, old_prio);
+		else
+			requeue_task(next, array);
 	}
 	next->activated = 0;
 switch_tasks:

/* ===== PATCH END ===== */

Thanks,
-chen

On 5/20/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> > On Fri, 20 May 2005 19:49, Ingo Molnar wrote:
> > > * chen Shang <shangcs@gmail.com> wrote:
> > > > I minimized my patch and against to 2.6.12-rc4 this time, see below.
> > >
> > > looks good - i've done some small style/whitespace cleanups and renamed
> > > prio to old_prio, patch against -rc4 below.
> >
> > We should inline requeue_task as well.
> 
> yeah.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
>         Ingo
>
