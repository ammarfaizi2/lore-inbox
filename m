Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVECONI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVECONI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVECONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:13:08 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:1727 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261564AbVECOJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:09:09 -0400
Message-ID: <42778601.9060807@lifl.fr>
Date: Tue, 03 May 2005 16:09:05 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Philippe Marquet <Philippe.Marquet@lifl.fr>,
       Christophe Osuna <osuna@lifl.fr>, Julien Soula <soula@lifl.fr>,
       Jean-Luc Dekeyser <dekeyser@lifl.fr>, paul.mckenney@us.ibm.com
Subject: [2/3] ARTiS, an asymmetric real-time scheduler - x86
References: <42778532.7090806@lifl.fr>
In-Reply-To: <42778532.7090806@lifl.fr>
Content-Type: multipart/mixed;
 boundary="------------070301010005050503090507"
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301010005050503090507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here is the architecture dependant part of ARTiS for x86.

--------------070301010005050503090507
Content-Type: text/x-patch;
 name="artis-2.6.11-20050502-i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="artis-2.6.11-20050502-i386.patch"

diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/arch/i386/Kconfig 2.6.11-artis-cvs/arch/i386/Kconfig
--- 2.6.11-pfm/arch/i386/Kconfig	2005-03-02 08:37:49.000000000 +0100
+++ 2.6.11-artis-cvs/arch/i386/Kconfig	2005-04-22 18:08:19.000000000 +0200
@@ -528,6 +528,32 @@ config PREEMPT_BKL
 	  Say Y here if you are building a kernel for a desktop system.
 	  Say N if you are unsure.
 
+config ARTIS
+	bool "Compile the kernel with ARTiS support (EXPERIMENTAL)"
+	depends on PREEMPT && SMP
+	help
+		ARTiS is an "Asymmetric Real-Time Scheduling". When activated,
+		the real-time tasks will be insured of low latencies. It works
+		by automatically migrating the normal tasks out from CPUs running
+		real-time tasks when they would trigger a preemption disable or a
+		IRQ disable. Obviously, a SMP system is required (SMT works too).
+		Note that it will not be activated by default, you need to select
+		it at boot time. For more information, see Documentation/artis.txt.
+
+config ARTIS_DEBUG
+	bool "Compile the kernel with ARTiS debugging support (EXPERIMENTAL)"
+	depends on ARTIS
+	help
+		Activate debuging code in ARTiS, you probably don't want this, excepted
+		if you want to hack on ARTiS.
+
+config ARTIS_STAT
+	bool "Compile the kernel with ARTiS accounting support (EXPERIMENTAL)"
+	depends on ARTIS
+	help
+		Activate statistics about ARTiS, available in /proc. There is no (or
+		very little) performance penalty, so you can safely say "yes" here.
+
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/arch/i386/kernel/entry.S 2.6.11-artis-cvs/arch/i386/kernel/entry.S
--- 2.6.11-pfm/arch/i386/kernel/entry.S	2005-03-02 08:37:51.000000000 +0100
+++ 2.6.11-artis-cvs/arch/i386/kernel/entry.S	2005-04-26 01:21:48.000000000 +0200
@@ -361,13 +361,25 @@ common_interrupt:
 	call do_IRQ
 	jmp ret_from_intr
 
+#ifdef CONFIG_ARTIS
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
+	call function_artis_migration_disable; \
 	movl %esp,%eax;			\
 	call smp_/**/name;		\
+	call function_artis_migration_enable; \
 	jmp ret_from_intr;
+#else
+#define BUILD_INTERRUPT(name, nr)	\
+ENTRY(name)				\
+	pushl $nr-256;			\
+	SAVE_ALL			\
+	movl %esp,%eax;			\
+	call smp_/**/name;	\
+	jmp ret_from_intr;
+#endif
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/arch/i386/kernel/traps.c 2.6.11-artis-cvs/arch/i386/kernel/traps.c
--- 2.6.11-pfm/arch/i386/kernel/traps.c	2005-03-02 08:37:49.000000000 +0100
+++ 2.6.11-artis-cvs/arch/i386/kernel/traps.c	2005-03-25 19:47:46.000000000 +0100
@@ -95,6 +95,31 @@ static int kstack_depth_to_print = 24;
 struct notifier_block *i386die_chain;
 static DEFINE_SPINLOCK(die_notifier_lock);
 
+#ifdef CONFIG_ARTIS_DEBUG
+void artis_put_trace(void **bt, struct task_struct *task, unsigned long * stack)
+{
+       int i, artis_skip_bt=0;
+       unsigned long addr;
+
+       if (!stack)
+               stack = (unsigned long*)&stack;
+       memset(bt, 0, ARTIS_BT_SIZE*sizeof(void *));
+       for(i=artis_skip_bt; i>0 && !kstack_end(stack); ) {
+               addr = *stack++;
+               if (kernel_text_address(addr))
+                       i--;
+       }
+       for(i=ARTIS_BT_SIZE; i>0 && !kstack_end(stack); ) {
+               addr = *stack++;
+               if (kernel_text_address(addr)) {
+                       i--;
+                       bt[i]=(void *)addr;
+               }
+       }
+}
+#endif
+
+
 int register_die_notifier(struct notifier_block *nb)
 {
 	int err = 0;
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/asm-i386/bug.h 2.6.11-artis-cvs/include/asm-i386/bug.h
--- 2.6.11-pfm/include/asm-i386/bug.h	2005-03-02 08:37:49.000000000 +0100
+++ 2.6.11-artis-cvs/include/asm-i386/bug.h	2005-03-25 19:47:46.000000000 +0100
@@ -2,6 +2,7 @@
 #define _I386_BUG_H
 
 #include <linux/config.h>
+#include <linux/artis-macros.h>
 
 /*
  * Tell the user there is some problem.
@@ -10,13 +11,19 @@
  */
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define BUG()				\
+#define _old_BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
 			"\t.word %c0\n"	\
 			"\t.long %c1\n"	\
 			 : : "i" (__LINE__), "i" (__FILE__))
 #else
-#define BUG() __asm__ __volatile__("ud2\n")
+#define _old_BUG() __asm__ __volatile__("ud2\n")
+#endif
+
+#if defined(CONFIG_ARTIS_DEBUG)
+#define BUG() ARTIS_BUG(1,0)
+#else
+#define BUG() _old_BUG()
 #endif
 
 #define HAVE_ARCH_BUG
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/asm-i386/system.h 2.6.11-artis-cvs/include/asm-i386/system.h
--- 2.6.11-pfm/include/asm-i386/system.h	2005-03-02 08:37:30.000000000 +0100
+++ 2.6.11-artis-cvs/include/asm-i386/system.h	2005-03-25 19:47:46.000000000 +0100
@@ -441,9 +441,13 @@ struct alt_instr { 
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* interrupt control.. */
-#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define local_save_flags(x)		\
+do { 					\
+	typecheck(unsigned long,x); 	\
+	__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); \
+} while (0)
+
+#define _raw_local_irq_disable() __asm__ __volatile__("cli": : :"memory")
 #define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
@@ -456,7 +460,48 @@ struct alt_instr { 
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define _raw_local_irq_save(x) __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+
+#ifdef CONFIG_ARTIS
+
+/* ARTIS: force migration on irq disable. We use the "preempt_disable" work
+ * around to do it because the funtion "artis_try_to_migrate" assume
+ * that preemption is already disabled */
+#define local_irq_restore(x)   		\
+do { 					\
+	typecheck(unsigned long,x); 	\
+	if (!((x) & (1<<9))) { 		\
+		artis_force_migration();\
+	}; 				\
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc");  \
+} while (0)
+
+#define local_irq_disable()    		\
+do {  					\
+	artis_force_migration();	\
+	_raw_local_irq_disable(); 	\
+} while (0)
+
+#define local_irq_save(x)      		\
+do { 					\
+	artis_force_migration();	\
+	_raw_local_irq_save(x); 	\
+} while(0)
+
+#else
+
+#define local_irq_restore(x)      	\
+do { 					\
+	typecheck(unsigned long,x); 	\
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc");  				\
+} while (0)
+
+#define local_irq_disable() _raw_local_irq_disable()
+#define local_irq_save(x) _raw_local_irq_save(x)
+
+#endif
+
 
 /*
  * disable hlt during certain critical i/o operations

--------------070301010005050503090507--
