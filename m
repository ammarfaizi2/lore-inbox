Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263256AbUJ2L0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbUJ2L0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbUJ2L0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:26:43 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:38810 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S263256AbUJ2L0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:26:09 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SysRq-n changes RT tasks to normal
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 29 Oct 2004 13:25:48 +0200
Message-ID: <yw1xy8hpix4z.fsf@inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes SysRq-n change all RT tasks into normal tasks.  Useful for
regaining control if an RT task is behaving badly.

Signed-off-by: Måns Rullgård <mru@inprovide.com>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/09 12:44:26+02:00 mru@ford.(none) 
#   sysrq-n changes all RT tasks into normally scheduled tasks
#   this is useful in case an RT task is misbehaving
# 
# kernel/sched.c
#   2004/10/09 12:44:13+02:00 mru@ford.(none) +32 -0
#   normalize_rt_tasks() converts all RT tasks into normal tasks
# 
# include/linux/sched.h
#   2004/10/09 12:44:13+02:00 mru@ford.(none) +6 -0
#   prototype for normalize_rt_tasks()
# 
# drivers/char/sysrq.c
#   2004/10/09 12:44:13+02:00 mru@ford.(none) +11 -1
#   sysrq-n calls normalize_rt_tasks()
# 
diff -Nru a/drivers/char/sysrq.c b/drivers/char/sysrq.c
--- a/drivers/char/sysrq.c	2004-10-29 13:19:05 +02:00
+++ b/drivers/char/sysrq.c	2004-10-29 13:19:05 +02:00
@@ -216,6 +216,16 @@
 
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
 
+static void sysrq_handle_unrt(int key, struct pt_regs *pt_regs,
+			      struct tty_struct *tty)
+{
+	normalize_rt_tasks();
+}
+static struct sysrq_key_op sysrq_unrt_op = {
+	.handler	= sysrq_handle_unrt,
+	.help_msg	= "Nice",
+	.action_msg	= "Nice All RT Tasks"
+};
 
 /* Key Operations table and lock */
 static spinlock_t sysrq_key_table_lock = SPIN_LOCK_UNLOCKED;
@@ -250,7 +260,7 @@
 #endif
 /* l */	NULL,
 /* m */	&sysrq_showmem_op,
-/* n */	NULL,
+/* n */	&sysrq_unrt_op,
 /* o */	NULL, /* This will often be registered
 		 as 'Off' at init time */
 /* p */	&sysrq_showregs_op,
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-10-29 13:19:05 +02:00
+++ b/include/linux/sched.h	2004-10-29 13:19:05 +02:00
@@ -1027,6 +1027,12 @@
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
 
+#ifdef CONFIG_MAGIC_SYSRQ
+
+extern void normalize_rt_tasks(void);
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-10-29 13:19:05 +02:00
+++ b/kernel/sched.c	2004-10-29 13:19:05 +02:00
@@ -4767,3 +4767,35 @@
 }
 EXPORT_SYMBOL(__might_sleep);
 #endif
+
+#ifdef CONFIG_MAGIC_SYSRQ
+void normalize_rt_tasks(void)
+{
+	struct task_struct *p;
+	prio_array_t *array;
+	unsigned long flags;
+	runqueue_t *rq;
+
+	for_each_process (p) {
+		if (!rt_task(p))
+			continue;
+
+		read_lock_irq(&tasklist_lock);
+		rq = task_rq_lock(p, &flags);
+
+		array = p->array;
+		if (array)
+			deactivate_task(p, task_rq(p));
+		__setscheduler(p, SCHED_NORMAL, 0);
+		if (array) {
+			__activate_task(p, task_rq(p));
+			resched_task(rq->curr);
+		}
+
+		task_rq_unlock(rq, &flags);
+		read_unlock_irq(&tasklist_lock);
+	}
+}
+
+EXPORT_SYMBOL(normalize_rt_tasks);
+#endif /* CONFIG_MAGIC_SYSRQ */


-- 
Måns Rullgård
mru@inprovide.com
