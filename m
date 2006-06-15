Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030719AbWFOT4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030719AbWFOT4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031234AbWFOT4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:56:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44469 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030719AbWFOT4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:56:36 -0400
Subject: Re: [PATCH 1/3] check_process_timers: fix possible lockup
From: john stultz <johnstul@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060615161115.GA21455@oleg>
References: <20060615161115.GA21455@oleg>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 12:56:31 -0700
Message-Id: <1150401392.15267.24.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 20:11 +0400, Oleg Nesterov wrote:
> If the local timer interrupt happens just after do_exit() sets PF_EXITING
> (and before it clears ->it_xxx_expires) run_posix_cpu_timers() will call
> check_process_timers() with tasklist_lock + ->siglock held and
> 
> 	check_process_timers:
> 
> 		t = tsk;
> 		do {
> 			....
> 
> 			do {
> 				t = next_thread(t);
> 			} while (unlikely(t->flags & PF_EXITING));
> 		} while (t != tsk);
> 
> the outer loop will never stop.

I believe we've hit the same issue here in the -RT tree. 


> Actually, the window is bigger. Another process can attach the timer after
> ->it_xxx_expires was cleared (see the patch 2/3) and the 'if (PF_EXITING)'
> check in arm_timer() is racy (see the patch 3/3).
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.17-rc6/kernel/posix-cpu-timers.c~1_CPT	2006-06-15 17:59:15.000000000 +0400
> +++ 2.6.17-rc6/kernel/posix-cpu-timers.c	2006-06-15 18:01:57.000000000 +0400
> @@ -1173,6 +1173,9 @@ static void check_process_timers(struct 
>  		}
>  		t = tsk;
>  		do {
> +			if (unlikely(t->flags & PF_EXITING))
> +				continue;
> +
>  			ticks = cputime_add(cputime_add(t->utime, t->stime),
>  					    prof_left);
>  			if (!cputime_eq(prof_expires, cputime_zero) &&
> @@ -1193,11 +1196,7 @@ static void check_process_timers(struct 
>  					      t->it_sched_expires > sched)) {
>  				t->it_sched_expires = sched;
>  			}
> -
> -			do {
> -				t = next_thread(t);
> -			} while (unlikely(t->flags & PF_EXITING));
> -		} while (t != tsk);
> +		} while ((t = next_thread(t)) != tsk);
>  	}
>  }

This looks equivalent to the fix in -RT.

thanks
-john


