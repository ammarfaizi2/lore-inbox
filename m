Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSFTT1K>; Thu, 20 Jun 2002 15:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSFTT1J>; Thu, 20 Jun 2002 15:27:09 -0400
Received: from holomorphy.com ([66.224.33.161]:65215 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315421AbSFTT1H>;
	Thu, 20 Jun 2002 15:27:07 -0400
Date: Thu, 20 Jun 2002 12:26:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020620192633.GZ22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020620172059.GW22961@holomorphy.com> <Pine.LNX.4.44.0206201929310.9805-100000@e2> <20020620181729.GY22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020620181729.GY22961@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 07:31:18PM +0200, Ingo Molnar wrote:
>> looks good to me - what do you think about my other pidhash suggestion:

On Thu, Jun 20, 2002 at 11:17:29AM -0700, William Lee Irwin III wrote:
> An excellent idea. I didn't go all the way and make the pidhash entirely
> private to fork.c but taking find_task_by_pid() out-of-line is implemented
> in the following, built atop the prior patch. I can also privatize the
> pidhash entirely if that's wanted.

The final piece, built on top of the previous two. Please comment and/or
use your discretion. Although I test compiled and booted it on UP i386,
this may not be the desired cleanup. The original purpose of this was to
enforce the usage of Linux' standard list data type for the pidhash.


Cheers,
Bill


diff -urN linux-2.5.23-virgin/include/linux/sched.h linux-2.5.23-wli/include/linux/sched.h
--- linux-2.5.23-virgin/include/linux/sched.h	Thu Jun 20 11:39:08 2002
+++ linux-2.5.23-wli/include/linux/sched.h	Thu Jun 20 11:41:26 2002
@@ -441,24 +441,8 @@
 extern struct task_struct *init_tasks[NR_CPUS];
 
 /* PID hashing. */
-extern list_t *pidhash;
-extern unsigned long pidhash_size;
-
-static inline unsigned pid_hashfn(pid_t pid)
-{
-	return ((pid >> 8) ^ pid) & (pidhash_size - 1);
-}
-
-static inline void hash_pid(struct task_struct *p)
-{
-	list_add(&p->pidhash_list, &pidhash[pid_hashfn(p->pid)]);
-}
-
-static inline void unhash_pid(struct task_struct *p)
-{
-	list_del(&p->pidhash_list);
-}
-
+extern void hash_pid(task_t *);
+extern void unhash_pid(task_t *);
 extern task_t *find_task_by_pid(int pid);
 
 /* per-UID process charging. */
diff -urN linux-2.5.23-virgin/kernel/fork.c linux-2.5.23-wli/kernel/fork.c
--- linux-2.5.23-virgin/kernel/fork.c	Thu Jun 20 11:39:08 2002
+++ linux-2.5.23-wli/kernel/fork.c	Thu Jun 20 11:43:30 2002
@@ -69,6 +69,11 @@
 		INIT_LIST_HEAD(&pidhash[i]);
 }
 
+static inline unsigned pid_hashfn(pid_t pid)
+{
+	return ((pid >> 8) ^ pid) & (pidhash_size - 1);
+}
+
 task_t *find_task_by_pid(int pid)
 {
 	list_t *p, *pid_list = &pidhash[pid_hashfn(pid)];
@@ -82,7 +87,20 @@
 
 	return NULL;
 }
+
+void hash_pid(task_t *p)
+{
+	list_add(&p->pidhash_list, &pidhash[pid_hashfn(p->pid)]);
+}
+
+void unhash_pid(task_t *p)
+{
+	list_del(&p->pidhash_list);
+}
+
 EXPORT_SYMBOL(find_task_by_pid);
+EXPORT_SYMBOL(hash_pid);
+EXPORT_SYMBOL(unhash_pid);
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
diff -urN linux-2.5.23-virgin/kernel/ksyms.c linux-2.5.23-wli/kernel/ksyms.c
--- linux-2.5.23-virgin/kernel/ksyms.c	Thu Jun 20 00:10:27 2002
+++ linux-2.5.23-wli/kernel/ksyms.c	Thu Jun 20 11:41:41 2002
@@ -602,5 +602,3 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
-EXPORT_SYMBOL(pidhash);
-EXPORT_SYMBOL(pidhash_size);
