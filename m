Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWEHFqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWEHFqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWEHFqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:46:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932319AbWEHFqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:46:53 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948422:sNHT84003682"
Subject: [PATCH 1/10] make stop_machine_run accept cpumask
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:40 +0800
Message-Id: <1147067141.2760.78.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make __stop_machine_run accepts 'cpumask_t' parameter and 
multiple cpus be able to run specified task.

Signed-off-by: Ashok Raj <ashok.raj@intel.com> 
Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---

 linux-2.6.17-rc3-root/include/linux/stop_machine.h |    4 -
 linux-2.6.17-rc3-root/kernel/cpu.c                 |    2 
 linux-2.6.17-rc3-root/kernel/stop_machine.c        |   68 ++++++++++++++-------
 3 files changed, 50 insertions(+), 24 deletions(-)

diff -puN include/linux/stop_machine.h~stopmachine-run-accept-cpumask include/linux/stop_machine.h
--- linux-2.6.17-rc3/include/linux/stop_machine.h~stopmachine-run-accept-cpumask	2006-05-07 07:44:34.000000000 +0800
+++ linux-2.6.17-rc3-root/include/linux/stop_machine.h	2006-05-07 07:44:34.000000000 +0800
@@ -28,14 +28,14 @@ int stop_machine_run(int (*fn)(void *), 
  * __stop_machine_run: freeze the machine on all CPUs and run this function
  * @fn: the function to run
  * @data: the data ptr for the @fn
- * @cpu: the cpu to run @fn on (or any, if @cpu == NR_CPUS.
+ * @cpus: the cpus to run @fn on.
  *
  * Description: This is a special version of the above, which returns the
  * thread which has run @fn(): kthread_stop will return the return value
  * of @fn().  Used by hotplug cpu.
  */
 struct task_struct *__stop_machine_run(int (*fn)(void *), void *data,
-				       unsigned int cpu);
+				       cpumask_t cpus);
 
 #else
 
diff -puN kernel/cpu.c~stopmachine-run-accept-cpumask kernel/cpu.c
--- linux-2.6.17-rc3/kernel/cpu.c~stopmachine-run-accept-cpumask	2006-05-07 07:44:34.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/cpu.c	2006-05-07 07:44:34.000000000 +0800
@@ -148,7 +148,7 @@ int cpu_down(unsigned int cpu)
 	cpu_clear(cpu, tmp);
 	set_cpus_allowed(current, tmp);
 
-	p = __stop_machine_run(take_cpu_down, NULL, cpu);
+	p = __stop_machine_run(take_cpu_down, NULL, cpumask_of_cpu(cpu));
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
diff -puN kernel/stop_machine.c~stopmachine-run-accept-cpumask kernel/stop_machine.c
--- linux-2.6.17-rc3/kernel/stop_machine.c~stopmachine-run-accept-cpumask	2006-05-07 07:44:34.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/stop_machine.c	2006-05-07 07:44:34.000000000 +0800
@@ -17,18 +17,31 @@ enum stopmachine_state {
 	STOPMACHINE_WAIT,
 	STOPMACHINE_PREPARE,
 	STOPMACHINE_DISABLE_IRQ,
+	STOPMACHINE_PREPARE_TASK,
+	STOPMACHINE_FINISH_TASK,
 	STOPMACHINE_EXIT,
 };
 
+struct stop_machine_data
+{
+	cpumask_t task_cpus;
+	int (*fn)(void *);
+	void *data;
+	struct completion done;
+};
+
 static enum stopmachine_state stopmachine_state;
 static unsigned int stopmachine_num_threads;
 static atomic_t stopmachine_thread_ack;
 static DECLARE_MUTEX(stopmachine_mutex);
+static struct stop_machine_data *smdata;
 
 static int stopmachine(void *cpu)
 {
 	int irqs_disabled = 0;
 	int prepared = 0;
+	int task_prepared = 0;
+	int task_finished = 0;
 
 	set_cpus_allowed(current, cpumask_of_cpu((int)(long)cpu));
 
@@ -52,7 +65,22 @@ static int stopmachine(void *cpu)
 			prepared = 1;
 			smp_mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
+		} else if (stopmachine_state == STOPMACHINE_PREPARE_TASK
+			   && !task_prepared) {
+			task_prepared = 1;
+			smp_mb(); /* Must read state first. */
+			atomic_inc(&stopmachine_thread_ack);
+			/* do the task */
+			if (cpu_isset((int)(long)cpu, smdata->task_cpus))
+				smdata->fn(smdata->data);
+		} else if (stopmachine_state == STOPMACHINE_FINISH_TASK
+			   && !task_finished) {
+			task_finished = 1;
+			smp_mb(); /* Must read state first. */
+			atomic_inc(&stopmachine_thread_ack);
 		}
+
+
 		/* Yield in first stage: migration threads need to
 		 * help our sisters onto their CPUs. */
 		if (!prepared && !irqs_disabled)
@@ -133,21 +161,18 @@ static void restart_machine(void)
 	preempt_enable_no_resched();
 }
 
-struct stop_machine_data
-{
-	int (*fn)(void *);
-	void *data;
-	struct completion done;
-};
 
 static int do_stop(void *_smdata)
 {
-	struct stop_machine_data *smdata = _smdata;
 	int ret;
 
 	ret = stop_machine();
 	if (ret == 0) {
+		stopmachine_set_state(STOPMACHINE_PREPARE_TASK);
+		/* only record first cpu's return value */
 		ret = smdata->fn(smdata->data);
+		/* wait peers finish task */
+		stopmachine_set_state(STOPMACHINE_FINISH_TASK);
 		restart_machine();
 	}
 
@@ -165,27 +190,25 @@ static int do_stop(void *_smdata)
 }
 
 struct task_struct *__stop_machine_run(int (*fn)(void *), void *data,
-				       unsigned int cpu)
+				       cpumask_t cpus)
 {
-	struct stop_machine_data smdata;
+	struct stop_machine_data tmp;
 	struct task_struct *p;
 
-	smdata.fn = fn;
-	smdata.data = data;
-	init_completion(&smdata.done);
+	tmp.fn = fn;
+	tmp.data = data;
+	tmp.task_cpus = cpus;
+	init_completion(&tmp.done);
 
 	down(&stopmachine_mutex);
-
-	/* If they don't care which CPU fn runs on, bind to any online one. */
-	if (cpu == NR_CPUS)
-		cpu = raw_smp_processor_id();
-
-	p = kthread_create(do_stop, &smdata, "kstopmachine");
+	smdata = &tmp;
+	p = kthread_create(do_stop, NULL, "kstopmachine");
 	if (!IS_ERR(p)) {
-		kthread_bind(p, cpu);
+		kthread_bind(p, first_cpu(cpus));
 		wake_up_process(p);
-		wait_for_completion(&smdata.done);
+		wait_for_completion(&smdata->done);
 	}
+	smdata = NULL;
 	up(&stopmachine_mutex);
 	return p;
 }
@@ -197,7 +220,10 @@ int stop_machine_run(int (*fn)(void *), 
 
 	/* No CPUs can come up or down during this. */
 	lock_cpu_hotplug();
-	p = __stop_machine_run(fn, data, cpu);
+	/* If they don't care which CPU fn runs on, bind to any online one. */
+	if (cpu == NR_CPUS)
+		cpu = raw_smp_processor_id();
+	p = __stop_machine_run(fn, data, cpumask_of_cpu(cpu));
 	if (!IS_ERR(p))
 		ret = kthread_stop(p);
 	else
_
