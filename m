Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265091AbSJOWmP>; Tue, 15 Oct 2002 18:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265060AbSJOW21>; Tue, 15 Oct 2002 18:28:27 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:35082 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265043AbSJOW1U>; Tue, 15 Oct 2002 18:27:20 -0400
Date: Tue, 15 Oct 2002 23:33:13 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [3/7] oprofile - timer hook
Message-ID: <20021015223313.GC41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements a simple hook into the profiling timer for x86
so that non-perfctr machines can still use oprofile. This has proven
useful for laptops and the like.

It also reduces header dependencies a bit by centralising readprofile
code

diff -Naur -X dontdiff linux-linus/arch/i386/kernel/Makefile linux-linus2/arch/i386/kernel/Makefile
--- linux-linus/arch/i386/kernel/Makefile	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/kernel/Makefile	Tue Oct 15 22:32:38 2002
@@ -27,6 +27,7 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
+obj-$(CONFIG_PROFILING)		+= profile.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -Naur -X dontdiff linux-linus/arch/i386/kernel/apic.c linux-linus2/arch/i386/kernel/apic.c
--- linux-linus/arch/i386/kernel/apic.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/kernel/apic.c	Tue Oct 15 22:32:38 2002
@@ -1008,17 +1008,9 @@
 
 inline void smp_local_timer_interrupt(struct pt_regs * regs)
 {
-	int user = user_mode(regs);
 	int cpu = smp_processor_id();
 
-	/*
-	 * The profiling function is SMP safe. (nothing can mess
-	 * around with "current", and the profiling counters are
-	 * updated with atomic operations). This is especially
-	 * useful with a profiling multiplier != 1
-	 */
-	if (!user)
-		x86_do_profile(regs->eip);
+	x86_do_profile(regs);
 
 	if (--prof_counter[cpu] <= 0) {
 		/*
@@ -1036,7 +1028,7 @@
 		}
 
 #ifdef CONFIG_SMP
-		update_process_times(user);
+		update_process_times(user_mode(regs));
 #endif
 	}
 
diff -Naur -X dontdiff linux-linus/arch/i386/kernel/i386_ksyms.c linux-linus2/arch/i386/kernel/i386_ksyms.c
--- linux-linus/arch/i386/kernel/i386_ksyms.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/kernel/i386_ksyms.c	Tue Oct 15 22:32:52 2002
@@ -167,6 +167,9 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
+EXPORT_SYMBOL_GPL(register_profile_notifier);
+EXPORT_SYMBOL_GPL(unregister_profile_notifier);
+ 
 #undef memcpy
 #undef memset
 extern void * memset(void *,int,__kernel_size_t);
diff -Naur -X dontdiff linux-linus/arch/i386/kernel/profile.c linux-linus2/arch/i386/kernel/profile.c
--- linux-linus/arch/i386/kernel/profile.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/kernel/profile.c	Tue Oct 15 22:32:38 2002
@@ -0,0 +1,45 @@
+/*
+ *	linux/arch/i386/kernel/profile.c
+ *
+ *	(C) 2002 John Levon <levon@movementarian.org>
+ *
+ */
+
+#include <linux/profile.h>
+#include <linux/spinlock.h>
+#include <linux/notifier.h>
+#include <linux/irq.h>
+#include <asm/hw_irq.h> 
+ 
+static struct notifier_block * profile_listeners;
+static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
+ 
+int register_profile_notifier(struct notifier_block * nb)
+{
+	int err;
+	write_lock_irq(&profile_lock);
+	err = notifier_chain_register(&profile_listeners, nb);
+	write_unlock_irq(&profile_lock);
+	return err;
+}
+
+
+int unregister_profile_notifier(struct notifier_block * nb)
+{
+	int err;
+	write_lock_irq(&profile_lock);
+	err = notifier_chain_unregister(&profile_listeners, nb);
+	write_unlock_irq(&profile_lock);
+	return err;
+}
+
+
+void x86_profile_hook(struct pt_regs * regs)
+{
+	/* we would not even need this lock if
+	 * we had a global cli() on register/unregister
+	 */ 
+	read_lock(&profile_lock);
+	notifier_call_chain(&profile_listeners, 0, regs);
+	read_unlock(&profile_lock);
+}
diff -Naur -X dontdiff linux-linus/arch/i386/kernel/time.c linux-linus2/arch/i386/kernel/time.c
--- linux-linus/arch/i386/kernel/time.c	Tue Oct 15 21:47:18 2002
+++ linux-linus2/arch/i386/kernel/time.c	Tue Oct 15 22:32:38 2002
@@ -64,11 +64,6 @@
 
 #include "do_timer.h"
 
-/*
- * for x86_do_profile()
- */
-#include <linux/irq.h>
-
 u64 jiffies_64;
 
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
diff -Naur -X dontdiff linux-linus/arch/i386/mach-generic/do_timer.h linux-linus2/arch/i386/mach-generic/do_timer.h
--- linux-linus/arch/i386/mach-generic/do_timer.h	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/mach-generic/do_timer.h	Tue Oct 15 22:32:38 2002
@@ -20,8 +20,7 @@
  * system, in that case we have to call the local interrupt handler.
  */
 #ifndef CONFIG_X86_LOCAL_APIC
-	if (!user_mode(regs))
-		x86_do_profile(regs->eip);
+	x86_do_profile(regs);
 #else
 	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
diff -Naur -X dontdiff linux-linus/arch/i386/mach-visws/do_timer.h linux-linus2/arch/i386/mach-visws/do_timer.h
--- linux-linus/arch/i386/mach-visws/do_timer.h	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/mach-visws/do_timer.h	Tue Oct 15 22:32:38 2002
@@ -15,8 +15,7 @@
  * system, in that case we have to call the local interrupt handler.
  */
 #ifndef CONFIG_X86_LOCAL_APIC
-	if (!user_mode(regs))
-		x86_do_profile(regs->eip);
+	x86_do_profile(regs);
 #else
 	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
diff -Naur -X dontdiff linux-linus/fs/proc/proc_misc.c linux-linus2/fs/proc/proc_misc.c
--- linux-linus/fs/proc/proc_misc.c	Tue Oct 15 21:47:21 2002
+++ linux-linus2/fs/proc/proc_misc.c	Tue Oct 15 22:32:38 2002
@@ -38,6 +38,7 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/profile.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -Naur -X dontdiff linux-linus/include/asm-i386/hw_irq.h linux-linus2/include/asm-i386/hw_irq.h
--- linux-linus/include/asm-i386/hw_irq.h	Sun Oct 13 19:51:03 2002
+++ linux-linus2/include/asm-i386/hw_irq.h	Tue Oct 15 22:32:38 2002
@@ -13,6 +13,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/profile.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
 
@@ -65,20 +66,31 @@
 
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
-extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-
 /*
- * x86 profiling function, SMP safe. We might want to do this in
- * assembly totally?
+ * The profiling function is SMP safe. (nothing can mess
+ * around with "current", and the profiling counters are
+ * updated with atomic operations). This is especially
+ * useful with a profiling multiplier != 1
  */
-static inline void x86_do_profile (unsigned long eip)
+static inline void x86_do_profile(struct pt_regs * regs)
 {
+	unsigned long eip;
+	extern unsigned long prof_cpu_mask;
+	extern char _stext;
+#ifdef CONFIG_PROFILING
+	extern void x86_profile_hook(struct pt_regs *);
+ 
+	x86_profile_hook(regs);
+#endif
+ 
+	if (user_mode(regs))
+		return;
+ 
 	if (!prof_buffer)
 		return;
 
+	eip = regs->eip;
+ 
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
@@ -97,7 +109,28 @@
 		eip = prof_len-1;
 	atomic_inc((atomic_t *)&prof_buffer[eip]);
 }
+ 
+struct notifier_block;
+ 
+#ifdef CONFIG_PROFILING
+ 
+int register_profile_notifier(struct notifier_block * nb);
+int unregister_profile_notifier(struct notifier_block * nb);
+
+#else
+
+static inline int register_profile_notifier(struct notifier_block * nb)
+{
+	return -ENOSYS;
+}
+
+static inline int unregister_profile_notifier(struct notifier_block * nb)
+{
+	return -ENOSYS;
+}
 
+#endif /* CONFIG_PROFILING */
+ 
 #ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
 	if (IO_APIC_IRQ(i))
diff -Naur -X dontdiff linux-linus/include/linux/profile.h linux-linus2/include/linux/profile.h
--- linux-linus/include/linux/profile.h	Tue Oct 15 22:23:10 2002
+++ linux-linus2/include/linux/profile.h	Tue Oct 15 22:34:06 2002
@@ -8,6 +8,17 @@
 #include <linux/init.h>
 #include <asm/errno.h>
  
+/* parse command line */
+int __init profile_setup(char * str);
+ 
+/* init basic kernel profiler */
+void __init profile_init(void);
+
+extern unsigned int * prof_buffer;
+extern unsigned long prof_len;
+extern unsigned long prof_shift;
+
+
 enum profile_type {
 	EXIT_TASK,
 	EXIT_MMAP,
diff -Naur -X dontdiff linux-linus/include/linux/sched.h linux-linus2/include/linux/sched.h
--- linux-linus/include/linux/sched.h	Sun Oct 13 19:51:03 2002
+++ linux-linus2/include/linux/sched.h	Tue Oct 15 22:32:40 2002
@@ -492,10 +492,6 @@
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
diff -Naur -X dontdiff linux-linus/init/main.c linux-linus2/init/main.c
--- linux-linus/init/main.c	Tue Oct 15 21:47:22 2002
+++ linux-linus2/init/main.c	Tue Oct 15 22:32:40 2002
@@ -30,6 +30,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
+#include <linux/profile.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -52,7 +53,6 @@
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
-extern char _stext, _etext;
 extern char *linux_banner;
 
 static int init(void *);
@@ -130,13 +130,6 @@
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 
-static int __init profile_setup(char *str)
-{
-    int par;
-    if (get_option(&str,&par)) prof_shift = par;
-	return 1;
-}
-
 __setup("profile=", profile_setup);
 
 static int __init checksetup(char *line)
@@ -411,16 +404,7 @@
 #ifdef CONFIG_MODULES
 	init_modules();
 #endif
-	if (prof_shift) {
-		unsigned int size;
-		/* only text is profiled */
-		prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
-		prof_len >>= prof_shift;
-		
-		size = prof_len * sizeof(unsigned int) + PAGE_SIZE-1;
-		prof_buffer = (unsigned int *) alloc_bootmem(size);
-	}
-
+	profile_init();
 	kmem_cache_init();
 	local_irq_enable();
 	calibrate_delay();
diff -Naur -X dontdiff linux-linus/kernel/profile.c linux-linus2/kernel/profile.c
--- linux-linus/kernel/profile.c	Tue Oct 15 22:23:10 2002
+++ linux-linus2/kernel/profile.c	Tue Oct 15 22:33:38 2002
@@ -9,6 +9,36 @@
 #include <linux/notifier.h>
 #include <linux/mm.h>
 
+extern char _stext, _etext;
+
+unsigned int * prof_buffer;
+unsigned long prof_len;
+unsigned long prof_shift;
+
+int __init profile_setup(char * str)
+{
+	int par;
+	if (get_option(&str,&par))
+		prof_shift = par;
+	return 1;
+}
+
+
+void __init profile_init(void)
+{
+	unsigned int size;
+ 
+	if (!prof_shift) 
+		return;
+ 
+	/* only text is profiled */
+	prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
+	prof_len >>= prof_shift;
+		
+	size = prof_len * sizeof(unsigned int) + PAGE_SIZE - 1;
+	prof_buffer = (unsigned int *) alloc_bootmem(size);
+}
+
 /* Profile event notifications */
  
 #ifdef CONFIG_PROFILING
diff -Naur -X dontdiff linux-linus/kernel/timer.c linux-linus2/kernel/timer.c
--- linux-linus/kernel/timer.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/kernel/timer.c	Tue Oct 15 22:32:41 2002
@@ -406,10 +406,6 @@
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 
-unsigned int * prof_buffer;
-unsigned long prof_len;
-unsigned long prof_shift;
-
 /*
  * this routine handles the overflow of the microsecond field
  *
