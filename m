Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267838AbUHKAXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267838AbUHKAXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267839AbUHKAXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:23:44 -0400
Received: from mail.broadpark.no ([217.13.4.2]:15581 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267838AbUHKAXj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:23:39 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092082920.5761.266.camel@cube>
	<cone.1092092365.461905.29067.502@pc.kolivas.org>
	<1092099669.5759.283.camel@cube> <yw1xisbrflws.fsf@kth.se>
	<1092148392.5818.6.camel@mindpipe>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 11 Aug 2004 02:23:37 +0200
In-Reply-To: <1092148392.5818.6.camel@mindpipe> (Lee Revell's message of
 "Tue, 10 Aug 2004 10:33:13 -0400")
Message-ID: <yw1xllgm8quu.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Tue, 2004-08-10 at 04:16, Måns Rullgård wrote:
>> Albert Cahalan <albert@users.sf.net> writes:
>> 
>> >> Last time I gave 
>> >> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
>> >> rt_task safe.
>> >
>> > So, you've been working on the scheduler anyway...
>> > An option to reserve some portion of CPU time for
>> > emergency use (say, 5% after 1 second has passed)
>> > would let somebody get out of this situation.
>> 
>> Another option would be an Alt-Sysrq-something that lowered all RT
>> processes to normal levels.
>
> I hate to derail a good flame-fest, but this would be extremely useful,
> for more than burning CDs.  Anytime you are dealing with a SCHED_FIFO
> process a bug can lock the machine, this would be useful for hacking
> jackd for example.
>
> If someone wants to code this up I and the other people on jackit-devel
> would gladly test it.

Here you go.  Some limited testing suggests that it actually works.
Pressing Alt-Sysrq-N (as in Nice) changes all RT tasks to SCHED_NORMAL
policy.

===== drivers/char/sysrq.c 1.29 vs edited =====
--- 1.29/drivers/char/sysrq.c	2004-01-20 00:38:11 +01:00
+++ edited/drivers/char/sysrq.c	2004-08-11 01:41:38 +02:00
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
===== include/linux/sched.h 1.197 vs edited =====
--- 1.197/include/linux/sched.h	2004-04-27 07:07:44 +02:00
+++ edited/include/linux/sched.h	2004-08-11 01:45:09 +02:00
@@ -944,6 +944,12 @@
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_MAGIC_SYSRQ
+
+extern void normalize_rt_tasks(void);
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
===== kernel/sched.c 1.261 vs edited =====
--- 1.261/kernel/sched.c	2004-04-27 07:07:43 +02:00
+++ edited/kernel/sched.c	2004-08-11 01:38:00 +02:00
@@ -3053,3 +3053,35 @@
 
 EXPORT_SYMBOL(__preempt_write_lock);
 #endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
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
mru@kth.se
