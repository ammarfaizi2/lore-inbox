Return-Path: <linux-kernel-owner+w=401wt.eu-S1423070AbWLUUQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423070AbWLUUQx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423071AbWLUUQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:16:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34625 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423070AbWLUUQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:16:51 -0500
Date: Thu, 21 Dec 2006 21:13:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: 2.6.19-rt14 e1000 shutdown problem
Message-ID: <20061221201351.GA11625@elte.hu>
References: <1166547279.28359.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166547279.28359.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Ingo,
> 
> While trying out the 2.6.19.1-rt14 kernel with a x86_64 system with 
> Clovertown processor, it hung when it was shutting down e1000 ethernet 
> interface running the command:
> 
> /sbin/ip link set dev eth0 down

does the patch below solve it for you?

	Ingo

Index: linux/fs/file_table.c
===================================================================
--- linux.orig/fs/file_table.c
+++ linux/fs/file_table.c
@@ -333,6 +333,22 @@ static void __filevec_add(struct filevec
 	filevec_reinit(fvec);
 }
 
+/*
+ * Flush files per-CPU workqueue:
+ */
+static struct workqueue_struct *flush_files_workqueue;
+
+int __init flush_files_init(void)
+{
+        flush_files_workqueue = create_workqueue("flush_filesd");
+        if (!flush_files_workqueue)
+                panic("Failed to create flush_filesd\n");
+
+	return 0;
+}
+
+__initcall(flush_files_init);
+
 static void filevec_add_drain(void)
 {
 	int cpu;
@@ -349,7 +365,8 @@ static void filevec_add_drain_per_cpu(st
 
 int filevec_add_drain_all(void)
 {
-	return schedule_on_each_cpu(filevec_add_drain_per_cpu);
+	return schedule_on_each_cpu_wq(flush_files_workqueue,
+				       filevec_add_drain_per_cpu);
 }
 EXPORT_SYMBOL_GPL(filevec_add_drain_all);
 
Index: linux/include/linux/workqueue.h
===================================================================
--- linux.orig/include/linux/workqueue.h
+++ linux/include/linux/workqueue.h
@@ -181,6 +181,7 @@ extern int FASTCALL(schedule_delayed_wor
 
 extern int schedule_delayed_work_on(int cpu, struct delayed_work *work, unsigned long delay);
 extern int schedule_on_each_cpu(work_func_t func);
+extern int schedule_on_each_cpu_wq(struct workqueue_struct *wq, work_func_t func);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
Index: linux/kernel/workqueue.c
===================================================================
--- linux.orig/kernel/workqueue.c
+++ linux/kernel/workqueue.c
@@ -700,6 +700,44 @@ int schedule_on_each_cpu(work_func_t fun
 	return 0;
 }
 
+/**
+ * schedule_on_each_cpu_wq - call a function on each online CPU on a per-CPU wq
+ * @func: the function to call
+ *
+ * Returns zero on success.
+ * Returns -ve errno on failure.
+ *
+ * Appears to be racy against CPU hotplug.
+ *
+ * schedule_on_each_cpu() is very slow.
+ */
+int schedule_on_each_cpu_wq(struct workqueue_struct *wq, work_func_t func)
+{
+	int cpu;
+	struct work_struct *works;
+
+	if (is_single_threaded(wq)) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+	works = alloc_percpu(struct work_struct);
+	if (!works)
+		return -ENOMEM;
+
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, func);
+		set_bit(WORK_STRUCT_PENDING, work_data_bits(work));
+		__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+	}
+	flush_workqueue(wq);
+	free_percpu(works);
+
+	return 0;
+}
+
+
 void flush_scheduled_work(void)
 {
 	flush_workqueue(keventd_wq);
