Return-Path: <linux-kernel-owner+w=401wt.eu-S1422823AbXAMXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbXAMXLc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbXAMXLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:11:11 -0500
Received: from gw.goop.org ([64.81.55.164]:59924 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030532AbXAMXKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:37 -0500
Message-Id: <20070113014648.000988681@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:48 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Rusty Russell <rusty@rustcorp.com.au>,
       Chris Wright <chrisw@sous-sol.org>
Subject: [patch 09/20] XEN-paravirt: dont export paravirt_ops structure, do individual functions
Content-Disposition: inline; filename=no-paravirt_ops-export.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the paravirt_ops members we want to export in wrapper functions.
Since we binary-patch the critical ones, this doesn't make a speed
impact.

I moved drm_follow_page into the core, to avoid having to wrap the
various pte ops.  Unlining kernel_fpu_end and using that in the RAID6
code would remove the need to export clts/read_cr0/write_cr0 too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -596,6 +596,123 @@ static int __init print_banner(void)
 	return 0;
 }
 core_initcall(print_banner);
+
+unsigned long paravirt_save_flags(void)
+{
+	return paravirt_ops.save_fl();
+}
+EXPORT_SYMBOL(paravirt_save_flags);
+
+void paravirt_restore_flags(unsigned long flags)
+{
+	paravirt_ops.restore_fl(flags);
+}
+EXPORT_SYMBOL(paravirt_restore_flags);
+
+void paravirt_irq_disable(void)
+{
+	paravirt_ops.irq_disable();
+}
+EXPORT_SYMBOL(paravirt_irq_disable);
+
+void paravirt_irq_enable(void)
+{
+	paravirt_ops.irq_enable();
+}
+EXPORT_SYMBOL(paravirt_irq_enable);
+
+void paravirt_io_delay(void)
+{
+	paravirt_ops.io_delay();
+}
+EXPORT_SYMBOL(paravirt_io_delay);
+
+void paravirt_const_udelay(unsigned long loops)
+{
+	paravirt_ops.const_udelay(loops);
+}
+EXPORT_SYMBOL(paravirt_const_udelay);
+
+u64 paravirt_read_msr(unsigned int msr, int *err)
+{
+	return paravirt_ops.read_msr(msr, err);
+}
+EXPORT_SYMBOL(paravirt_read_msr);
+
+int paravirt_write_msr(unsigned int msr, u64 val)
+{
+	return paravirt_ops.write_msr(msr, val);
+}
+EXPORT_SYMBOL(paravirt_write_msr);
+
+u64 paravirt_read_tsc(void)
+{
+	return paravirt_ops.read_tsc();
+}
+EXPORT_SYMBOL(paravirt_read_tsc);
+
+int paravirt_enabled(void)
+{
+	return paravirt_ops.paravirt_enabled;
+}
+EXPORT_SYMBOL(paravirt_enabled);
+
+void clts(void)
+{
+	paravirt_ops.clts();
+}
+EXPORT_SYMBOL(clts);
+
+unsigned long read_cr0(void)
+{
+	return paravirt_ops.read_cr0();
+}
+EXPORT_SYMBOL_GPL(read_cr0);
+
+void write_cr0(unsigned long cr0)
+{
+	paravirt_ops.write_cr0(cr0);
+}
+EXPORT_SYMBOL_GPL(write_cr0);
+
+void wbinvd(void)
+{
+	paravirt_ops.wbinvd();
+}
+EXPORT_SYMBOL(wbinvd);
+
+void raw_safe_halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+EXPORT_SYMBOL_GPL(raw_safe_halt);
+
+void halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+EXPORT_SYMBOL_GPL(halt);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+void apic_write(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write(reg,v);
+}
+EXPORT_SYMBOL_GPL(apic_write);
+
+unsigned long apic_read(unsigned long reg)
+{
+	return paravirt_ops.apic_read(reg);
+}
+EXPORT_SYMBOL_GPL(apic_read);
+#endif
+
+void __cpuid(unsigned int *eax, unsigned int *ebx,
+	     unsigned int *ecx, unsigned int *edx)
+{
+	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+}
+EXPORT_SYMBOL(__cpuid);
 
 /* We simply declare start_kernel to be the paravirt probe of last resort. */
 paravirt_probe(start_kernel);
@@ -712,11 +829,3 @@ struct paravirt_ops paravirt_ops = {
 
 	.startup_ipi_hook = (void *)native_nop,
 };
-
-/*
- * NOTE: CONFIG_PARAVIRT is experimental and the paravirt_ops
- * semantics are subject to change. Hence we only do this
- * internal-only export of this, until it gets sorted out and
- * all lowlevel CPU ops used by modules are separately exported.
- */
-EXPORT_SYMBOL_GPL(paravirt_ops);
===================================================================
--- a/include/asm-i386/delay.h
+++ b/include/asm-i386/delay.h
@@ -17,9 +17,9 @@ extern void __delay(unsigned long loops)
 extern void __delay(unsigned long loops);
 
 #if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
-#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+#define udelay(n) paravirt_const_udelay((n) * 0x10c7ul)
 
-#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+#define ndelay(n) paravirt_const_udelay((n) * 5ul)
 
 #else /* !PARAVIRT || USE_REAL_TIME_DELAY */
 
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -218,8 +218,6 @@ fastcall pgd_t native_make_pgd(unsigned 
 fastcall pgd_t native_make_pgd(unsigned long pgd);
 #endif
 
-#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
-
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
@@ -243,11 +241,8 @@ static inline void do_time_init(void)
 }
 
 /* The paravirtualized CPUID instruction. */
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-			   unsigned int *ecx, unsigned int *edx)
-{
-	paravirt_ops.cpuid(eax, ebx, ecx, edx);
-}
+void __cpuid(unsigned int *eax, unsigned int *ebx,
+	     unsigned int *ecx, unsigned int *edx);
 
 /*
  * These special macros can be used to get or set a debugging register
@@ -255,11 +250,6 @@ static inline void __cpuid(unsigned int 
 #define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
 #define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
 
-#define clts() paravirt_ops.clts()
-
-#define read_cr0() paravirt_ops.read_cr0()
-#define write_cr0(x) paravirt_ops.write_cr0(x)
-
 #define read_cr2() paravirt_ops.read_cr2()
 #define write_cr2(x) paravirt_ops.write_cr2(x)
 
@@ -272,62 +262,51 @@ static inline void __cpuid(unsigned int 
 
 #define raw_ptep_get_and_clear(xp)	(paravirt_ops.ptep_get_and_clear(xp))
 
-static inline void raw_safe_halt(void)
-{
-	paravirt_ops.safe_halt();
-}
-
-static inline void halt(void)
-{
-	paravirt_ops.safe_halt();
-}
-#define wbinvd() paravirt_ops.wbinvd()
-
 #define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
 
 #define rdmsr(msr,val1,val2) do {				\
 	int _err;						\
-	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	u64 _l = paravirt_read_msr(msr,&_err);			\
 	val1 = (u32)_l;						\
 	val2 = _l >> 32;					\
 } while(0)
 
 #define wrmsr(msr,val1,val2) do {				\
 	u64 _l = ((u64)(val2) << 32) | (val1);			\
-	paravirt_ops.write_msr((msr), _l);			\
+	paravirt_write_msr((msr), _l);				\
 } while(0)
 
 #define rdmsrl(msr,val) do {					\
 	int _err;						\
-	val = paravirt_ops.read_msr((msr),&_err);		\
+	val = paravirt_read_msr((msr),&_err);			\
 } while(0)
 
-#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+#define wrmsrl(msr,val) (paravirt_write_msr((msr),(val)))
 #define wrmsr_safe(msr,a,b) ({					\
 	u64 _l = ((u64)(b) << 32) | (a);			\
-	paravirt_ops.write_msr((msr),_l);			\
+	paravirt_write_msr((msr),_l);				\
 })
 
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr,a,b) ({					\
 	int _err;						\
-	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	u64 _l = paravirt_read_msr(msr,&_err);			\
 	(*a) = (u32)_l;						\
 	(*b) = _l >> 32;					\
 	_err; })
 
 #define rdtsc(low,high) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = paravirt_read_tsc();				\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
 
 #define rdtscl(low) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = paravirt_read_tsc();				\
 	low = (int)_l;						\
 } while(0)
 
-#define rdtscll(val) (val = paravirt_ops.read_tsc())
+#define rdtscll(val) (val = paravirt_read_tsc())
 
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
@@ -364,35 +343,7 @@ static inline void halt(void)
 #define pmd_val(x)	paravirt_ops.pmd_val(x)
 #endif
 
-/* The paravirtualized I/O functions */
-static inline void slow_down_io(void) {
-	paravirt_ops.io_delay();
-#ifdef REALLY_SLOW_IO
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-#endif
-}
-
 #ifdef CONFIG_X86_LOCAL_APIC
-/*
- * Basic functions accessing APICs.
- */
-static inline void apic_write(unsigned long reg, unsigned long v)
-{
-	paravirt_ops.apic_write(reg,v);
-}
-
-static inline void apic_write_atomic(unsigned long reg, unsigned long v)
-{
-	paravirt_ops.apic_write_atomic(reg,v);
-}
-
-static inline unsigned long apic_read(unsigned long reg)
-{
-	return paravirt_ops.apic_read(reg);
-}
-
 static inline void setup_boot_clock(void)
 {
 	paravirt_ops.setup_boot_clock();
@@ -489,6 +440,46 @@ static inline void pte_update_defer(stru
 	paravirt_ops.pte_update_defer(mm, addr, ptep);
 }
 
+/* These are the functions exported to modules. */
+int paravirt_enabled(void);
+unsigned long paravirt_save_flags(void);
+void paravirt_restore_flags(unsigned long flags);
+void paravirt_irq_disable(void);
+void paravirt_irq_enable(void);
+void paravirt_const_udelay(unsigned long loops);
+u64 paravirt_read_msr(unsigned int msr, int *err);
+int paravirt_write_msr(unsigned int msr, u64 val);
+u64 paravirt_read_tsc(void);
+void raw_safe_halt(void);
+void halt(void);
+void wbinvd(void);
+void paravirt_io_delay(void);
+static inline void slow_down_io(void) {
+	paravirt_io_delay();
+#ifdef REALLY_SLOW_IO
+	paravirt_io_delay();
+	paravirt_io_delay();
+	paravirt_io_delay();
+#endif
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * Basic functions accessing APICs.
+ */
+void apic_write(unsigned long reg, unsigned long v);
+static inline void apic_write_atomic(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write_atomic(reg,v);
+}
+unsigned long apic_read(unsigned long reg);
+#endif
+
+/* These will be unexported once raid6 is fixed... */
+void clts(void);
+unsigned long read_cr0(void);
+void write_cr0(unsigned long);
+
 #ifdef CONFIG_X86_PAE
 static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
 {
@@ -551,42 +542,38 @@ static inline unsigned long __raw_local_
 	unsigned long f;
 
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
-					   "call *%1;"
+					   "call paravirt_save_flags;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
-			     : "=a"(f): "m"(paravirt_ops.save_fl)
-			     : "memory", "cc");
+			     : "=a"(f) : : "memory", "cc");
 	return f;
 }
 
 static inline void raw_local_irq_restore(unsigned long f)
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
-					   "call *%1;"
+					   "call paravirt_restore_flags;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
-			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
-			     : "memory", "cc");
+			     : "=a"(f) : "0"(f) : "memory", "cc");
 }
 
 static inline void raw_local_irq_disable(void)
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
-					   "call *%0;"
+					   "call paravirt_irq_disable;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_disable)
-			     : "memory", "eax", "cc");
+			     : : : "memory", "eax", "cc");
 }
 
 static inline void raw_local_irq_enable(void)
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
-					   "call *%0;"
+					   "call paravirt_irq_enable;"
 					   "popl %%edx; popl %%ecx",
 					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_enable)
-			     : "memory", "eax", "cc");
+			     : : : "memory", "eax", "cc");
 }
 
 static inline unsigned long __raw_local_irq_save(void)
@@ -594,15 +581,13 @@ static inline unsigned long __raw_local_
 	unsigned long f;
 
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
-					   "call *%1; pushl %%eax;"
-					   "call *%2; popl %%eax;"
-					   "popl %%edx; popl %%ecx",
+					   "call paravirt_save_flags;"
+					   "pushl %%eax;"
+					   "call paravirt_irq_disable;"
+					   "popl %%eax;popl %%edx; popl %%ecx",
 					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
 					  CLBR_NONE)
-			     : "=a"(f)
-			     : "m" (paravirt_ops.save_fl),
-			       "m" (paravirt_ops.irq_disable)
-			     : "memory", "cc");
+			     : "=a"(f) : : "memory", "cc");
 	return f;
 }
 
===================================================================
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -74,11 +74,11 @@
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-#define safe_halt()						\
-	do {							\
-		trace_hardirqs_on();				\
-		raw_safe_halt();				\
-	} while (0)
+static inline void safe_halt(void)
+{
+	trace_hardirqs_on();
+	raw_safe_halt();
+}
 
 #define local_save_flags(flags)		raw_local_save_flags(flags)
 
===================================================================
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1174,6 +1174,8 @@ struct page *follow_page(struct vm_area_
 #define FOLL_GET	0x04	/* do get_page on page */
 #define FOLL_ANON	0x08	/* give ZERO_PAGE if no pgtable */
 
+unsigned long __follow_page(void *vaddr);
+
 #ifdef CONFIG_PROC_FS
 void vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
===================================================================
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -976,6 +976,17 @@ no_page_table:
 	return page;
 }
 
+/* You don't want to use this function.  It's for drm_memory.c. */
+unsigned long __follow_page(void *vaddr)
+{
+	pgd_t *pgd = pgd_offset_k((unsigned long)vaddr);
+	pud_t *pud = pud_offset(pgd, (unsigned long)vaddr);
+	pmd_t *pmd = pmd_offset(pud, (unsigned long)vaddr);
+	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long)vaddr);
+	return pte_pfn(*ptep) << PAGE_SHIFT;
+}
+EXPORT_SYMBOL_GPL(__follow_page);
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)

-- 

