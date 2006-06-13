Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWFNAB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWFNAB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWFNAB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:01:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:14781 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964809AbWFNABx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:01:53 -0400
Subject: [PATCH 06/11] Task watchers:  Register audit task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-audit@redhat.com
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:46 -0700
Message-Id: <1150242886.21787.146.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt audit to use task watchers.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-audit@redhat.com
--

 kernel/audit.c |   25 ++++++++++++++++++++++++-
 kernel/exit.c  |    3 ---
 kernel/fork.c  |    7 +------
 3 files changed, 25 insertions(+), 10 deletions(-)

Index: linux-2.6.17-rc5-mm2/kernel/exit.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/kernel/exit.c
+++ linux-2.6.17-rc5-mm2/kernel/exit.c
@@ -35,11 +35,10 @@
 #include <linux/posix-timers.h>
 #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
-#include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
 #include <linux/notifier.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -914,12 +913,10 @@ fastcall NORET_TYPE void do_exit(long co
 		exit_robust_list(tsk);
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
-	if (unlikely(tsk->audit_context))
-		audit_free(tsk);
 	tsk->exit_code = code;
 	taskstats_exit_send(tsk, tidstats, tgidstats);
 	taskstats_exit_free(tidstats, tgidstats);
 	delayacct_tsk_exit(tsk);
 	notify_result = notify_watchers(WATCH_TASK_FREE, tsk);
Index: linux-2.6.17-rc5-mm2/kernel/audit.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/kernel/audit.c
+++ linux-2.6.17-rc5-mm2/kernel/audit.c
@@ -46,10 +46,11 @@
 #include <asm/atomic.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kthread.h>
+#include <linux/notifier.h>
 
 #include <linux/audit.h>
 
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -64,10 +65,30 @@
 static int	audit_initialized;
 
 /* No syscall auditing will take place unless audit_enabled != 0. */
 int		audit_enabled;
 
+static int audit_task(struct notifier_block *nb, unsigned long val, void *t)
+{
+	struct task_struct *tsk = t;
+
+	switch(get_watch_event(val)) {
+	case WATCH_TASK_INIT:
+		/* Hack: -EFOO sets NOTIFY_STOP_MASK */
+		return audit_alloc(tsk);
+	case WATCH_TASK_FREE:
+		if (unlikely(tsk->audit_context))
+			audit_free(tsk);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block __read_mostly audit_watch_tasks_nb = {
+	.notifier_call = audit_task,
+};
+
 /* Default state when kernel boots without any parameters. */
 static int	audit_default;
 
 /* If auditing cannot proceed, audit_failure selects what happens. */
 static int	audit_failure = AUDIT_FAIL_PRINTK;
@@ -707,12 +728,14 @@ static int __init audit_enable(char *str
 {
 	audit_default = !!simple_strtol(str, NULL, 0);
 	printk(KERN_INFO "audit: %s%s\n",
 	       audit_default ? "enabled" : "disabled",
 	       audit_initialized ? "" : " (after initialization)");
-	if (audit_initialized)
+	if (audit_initialized) {
 		audit_enabled = audit_default;
+		register_task_watcher(&audit_watch_tasks_nb);
+	}
 	return 1;
 }
 
 __setup("audit=", audit_enable);
 
Index: linux-2.6.17-rc5-mm2/kernel/fork.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/kernel/fork.c
+++ linux-2.6.17-rc5-mm2/kernel/fork.c
@@ -38,11 +38,10 @@
 #include <linux/jiffies.h>
 #include <linux/futex.h>
 #include <linux/rcupdate.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
-#include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/delayacct.h>
 #include <linux/notifier.h>
@@ -1088,15 +1087,13 @@ static task_t *copy_process(unsigned lon
 	p->softirq_context = 0;
 #endif
 
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
-	if ((retval = audit_alloc(p)))
-		goto bad_fork_cleanup_security;
 	/* copy all the process information */
 	if ((retval = copy_semundo(clone_flags, p)))
-		goto bad_fork_cleanup_audit;
+		goto bad_fork_cleanup_security;
 	if ((retval = copy_files(clone_flags, p)))
 		goto bad_fork_cleanup_semundo;
 	if ((retval = copy_fs(clone_flags, p)))
 		goto bad_fork_cleanup_files;
 	if ((retval = copy_sighand(clone_flags, p)))
@@ -1270,12 +1267,10 @@ bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
-bad_fork_cleanup_audit:
-	audit_free(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
 	notify_result = notify_watchers(WATCH_TASK_FREE, p);
 	WARN_ON(notify_result & NOTIFY_STOP_MASK);
 bad_fork_cleanup_policy:

--

