Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVECOOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVECOOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVECONw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:13:52 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:26559 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261572AbVECOKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:10:06 -0400
Message-ID: <4277863B.2090208@lifl.fr>
Date: Tue, 03 May 2005 16:10:03 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Philippe Marquet <Philippe.Marquet@lifl.fr>,
       Christophe Osuna <osuna@lifl.fr>, Julien Soula <soula@lifl.fr>,
       Jean-Luc Dekeyser <dekeyser@lifl.fr>, paul.mckenney@us.ibm.com
Subject: [3/3] ARTiS, an asymmetric real-time scheduler - IA-64
References: <42778532.7090806@lifl.fr>
In-Reply-To: <42778532.7090806@lifl.fr>
Content-Type: multipart/mixed;
 boundary="------------040001070002000802020700"
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040001070002000802020700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here is the Here is the architecture dependant part of ARTiS for IA-64.

--------------040001070002000802020700
Content-Type: text/x-patch;
 name="artis-2.6.11-20050502-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="artis-2.6.11-20050502-ia64.patch"

diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/arch/ia64/Kconfig 2.6.11-artis-cvs/arch/ia64/Kconfig
--- 2.6.11-pfm/arch/ia64/Kconfig	2005-03-02 08:38:26.000000000 +0100
+++ 2.6.11-artis-cvs/arch/ia64/Kconfig	2005-04-22 18:08:19.000000000 +0200
@@ -46,6 +46,32 @@ config GENERIC_IOMAP
 	bool
 	default y
 
+config ARTIS
+	bool "Compile the kernel with ARTiS support (EXPERIMENTAL)"
+	depends on PREEMPT && SMP
+	help
+		ARTiS is an "Asymmetric Real-Time Scheduling". When activated,
+		the real-time tasks will be insured of low latencies. It works
+		by automatically migrating the normal tasks out from CPUs running
+		real-time tasks when they would trigger a preemption disable or an
+		IRQ disable. Obviously, a SMP system is required (SMT works too).
+		Note that it will not be activated by default, you need to select
+		it at boot time. For more information, see Documentation/artis.txt.
+
+config ARTIS_DEBUG
+       bool "Compile the kernel with ARTiS debugging support (EXPERIMENTAL)"
+       depends on ARTIS
+       help
+		Activate debuging code in ARTiS, you probably don't want this, excepted
+		if you want to hack on ARTiS.
+
+config ARTIS_STAT
+       bool "Compile the kernel with ARTiS accounting support (EXPERIMENTAL)"
+       depends on ARTIS
+       help
+		Activate statistics about ARTiS, available in /proc. There is no (or
+		very little) performance penalty, so you can safely say "yes" here.
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/arch/ia64/kernel/process.c 2.6.11-artis-cvs/arch/ia64/kernel/process.c
--- 2.6.11-pfm/arch/ia64/kernel/process.c	2005-03-02 08:38:08.000000000 +0100
+++ 2.6.11-artis-cvs/arch/ia64/kernel/process.c	2005-03-25 19:47:46.000000000 +0100
@@ -229,6 +229,43 @@ static inline void play_dead(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_ARTIS_DEBUG
+#include <linux/artis.h>
+void
+artis_ia64_put_trace(struct unw_frame_info *info, void *arg)
+{
+	void **bt = (void **)arg;
+	int i, artis_skip_bt, r_unw;
+	unsigned long ip, sp, bsp;
+
+	memset(bt, 0, ARTIS_BT_SIZE*sizeof(void *));
+	r_unw=0; 
+	artis_skip_bt=0;
+	for(i=artis_skip_bt-1;
+			i>=0 && r_unw>=0; 
+			i--, r_unw=unw_unwind(info)) {
+		unw_get_ip(info, &ip);
+		if (ip == 0)
+			break;
+		unw_get_sp(info, &sp);
+		unw_get_bsp(info, &bsp);
+	}
+	for(i=ARTIS_BT_SIZE-1;
+			i>=0 && r_unw>=0; 
+			i--, r_unw=unw_unwind(info)) {
+		unw_get_ip(info, &ip);
+		if (ip == 0)
+			break;
+		unw_get_sp(info, &sp);
+		unw_get_bsp(info, &bsp);
+		bt[i] = (void *)ip;
+	}
+}
+void
+artis_put_trace(void **bt, struct task_struct *task, unsigned long *stack) {
+		unw_init_running(artis_ia64_put_trace, (void *)bt);
+}
+#endif
 
 void cpu_idle_wait(void)
 {
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/asm-ia64/bug.h 2.6.11-artis-cvs/include/asm-ia64/bug.h
--- 2.6.11-pfm/include/asm-ia64/bug.h	2005-03-02 08:38:34.000000000 +0100
+++ 2.6.11-artis-cvs/include/asm-ia64/bug.h	2005-03-25 19:47:46.000000000 +0100
@@ -1,12 +1,20 @@
 #ifndef _ASM_IA64_BUG_H
 #define _ASM_IA64_BUG_H
 
+#include <linux/artis-macros.h>
+
 #if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
 # define ia64_abort()	__builtin_trap()
 #else
 # define ia64_abort()	(*(volatile int *) 0 = 0)
 #endif
-#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+#define _old_BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+
+#if defined(CONFIG_ARTIS_DEBUG)
+#define BUG() do { ARTIS_BUG(1,0); } while (0)
+#else
+#define BUG() _old_BUG()
+#endif
 
 /* should this BUG should be made generic? */
 #define HAVE_ARCH_BUG
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/asm-ia64/system.h 2.6.11-artis-cvs/include/asm-ia64/system.h
--- 2.6.11-pfm/include/asm-ia64/system.h	2005-03-02 08:38:07.000000000 +0100
+++ 2.6.11-artis-cvs/include/asm-ia64/system.h	2005-03-25 19:47:46.000000000 +0100
@@ -121,7 +121,7 @@ extern struct ia64_boot_param {
  *   write a floating-point register right before reading the PSR
  *   and that writes to PSR.mfl
  */
-#define __local_irq_save(x)			\
+#define _raw__local_irq_save(x)			\
 do {						\
 	ia64_stop();				\
 	(x) = ia64_getreg(_IA64_REG_PSR);	\
@@ -129,13 +129,47 @@ do {						\
 	ia64_rsm(IA64_PSR_I);			\
 } while (0)
 
-#define __local_irq_disable()			\
+#define _raw__local_irq_disable()		\
 do {						\
 	ia64_stop();				\
 	ia64_rsm(IA64_PSR_I);			\
 } while (0)
 
-#define __local_irq_restore(x)	ia64_intrin_local_irq_restore((x) & IA64_PSR_I)
+#define _raw__local_irq_restore(x)	ia64_intrin_local_irq_restore((x) & IA64_PSR_I)
+
+#ifdef CONFIG_ARTIS
+#include <linux/artis-macros.h>
+
+/* Overwrite all functions "dangerous" for real-time: migrate task on
+ * non real-time CPU */
+
+#define __local_irq_save(x) 			\
+do { 						\
+	artis_force_migration(); 		\
+	_raw__local_irq_save(x); 		\
+} while (0)
+
+#define __local_irq_disable() 			\
+do { 						\
+	artis_force_migration(); 		\
+	_raw__local_irq_disable(); 		\
+} while (0)
+
+#define __local_irq_restore(x) 			\
+do { 						\
+	if (!((x) & IA64_PSR_I)) 		\
+		artis_force_migration(); 	\
+	_raw__local_irq_restore(x); 		\
+} while (0)
+
+#else
+
+#define __local_irq_save(x) 	_raw__local_irq_save(x)
+#define __local_irq_disable() 	_raw__local_irq_disable()
+#define __local_irq_restore(x) 	_raw__local_irq_restore(x)
+
+#endif
+
 
 #ifdef CONFIG_IA64_DEBUG_IRQ
 
@@ -282,6 +316,20 @@ do {						\
 #define finish_arch_switch(rq, prev)	spin_unlock_irq(&(prev)->switch_lock)
 #define task_running(rq, p) 		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
 
+#ifdef CONFIG_ARTIS
+/* On IA64, the end of scheduler releases the runqueue lock, 
+ * so a wake-up has re-activated the task and we must
+ * deactivate it
+ * */
+#define artis_complete_arch(rq, task) 		\
+do { 						\
+	spin_lock(&(rq)->lock); 		\
+	if ((task)->array) 			\
+		deactivate_task((task),(rq)); 	\
+} while(0)
+#define artis_finish_complete_arch(rq, task) spin_unlock(&(rq)->lock)
+#endif
+
 #define ia64_platform_is(x) (strcmp(x, platform_name) == 0)
 
 void cpu_idle_wait(void);

--------------040001070002000802020700--
