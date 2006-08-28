Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWH1WBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWH1WBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWH1WBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:01:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8093 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751530AbWH1WBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:01:48 -0400
Message-ID: <44F367C8.9040507@watson.ibm.com>
Date: Mon, 28 Aug 2006 18:01:44 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>	<20060827231421.f0fc9db1.akpm@osdl.org>	<20060828061940.GA12671@aepfle.de> <20060827232437.821110f3.akpm@osdl.org> <44F300A8.2000408@watson.ibm.com>
In-Reply-To: <44F300A8.2000408@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup allocation and freeing of tsk->delays used by delay accounting.
This solves two problems reported for delay accounting:

1. oops in __delayacct_blkio_ticks
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0608.2/1844.html

Currently tsk->delays is getting freed too early in task exit
which can cause a NULL tsk->delays to get accessed via reading
of /proc/<tgid>/stats. The patch fixes this problem by freeing
tsk->delays closer to when task_struct itself is freed up. As a result,
it also eliminates the use of tsk->delays_lock which was only being
used (inadequately) to safeguard access to tsk->delays
while a task was exiting.

2. Possible memory leak in kernel/delayacct.c
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0608.2/1389.html

The patch cleans up tsk->delays allocations after a bad fork which
was missing earlier.


The patch has been tested to fix the problems listed above
and stress tested with rapid calls to delay accounting's taskstats
command interface (which is the other path that can access the same
data, besides the /proc interface causing the oops above).


Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |   10 +++++++---
 include/linux/sched.h     |    1 -
 kernel/delayacct.c        |   16 ----------------
 kernel/exit.c             |    1 -
 kernel/fork.c             |    6 ++++--
 5 files changed, 11 insertions(+), 23 deletions(-)

Index: linux-2.6.18-rc5/kernel/fork.c
===================================================================
--- linux-2.6.18-rc5.orig/kernel/fork.c	2006-08-28 11:34:27.000000000 -0400
+++ linux-2.6.18-rc5/kernel/fork.c	2006-08-28 11:34:48.000000000 -0400
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
Index: linux-2.6.18-rc5/include/linux/delayacct.h
===================================================================
--- linux-2.6.18-rc5.orig/include/linux/delayacct.h	2006-08-28 11:34:27.000000000 -0400
+++ linux-2.6.18-rc5/include/linux/delayacct.h	2006-08-28 11:34:48.000000000 -0400
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
Index: linux-2.6.18-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc5.orig/include/linux/sched.h	2006-08-28 11:34:27.000000000 -0400
+++ linux-2.6.18-rc5/include/linux/sched.h	2006-08-28 11:34:48.000000000 -0400
@@ -994,7 +994,6 @@ struct task_struct {
 	 */
 	struct pipe_inode_info *splice_pipe;
 #ifdef	CONFIG_TASK_DELAY_ACCT
-	spinlock_t delays_lock;
 	struct task_delay_info *delays;
 #endif
 };
Index: linux-2.6.18-rc5/kernel/exit.c
===================================================================
--- linux-2.6.18-rc5.orig/kernel/exit.c	2006-08-28 11:34:27.000000000 -0400
+++ linux-2.6.18-rc5/kernel/exit.c	2006-08-28 11:34:48.000000000 -0400
@@ -908,7 +908,6 @@ fastcall NORET_TYPE void do_exit(long co
 		audit_free(tsk);
 	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
 	taskstats_exit_free(tidstats);
-	delayacct_tsk_exit(tsk);

 	exit_mm(tsk);

Index: linux-2.6.18-rc5/kernel/delayacct.c
===================================================================
--- linux-2.6.18-rc5.orig/kernel/delayacct.c	2006-08-28 11:34:27.000000000 -0400
+++ linux-2.6.18-rc5/kernel/delayacct.c	2006-08-28 11:34:48.000000000 -0400
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




