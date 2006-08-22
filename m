Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWHVTKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWHVTKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWHVTKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:10:00 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20691 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751098AbWHVTJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:09:58 -0400
Message-ID: <44EB5684.60002@watson.ibm.com>
Date: Tue, 22 Aug 2006 15:09:56 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: linux-kernel@vger.kernel.org, Balbir Singh <balbir@in.ibm.com>
Subject: Re: oops in __delayacct_blkio_ticks with 2.6.18-rc4
References: <20060821112405.GA28356@aepfle.de>
In-Reply-To: <20060821112405.GA28356@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> https://bugzilla.novell.com/show_bug.cgi?id=200526
>

Thanks for detecting this.

I suspect the oops is caused by a reading of /proc/<tgid>/stat for some task
that is late in exit. Currently tsk->delays is being freed up too early (before
the tsk is removed from the tasklist).

Could you try the patch below ? It was unclear from the bug what userspace
actions were being done to reproduce the oops - I suspect some kind of
reading of /proc/.../stat for all processes ?

>
> tsk->delays became 0 after or during the call to spinlock. _spin_lock cant be
> called with 0.
>

<snip>

> Call Trace:
> [C0000000BB3078B0] [C00000000009D604] .__delayacct_blkio_ticks+0x24/0x6c (unreliable)
> [C0000000BB307940] [C000000000128320] .do_task_stat+0x4b0/0x6fc
> [C0000000BB307C40] [C000000000124F4C] .proc_info_read+0x9c/0x144
> [C0000000BB307CF0] [C0000000000D394C] .vfs_read+0x118/0x200
> [C0000000BB307D90] [C0000000000D3E30] .sys_read+0x4c/0x8c
> [C0000000BB307E30] [C00000000000871C] syscall_exit+0x0/0x40




Cleanup allocation and freeing of tsk->delays used by delay accounting.

Currently tsk->delays is getting freed too early in task exit
which can cause a NULL tsk->delays to get accessed via reading
of /proc/<tgid>/stats. The patch fixes this problem by freeing
tsk->delays closer to when task_struct itself is freed up. As a result,
it also eliminates the use of tsk->delays_lock which was only being
used (inadequately) to safeguard access to tsk->delays
while a task was exiting.

The patch also cleans up tsk->delays allocations after a bad fork which
was missing earlier and might lead to leaks.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |   10 +++++++---
 include/linux/sched.h     |    1 -
 kernel/delayacct.c        |   16 ----------------
 kernel/exit.c             |    1 -
 kernel/fork.c             |    6 ++++--
 5 files changed, 11 insertions(+), 23 deletions(-)

Index: linux-2.6.18-rc4/kernel/fork.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/fork.c	2006-08-22 14:42:08.000000000 -0400
+++ linux-2.6.18-rc4/kernel/fork.c	2006-08-22 14:52:52.000000000 -0400
@@ -117,6 +117,7 @@ void __put_task_struct(struct task_struc
 	security_task_free(tsk);
 	free_uid(tsk->user);
 	put_group_info(tsk->group_info);
+	delayacct_tsk_free(tsk);

 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
@@ -1011,7 +1012,7 @@ static struct task_struct *copy_process(
 	retval = -EFAULT;
 	if (clone_flags & CLONE_PARENT_SETTID)
 		if (put_user(p->pid, parent_tidptr))
-			goto bad_fork_cleanup;
+			goto bad_fork_cleanup_delays_binfmt;

 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
@@ -1277,7 +1278,8 @@ bad_fork_cleanup_policy:
 bad_fork_cleanup_cpuset:
 #endif
 	cpuset_exit(p);
-bad_fork_cleanup:
+bad_fork_cleanup_delays_binfmt:
+	delayacct_tsk_free(p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
Index: linux-2.6.18-rc4/include/linux/delayacct.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/delayacct.h	2006-08-22 14:42:03.000000000 -0400
+++ linux-2.6.18-rc4/include/linux/delayacct.h	2006-08-22 14:52:52.000000000 -0400
@@ -59,10 +59,14 @@ static inline void delayacct_tsk_init(st
 		__delayacct_tsk_init(tsk);
 }

-static inline void delayacct_tsk_exit(struct task_struct *tsk)
+/* Free tsk->delays. Called from bad fork and __put_task_struct
+ * where there's no risk of tsk->delays being accessed elsewhere
+ */
+static inline void delayacct_tsk_free(struct task_struct *tsk)
 {
 	if (tsk->delays)
-		__delayacct_tsk_exit(tsk);
+		kmem_cache_free(delayacct_cache, tsk->delays);
+	tsk->delays = NULL;
 }

 static inline void delayacct_blkio_start(void)
@@ -101,7 +105,7 @@ static inline void delayacct_init(void)
 {}
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {}
-static inline void delayacct_tsk_exit(struct task_struct *tsk)
+static inline void delayacct_tsk_free(struct task_struct *tsk)
 {}
 static inline void delayacct_blkio_start(void)
 {}
Index: linux-2.6.18-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/sched.h	2006-08-22 14:42:03.000000000 -0400
+++ linux-2.6.18-rc4/include/linux/sched.h	2006-08-22 14:52:52.000000000 -0400
@@ -994,7 +994,6 @@ struct task_struct {
 	 */
 	struct pipe_inode_info *splice_pipe;
 #ifdef	CONFIG_TASK_DELAY_ACCT
-	spinlock_t delays_lock;
 	struct task_delay_info *delays;
 #endif
 };
Index: linux-2.6.18-rc4/kernel/exit.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/exit.c	2006-08-22 14:42:03.000000000 -0400
+++ linux-2.6.18-rc4/kernel/exit.c	2006-08-22 14:52:52.000000000 -0400
@@ -908,7 +908,6 @@ fastcall NORET_TYPE void do_exit(long co
 		audit_free(tsk);
 	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
 	taskstats_exit_free(tidstats);
-	delayacct_tsk_exit(tsk);

 	exit_mm(tsk);

Index: linux-2.6.18-rc4/kernel/delayacct.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/delayacct.c	2006-08-22 14:42:03.000000000 -0400
+++ linux-2.6.18-rc4/kernel/delayacct.c	2006-08-22 14:52:52.000000000 -0400
@@ -41,24 +41,11 @@ void delayacct_init(void)

 void __delayacct_tsk_init(struct task_struct *tsk)
 {
-	spin_lock_init(&tsk->delays_lock);
-	/* No need to acquire tsk->delays_lock for allocation here unless
-	   __delayacct_tsk_init called after tsk is attached to tasklist
-	*/
 	tsk->delays = kmem_cache_zalloc(delayacct_cache, SLAB_KERNEL);
 	if (tsk->delays)
 		spin_lock_init(&tsk->delays->lock);
 }

-void __delayacct_tsk_exit(struct task_struct *tsk)
-{
-	struct task_delay_info *delays = tsk->delays;
-	spin_lock(&tsk->delays_lock);
-	tsk->delays = NULL;
-	spin_unlock(&tsk->delays_lock);
-	kmem_cache_free(delayacct_cache, delays);
-}
-
 /*
  * Start accounting for a delay statistic using
  * its starting timestamp (@start)
@@ -118,8 +105,6 @@ int __delayacct_add_tsk(struct taskstats
 	struct timespec ts;
 	unsigned long t1,t2,t3;

-	spin_lock(&tsk->delays_lock);
-
 	/* Though tsk->delays accessed later, early exit avoids
 	 * unnecessary returning of other data
 	 */
@@ -161,7 +146,6 @@ int __delayacct_add_tsk(struct taskstats
 	spin_unlock(&tsk->delays->lock);

 done:
-	spin_unlock(&tsk->delays_lock);
 	return 0;
 }


