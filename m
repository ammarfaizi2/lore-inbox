Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266359AbUG0IgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbUG0IgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUG0IgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:36:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:23499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266364AbUG0Ifz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:35:55 -0400
Date: Tue, 27 Jul 2004 01:34:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Message-Id: <20040727013427.52d3e5f5.akpm@osdl.org>
In-Reply-To: <41060B62.1060806@suse.de>
References: <40FD23A8.6090409@suse.de>
	<20040725182006.6c6a36df.akpm@osdl.org>
	<4104E421.8080700@suse.de>
	<20040726131807.47816576.akpm@osdl.org>
	<4105FE68.7040506@suse.de>
	<20040727002409.68d49d7c.akpm@osdl.org>
	<41060B62.1060806@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> wrote:
>
>  Patch (for the semaphore version) is attached.

err, what on earth is this patch trying to do?  It adds tons more
complexity then I expected to see.  Are the async (wait=0) semantics for
call_usermodehelper() preserved?

You cannot access semaphore.count here.  That's x86-specific.

Why is the code now doing

	if (stored_info.wait > 0) {
and
	if (stored_info.wait >= 0) {

?  `wait' is a boolean.  Or did its semantics get secretly changed somewhere?

Why is a new kernel thread needed to up and down a semaphore?

Sorry, but I've completely lost the plot on what you're trying to do here!




I'd have though that something like the below (untested, slightly hacky)
patch would suit.

diff -puN kernel/kmod.c~call_usermodehelper-ratelimiting kernel/kmod.c
--- 25/kernel/kmod.c~call_usermodehelper-ratelimiting	2004-07-27 01:10:02.621133160 -0700
+++ 25-akpm/kernel/kmod.c	2004-07-27 01:31:46.053981248 -0700
@@ -42,6 +42,12 @@ extern int max_threads;
 
 static struct workqueue_struct *khelper_wq;
 
+/*
+ * thread_count_sem is used to limit the number of concurrently-executing
+ * usermode helpers.
+ */
+static struct semaphore thread_count_sem;
+
 #ifdef CONFIG_KMOD
 
 /*
@@ -167,6 +173,8 @@ static int ____call_usermodehelper(void 
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
 	retval = -EPERM;
+
+	current->flags |= PF_USERMODEHELPER;
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
 
@@ -175,6 +183,11 @@ static int ____call_usermodehelper(void 
 	do_exit(0);
 }
 
+void usermodehelper_exit(void)
+{
+	up(&thread_count_sem);
+}
+
 /* Keventd can't block, but this (a child) can. */
 static int wait_for_helper(void *data)
 {
@@ -193,6 +206,7 @@ static int wait_for_helper(void *data)
 	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
 	if (pid < 0) {
 		sub_info->retval = pid;
+		up(&thread_count_sem);
 	} else {
 		/*
 		 * Normally it is bogus to call wait4() from in-kernel because
@@ -228,6 +242,7 @@ static void __call_usermodehelper(void *
 
 	if (pid < 0) {
 		sub_info->retval = pid;
+		up(&thread_count_sem);
 		complete(sub_info->complete);
 	} else if (!sub_info->wait)
 		complete(sub_info->complete);
@@ -266,6 +281,7 @@ int call_usermodehelper(char *path, char
 	if (path[0] == '\0')
 		return 0;
 
+	down(&thread_count_sem);
 	queue_work(khelper_wq, &work);
 	wait_for_completion(&done);
 	return sub_info.retval;
@@ -274,6 +290,7 @@ EXPORT_SYMBOL(call_usermodehelper);
 
 void __init usermodehelper_init(void)
 {
+	sema_init(&thread_count_sem, 50);
 	khelper_wq = create_singlethread_workqueue("khelper");
 	BUG_ON(!khelper_wq);
 }
diff -puN include/linux/sched.h~call_usermodehelper-ratelimiting include/linux/sched.h
--- 25/include/linux/sched.h~call_usermodehelper-ratelimiting	2004-07-27 01:27:39.903401824 -0700
+++ 25-akpm/include/linux/sched.h	2004-07-27 01:28:06.429369264 -0700
@@ -578,6 +578,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_USERMODEHELPER 0x00400000	/* kmod helper */
 
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
diff -puN include/linux/kmod.h~call_usermodehelper-ratelimiting include/linux/kmod.h
--- 25/include/linux/kmod.h~call_usermodehelper-ratelimiting	2004-07-27 01:30:37.793358440 -0700
+++ 25-akpm/include/linux/kmod.h	2004-07-27 01:30:51.249312824 -0700
@@ -36,6 +36,8 @@ static inline int request_module(const c
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
+void usermodehelper_exit(void);
+
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path [];
 #endif
diff -puN kernel/exit.c~call_usermodehelper-ratelimiting kernel/exit.c
--- 25/kernel/exit.c~call_usermodehelper-ratelimiting	2004-07-27 01:31:23.449417664 -0700
+++ 25-akpm/kernel/exit.c	2004-07-27 01:32:40.447712144 -0700
@@ -13,6 +13,7 @@
 #include <linux/completion.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
+#include <linux/kmod.h>
 #include <linux/namespace.h>
 #include <linux/security.h>
 #include <linux/acct.h>
@@ -840,6 +841,9 @@ asmlinkage NORET_TYPE void do_exit(long 
 
 	tsk->exit_code = code;
 	exit_notify(tsk);
+	if (unlikely(tsk->flags & PF_USERMODEHELPER))
+		usermodehelper_exit();
+
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
_

