Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbUJZMLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUJZMLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUJZMLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:11:44 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:15206 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262247AbUJZMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:04:42 -0400
Message-ID: <417E3D4C.2010909@yahoo.com.au>
Date: Tue, 26 Oct 2004 22:04:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Geithe <warpy@gmx.de>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: 2.6.10-rc1-bk4 and kernel/futex.c:542
References: <200410261135.51035.warpy@gmx.de> <20041026133126.1b44fb38@mango.fruits.de> <20041026112415.GA21015@elte.hu> <200410261338.00341.warpy@gmx.de>
In-Reply-To: <200410261338.00341.warpy@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------090807050408060102040005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807050408060102040005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Michael Geithe wrote:
> Hi,
> 
> first config with > e100
> 
> Oct 26 10:57:33 h2so4 kernel: e100: Intel(R) PRO/100 Network Driver, 
> 3.2.3-k2-NAPI
> Oct 26 10:57:33 h2so4 kernel: e100: Copyright(c) 1999-2004 Intel Corporation
> 
> Oct 26 11:02:19 h2so4 kernel: Badness in futex_wait at kernel/futex.c:542
> Oct 26 11:02:19 h2so4 kernel:  [<c012ba15>] futex_wait+0x180/0x18a
> Oct 26 11:02:19 h2so4 kernel:  [<c011532c>] default_wake_function+0x0/0xc
> Oct 26 11:02:19 h2so4 kernel:  [<c011532c>] default_wake_function+0x0/0xc
> Oct 26 11:02:19 h2so4 kernel:  [<c010a323>] convert_fxsr_from_user+0x15/0xd8
> Oct 26 11:02:19 h2so4 kernel:  [<c012bc43>] do_futex+0x35/0x7f
> Oct 26 11:02:19 h2so4 kernel:  [<c01dbd77>] copy_from_user+0x34/0x61
> Oct 26 11:02:19 h2so4 kernel:  [<c012bd6d>] sys_futex+0xe0/0xec
> Oct 26 11:02:19 h2so4 kernel:  [<c0103da5>] sysenter_past_esp+0x52/0x71
> 
> and second config with > eepro100
> 
> Oct 26 13:12:25 h2so4 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
> http://www.scyld.com/network/eepro100.html
> Oct 26 13:12:25 h2so4 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
> Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
> 
> and i dont see this message again.
> 

Hi,
Can you try the following patch and see what it says?

--------------090807050408060102040005
Content-Type: text/x-patch;
 name="futex-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="futex-debug.patch"




---

 linux-2.6-npiggin/include/linux/sched.h |    1 +
 linux-2.6-npiggin/kernel/futex.c        |   15 +++++++++++++--
 linux-2.6-npiggin/kernel/sched.c        |    8 ++++++++
 linux-2.6-npiggin/kernel/timer.c        |   12 +++++++++++-
 4 files changed, 33 insertions(+), 3 deletions(-)

diff -puN kernel/futex.c~futex-debug kernel/futex.c
--- linux-2.6/kernel/futex.c~futex-debug	2004-10-26 21:59:06.000000000 +1000
+++ linux-2.6-npiggin/kernel/futex.c	2004-10-26 21:59:55.000000000 +1000
@@ -271,7 +271,11 @@ static void wake_futex(struct futex_q *q
 	 * The lock in wake_up_all() is a crucial memory barrier after the
 	 * list_del_init() and also before assigning to q->lock_ptr.
 	 */
+
+	current->flags |= PF_FUTEX_DEBUG;
 	wake_up_all(&q->waiters);
+	current->flags &= ~PF_FUTEX_DEBUG;
+
 	/*
 	 * The waiting task can free the futex_q as soon as this is written,
 	 * without taking any locks.  This must come last.
@@ -524,8 +528,11 @@ static int futex_wait(unsigned long uadd
 	 * !list_empty() is safe here without any lock.
 	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
 	 */
-	if (likely(!list_empty(&q.list)))
+	if (likely(!list_empty(&q.list))) {
+		current->flags |= PF_FUTEX_DEBUG;
 		time = schedule_timeout(time);
+		current->flags &= ~PF_FUTEX_DEBUG;
+	}
 	__set_current_state(TASK_RUNNING);
 
 	/*
@@ -539,7 +546,11 @@ static int futex_wait(unsigned long uadd
 	if (time == 0)
 		return -ETIMEDOUT;
 	/* A spurious wakeup should never happen. */
-	WARN_ON(!signal_pending(current));
+	if (!signal_pending(current)) {
+		printk("futex_wait woken: %lu %i %lu\n",
+		       uaddr, val, time);
+		WARN_ON(1);
+	}
 	return -EINTR;
 
  out_unqueue:
diff -puN include/linux/sched.h~futex-debug include/linux/sched.h
--- linux-2.6/include/linux/sched.h~futex-debug	2004-10-26 21:59:06.000000000 +1000
+++ linux-2.6-npiggin/include/linux/sched.h	2004-10-26 22:01:01.000000000 +1000
@@ -701,6 +701,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_FUTEX_DEBUG	0x00800000
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
diff -puN kernel/sched.c~futex-debug kernel/sched.c
--- linux-2.6/kernel/sched.c~futex-debug	2004-10-26 21:59:06.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-10-26 22:02:51.000000000 +1000
@@ -993,6 +993,14 @@ static int try_to_wake_up(task_t * p, un
 	old_state = p->state;
 	if (!(old_state & state))
 		goto out;
+	
+	if ((p->flags & PF_FUTEX_DEBUG)
+	    && !(current->flags & PF_FUTEX_DEBUG)) {
+		printk("%s %i waking %s: %i %i\n",
+		       current->comm, (int)in_interrupt(),
+		       p->comm, p->tgid, p->pid);
+		WARN_ON(1);
+	}
 
 	if (p->array)
 		goto out_running;
diff -puN kernel/timer.c~futex-debug kernel/timer.c
--- linux-2.6/kernel/timer.c~futex-debug	2004-10-26 21:59:17.000000000 +1000
+++ linux-2.6-npiggin/kernel/timer.c	2004-10-26 21:59:55.000000000 +1000
@@ -1083,6 +1083,13 @@ static void process_timeout(unsigned lon
 	wake_up_process((task_t *)__data);
 }
 
+static void futex_timeout(unsigned long __data)
+{
+	current->flags |= PF_FUTEX_DEBUG;
+	wake_up_process((task_t *)__data);
+	current->flags &= ~PF_FUTEX_DEBUG;
+}
+
 /**
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
@@ -1149,7 +1156,10 @@ fastcall signed long __sched schedule_ti
 	init_timer(&timer);
 	timer.expires = expire;
 	timer.data = (unsigned long) current;
-	timer.function = process_timeout;
+	if (current->flags & PF_FUTEX_DEBUG)
+		timer.function = futex_timeout;
+	else
+		timer.function = process_timeout;
 
 	add_timer(&timer);
 	schedule();

_

--------------090807050408060102040005--
