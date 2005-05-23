Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVEWOqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVEWOqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEWOqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:46:07 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:64019 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261860AbVEWOpn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:45:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O5Rb7giopr9ViyPLZXX7K8STDEbMKNJMx6roaASl0BU6VnQDnexb+yhnlsYgOcslahGnRLcecZEREe55ymCTzVrX2PQ+VNCtI7mWD8L41s/uiWMLWRdmy+uQx2YiY1JNr3Vxuzf/R2IDI8+/VLYTrAeQq4z5+CrdY+LDBlt6u7g=
Message-ID: <855e4e4605052307453b744e4a@mail.gmail.com>
Date: Mon, 23 May 2005 07:45:40 -0700
From: Chen Shang <shangcs@gmail.com>
Reply-To: Chen Shang <shangcs@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Cc: Con Kolivas <kernel@kolivas.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, rml@tech9.net,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050523071103.GA30016@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <855e4e4605051909561f47351@mail.gmail.com>
	 <855e4e46050520001215be7cde@mail.gmail.com>
	 <20050520094909.GA16923@elte.hu>
	 <200505202040.51329.kernel@kolivas.org>
	 <20050520113448.GA20486@elte.hu>
	 <855e4e460505212141105e6b43@mail.gmail.com>
	 <20050523071103.GA30016@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

much better.
If so, another place, activate_task(), need to make adjustment as well.

-chen

/* ============================ */
 /*
@@ -704,7 +704,7 @@
 	}
 #endif
 
-	recalc_task_prio(p, now);
+	p->prio = recalc_task_prio(p, now);

/* ============================ */

On 5/23/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> the real problem comes from recalc_task_prio() having a side-effect,
> which makes requeueing of tasks harder. The solution is to return the
> prio from recalc_task_prio() - see the tested patch below. Agreed?
> 
>         Ingo
> 
> --
> 
> micro-optimize task requeueing in schedule() & clean up
> recalc_task_prio().
> 
> --- linux/kernel/sched.c.orig
> +++ linux/kernel/sched.c
> @@ -675,7 +675,7 @@ static inline void __activate_idle_task(
>         rq->nr_running++;
>  }
> 
> -static void recalc_task_prio(task_t *p, unsigned long long now)
> +static int recalc_task_prio(task_t *p, unsigned long long now)
>  {
>         /* Caller must always ensure 'now >= p->timestamp' */
>         unsigned long long __sleep_time = now - p->timestamp;
> @@ -734,7 +734,7 @@ static void recalc_task_prio(task_t *p,
>                 }
>         }
> 
> -       p->prio = effective_prio(p);
> +       return effective_prio(p);
>  }
> 
>  /*
> @@ -757,7 +757,7 @@ static void activate_task(task_t *p, run
>         }
>  #endif
> 
> -       recalc_task_prio(p, now);
> +       p->prio = recalc_task_prio(p, now);
> 
>         /*
>          * This checks to make sure it's not an uninterruptible task
> @@ -2751,7 +2751,7 @@ asmlinkage void __sched schedule(void)
>         struct list_head *queue;
>         unsigned long long now;
>         unsigned long run_time;
> -       int cpu, idx;
> +       int cpu, idx, new_prio;
> 
>         /*
>          * Test if we are atomic.  Since do_exit() needs to call into
> @@ -2873,9 +2873,14 @@ go_idle:
>                         delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
> 
>                 array = next->array;
> -               dequeue_task(next, array);
> -               recalc_task_prio(next, next->timestamp + delta);
> -               enqueue_task(next, array);
> +               new_prio = recalc_task_prio(next, next->timestamp + delta);
> +
> +               if (unlikely(next->prio != new_prio)) {
> +                       dequeue_task(next, array);
> +                       next->prio = new_prio;
> +                       enqueue_task(next, array);
> +               } else
> +                       requeue_task(next, array);
>         }
>         next->activated = 0;
>  switch_tasks:
>
