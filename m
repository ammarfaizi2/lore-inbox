Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTBIL6L>; Sun, 9 Feb 2003 06:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTBIL6K>; Sun, 9 Feb 2003 06:58:10 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:848
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267236AbTBIL5j>; Sun, 9 Feb 2003 06:57:39 -0500
Date: Sun, 9 Feb 2003 07:06:25 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][6/15] smp_call_function/_on_cpu - mips64
Message-ID: <Pine.LNX.4.50.0302090604380.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 65 insertions(+), 9 deletions(-)

Index: linux-2.5.59-bk/arch/mips64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/mips64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/mips64/kernel/smp.c	9 Feb 2003 09:08:29 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/mips64/kernel/smp.c	9 Feb 2003 11:45:12 -0000
@@ -92,7 +92,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 	smp_num_cpus = 1;
 }
 
@@ -116,7 +116,6 @@
  * Run a function on all other CPUs.
  *  <func>      The function to run. This must be fast and non-blocking.
  *  <info>      An arbitrary pointer to pass to the function.
- *  <retry>     If true, keep retrying until ready.
  *  <wait>      If true, wait until function has completed on other CPUs.
  *  [RETURNS]   0 on success, else a negative status code.
  *
@@ -131,15 +130,14 @@
 	int wait;
 } *call_data;
 
-int smp_call_function (void (*func) (void *info), void *info, int retry, 
-								int wait)
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int i, cpus = smp_num_cpus-1;
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 
 	if (cpus == 0)
-		return 0;
+		return -EINVAL;
 
 	data.func = func;
 	data.info = info;
@@ -167,6 +165,64 @@
 	return 0;
 }
 
+/*
+ * smp_call_function_on_cpu - Runs func on all processors in the mask
+ *
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ * @mask The bitmask of CPUs to call the function
+ * 
+ * Returns 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute func or have executed it.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+
+int smp_call_function_on_cpu (void (*func) (void *info), void *info,
+				int wait, unsigned long mask)
+{
+	struct call_data_struct data;
+	int i, cpu, num_cpus = hweight32(mask);
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+
+	cpu = get_cpu();
+	if ((num_cpus == 0) || ((1UL << cpu) & mask)) {
+		put_cpu_no_resched();
+		return -EINVAL;
+	}
+
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	spin_lock_bh(&lock);
+	call_data = &data;
+	/* Send a message to all other CPUs and wait for them to respond */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+
+		if ((1UL << i) & mask)
+			sendintr(i, DOCALL);
+	}
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&data.finished) != num_cpus)
+			barrier();
+	spin_unlock_bh(&lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
 extern void smp_call_function_interrupt(int irq, void *d, struct pt_regs *r)
 {
 	void (*func) (void *info) = call_data->func;
@@ -195,7 +251,7 @@
 
 void flush_tlb_all(void)
 {
-	smp_call_function(flush_tlb_all_ipi, 0, 1, 1);
+	smp_call_function(flush_tlb_all_ipi, NULL, 1);
 	_flush_tlb_all();
 }
 
@@ -220,7 +276,7 @@
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
-		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1, 1);
+		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1);
 	} else {
 		int i;
 		for (i = 0; i < smp_num_cpus; i++)
@@ -252,7 +308,7 @@
 		fd.vma = vma;
 		fd.addr1 = start;
 		fd.addr2 = end;
-		smp_call_function(flush_tlb_range_ipi, (void *)&fd, 1, 1);
+		smp_call_function(flush_tlb_range_ipi, (void *)&fd, 1);
 	} else {
 		int i;
 		for (i = 0; i < smp_num_cpus; i++)
@@ -276,7 +332,7 @@
 
 		fd.vma = vma;
 		fd.addr1 = page;
-		smp_call_function(flush_tlb_page_ipi, (void *)&fd, 1, 1);
+		smp_call_function(flush_tlb_page_ipi, (void *)&fd, 1);
 	} else {
 		int i;
 		for (i = 0; i < smp_num_cpus; i++)
