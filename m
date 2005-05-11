Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVEKP6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVEKP6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEKP6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:58:14 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:38681 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261980AbVEKP5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:57:24 -0400
Message-ID: <42822B5F.8040901@sw.ru>
Date: Wed, 11 May 2005 19:57:19 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus
 via NMI IPI
Content-Type: multipart/mixed;
 boundary="------------000901000101090109080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901000101090109080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

against 2.6.12-rc4

This patch adds dumping of calltraces on _all_ CPUs
on AltSysRq-P and NMI LOCKUP. It does this via sending
NMI IPI interrupts to the cpus.

I saw the same patch in RedHat kernels, here goes our own version of the 
patch, not sure it will be accepted, but I think it can be used by some 
people at least for debugging lockups etc.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Pavel Emelianov <xemul@sw.ru>

Kirill

--------------000901000101090109080902
Content-Type: text/plain;
 name="diff-mainstream-ipi-calltraces-20050412"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-ipi-calltraces-20050412"

--- ./arch/i386/kernel/nmi.c.ipicalltraces	2005-05-10 16:09:58.000000000 +0400
+++ ./arch/i386/kernel/nmi.c	2005-05-10 18:20:00.000000000 +0400
@@ -476,6 +476,21 @@ void touch_nmi_watchdog (void)
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
+static spinlock_t show_regs_lock = SPIN_LOCK_UNLOCKED;
+
+void smp_show_regs(struct pt_regs *regs, void *info)
+{
+	if (regs == NULL)
+		return;
+
+	bust_spinlocks(1);
+	spin_lock(&show_regs_lock);
+	printk("----------- IPI show regs -----------");
+	show_regs(regs);
+	spin_unlock(&show_regs_lock);
+	bust_spinlocks(0);
+}
+
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
 
--- ./arch/i386/kernel/smp.c.ipicalltraces	2005-05-10 16:09:58.000000000 +0400
+++ ./arch/i386/kernel/smp.c	2005-05-10 18:28:08.000000000 +0400
@@ -20,6 +20,7 @@
 #include <linux/cache.h>
 #include <linux/interrupt.h>
 
+#include <asm/nmi.h>
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
 #include <mach_apic.h>
@@ -548,6 +549,89 @@ int smp_call_function (void (*func) (voi
 	return 0;
 }
 
+static spinlock_t nmi_call_lock = SPIN_LOCK_UNLOCKED;
+static struct nmi_call_data_struct {
+	smp_nmi_function func;
+	void *info;
+	atomic_t started;
+	atomic_t finished;
+	cpumask_t cpus_called;
+	int wait;
+} *nmi_call_data;
+
+static int smp_nmi_callback(struct pt_regs * regs, int cpu)
+{
+	smp_nmi_function func;
+	void *info;
+	int wait;
+
+	func = nmi_call_data->func;
+	info = nmi_call_data->info;
+	wait = nmi_call_data->wait;
+	ack_APIC_irq();
+	/* prevent from calling func() multiple times */
+	if (cpu_test_and_set(cpu, nmi_call_data->cpus_called))
+		return 0;
+	/*
+	 * notify initiating CPU that I've grabbed the data and am
+	 * about to execute the function
+	 */
+	mb();
+	atomic_inc(&nmi_call_data->started);
+	/* at this point the nmi_call_data structure is out of scope */
+	irq_enter();
+	func(regs, info);
+	irq_exit();
+	if (wait)
+		atomic_inc(&nmi_call_data->finished);
+
+	return 0;
+}
+
+/* 
+ * This function tries to call func(regs, info) on each cpu.
+ * Func must be fast and non-blocking.
+ * May be called with disabled interrupts and from any context.
+ */
+int smp_nmi_call_function(smp_nmi_function func, void *info, int wait)
+{
+	struct nmi_call_data_struct data;
+	int cpus;
+
+	cpus = num_online_cpus() - 1;
+	if (!cpus)
+		return 0;
+
+	data.func = func;
+	data.info = info;
+	data.wait = wait;
+	atomic_set(&data.started, 0);
+	atomic_set(&data.finished, 0);
+	cpus_clear(data.cpus_called);
+	/* prevent this cpu from calling func if NMI happens */
+	cpu_set(smp_processor_id(), data.cpus_called);
+
+	if (!spin_trylock(&nmi_call_lock))
+		return -1;
+
+	nmi_call_data = &data;
+	set_nmi_ipi_callback(smp_nmi_callback);
+	mb();
+
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_allbutself(APIC_DM_NMI);
+	while (atomic_read(&data.started) != cpus)
+		barrier();
+
+	unset_nmi_ipi_callback();
+	if (wait)
+		while (atomic_read(&data.finished) != cpus)
+			barrier();
+	spin_unlock(&nmi_call_lock);
+
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
--- ./arch/i386/kernel/traps.c.ipicalltraces	2005-05-10 16:09:58.000000000 +0400
+++ ./arch/i386/kernel/traps.c	2005-05-10 18:27:04.000000000 +0400
@@ -565,6 +565,8 @@ void die_nmi (struct pt_regs *regs, cons
 	printk(" on CPU%d, eip %08lx, registers:\n",
 		smp_processor_id(), regs->eip);
 	show_registers(regs);
+	smp_nmi_call_function(smp_show_regs, NULL, 1);
+	bust_spinlocks(1);
 	printk("console shuts up ...\n");
 	console_silent();
 	spin_unlock(&nmi_print_lock);
@@ -616,6 +618,7 @@ static int dummy_nmi_callback(struct pt_
 }
  
 static nmi_callback_t nmi_callback = dummy_nmi_callback;
+static nmi_callback_t nmi_ipi_callback = dummy_nmi_callback;
  
 fastcall void do_nmi(struct pt_regs * regs, long error_code)
 {
@@ -629,9 +632,20 @@ fastcall void do_nmi(struct pt_regs * re
 	if (!nmi_callback(regs, cpu))
 		default_do_nmi(regs);
 
+	nmi_ipi_callback(regs, cpu);
 	nmi_exit();
 }
 
+void set_nmi_ipi_callback(nmi_callback_t callback)
+{
+	nmi_ipi_callback = callback;
+}
+
+void unset_nmi_ipi_callback(void)
+{
+	nmi_ipi_callback = dummy_nmi_callback;
+}
+
 void set_nmi_callback(nmi_callback_t callback)
 {
 	nmi_callback = callback;
--- ./drivers/char/sysrq.c.ipicalltraces	2005-05-10 16:10:05.000000000 +0400
+++ ./drivers/char/sysrq.c	2005-05-10 18:20:00.000000000 +0400
@@ -143,8 +143,13 @@ static struct sysrq_key_op sysrq_mountro
 static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 
 {
+	bust_spinlocks(1);
 	if (pt_regs)
 		show_regs(pt_regs);
+	bust_spinlocks(0);
+#ifdef __i386__
+	smp_nmi_call_function(smp_show_regs, NULL, 0);
+#endif
 }
 static struct sysrq_key_op sysrq_showregs_op = {
 	.handler	= sysrq_handle_showregs,
--- ./include/asm-i386/nmi.h.ipicalltraces	2005-03-02 10:37:54.000000000 +0300
+++ ./include/asm-i386/nmi.h	2005-05-10 18:20:00.000000000 +0400
@@ -17,6 +17,7 @@ typedef int (*nmi_callback_t)(struct pt_
  * set. Return 1 if the NMI was handled.
  */
 void set_nmi_callback(nmi_callback_t callback);
+void set_nmi_ipi_callback(nmi_callback_t callback);
  
 /** 
  * unset_nmi_callback
@@ -24,5 +25,6 @@ void set_nmi_callback(nmi_callback_t cal
  * Remove the handler previously set.
  */
 void unset_nmi_callback(void);
+void unset_nmi_ipi_callback(void);
  
 #endif /* ASM_NMI_H */
--- ./include/linux/sched.h.ipicalltraces	2005-05-10 16:10:39.000000000 +0400
+++ ./include/linux/sched.h	2005-05-10 18:20:00.000000000 +0400
@@ -160,6 +160,7 @@ extern cpumask_t nohz_cpu_mask;
 
 extern void show_state(void);
 extern void show_regs(struct pt_regs *);
+extern void smp_show_regs(struct pt_regs *, void *);
 
 /*
  * TASK is a pointer to the task whose backtrace we want to see (or NULL for current
--- ./include/linux/smp.h.ipicalltraces	2005-05-10 16:10:39.000000000 +0400
+++ ./include/linux/smp.h	2005-05-10 18:20:00.000000000 +0400
@@ -56,6 +56,9 @@ extern void smp_cpus_done(unsigned int m
 extern int smp_call_function (void (*func) (void *info), void *info,
 			      int retry, int wait);
 
+typedef void (*smp_nmi_function)(struct pt_regs *regs, void *info);
+extern int smp_nmi_call_function(smp_nmi_function func, void *info, int wait);
+
 /*
  * Call a function on all processors
  */
@@ -98,6 +101,7 @@ void smp_prepare_boot_cpu(void);
 #endif
 #define hard_smp_processor_id()			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_nmi_call_function(func, info, wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1

--------------000901000101090109080902--

