Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTBURPB>; Fri, 21 Feb 2003 12:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTBURPB>; Fri, 21 Feb 2003 12:15:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61631 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267583AbTBURO4>;
	Fri, 21 Feb 2003 12:14:56 -0500
Date: Fri, 21 Feb 2003 17:36:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w ith flush_tlb_all()
Message-ID: <20030221173602.GC25704@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030221142039.GA21532@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221142039.GA21532@codemonkey.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 02:20:39PM +0000, Dave Jones wrote:

 > That would appear to do what you want, but its an ugly construct to
 > be repeating everywhere that wants to call a function on all CPUs.
 > It would probably clean things up a lot if we had a function to do..

Ok, here's a first stab at an implementation. Compiles, but is untested..
Fixes up a few preemption races Thomas highlighted, and converts
a few smp_call_function() users over to on_each_cpu(), which
saves quite a bit of code.

		Dave


diff -Nru a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	Fri Feb 21 17:16:00 2003
+++ b/arch/i386/kernel/cpuid.c	Fri Feb 21 17:16:00 2003
@@ -64,6 +64,7 @@
 {
   struct cpuid_command cmd;
   
+  preempt_disable();
   if ( cpu == smp_processor_id() ) {
     cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
   } else {
@@ -73,6 +74,7 @@
     
     smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
   }
+  preempt_enable();
 }
 #else /* ! CONFIG_SMP */
 
diff -Nru a/arch/i386/kernel/microcode.c b/arch/i386/kernel/microcode.c
--- a/arch/i386/kernel/microcode.c	Fri Feb 21 17:16:00 2003
+++ b/arch/i386/kernel/microcode.c	Fri Feb 21 17:16:00 2003
@@ -183,11 +183,8 @@
 	int i, error = 0, err;
 	struct microcode *m;
 
-	if (smp_call_function(do_update_one, NULL, 1, 1) != 0) {
-		printk(KERN_ERR "microcode: IPI timeout, giving up\n");
+	if (on_each_cpu(do_update_one, NULL)==-1)
 		return -EIO;
-	}
-	do_update_one(NULL);
 
 	for (i=0; i<NR_CPUS; i++) {
 		err = update_req[i].err;
diff -Nru a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
--- a/arch/i386/kernel/msr.c	Fri Feb 21 17:16:00 2003
+++ b/arch/i386/kernel/msr.c	Fri Feb 21 17:16:00 2003
@@ -115,9 +115,13 @@
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
 {
   struct msr_command cmd;
+  int ret;
 
+  preempt_disable();
   if ( cpu == smp_processor_id() ) {
-    return wrmsr_eio(reg, eax, edx);
+    ret = wrmsr_eio(reg, eax, edx);
+    preempt_enable();
+    return ret;
   } else {
     cmd.cpu = cpu;
     cmd.reg = reg;
@@ -125,6 +129,7 @@
     cmd.data[1] = edx;
     
     smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
+    preempt_enable();
     return cmd.err;
   }
 }
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Fri Feb 21 17:16:00 2003
+++ b/arch/i386/kernel/smp.c	Fri Feb 21 17:16:00 2003
@@ -547,6 +547,41 @@
 	return 0;
 }
 
+/*
+ * [SUMMARY] Run a function on every CPU.
+ * <func> The function to run. This must be fast and non-blocking.
+ * <info> An arbitrary pointer to pass to the function.
+ * <nonatomic> currently unused.
+ * [RETURNS] 0 on success, else a negative status code. Does not return until
+ * remote CPUs are nearly ready to execute <<func>> or are or have executed.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+int on_each_cpu(void (*func) (void *info), void *info)
+{
+#ifdef CONFIG_SMP
+	preempt_disable();
+
+	if (num_online_cpus() == 1)
+		goto only_one;
+
+	if (smp_call_function(func, info, 1, 1) != 0) {
+		printk (KERN_ERR "%p: IPI timeout, giving up\n",
+			__builtin_return_address(0));
+		preempt_enable();
+		return -1;
+	}
+
+only_one:
+	func(info);
+	preempt_enable();
+#else
+	func(info);
+#endif
+	return 0;
+}
+
 static void stop_this_cpu (void * dummy)
 {
 	/*
diff -Nru a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c
--- a/arch/i386/kernel/sysenter.c	Fri Feb 21 17:16:00 2003
+++ b/arch/i386/kernel/sysenter.c	Fri Feb 21 17:16:00 2003
@@ -17,6 +17,7 @@
 #include <asm/msr.h>
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
+#include <asm/smp.h>
 
 extern asmlinkage void sysenter_entry(void);
 
@@ -97,8 +98,7 @@
 		return 0;
 
 	memcpy((void *) page, sysent, sizeof(sysent));
-	enable_sep_cpu(NULL);
-	smp_call_function(enable_sep_cpu, NULL, 1, 1);
+	on_each_cpu (enable_sep_cpu, NULL);
 	return 0;
 }
 
diff -Nru a/arch/i386/mm/pageattr.c b/arch/i386/mm/pageattr.c
--- a/arch/i386/mm/pageattr.c	Fri Feb 21 17:16:00 2003
+++ b/arch/i386/mm/pageattr.c	Fri Feb 21 17:16:00 2003
@@ -131,10 +131,7 @@
 
 static inline void flush_map(void)
 {	
-#ifdef CONFIG_SMP 
-	smp_call_function(flush_kernel_map, NULL, 1, 1);
-#endif	
-	flush_kernel_map(NULL);
+	on_each_cpu(flush_kernel_map, NULL);
 }
 
 struct deferred_page { 
diff -Nru a/arch/x86_64/mm/pageattr.c b/arch/x86_64/mm/pageattr.c
--- a/arch/x86_64/mm/pageattr.c	Fri Feb 21 17:16:00 2003
+++ b/arch/x86_64/mm/pageattr.c	Fri Feb 21 17:16:00 2003
@@ -123,10 +123,7 @@
 
 static inline void flush_map(unsigned long address)
 {	
-#ifdef CONFIG_SMP 
-	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
-#endif	
-	flush_kernel_map((void *)address);
+	on_each_cpu(flush_kernel_map,(void *)address);
 }
 
 struct deferred_page { 
diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	Fri Feb 21 17:16:00 2003
+++ b/drivers/char/agp/agp.h	Fri Feb 21 17:16:00 2003
@@ -34,24 +34,10 @@
 
 #define PFX "agpgart: "
 
-#ifdef CONFIG_SMP
-static void ipi_handler(void *null)
-{
-	flush_agp_cache();
-}
-
-static void __attribute__((unused)) global_cache_flush(void)
-{
-	if (smp_call_function(ipi_handler, NULL, 1, 1) != 0)
-		panic(PFX "timed out waiting for the other CPUs!\n");
-	flush_agp_cache();
-}
-#else
 static inline void global_cache_flush(void)
 {
-	flush_agp_cache();
+	on_each_cpu(flush_agp_cache, NULL);
 }
-#endif	/* !CONFIG_SMP */
 
 enum aper_size_type {
 	U8_APER_SIZE,
diff -Nru a/include/asm-i386/agp.h b/include/asm-i386/agp.h
--- a/include/asm-i386/agp.h	Fri Feb 21 17:16:00 2003
+++ b/include/asm-i386/agp.h	Fri Feb 21 17:16:00 2003
@@ -18,6 +18,8 @@
 /* Could use CLFLUSH here if the cpu supports it. But then it would
    need to be called for each cacheline of the whole page so it may not be 
    worth it. Would need a page for it. */
-#define flush_agp_cache() asm volatile("wbinvd":::"memory")
-
+static void flush_agp_cache(void *info)
+{
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+}
 #endif
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Fri Feb 21 17:16:00 2003
+++ b/include/asm-i386/smp.h	Fri Feb 21 17:16:00 2003
@@ -46,6 +46,8 @@
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
 
+extern int on_each_cpu(void (*func) (void *info), void *info);
+
 #define MAX_APICID 256
 
 /*
diff -Nru a/include/asm-x86_64/agp.h b/include/asm-x86_64/agp.h
--- a/include/asm-x86_64/agp.h	Fri Feb 21 17:16:00 2003
+++ b/include/asm-x86_64/agp.h	Fri Feb 21 17:16:00 2003
@@ -18,6 +18,8 @@
 /* Could use CLFLUSH here if the cpu supports it. But then it would
    need to be called for each cacheline of the whole page so it may not be 
    worth it. Would need a page for it. */
-#define flush_agp_cache() asm volatile("wbinvd":::"memory")
-
+static void flush_agp_cache(void *info)
+{
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+}
 #endif
diff -Nru a/include/asm-x86_64/smp.h b/include/asm-x86_64/smp.h
--- a/include/asm-x86_64/smp.h	Fri Feb 21 17:16:00 2003
+++ b/include/asm-x86_64/smp.h	Fri Feb 21 17:16:00 2003
@@ -46,6 +46,8 @@
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings(void);
 
+extern int on_each_cpu(void (*func) (void *info), void *info);
+
 #define SMP_TRAMPOLINE_BASE 0x6000
 
 /*
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
