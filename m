Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSHYNQ6>; Sun, 25 Aug 2002 09:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHYNQ6>; Sun, 25 Aug 2002 09:16:58 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:47623 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317354AbSHYNQ4>;
	Sun, 25 Aug 2002 09:16:56 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208251321.g7PDL9v09118@oboe.it.uc3m.es>
Subject: [PATCH]  apm cannot be compiled as a module in 2.5.31
To: linux-kernel@vger.kernel.org
Date: Sun, 25 Aug 2002 15:21:09 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

apm complains about cpu_gdt_table and xtime_lock when compiled as a
module for SMP. Yes, it makes sense. I run the same kernel everywhere,
even on machines with one cpu.


--- kernel/ksyms.c.orig	Sun Aug 25 15:15:02 2002
+++ kernel/ksyms.c	Thu Aug 22 19:11:07 2002
@@ -428,6 +428,10 @@
 EXPORT_SYMBOL(__br_write_unlock);
 #endif
 
+#ifdef CONFIG_X86
+EXPORT_SYMBOL(cpu_gdt_table);
+#endif
+
 /* Kiobufs */
 EXPORT_SYMBOL(alloc_kiovec);
 EXPORT_SYMBOL(free_kiovec);


Hurrr .. the xtime_lock is harder. Have to EXPORT from the file where
it is defined. Locks only make sense in SMP so only export if compiled
for SMP.


--- kernel/timer.c.orig	Sun Aug 25 15:17:09 2002
+++ kernel/timer.c	Thu Aug 22 19:13:15 2002
@@ -635,6 +635,9 @@
  * playing with xtime and avenrun.
  */
 rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(xtime_lock);
+#endif
 
 unsigned long last_time_offset;
 

And we need to fix the kernel/Makefile too?


--- kernel/Makefile.orig	Sun Aug 25 15:19:22 2002
+++ kernel/Makefile	Thu Aug 22 19:11:59 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o timer.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
