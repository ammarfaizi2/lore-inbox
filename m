Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWHVMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWHVMWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHVMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:22:39 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:11490 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP id S932206AbWHVMWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:22:38 -0400
Subject: Re: [patch] pi-futex: missing pi_waiters plist initialization
From: Sharyathi Nagesh <sharyath@in.ibm.com>
Reply-To: sharyath@in.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: zhuyaof@cn.ibm.com, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060724112112.GA16537@osiris.boeblingen.de.ibm.com>
References: <20060724112112.GA16537@osiris.boeblingen.de.ibm.com>
Content-Type: multipart/mixed; boundary="=-BlqFUO1v72sOgwkFB0LV"
Organization: IBM
Date: Tue, 22 Aug 2006 17:58:07 +0530
Message-Id: <1156249687.14883.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BlqFUO1v72sOgwkFB0LV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-07-24 at 13:21 +0200, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Initialize init task's pi_waiters plist. Otherwise cpu hotplug of cpu 0
> might crash, since rt_mutex_getprio() accesses an uninitialized list head.
> 
> call chain which led to crash:
> 
> take_cpu_down
> sched_idle_next
> __setscheduler
> rt_mutex_getprio
> 
> Using PLIST_HEAD_INIT in the INIT_TASK macro doesn't work unfortunately, since
> the pi_waiters member is only conditionally present.

Hi 
     I felt it would be more appropriate to put initialization of
pi_waiters in fork_init function rather than in sched_init function as
other init_task related initialization or happening in fork_init(). As
well we have rt_mutex_init_task() function in fork.c which can be reused
for initializing pi_waiters field of init_task. 
    Please go through the patch and let me know of your opinion.
Thanks 
Sharyathi Nagesh

--=-BlqFUO1v72sOgwkFB0LV
Content-Disposition: attachment; filename=pi_waiters.patch
Content-Type: text/x-patch; name=pi_waiters.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: <sharyath@in.ibm.com>
----


Index: linux-2.6.18-rc4/kernel/fork.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/fork.c	2006-08-06 23:50:11.000000000 +0530
+++ linux-2.6.18-rc4/kernel/fork.c	2006-08-22 13:03:03.000000000 +0530
@@ -122,6 +122,16 @@
 		free_task(tsk);
 }
 
+
+static inline void rt_mutex_init_task(struct task_struct *p)
+{
+#ifdef CONFIG_RT_MUTEXES
+	spin_lock_init(&p->pi_lock);
+	plist_head_init(&p->pi_waiters, &p->pi_lock);
+	p->pi_blocked_on = NULL;
+#endif
+}
+
 void __init fork_init(unsigned long mempages)
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
@@ -151,6 +161,7 @@
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
+	rt_mutex_init_task(&init_task);
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -919,15 +930,6 @@
 	return current->pid;
 }
 
-static inline void rt_mutex_init_task(struct task_struct *p)
-{
-#ifdef CONFIG_RT_MUTEXES
-	spin_lock_init(&p->pi_lock);
-	plist_head_init(&p->pi_waiters, &p->pi_lock);
-	p->pi_blocked_on = NULL;
-#endif
-}
-
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.

--=-BlqFUO1v72sOgwkFB0LV--

