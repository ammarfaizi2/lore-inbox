Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWGERLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWGERLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWGERLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:11:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964916AbWGERLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:11:06 -0400
Date: Wed, 5 Jul 2006 10:10:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060705101059.66a762bf.akpm@osdl.org>
In-Reply-To: <20060705114630.GA3134@elte.hu>
References: <20060705084914.GA8798@elte.hu>
	<20060705023120.2b70add6.akpm@osdl.org>
	<20060705093259.GA11237@elte.hu>
	<20060705025349.eb88b237.akpm@osdl.org>
	<20060705102633.GA17975@elte.hu>
	<20060705113054.GA30919@elte.hu>
	<20060705114630.GA3134@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 13:46:30 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > true. I redid my tests with both lockdep and debug-spinlocks turned off:
> > > 
> > >   text            data    bss     dec             filename
> > >   21172153        6077270 3081864 30331287        vmlinux.x32.after
> > >   21198222        6077106 3081864 30357192        vmlinux.x32.before
> > > 
> > > with 851 callsites that's a 30.6 bytes win per call site (total 26K) - 
> > > still not bad at all.
> > 
> > and that was with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled. With 
> > optimize-for-size disabled the win goes up to 32.6 bytes (total 28K).
> 
> i also tried a config with the best size settings (disabling 
> FRAME_POINTER, enabling CC_OPTIMIZE_FOR_SIZE), and this gives:
> 
>   text            data    bss     dec         filename
>   20777768        6076042 3081864 29935674    vmlinux.x32.size.before
>   20748140        6076178 3081864 29906182    vmlinux.x32.size.after
> 
> or a 34.8 bytes win per callsite (29K total).
> 

With gcc-4.1.0 on i686, uninlining those three functions as per the below
patch _increases_ the allnoconfig vmlinux's .text from 833456 bytes to
833728.

Which maybe means it's still worth doing, because a lot of people run with
some debug options nowadays.

But it's a more believable result, and an inexplicable one given your
numbers.  Something's up.



 include/linux/wait.h |   24 +++---------------------
 kernel/fork.c        |   21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff -puN include/linux/wait.h~a include/linux/wait.h
--- a/include/linux/wait.h~a
+++ a/include/linux/wait.h
@@ -82,27 +82,9 @@ struct task_struct;
  */
 extern struct lock_class_key waitqueue_lock_key;
 
-static inline void init_waitqueue_head(wait_queue_head_t *q)
-{
-	spin_lock_init(&q->lock);
-	lockdep_set_class(&q->lock, &waitqueue_lock_key);
-	INIT_LIST_HEAD(&q->task_list);
-}
-
-static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
-{
-	q->flags = 0;
-	q->private = p;
-	q->func = default_wake_function;
-}
-
-static inline void init_waitqueue_func_entry(wait_queue_t *q,
-					wait_queue_func_t func)
-{
-	q->flags = 0;
-	q->private = NULL;
-	q->func = func;
-}
+void init_waitqueue_head(wait_queue_head_t *q);
+void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p);
+void init_waitqueue_func_entry(wait_queue_t *q, wait_queue_func_t func);
 
 static inline int waitqueue_active(wait_queue_head_t *q)
 {
diff -puN fs/aio.c~a fs/aio.c
diff -puN kernel/fork.c~a kernel/fork.c
--- a/kernel/fork.c~a
+++ a/kernel/fork.c
@@ -153,6 +153,27 @@ void __init fork_init(unsigned long memp
 		init_task.signal->rlim[RLIMIT_NPROC];
 }
 
+void init_waitqueue_head(wait_queue_head_t *q)
+{
+	spin_lock_init(&q->lock);
+	lockdep_set_class(&q->lock, &waitqueue_lock_key);
+	INIT_LIST_HEAD(&q->task_list);
+}
+
+void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
+{
+	q->flags = 0;
+	q->private = p;
+	q->func = default_wake_function;
+}
+
+void init_waitqueue_func_entry(wait_queue_t *q, wait_queue_func_t func)
+{
+	q->flags = 0;
+	q->private = NULL;
+	q->func = func;
+}
+
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;
_

