Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTFDA0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTFDA0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:26:14 -0400
Received: from oss.SGI.COM ([192.48.159.27]:59847 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id S262016AbTFDA0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:26:11 -0400
Date: Tue, 3 Jun 2003 17:39:37 -0700
From: John Hawkes <hawkes@oss.sgi.com>
Message-Id: <200306040039.h540dbZX031979@oss.sgi.com>
To: linux-kernel@vger.kernel.org, akpm@digeo.com, torvalds@transmeta.com
Subject: [PATCH] [retry] 2.5.70 remove smp_send_reschedule() cruft
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for the whitespace damage of the earlier email.
This 2.5.70 patch removes the unused references to smp_send_reschedule_all().

-- 
John Hawkes


diff -Naur linux-2.5.70/arch/i386/kernel/smp.c linux-2.5.70-sendall/arch/i386/kernel/smp.c
--- linux-2.5.70/arch/i386/kernel/smp.c	Mon May 26 18:00:22 2003
+++ linux-2.5.70-sendall/arch/i386/kernel/smp.c	Tue Jun  3 16:01:36 2003
@@ -461,17 +461,6 @@
 }
 
 /*
- * this function sends a reschedule IPI to all (other) CPUs.
- * This should only be used if some 'global' task became runnable,
- * such as a RT task, that must be handled now. The first CPU
- * that manages to grab the task will run it.
- */
-void smp_send_reschedule_all(void)
-{
-	send_IPI_allbutself(RESCHEDULE_VECTOR);
-}
-
-/*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
  */
diff -Naur linux-2.5.70/arch/ia64/kernel/smp.c linux-2.5.70-sendall/arch/ia64/kernel/smp.c
--- linux-2.5.70/arch/ia64/kernel/smp.c	Mon May 26 18:01:00 2003
+++ linux-2.5.70-sendall/arch/ia64/kernel/smp.c	Tue Jun  3 15:59:20 2003
@@ -205,24 +205,6 @@
 	platform_send_ipi(cpu, IA64_IPI_RESCHEDULE, IA64_IPI_DM_INT, 0);
 }
 
-/*
- * This function sends a reschedule IPI to all (other) CPUs.  This should only be used if
- * some 'global' task became runnable, such as a RT task, that must be handled now. The
- * first CPU that manages to grab the task will run it.
- */
-void
-smp_send_reschedule_all (void)
-{
-	int i;
-	int cpu = get_cpu(); /* disable preemption */
-
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_online(i) && i != cpu)
-			smp_send_reschedule(i);
-	put_cpu();
-}
-
-
 void
 smp_flush_tlb_all (void)
 {
diff -Naur linux-2.5.70/arch/ppc64/kernel/smp.c linux-2.5.70-sendall/arch/ppc64/kernel/smp.c
--- linux-2.5.70/arch/ppc64/kernel/smp.c	Mon May 26 18:00:45 2003
+++ linux-2.5.70-sendall/arch/ppc64/kernel/smp.c	Tue Jun  3 16:02:07 2003
@@ -392,17 +392,6 @@
 	smp_message_pass(cpu, PPC_MSG_RESCHEDULE, 0, 0);
 }
 
-/*
- * this function sends a reschedule IPI to all (other) CPUs.
- * This should only be used if some 'global' task became runnable,
- * such as a RT task, that must be handled now. The first CPU
- * that manages to grab the task will run it.
- */
-void smp_send_reschedule_all(void)
-{
-	smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_RESCHEDULE, 0, 0);
-}
-
 #ifdef CONFIG_XMON
 void smp_send_xmon_break(int cpu)
 {
diff -Naur linux-2.5.70/include/asm-i386/smp.h linux-2.5.70-sendall/include/asm-i386/smp.h
--- linux-2.5.70/include/asm-i386/smp.h	Mon May 26 18:00:41 2003
+++ linux-2.5.70-sendall/include/asm-i386/smp.h	Tue Jun  3 16:01:00 2003
@@ -41,7 +41,6 @@
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
-extern void smp_send_reschedule_all(void);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
diff -Naur linux-2.5.70/include/asm-ia64/smp.h linux-2.5.70-sendall/include/asm-ia64/smp.h
--- linux-2.5.70/include/asm-ia64/smp.h	Mon May 26 18:00:40 2003
+++ linux-2.5.70-sendall/include/asm-ia64/smp.h	Tue Jun  3 16:00:15 2003
@@ -136,8 +136,6 @@
 extern int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
 				     int retry, int wait);
 extern void smp_send_reschedule (int cpu);
-extern void smp_send_reschedule_all (void);
-
 
 #endif /* CONFIG_SMP */
 #endif /* _ASM_IA64_SMP_H */
diff -Naur linux-2.5.70/include/asm-ppc64/smp.h linux-2.5.70-sendall/include/asm-ppc64/smp.h
--- linux-2.5.70/include/asm-ppc64/smp.h	Mon May 26 18:00:19 2003
+++ linux-2.5.70-sendall/include/asm-ppc64/smp.h	Tue Jun  3 16:00:07 2003
@@ -34,7 +34,6 @@
 extern void smp_send_xmon_break(int cpu);
 struct pt_regs;
 extern void smp_message_recv(int, struct pt_regs *);
-extern void smp_send_reschedule_all(void);
 
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 
diff -Naur linux-2.5.70/include/asm-x86_64/smp.h linux-2.5.70-sendall/include/asm-x86_64/smp.h
--- linux-2.5.70/include/asm-x86_64/smp.h	Mon May 26 18:00:20 2003
+++ linux-2.5.70-sendall/include/asm-x86_64/smp.h	Tue Jun  3 16:00:01 2003
@@ -42,7 +42,6 @@
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
-extern void smp_send_reschedule_all(void);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings(void);
diff -Naur linux-2.5.70/include/linux/smp.h linux-2.5.70-sendall/include/linux/smp.h
--- linux-2.5.70/include/linux/smp.h	Mon May 26 18:00:40 2003
+++ linux-2.5.70-sendall/include/linux/smp.h	Tue Jun  3 16:00:47 2003
@@ -110,7 +110,6 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
-static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
 #define cpu_online(cpu)				({ BUG_ON((cpu) != 0); 1; })
 #define num_online_cpus()			1
