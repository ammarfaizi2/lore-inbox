Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263286AbUJ2Lx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbUJ2Lx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUJ2Lx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:53:28 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:15747 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S263297AbUJ2Lv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:51:58 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SysRq-n changes RT tasks to normal
References: <yw1xy8hpix4z.fsf@inprovide.com> <20041029113405.GA32204@elte.hu>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 29 Oct 2004 13:51:34 +0200
In-Reply-To: <20041029113405.GA32204@elte.hu> (Ingo Molnar's message of
 "Fri, 29 Oct 2004 13:34:05 +0200")
Message-ID: <yw1xpt31ivy1.fsf@inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Måns Rullgård <mru@inprovide.com> wrote:
>
>> +	for_each_process (p) {
>> +		if (!rt_task(p))
>> +			continue;
>> +
>> +		read_lock_irq(&tasklist_lock);
>> +		rq = task_rq_lock(p, &flags);
>
> you must take the tasklist_lock outside the for_each_process().

The danger of cut and paste programming.  New diff below.

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
@@ -4590,3 +4590,35 @@
 }
 EXPORT_SYMBOL(__might_sleep);
 #endif
+
+#ifdef CONFIG_MAGIC_SYSRQ
+void normalize_rt_tasks(void)
+{
+       struct task_struct *p;
+       prio_array_t *array;
+       unsigned long flags;
+       runqueue_t *rq;
+
+       read_lock_irq(&tasklist_lock);
+       for_each_process (p) {
+               if (!rt_task(p))
+                       continue;
+
+               rq = task_rq_lock(p, &flags);
+
+               array = p->array;
+               if (array)
+                       deactivate_task(p, task_rq(p));
+               __setscheduler(p, SCHED_NORMAL, 0);
+               if (array) {
+                       __activate_task(p, task_rq(p));
+                       resched_task(rq->curr);
+               }
+
+               task_rq_unlock(rq, &flags);
+       }
+       read_unlock_irq(&tasklist_lock);
+}
+
+EXPORT_SYMBOL(normalize_rt_tasks);
+#endif /* CONFIG_MAGIC_SYSRQ */


-- 
Måns Rullgård
mru@inprovide.com
