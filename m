Return-Path: <linux-kernel-owner+w=401wt.eu-S1751184AbXAFGZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXAFGZ3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 01:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXAFGZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 01:25:29 -0500
Received: from ozlabs.org ([203.10.76.45]:50760 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbXAFGZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 01:25:28 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <459EEDEB.8090800@vmware.com>
References: <20070106000715.GA6688@elte.hu>  <459EEDEB.8090800@vmware.com>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 17:25:10 +1100
Message-Id: <1168064710.20372.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 16:31 -0800, Zachary Amsden wrote:
> Ingo Molnar wrote:
> > Subject: [patch] paravirt: isolate module ops
> > From: Ingo Molnar <mingo@elte.hu>
> >
> > only export those operations to modules that have been available to them 
> > historically: irq disable/enable, io-delay, udelay, etc.
> >
> > this isolates that functionality from other paravirtualization 
> > functionality that modules have no business messing with.
> >
> > boot and build tested with CONFIG_PARAVIRT=y.
> >
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > ---
> >  arch/i386/kernel/paravirt.c |   41 +++++++++++++++++++++++++++
> >  include/asm-i386/delay.h    |    4 +-
> >  include/asm-i386/paravirt.h |   65 ++++++++++++++++++++++----------------------
> >  3 files changed, 75 insertions(+), 35 deletions(-)
> >
> > Index: linux/arch/i386/kernel/paravirt.c
> > ===================================================================
> > --- linux.orig/arch/i386/kernel/paravirt.c
> > +++ linux/arch/i386/kernel/paravirt.c
> > @@ -492,6 +492,7 @@ struct paravirt_ops paravirt_ops = {
> >  
> >   	.patch = native_patch,
> >  	.banner = default_banner,
> > +
> >  	.arch_setup = native_nop,
> >  	.memory_setup = machine_specific_memory_setup,
> >  	.get_wallclock = native_get_wallclock,
> > @@ -566,4 +567,42 @@ struct paravirt_ops paravirt_ops = {
> >  	.irq_enable_sysexit = native_irq_enable_sysexit,
> >  	.iret = native_iret,
> >  };
> > -EXPORT_SYMBOL(paravirt_ops);
> > +
> > +/*
> > + * These are exported to modules:
> > + */
> > +struct paravirt_ops paravirt_mod_ops = {
> > +	.name = "bare hardware",
> > +	.paravirt_enabled = 0,
> > +	.kernel_rpl = 0,
> > +
> > + 	.patch = native_patch,
> >   
> 
> I don't think you want to leave that one... patching the kernel isn't 
> something modules should be doing.

Yeah, this patch is terrible, but I know why Ingo did it; it's my fault
for not finishing my version yesterday (but allmodconfig takes a while
to build and every change to paravirt.h rebuilds the universe...).

So here's my variant, compile-tested with "make allmodconfig".  Exports
individual functions, some of which can be reduced over time as the
modules involved are whacked into shape.

Note: it reduces the patching space by 1 byte (direct jumps vs indirect
jumps).  If this a problem for any paravirt_ops backend in practice, we
can add noops...

Cheers,
Rusty.
PS.  May break with other configurations...

Name: don't export paravirt_ops structure, do individual functions

Some of the more obscure ones are only used by one or two modules.
We can almost certainly reduce them with more work.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 48f31ae5d7b5 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Sat Jan 06 10:32:24 2007 +1100
+++ b/arch/i386/kernel/paravirt.c	Sat Jan 06 17:23:12 2007 +1100
@@ -596,6 +596,154 @@ static int __init print_banner(void)
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
+EXPORT_SYMBOL(read_cr0);
+
+void write_cr0(unsigned long cr0)
+{
+	paravirt_ops.write_cr0(cr0);
+}
+EXPORT_SYMBOL(write_cr0);
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
+EXPORT_SYMBOL(raw_safe_halt);
+
+void halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+EXPORT_SYMBOL(halt);
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
+#ifdef CONFIG_X86_PAE
+unsigned long long pgd_val(pgd_t x)
+{
+	return paravirt_ops.pgd_val(x);
+}
+unsigned long long pte_val(pte_t x)
+{
+	return paravirt_ops.pte_val(x);
+}
+pte_t __pte(unsigned long long x)
+{
+	return paravirt_ops.make_pte(x);
+}
+#else
+unsigned long pgd_val(pgd_t x)
+{
+	return paravirt_ops.pgd_val(x);
+}
+unsigned long pte_val(pte_t x)
+{
+	return paravirt_ops.pte_val(x);
+}
+pte_t __pte(unsigned long x)
+{
+	return paravirt_ops.make_pte(x);
+}
+#endif
+EXPORT_SYMBOL_GPL(pgd_val);
+EXPORT_SYMBOL_GPL(pte_val);
+EXPORT_SYMBOL_GPL(__pte);
 
 /* We simply declare start_kernel to be the paravirt probe of last resort. */
 paravirt_probe(start_kernel);
@@ -710,4 +858,3 @@ struct paravirt_ops paravirt_ops = {
 
 	.startup_ipi_hook = (void *)native_nop,
 };
-EXPORT_SYMBOL(paravirt_ops);
diff -r 48f31ae5d7b5 include/asm-i386/delay.h
--- a/include/asm-i386/delay.h	Sat Jan 06 10:32:24 2007 +1100
+++ b/include/asm-i386/delay.h	Sat Jan 06 11:23:25 2007 +1100
@@ -17,9 +17,9 @@ extern void __delay(unsigned long loops)
 extern void __delay(unsigned long loops);
 
 #if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_TIME_DELAY)
-#define udelay(n) paravirt_ops.const_udelay((n) * 0x10c7ul)
+#define udelay(n) paravirt_const_udelay((n) * 0x10c7ul)
 
-#define ndelay(n) paravirt_ops.const_udelay((n) * 5ul)
+#define ndelay(n) paravirt_const_udelay((n) * 5ul)
 
 #else /* !PARAVIRT || USE_REAL_TIME_DELAY */
 
diff -r 48f31ae5d7b5 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Sat Jan 06 10:32:24 2007 +1100
+++ b/include/asm-i386/paravirt.h	Sat Jan 06 16:46:14 2007 +1100
@@ -198,6 +198,18 @@ extern struct paravirt_ops paravirt_ops;
 
 void native_pagetable_setup_start(pgd_t *pgd);
 
+/* These are the functions exported to modules. */
+unsigned long paravirt_save_flags(void);
+void paravirt_restore_flags(unsigned long flags);
+void paravirt_irq_disable(void);
+void paravirt_irq_enable(void);
+void paravirt_const_udelay(unsigned long loops);
+void paravirt_io_delay(void);
+u64 paravirt_read_msr(unsigned int msr, int *err);
+int paravirt_write_msr(unsigned int msr, u64 val);
+u64 paravirt_read_tsc(void);
+int paravirt_enabled(void);
+
 #ifdef CONFIG_X86_PAE
 fastcall unsigned long long native_pte_val(pte_t);
 fastcall unsigned long long native_pmd_val(pmd_t);
@@ -216,8 +228,6 @@ fastcall pgd_t native_make_pgd(unsigned 
 fastcall pgd_t native_make_pgd(unsigned long pgd);
 #endif
 
-#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
-
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
@@ -241,11 +251,8 @@ static inline void do_time_init(void)
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
@@ -253,10 +260,9 @@ static inline void __cpuid(unsigned int 
 #define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
 #define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
 
-#define clts() paravirt_ops.clts()
-
-#define read_cr0() paravirt_ops.read_cr0()
-#define write_cr0(x) paravirt_ops.write_cr0(x)
+void clts(void);
+unsigned long read_cr0(void);
+void write_cr0(unsigned long);
 
 #define read_cr2() paravirt_ops.read_cr2()
 #define write_cr2(x) paravirt_ops.write_cr2(x)
@@ -270,62 +276,55 @@ static inline void __cpuid(unsigned int 
 
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
+void raw_safe_halt(void);
+void halt(void);
+void wbinvd(void);
 
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
 
@@ -351,11 +350,18 @@ static inline void halt(void)
 	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
 #define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
 
-#define __pte(x)	paravirt_ops.make_pte(x)
+/* FIXME: drivers/char/drm/drm_memory.h wants access to these. */
+#ifdef CONFIG_X86_PAE
+unsigned long long pgd_val(pgd_t x);
+unsigned long long pte_val(pte_t x);
+pte_t __pte(unsigned long long x);
+#else
+unsigned long pgd_val(pgd_t x);
+unsigned long pte_val(pte_t x);
+pte_t __pte(unsigned long x);
+#endif
+
 #define __pgd(x)	paravirt_ops.make_pgd(x)
-
-#define pte_val(x)	paravirt_ops.pte_val(x)
-#define pgd_val(x)	paravirt_ops.pgd_val(x)
 
 #ifdef CONFIG_X86_PAE
 #define __pmd(x)	paravirt_ops.make_pmd(x)
@@ -363,12 +369,13 @@ static inline void halt(void)
 #endif
 
 /* The paravirtualized I/O functions */
+
 static inline void slow_down_io(void) {
-	paravirt_ops.io_delay();
+	paravirt_io_delay();
 #ifdef REALLY_SLOW_IO
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
+	paravirt_io_delay();
+	paravirt_io_delay();
+	paravirt_io_delay();
 #endif
 }
 
@@ -376,19 +383,12 @@ static inline void slow_down_io(void) {
 /*
  * Basic functions accessing APICs.
  */
-static inline void apic_write(unsigned long reg, unsigned long v)
-{
-	paravirt_ops.apic_write(reg,v);
-}
+void apic_write(unsigned long reg, unsigned long v);
+unsigned long apic_read(unsigned long reg);
 
 static inline void apic_write_atomic(unsigned long reg, unsigned long v)
 {
 	paravirt_ops.apic_write_atomic(reg,v);
-}
-
-static inline unsigned long apic_read(unsigned long reg)
-{
-	return paravirt_ops.apic_read(reg);
 }
 #endif
 
@@ -532,42 +532,38 @@ static inline unsigned long __raw_local_
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
@@ -575,15 +571,13 @@ static inline unsigned long __raw_local_
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
 
diff -r 48f31ae5d7b5 include/linux/irqflags.h
--- a/include/linux/irqflags.h	Sat Jan 06 10:32:24 2007 +1100
+++ b/include/linux/irqflags.h	Sat Jan 06 15:03:42 2007 +1100
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
 


