Return-Path: <linux-kernel-owner+w=401wt.eu-S1751036AbXAFRmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXAFRmu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXAFRmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:42:49 -0500
Received: from ozlabs.org ([203.10.76.45]:55090 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbXAFRms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:42:48 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20070106070807.GA11232@elte.hu>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>
	 <1168064710.20372.28.camel@localhost.localdomain>
	 <20070106070807.GA11232@elte.hu>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 04:42:33 +1100
Message-Id: <1168105353.20372.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 08:08 +0100, Ingo Molnar wrote:
> btw., your patch does not apply to current -git - could you please 
> rebase this patch to the head of your queue so that upstream can pick it 
> up?

OK, here it is against rc3-git4.

Name: don't export paravirt_ops structure, do individual functions

Wrap the paravirt_ops members we want to export in wrapper functions.
Since we binary-patch the critical ones, this doesn't make a speed
impact.

I moved drm_follow_page into the core, to avoid having to wrap the
various pte ops.  Unlining kernel_fpu_end and using that in the RAID6
code would remove the need to export clts/read_cr0/write_cr0 too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/arch/i386/kernel/paravirt.c working-2.6.20-rc3-git4/arch/i386/kernel/paravirt.c
--- linux-2.6.20-rc3-git4/arch/i386/kernel/paravirt.c	2007-01-07 03:41:32.000000000 +1100
+++ working-2.6.20-rc3-git4/arch/i386/kernel/paravirt.c	2007-01-07 04:21:59.000000000 +1100
@@ -482,6 +482,123 @@ static int __init print_banner(void)
 }
 core_initcall(print_banner);
 
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
+
 /* We simply declare start_kernel to be the paravirt probe of last resort. */
 paravirt_probe(start_kernel);
 
@@ -566,4 +683,3 @@ struct paravirt_ops paravirt_ops = {
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 };
-EXPORT_SYMBOL(paravirt_ops);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/drivers/char/drm/drm_memory.h working-2.6.20-rc3-git4/drivers/char/drm/drm_memory.h
--- linux-2.6.20-rc3-git4/drivers/char/drm/drm_memory.h	2006-09-22 15:36:13.000000000 +1000
+++ working-2.6.20-rc3-git4/drivers/char/drm/drm_memory.h	2007-01-07 04:19:07.000000000 +1100
@@ -58,11 +58,7 @@
 
 static inline unsigned long drm_follow_page(void *vaddr)
 {
-	pgd_t *pgd = pgd_offset_k((unsigned long)vaddr);
-	pud_t *pud = pud_offset(pgd, (unsigned long)vaddr);
-	pmd_t *pmd = pmd_offset(pud, (unsigned long)vaddr);
-	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long)vaddr);
-	return pte_pfn(*ptep) << PAGE_SHIFT;
+	return __follow_page(vaddr);
 }
 
 #else				/* __OS_HAS_AGP */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/include/asm-i386/delay.h working-2.6.20-rc3-git4/include/asm-i386/delay.h
--- linux-2.6.20-rc3-git4/include/asm-i386/delay.h	2007-01-07 03:42:32.000000000 +1100
+++ working-2.6.20-rc3-git4/include/asm-i386/delay.h	2007-01-07 04:08:46.000000000 +1100
@@ -17,9 +17,9 @@ extern void __const_udelay(unsigned long
 extern void __delay(unsigned long loops);
 
 #if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
-#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+#define udelay(n) paravirt_const_udelay((n) * 0x10c7ul)
 
-#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+#define ndelay(n) paravirt_const_udelay((n) * 5ul)
 
 #else /* !PARAVIRT || USE_REAL_TIME_DELAY */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/include/asm-i386/paravirt.h working-2.6.20-rc3-git4/include/asm-i386/paravirt.h
--- linux-2.6.20-rc3-git4/include/asm-i386/paravirt.h	2007-01-07 03:42:33.000000000 +1100
+++ working-2.6.20-rc3-git4/include/asm-i386/paravirt.h	2007-01-07 04:13:44.000000000 +1100
@@ -152,8 +152,6 @@ struct paravirt_ops
 
 extern struct paravirt_ops paravirt_ops;
 
-#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
-
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
@@ -177,11 +175,8 @@ static inline void do_time_init(void)
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
@@ -189,11 +184,6 @@ static inline void __cpuid(unsigned int 
 #define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
 #define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
 
-#define clts() paravirt_ops.clts()
-
-#define read_cr0() paravirt_ops.read_cr0()
-#define write_cr0(x) paravirt_ops.write_cr0(x)
-
 #define read_cr2() paravirt_ops.read_cr2()
 #define write_cr2(x) paravirt_ops.write_cr2(x)
 
@@ -204,62 +194,51 @@ static inline void __cpuid(unsigned int 
 #define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
 #define write_cr4(x) paravirt_ops.write_cr4(x)
 
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
 
@@ -345,6 +324,26 @@ static inline void pte_update_defer(stru
 	paravirt_ops.pte_update_defer(mm, addr, ptep);
 }
 
+/* These are the functions exported to modules. */
+int paravirt_enabled(void);
+unsigned long paravirt_save_flags(void);
+void paravirt_restore_flags(unsigned long flags);
+void paravirt_irq_disable(void);
+void paravirt_irq_enable(void);
+void paravirt_const_udelay(unsigned long loops);
+void paravirt_io_delay(void);
+u64 paravirt_read_msr(unsigned int msr, int *err);
+int paravirt_write_msr(unsigned int msr, u64 val);
+u64 paravirt_read_tsc(void);
+void raw_safe_halt(void);
+void halt(void);
+void wbinvd(void);
+
+/* These will be unexported once raid6 is fixed... */
+void clts(void);
+unsigned long read_cr0(void);
+void write_cr0(unsigned long);
+
 #ifdef CONFIG_X86_PAE
 static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
 {
@@ -394,42 +393,38 @@ static inline unsigned long __raw_local_
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
@@ -437,15 +432,13 @@ static inline unsigned long __raw_local_
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/include/linux/irqflags.h working-2.6.20-rc3-git4/include/linux/irqflags.h
--- linux-2.6.20-rc3-git4/include/linux/irqflags.h	2006-09-22 15:37:14.000000000 +1000
+++ working-2.6.20-rc3-git4/include/linux/irqflags.h	2007-01-07 04:08:46.000000000 +1100
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/include/linux/mm.h working-2.6.20-rc3-git4/include/linux/mm.h
--- linux-2.6.20-rc3-git4/include/linux/mm.h	2007-01-07 03:42:43.000000000 +1100
+++ working-2.6.20-rc3-git4/include/linux/mm.h	2007-01-07 04:20:41.000000000 +1100
@@ -1127,6 +1127,8 @@ struct page *follow_page(struct vm_area_
 #define FOLL_GET	0x04	/* do get_page on page */
 #define FOLL_ANON	0x08	/* give ZERO_PAGE if no pgtable */
 
+unsigned long __follow_page(void *vaddr);
+
 #ifdef CONFIG_PROC_FS
 void vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);
 #else
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.20-rc3-git4/mm/memory.c working-2.6.20-rc3-git4/mm/memory.c
--- linux-2.6.20-rc3-git4/mm/memory.c	2007-01-07 03:42:49.000000000 +1100
+++ working-2.6.20-rc3-git4/mm/memory.c	2007-01-07 04:19:20.000000000 +1100
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


