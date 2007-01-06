Return-Path: <linux-kernel-owner+w=401wt.eu-S1750960AbXAFALE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbXAFALE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbXAFALD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:11:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43142 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbXAFALA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:11:00 -0500
Date: Sat, 6 Jan 2007 01:07:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Subject: [patch] paravirt: isolate module ops
Message-ID: <20070106000715.GA6688@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Subject: [patch] paravirt: isolate module ops
From: Ingo Molnar <mingo@elte.hu>

only export those operations to modules that have been available to them 
historically: irq disable/enable, io-delay, udelay, etc.

this isolates that functionality from other paravirtualization 
functionality that modules have no business messing with.

boot and build tested with CONFIG_PARAVIRT=y.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/paravirt.c |   41 +++++++++++++++++++++++++++
 include/asm-i386/delay.h    |    4 +-
 include/asm-i386/paravirt.h |   65 ++++++++++++++++++++++----------------------
 3 files changed, 75 insertions(+), 35 deletions(-)

Index: linux/arch/i386/kernel/paravirt.c
===================================================================
--- linux.orig/arch/i386/kernel/paravirt.c
+++ linux/arch/i386/kernel/paravirt.c
@@ -492,6 +492,7 @@ struct paravirt_ops paravirt_ops = {
 
  	.patch = native_patch,
 	.banner = default_banner,
+
 	.arch_setup = native_nop,
 	.memory_setup = machine_specific_memory_setup,
 	.get_wallclock = native_get_wallclock,
@@ -566,4 +567,42 @@ struct paravirt_ops paravirt_ops = {
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 };
-EXPORT_SYMBOL(paravirt_ops);
+
+/*
+ * These are exported to modules:
+ */
+struct paravirt_ops paravirt_mod_ops = {
+	.name = "bare hardware",
+	.paravirt_enabled = 0,
+	.kernel_rpl = 0,
+
+ 	.patch = native_patch,
+	.banner = default_banner,
+
+	.save_fl = native_save_fl,
+	.restore_fl = native_restore_fl,
+	.irq_disable = native_irq_disable,
+	.irq_enable = native_irq_enable,
+
+	.cpuid = native_cpuid,
+
+	.read_msr = native_read_msr,
+	.write_msr = native_write_msr,
+
+	.read_tsc = native_read_tsc,
+	.read_pmc = native_read_pmc,
+
+	.io_delay = native_io_delay,
+	.const_udelay = __const_udelay,
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	.apic_write = native_apic_write,
+	.apic_write_atomic = native_apic_write_atomic,
+	.apic_read = native_apic_read,
+#endif
+
+	.flush_tlb_user = native_flush_tlb,
+	.flush_tlb_kernel = native_flush_tlb_global,
+	.flush_tlb_single = native_flush_tlb_single,
+};
+EXPORT_SYMBOL(paravirt_mod_ops);
Index: linux/include/asm-i386/delay.h
===================================================================
--- linux.orig/include/asm-i386/delay.h
+++ linux/include/asm-i386/delay.h
@@ -17,9 +17,9 @@ extern void __const_udelay(unsigned long
 extern void __delay(unsigned long loops);
 
 #if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
-#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+#define udelay(n) paravirt_mod_ops.const_udelay((n) * 0x10c7ul)
 
-#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+#define ndelay(n) paravirt_mod_ops.const_udelay((n) * 5ul)
 
 #else /* !PARAVIRT || USE_REAL_TIME_DELAY */
 
Index: linux/include/asm-i386/paravirt.h
===================================================================
--- linux.orig/include/asm-i386/paravirt.h
+++ linux/include/asm-i386/paravirt.h
@@ -151,8 +151,9 @@ struct paravirt_ops
 		__attribute__((__section__(".paravirtprobe"))) = fn
 
 extern struct paravirt_ops paravirt_ops;
+extern struct paravirt_ops paravirt_mod_ops;
 
-#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
+#define paravirt_enabled() (paravirt_mod_ops.paravirt_enabled)
 
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
@@ -180,7 +181,7 @@ static inline void do_time_init(void)
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
-	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+	paravirt_mod_ops.cpuid(eax, ebx, ecx, edx);
 }
 
 /*
@@ -219,52 +220,52 @@ static inline void halt(void)
 
 #define rdmsr(msr,val1,val2) do {				\
 	int _err;						\
-	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	u64 _l = paravirt_mod_ops.read_msr(msr,&_err);		\
 	val1 = (u32)_l;						\
 	val2 = _l >> 32;					\
 } while(0)
 
 #define wrmsr(msr,val1,val2) do {				\
 	u64 _l = ((u64)(val2) << 32) | (val1);			\
-	paravirt_ops.write_msr((msr), _l);			\
+	paravirt_mod_ops.write_msr((msr), _l);			\
 } while(0)
 
 #define rdmsrl(msr,val) do {					\
 	int _err;						\
-	val = paravirt_ops.read_msr((msr),&_err);		\
+	val = paravirt_mod_ops.read_msr((msr),&_err);		\
 } while(0)
 
-#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+#define wrmsrl(msr,val) (paravirt_mod_ops.write_msr((msr),(val)))
 #define wrmsr_safe(msr,a,b) ({					\
 	u64 _l = ((u64)(b) << 32) | (a);			\
-	paravirt_ops.write_msr((msr),_l);			\
+	paravirt_mod_ops.write_msr((msr),_l);			\
 })
 
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr,a,b) ({					\
 	int _err;						\
-	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	u64 _l = paravirt_mod_ops.read_msr(msr,&_err);		\
 	(*a) = (u32)_l;						\
 	(*b) = _l >> 32;					\
 	_err; })
 
 #define rdtsc(low,high) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = paravirt_mod_ops.read_tsc();			\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
 
 #define rdtscl(low) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = paravirt_mod_ops.read_tsc();			\
 	low = (int)_l;						\
 } while(0)
 
-#define rdtscll(val) (val = paravirt_ops.read_tsc())
+#define rdtscll(val) (val = paravirt_mod_ops.read_tsc())
 
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) do {				\
-	u64 _l = paravirt_ops.read_pmc();			\
+	u64 _l = paravirt_mod_ops.read_pmc();			\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
@@ -287,11 +288,11 @@ static inline void halt(void)
 
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void) {
-	paravirt_ops.io_delay();
+	paravirt_mod_ops.io_delay();
 #ifdef REALLY_SLOW_IO
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
+	paravirt_mod_ops.io_delay();
+	paravirt_mod_ops.io_delay();
+	paravirt_mod_ops.io_delay();
 #endif
 }
 
@@ -301,24 +302,24 @@ static inline void slow_down_io(void) {
  */
 static inline void apic_write(unsigned long reg, unsigned long v)
 {
-	paravirt_ops.apic_write(reg,v);
+	paravirt_mod_ops.apic_write(reg,v);
 }
 
 static inline void apic_write_atomic(unsigned long reg, unsigned long v)
 {
-	paravirt_ops.apic_write_atomic(reg,v);
+	paravirt_mod_ops.apic_write_atomic(reg,v);
 }
 
 static inline unsigned long apic_read(unsigned long reg)
 {
-	return paravirt_ops.apic_read(reg);
+	return paravirt_mod_ops.apic_read(reg);
 }
 #endif
 
 
-#define __flush_tlb() paravirt_ops.flush_tlb_user()
-#define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
-#define __flush_tlb_single(addr) paravirt_ops.flush_tlb_single(addr)
+#define __flush_tlb()			paravirt_mod_ops.flush_tlb_user()
+#define __flush_tlb_global()		paravirt_mod_ops.flush_tlb_kernel()
+#define __flush_tlb_single(addr)	paravirt_mod_ops.flush_tlb_single(addr)
 
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
@@ -397,7 +398,7 @@ static inline unsigned long __raw_local_
 					   "call *%1;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
-			     : "=a"(f): "m"(paravirt_ops.save_fl)
+			     : "=a"(f): "m"(paravirt_mod_ops.save_fl)
 			     : "memory", "cc");
 	return f;
 }
@@ -408,7 +409,7 @@ static inline void raw_local_irq_restore
 					   "call *%1;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
-			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
+			     : "=a"(f) : "m" (paravirt_mod_ops.restore_fl), "0"(f)
 			     : "memory", "cc");
 }
 
@@ -418,7 +419,7 @@ static inline void raw_local_irq_disable
 					   "call *%0;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_disable)
+			     : : "m" (paravirt_mod_ops.irq_disable)
 			     : "memory", "eax", "cc");
 }
 
@@ -428,7 +429,7 @@ static inline void raw_local_irq_enable(
 					   "call *%0;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_enable)
+			     : : "m" (paravirt_mod_ops.irq_enable)
 			     : "memory", "eax", "cc");
 }
 
@@ -443,19 +444,19 @@ static inline unsigned long __raw_local_
 					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
 					  CLBR_NONE)
 			     : "=a"(f)
-			     : "m" (paravirt_ops.save_fl),
-			       "m" (paravirt_ops.irq_disable)
+			     : "m" (paravirt_mod_ops.save_fl),
+			       "m" (paravirt_mod_ops.irq_disable)
 			     : "memory", "cc");
 	return f;
 }
 
 #define CLI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_disable];"		\
+		     "call *paravirt_mod_ops+%c[irq_disable];"		\
 		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
 
 #define STI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_enable];"		\
+		     "call *paravirt_mod_ops+%c[irq_enable];"		\
 		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
 #define CLI_STI_CLOBBERS , "%eax"
@@ -484,13 +485,13 @@ static inline unsigned long __raw_local_
 #define DISABLE_INTERRUPTS(clobbers)			\
 	PARA_PATCH(PARAVIRT_IRQ_DISABLE, clobbers,	\
 	pushl %ecx; pushl %edx;				\
-	call *paravirt_ops+PARAVIRT_irq_disable;	\
+	call *paravirt_mod_ops+PARAVIRT_irq_disable;	\
 	popl %edx; popl %ecx)				\
 
 #define ENABLE_INTERRUPTS(clobbers)			\
 	PARA_PATCH(PARAVIRT_IRQ_ENABLE, clobbers,	\
 	pushl %ecx; pushl %edx;				\
-	call *%cs:paravirt_ops+PARAVIRT_irq_enable;	\
+	call *%cs:paravirt_mod_ops+PARAVIRT_irq_enable;	\
 	popl %edx; popl %ecx)
 
 #define ENABLE_INTERRUPTS_SYSEXIT			\
