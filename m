Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUFJCUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUFJCUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUFJCUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:20:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:22507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264492AbUFJCUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:20:52 -0400
Date: Wed, 9 Jun 2004 19:20:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, jk@ozlabs.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Fix signal race during process exit
Message-Id: <20040609192000.78142ba3.akpm@osdl.org>
In-Reply-To: <200406100148.i5A1mwHl009763@magilla.sf.frob.com>
References: <20040603183044.40e4a95c.akpm@osdl.org>
	<200406100148.i5A1mwHl009763@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> Back to the local fix for the case we have hit, the signals produced by
>  update_process_times.  I think the patch below that went in has a bug.
>  Perhaps I've missed something.  It seems to me that clearing it_virt_incr
>  doesn't really cut it, since there will be one more hit before that value
>  is reloaded.  Shouldn't it clear it_virt_value, as it clears it_prof_value?
> 

yup.



As Roland McGrath <roland@redhat.com> points out, we need to zero
task->it_virt_value to prevent timer-based signal delivery, not
->it_virt_incr.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/exit.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/exit.c~exit-timer-interrupt-race-fix-fix kernel/exit.c
--- 25/kernel/exit.c~exit-timer-interrupt-race-fix-fix	2004-06-09 19:17:21.138846896 -0700
+++ 25-akpm/kernel/exit.c	2004-06-09 19:17:35.523660072 -0700
@@ -740,7 +740,7 @@ static void exit_notify(struct task_stru
 	 * Clear these here so that update_process_times() won't try to deliver
 	 * itimer, profile or rlimit signals to this task while it is in late exit.
 	 */
-	tsk->it_virt_incr = 0;
+	tsk->it_virt_value = 0;
 	tsk->it_prof_value = 0;
 	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
 
_

>  And btw, as I think someone else mentioned, update_one_process really
>  should be made static so it can be inlined.  It has just the one caller,
>  update_process_times in the same file (kernel/timer.c).

yup.



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/sched.h |    2 --
 25-akpm/kernel/timer.c        |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff -puN include/linux/sched.h~staticalise-update_one_process include/linux/sched.h
--- 25/include/linux/sched.h~staticalise-update_one_process	2004-06-09 19:16:02.826752144 -0700
+++ 25-akpm/include/linux/sched.h	2004-06-09 19:16:23.919545552 -0700
@@ -176,8 +176,6 @@ long io_schedule_timeout(long timeout);
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
-extern void update_one_process(struct task_struct *p, unsigned long user,
-			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 
diff -puN kernel/timer.c~staticalise-update_one_process kernel/timer.c
--- 25/kernel/timer.c~staticalise-update_one_process	2004-06-09 19:16:02.855747736 -0700
+++ 25-akpm/kernel/timer.c	2004-06-09 19:16:30.734509520 -0700
@@ -830,7 +830,7 @@ static inline void do_it_prof(struct tas
 	}
 }
 
-void update_one_process(struct task_struct *p, unsigned long user,
+static void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
 	do_process_times(p, user, system);
_

