Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWAKWkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWAKWkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWAKWkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:40:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16107 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932394AbWAKWkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:40:32 -0500
Date: Wed, 11 Jan 2006 23:40:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org,
       sct@redhat.com, mingo@elte.hu
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
Message-ID: <20060111224013.GA8277@elf.ucw.cz>
References: <200601112126.59796.ak@suse.de> <20060111124617.5e7e1eaa.akpm@osdl.org> <1137012917.2929.78.camel@laptopd505.fenrus.org> <20060111130728.579ab429.akpm@osdl.org> <1137014875.2929.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137014875.2929.81.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 11-01-06 22:27:55, Arjan van de Ven wrote:
> > We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> > to return zero.
> 
> you are correct, and the x86-64 mutex.h is buggy
> 
> --- linux-2.6.15/include/asm-x86_64/mutex.h.org	2006-01-11 22:25:37.000000000 +0100
> +++ linux-2.6.15/include/asm-x86_64/mutex.h	2006-01-11 22:25:43.000000000 +0100
> @@ -104,7 +104,7 @@
>  static inline int
>  __mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
>  {
> -	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
> +	if (likely(atomic_cmpxchg(count, 1, 0) == 1))
>  		return 1;
>  	else
>  		return 0;
> 
> changes the asm to be the correct one for me.
> This is odd/evil though..

likely is the evil part here. What about this? Should make this bug
impossible to do....

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -59,8 +59,8 @@ extern void __chk_io_ptr(void __iomem *)
  * specific implementations come from the above header files
  */
 
-#define likely(x)	__builtin_expect(!!(x), 1)
-#define unlikely(x)	__builtin_expect(!!(x), 0)
+#define likely(x)	(__builtin_expect(!!(x), 1))
+#define unlikely(x)	(__builtin_expect(!!(x), 0))
 
 /* Optimization barrier */
 #ifndef barrier
diff --git a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -367,7 +367,7 @@ repeat_lock_task:
 	local_irq_save(*flags);
 	rq = task_rq(p);
 	spin_lock(&rq->lock);
-	if (unlikely(rq != task_rq(p))) {
+	if unlikely(rq != task_rq(p)) {
 		spin_unlock_irqrestore(&rq->lock, *flags);
 		goto repeat_lock_task;
 	}
@@ -751,7 +751,7 @@ static int recalc_task_prio(task_t *p, u
 	else
 		sleep_time = (unsigned long)__sleep_time;
 
-	if (likely(sleep_time > 0)) {
+	if likely(sleep_time > 0) {
 		/*
 		 * User tasks that sleep a long time are categorised as
 		 * idle and will get just interactive status to stay active &
@@ -876,7 +876,7 @@ static void resched_task(task_t *p)
 
 	assert_spin_locked(&task_rq(p)->lock);
 
-	if (unlikely(test_tsk_thread_flag(p, TIF_NEED_RESCHED)))
+	if unlikely(test_tsk_thread_flag(p, TIF_NEED_RESCHED))
 		return;
 
 	set_tsk_thread_flag(p, TIF_NEED_RESCHED);


-- 
Thanks, Sharp!
