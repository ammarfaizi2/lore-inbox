Return-Path: <linux-kernel-owner+w=401wt.eu-S1751027AbXAFBCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXAFBCu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbXAFBCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:02:49 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:42375 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXAFBCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:02:48 -0500
Message-ID: <459EF537.6090301@vmware.com>
Date: Fri, 05 Jan 2007 17:02:47 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
References: <20070106000715.GA6688@elte.hu>
In-Reply-To: <20070106000715.GA6688@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000900020005080008010809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900020005080008010809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> Subject: [patch] paravirt: isolate module ops
> From: Ingo Molnar <mingo@elte.hu>
>
> only export those operations to modules that have been available to them 
> historically: irq disable/enable, io-delay, udelay, etc.
>
> this isolates that functionality from other paravirtualization 
> functionality that modules have no business messing with.
>
> boot and build tested with CONFIG_PARAVIRT=y.
>   

I would suggest a slightly different carving.  For one, no TLB flushes.  
If you can't modify PTEs, why do you need to have TLB flushes?  And I 
would allow CR0 read / write for code which saves and restores FPU state 
- possibly even debug register access, although any code which touches 
DRs could be doing something sneaky.  I'm on the fence about that one.

Here is a partially tested patch against the -mm tree.  Let me know what 
you think of this slightly different approach.

--------------000900020005080008010809
Content-Type: text/plain;
 name="ingo-isolation"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ingo-isolation"

diff -r 3242f865ce8e arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Thu Jan 04 20:17:02 2007 -0800
+++ b/arch/i386/kernel/paravirt.c	Fri Jan 05 16:48:25 2007 -0800
@@ -492,6 +492,7 @@ struct paravirt_ops paravirt_ops = {
 
  	.patch = native_patch,
 	.banner = default_banner,
+
 	.arch_setup = native_nop,
 	.memory_setup = machine_specific_memory_setup,
 	.get_wallclock = native_get_wallclock,
@@ -577,4 +578,42 @@ struct paravirt_ops paravirt_ops = {
 
 	.startup_ipi_hook = (void *)native_nop,
 };
-EXPORT_SYMBOL(paravirt_ops);
+
+/*
+ * These are exported to modules:
+ */
+struct paravirt_mod_ops paravirt_mod_ops = {
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
diff -r 3242f865ce8e include/asm-i386/delay.h
--- a/include/asm-i386/delay.h	Thu Jan 04 20:17:02 2007 -0800
+++ b/include/asm-i386/delay.h	Fri Jan 05 16:11:43 2007 -0800
@@ -17,9 +17,9 @@ extern void __delay(unsigned long loops)
 extern void __delay(unsigned long loops);
 
 #if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
-#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+#define udelay(n) paravirt_mod_ops.const_udelay((n) * 0x10c7ul)
 
-#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+#define ndelay(n) paravirt_mod_ops.const_udelay((n) * 5ul)
 
 #else /* !PARAVIRT || USE_REAL_TIME_DELAY */
 
diff -r 3242f865ce8e include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Jan 04 20:17:02 2007 -0800
+++ b/include/asm-i386/paravirt.h	Fri Jan 05 16:51:10 2007 -0800
@@ -29,12 +29,52 @@ struct Xgt_desc_struct;
 struct Xgt_desc_struct;
 struct tss_struct;
 struct mm_struct;
-struct paravirt_ops
+struct paravirt_mod_ops
 {
 	unsigned int kernel_rpl;
  	int paravirt_enabled;
 	const char *name;
 
+	/* All the function pointers here are declared as "fastcall"
+	   so that we get a specific register-based calling
+	   convention.  This makes it easier to implement inline
+	   assembler replacements. */
+
+	void (fastcall *cpuid)(unsigned int *eax, unsigned int *ebx,
+		      unsigned int *ecx, unsigned int *edx);
+
+	/* CLTS / cr0 may be used for math state save / restore */
+	void (fastcall *clts)(void);
+	unsigned long (fastcall *read_cr0)(void);
+	void (fastcall *write_cr0)(unsigned long);
+
+	unsigned long (fastcall *save_fl)(void);
+	void (fastcall *restore_fl)(unsigned long);
+	void (fastcall *irq_disable)(void);
+	void (fastcall *irq_enable)(void);
+
+	/* err = 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
+	u64 (fastcall *read_msr)(unsigned int msr, int *err);
+	int (fastcall *write_msr)(unsigned int msr, u64 val);
+
+	u64 (fastcall *read_tsc)(void);
+	u64 (fastcall *read_pmc)(void);
+
+	void (fastcall *io_delay)(void);
+	void (*const_udelay)(unsigned long loops);
+
+	/* May be needed by device drivers to flush cache */
+	void (fastcall *wbinvd)(void);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
+	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
+	unsigned long (fastcall *apic_read)(unsigned long reg);
+#endif
+};
+
+struct paravirt_ops
+{
 	/*
 	 * Patch may replace one of the defined code sequences with arbitrary
 	 * code, subject to the same register constraints.  This generally
@@ -54,21 +94,8 @@ struct paravirt_ops
 	int (*set_wallclock)(unsigned long);
 	void (*time_init)(void);
 
-	/* All the function pointers here are declared as "fastcall"
-	   so that we get a specific register-based calling
-	   convention.  This makes it easier to implement inline
-	   assembler replacements. */
-
-	void (fastcall *cpuid)(unsigned int *eax, unsigned int *ebx,
-		      unsigned int *ecx, unsigned int *edx);
-
 	unsigned long (fastcall *get_debugreg)(int regno);
 	void (fastcall *set_debugreg)(int regno, unsigned long value);
-
-	void (fastcall *clts)(void);
-
-	unsigned long (fastcall *read_cr0)(void);
-	void (fastcall *write_cr0)(unsigned long);
 
 	unsigned long (fastcall *read_cr2)(void);
 	void (fastcall *write_cr2)(unsigned long);
@@ -80,20 +107,8 @@ struct paravirt_ops
 	unsigned long (fastcall *read_cr4)(void);
 	void (fastcall *write_cr4)(unsigned long);
 
-	unsigned long (fastcall *save_fl)(void);
-	void (fastcall *restore_fl)(unsigned long);
-	void (fastcall *irq_disable)(void);
-	void (fastcall *irq_enable)(void);
 	void (fastcall *safe_halt)(void);
 	void (fastcall *halt)(void);
-	void (fastcall *wbinvd)(void);
-
-	/* err = 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
-	u64 (fastcall *read_msr)(unsigned int msr, int *err);
-	int (fastcall *write_msr)(unsigned int msr, u64 val);
-
-	u64 (fastcall *read_tsc)(void);
-	u64 (fastcall *read_pmc)(void);
 
 	void (fastcall *load_tr_desc)(void);
 	void (fastcall *load_gdt)(const struct Xgt_desc_struct *);
@@ -114,13 +129,7 @@ struct paravirt_ops
 
 	void (fastcall *set_iopl_mask)(unsigned mask);
 
-	void (fastcall *io_delay)(void);
-	void (*const_udelay)(unsigned long loops);
-
 #ifdef CONFIG_X86_LOCAL_APIC
-	void (fastcall *apic_write)(unsigned long reg, unsigned long v);
-	void (fastcall *apic_write_atomic)(unsigned long reg, unsigned long v);
-	unsigned long (fastcall *apic_read)(unsigned long reg);
 	void (*setup_boot_clock)(void);
 	void (*setup_secondary_clock)(void);
 #endif
@@ -163,8 +172,9 @@ struct paravirt_ops
 		__attribute__((__section__(".paravirtprobe"))) = fn
 
 extern struct paravirt_ops paravirt_ops;
-
-#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
+extern struct paravirt_mod_ops paravirt_mod_ops;
+
+#define paravirt_enabled() (paravirt_mod_ops.paravirt_enabled)
 
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
@@ -192,7 +202,7 @@ static inline void __cpuid(unsigned int 
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
-	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+	paravirt_mod_ops.cpuid(eax, ebx, ecx, edx);
 }
 
 /*
@@ -201,10 +211,10 @@ static inline void __cpuid(unsigned int 
 #define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
 #define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
 
-#define clts() paravirt_ops.clts()
-
-#define read_cr0() paravirt_ops.read_cr0()
-#define write_cr0(x) paravirt_ops.write_cr0(x)
+#define clts() paravirt_mod_ops.clts()
+
+#define read_cr0() paravirt_mod_ops.read_cr0()
+#define write_cr0(x) paravirt_mod_ops.write_cr0(x)
 
 #define read_cr2() paravirt_ops.read_cr2()
 #define write_cr2(x) paravirt_ops.write_cr2(x)
@@ -225,58 +235,58 @@ static inline void halt(void)
 {
 	paravirt_ops.safe_halt();
 }
-#define wbinvd() paravirt_ops.wbinvd()
-
-#define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
+#define wbinvd() paravirt_mod_ops.wbinvd()
+
+#define get_kernel_rpl()  (paravirt_mod_ops.kernel_rpl)
 
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
-} while(0)
-
-#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+	val = paravirt_mod_ops.read_msr((msr),&_err);		\
+} while(0)
+
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
@@ -299,11 +309,11 @@ static inline void halt(void)
 
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
 
@@ -313,17 +323,17 @@ static inline void slow_down_io(void) {
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
 
 static inline void setup_boot_clock(void)
@@ -447,7 +457,7 @@ static inline unsigned long __raw_local_
 					   "call *%1;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
-			     : "=a"(f): "m"(paravirt_ops.save_fl)
+			     : "=a"(f): "m"(paravirt_mod_ops.save_fl)
 			     : "memory", "cc");
 	return f;
 }
@@ -458,7 +468,7 @@ static inline void raw_local_irq_restore
 					   "call *%1;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
-			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
+			     : "=a"(f) : "m" (paravirt_mod_ops.restore_fl), "0"(f)
 			     : "memory", "cc");
 }
 
@@ -468,7 +478,7 @@ static inline void raw_local_irq_disable
 					   "call *%0;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_disable)
+			     : : "m" (paravirt_mod_ops.irq_disable)
 			     : "memory", "eax", "cc");
 }
 
@@ -478,7 +488,7 @@ static inline void raw_local_irq_enable(
 					   "call *%0;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_enable)
+			     : : "m" (paravirt_mod_ops.irq_enable)
 			     : "memory", "eax", "cc");
 }
 
@@ -493,26 +503,26 @@ static inline unsigned long __raw_local_
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
 #define CLI_STI_INPUT_ARGS \
 	,								\
-	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
-	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
+	[irq_disable] "i" (offsetof(struct paravirt_mod_ops, irq_disable)),	\
+	[irq_enable] "i" (offsetof(struct paravirt_mod_ops, irq_enable))
 
 #else  /* __ASSEMBLY__ */
 
@@ -534,13 +544,13 @@ 772:;						\
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
@@ -548,7 +558,7 @@ 772:;						\
 	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit)
 
 #define GET_CR0_INTO_EAX			\
-	call *paravirt_ops+PARAVIRT_read_cr0
+	call *paravirt_mod_ops+PARAVIRT_read_cr0
 
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT */
diff -r 3242f865ce8e arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Thu Jan 04 20:17:02 2007 -0800
+++ b/arch/i386/kernel/asm-offsets.c	Fri Jan 05 16:49:15 2007 -0800
@@ -104,11 +104,11 @@ void foo(void)
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_enabled, paravirt_ops, paravirt_enabled);
-	OFFSET(PARAVIRT_irq_disable, paravirt_ops, irq_disable);
-	OFFSET(PARAVIRT_irq_enable, paravirt_ops, irq_enable);
+	OFFSET(PARAVIRT_enabled, paravirt_mod_ops, paravirt_enabled);
+	OFFSET(PARAVIRT_irq_disable, paravirt_mod_ops, irq_disable);
+	OFFSET(PARAVIRT_irq_enable, paravirt_mod_ops, irq_enable);
 	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
 	OFFSET(PARAVIRT_iret, paravirt_ops, iret);
-	OFFSET(PARAVIRT_read_cr0, paravirt_ops, read_cr0);
+	OFFSET(PARAVIRT_read_cr0, paravirt_mod_ops, read_cr0);
 #endif
 }

--------------000900020005080008010809--
