Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWH3Sh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWH3Sh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWH3Sh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:37:57 -0400
Received: from mga06.intel.com ([134.134.136.21]:13133 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751301AbWH3Shy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:37:54 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,189,1154934000"; 
   d="scan'208"; a="117964592:sNHT2696121785"
Date: Wed, 30 Aug 2006 11:15:08 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3
Message-ID: <20060830111507.B30823@unix-os.sc.intel.com>
References: <39A055DD9BDD564FAF89ABDA9EB5F58512A76FE4@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <39A055DD9BDD564FAF89ABDA9EB5F58512A76FE4@scsmsx413.amr.corp.intel.com>; from venkatesh.pallipadi@intel.com on Mon, Aug 28, 2006 at 07:00:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 07:00:33PM -0700, Pallipadi, Venkatesh wrote:
>  
> 
> >-----Original Message-----
> >From: Benoit Boissinot [mailto:bboissin@gmail.com] 
> >Sent: Sunday, August 27, 2006 9:00 AM
> >To: Andrew Morton
> >Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Brown, Len
> >Subject: Re: 2.6.18-rc4-mm3
> >
> >On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
> >>
> >> 
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
> >.6.18-rc4/2.6.18-rc4-mm3/
> >>
> >>  git-acpi.patch
> >
> >commit f62d31ee2f2f453b07107465fea54540cab418eb broke my laptop
> >(pentium M, dell D600).
> >I can reliably get a hard lockup (no sysrq) when modprobing ehci_hcd
> >and uhci_hci. It works when reverting the changeset.
> >
> >I can provide cpuinfo or dmesg if necessary.
> >
> >regards,
> >
> >Benoit
> 
> Thanks Benoit for identifying the problem with this patch and reporting
> it. I was able to reproduce it on a system locally and I have tracked
> down the problem. I will send out the updated patch soon and cc it to
> you. 
> 
> Thanks,
> Venki

Benoit,

Attached is the updated patch. Please test it on your system whenever you get
a chance. ACPI C-states and /proc/acpi/processor/*/power should show similar
numbers with or without this patch. It should not hang as before.

Thanks,
Venki


Below is tha patch to support Processor Native C-state using "mwait"
instruction on Intel processors.

Background:
Newer Intel processors (eg: Core Duo), support processor native C-state using
mwait instructions.
Refer: Intel Architecture Software Developer's Manual
http://www.intel.com/design/Pentium4/manuals/253668.htm

Platform firmware exports the support for Native C-state to OS using
ACPI _PDC and _CST methods.
Refer: Intel Processor Vendor-Specific ACPI: Interface Specification
http://www.intel.com/technology/iapc/acpi/downloads/302223.htm


With Processor Native C-state, we use 'mwait' instruction on the processor to
enter different C-states (C1, C2, C3). We won't use the special IO ports to
enter C-state and no SMM mode etc required to enter C-state. Overall this 
will mean better C-state support. 
One major advantage of using mwait for all C-states is, with this and 
"treat interrupt as break event" feature of mwait, we can now get
accurate timing for the time spent in C1, C2, .. states. 

The patch below adds support for both i386 and x86-64 kernels.

Patch against 2.6.18-rc4.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.18-rc4/arch/i386/kernel/acpi/cstate.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/kernel/acpi/cstate.c
+++ linux-2.6.18-rc4/arch/i386/kernel/acpi/cstate.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 
 #include <acpi/processor.h>
 #include <asm/acpi.h>
@@ -41,5 +42,124 @@ void acpi_processor_power_init_bm_check(
 		flags->bm_check = 1;
 	}
 }
-
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
+
+/* The code below handles cstate entry with monitor-mwait pair on Intel*/
+
+struct cstate_entry_s {
+	struct {
+		unsigned int eax;
+		unsigned int ecx;
+	} states[ACPI_PROCESSOR_MAX_POWER];
+};
+static struct cstate_entry_s *cpu_cstate_entry;	/* per CPU ptr */
+
+static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
+
+#define MWAIT_SUBSTATE_MASK	(0xf)
+#define MWAIT_SUBSTATE_SIZE	(4)
+
+#define CPUID_MWAIT_LEAF (5)
+#define CPUID5_ECX_EXTENSIONS_SUPPORTED (0x1)
+#define CPUID5_ECX_INTERRUPT_BREAK	(0x2)
+
+#define MWAIT_ECX_INTERRUPT_BREAK	(0x1)
+
+#define NATIVE_CSTATE_BEYOND_HALT	(2)
+
+int acpi_processor_ffh_cstate_probe(unsigned int cpu,
+		struct acpi_processor_cx *cx, struct acpi_power_register *reg)
+{
+	struct cstate_entry_s *percpu_entry;
+	struct cpuinfo_x86 *c = cpu_data + cpu;
+
+	cpumask_t saved_mask;
+	int retval;
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int edx_part;
+	unsigned int cstate_type; /* C-state type and not ACPI C-state type */
+	unsigned int num_cstate_subtype;
+
+	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF )
+		return -1;
+
+	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
+		return -1;
+
+	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	percpu_entry->states[cx->index].eax = 0;
+	percpu_entry->states[cx->index].ecx = 0;
+
+	/* Make sure we are running on right CPU */
+	saved_mask = current->cpus_allowed;
+	retval = set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	if (retval)
+		return -1;
+
+	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+
+	/* Check whether this particular cx_type (in CST) is supported or not */
+	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
+	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
+	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
+
+	retval = 0;
+	if (num_cstate_subtype < (cx->address & MWAIT_SUBSTATE_MASK)) {
+		retval = -1;
+		goto out;
+	}
+
+	/* mwait ecx extensions INTERRUPT_BREAK should be supported for C2/C3 */
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
+	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK)) {
+		retval = -1;
+		goto out;
+	}
+	percpu_entry->states[cx->index].ecx = MWAIT_ECX_INTERRUPT_BREAK;
+
+	/* Use the hint in CST */
+	percpu_entry->states[cx->index].eax = cx->address;
+
+	if (!mwait_supported[cstate_type]) {
+		mwait_supported[cstate_type] = 1;
+		printk(KERN_DEBUG "Monitor-Mwait will be used to enter C-%d "
+		       "state\n", cx->type);
+	}
+
+out:
+	set_cpus_allowed(current, saved_mask);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
+
+void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
+{
+	unsigned int cpu = smp_processor_id();
+	struct cstate_entry_s *percpu_entry;
+
+	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
+	                      percpu_entry->states[cx->index].ecx);
+}
+EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
+
+static int __init ffh_cstate_init(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		return -1;
+
+	cpu_cstate_entry = alloc_percpu(struct cstate_entry_s);
+	return 0;
+}
+
+static void __exit ffh_cstate_exit(void)
+{
+	if (cpu_cstate_entry) {
+		free_percpu(cpu_cstate_entry);
+		cpu_cstate_entry = NULL;
+	}
+}
+
+arch_initcall(ffh_cstate_init);
+__exitcall(ffh_cstate_exit);
Index: linux-2.6.18-rc4/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/kernel/process.c
+++ linux-2.6.18-rc4/arch/i386/kernel/process.c
@@ -235,20 +235,28 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  * We execute MONITOR against need_resched and enter optimized wait state
  * through MWAIT. Whenever someone changes need_resched, we would be woken
  * up from MWAIT (without an IPI).
+ *
+ * New with Core Duo processors, MWAIT can take some hints based on CPU
+ * capability.
  */
-static void mwait_idle(void)
+void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
-	local_irq_enable();
-
-	while (!need_resched()) {
+	if (!need_resched()) {
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		smp_mb();
-		if (need_resched())
-			break;
-		__mwait(0, 0);
+		if (!need_resched())
+			__mwait(eax, ecx);
 	}
 }
 
+/* Default MONITOR/MWAIT with no hints, used for default C1 state */
+static void mwait_idle(void)
+{
+	local_irq_enable();
+	while (!need_resched())
+		mwait_idle_with_hints(0, 0);
+}
+
 void __devinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
Index: linux-2.6.18-rc4/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.18-rc4/arch/x86_64/kernel/process.c
@@ -235,20 +235,28 @@ void cpu_idle (void)
  * We execute MONITOR against need_resched and enter optimized wait state
  * through MWAIT. Whenever someone changes need_resched, we would be woken
  * up from MWAIT (without an IPI).
+ *
+ * New with Core Duo processors, MWAIT can take some hints based on CPU
+ * capability.
  */
-static void mwait_idle(void)
+void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
-	local_irq_enable();
-
-	while (!need_resched()) {
+	if (!need_resched()) {
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		smp_mb();
-		if (need_resched())
-			break;
-		__mwait(0, 0);
+		if (!need_resched())
+			__mwait(eax, ecx);
 	}
 }
 
+/* Default MONITOR/MWAIT with no hints, used for default C1 state */
+static void mwait_idle(void)
+{
+	local_irq_enable();
+	while (!need_resched())
+		mwait_idle_with_hints(0,0);
+}
+
 void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	static int printed;
Index: linux-2.6.18-rc4/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.18-rc4/drivers/acpi/processor_idle.c
@@ -218,6 +218,23 @@ static void acpi_safe_halt(void)
 
 static atomic_t c3_cpu_count;
 
+/* Common C-state entry for C2, C3, .. */
+static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
+{
+	if (cstate->space_id == ACPI_CSTATE_FFH) {
+		/* Call into architectural FFH based C-state */
+		acpi_processor_ffh_cstate_enter(cstate);
+	} else {
+		int unused;
+		/* IO port based C-state */
+		inb(cstate->address);
+		/* Dummy wait op - must do something useless after P_LVL2 read
+		   because chipsets cannot guarantee that STPCLK# signal
+		   gets asserted in time to freeze execution properly. */
+		unused = inl(acpi_fadt.xpm_tmr_blk.address);
+	}
+}
+
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr = NULL;
@@ -360,11 +377,7 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C2 */
-		inb(cx->address);
-		/* Dummy wait op - must do something useless after P_LVL2 read
-		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 
@@ -400,9 +413,7 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C3 */
-		inb(cx->address);
-		/* Dummy wait op (see above) */
-		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		if (pr->flags.bm_check) {
@@ -624,20 +635,16 @@ static int acpi_processor_get_power_info
 	return 0;
 }
 
-static int acpi_processor_get_power_info_default_c1(struct acpi_processor *pr)
+static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
 {
-
-	/* Zero initialize all the C-states info. */
-	memset(pr->power.states, 0, sizeof(pr->power.states));
-
-	/* set the first C-State to C1 */
-	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
-
-	/* the C0 state only exists as a filler in our array,
-	 * and all processors need to support C1 */
+	if (!pr->power.states[ACPI_STATE_C1].valid) {
+		/* set the first C-State to C1 */
+		/* all processors need to support C1 */
+		pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
+		pr->power.states[ACPI_STATE_C1].valid = 1;
+	}
+	/* the C0 state only exists as a filler in our array */
 	pr->power.states[ACPI_STATE_C0].valid = 1;
-	pr->power.states[ACPI_STATE_C1].valid = 1;
-
 	return 0;
 }
 
@@ -654,12 +661,7 @@ static int acpi_processor_get_power_info
 	if (nocst)
 		return -ENODEV;
 
-	current_count = 1;
-
-	/* Zero initialize C2 onwards and prepare for fresh CST lookup */
-	for (i = 2; i < ACPI_PROCESSOR_MAX_POWER; i++)
-		memset(&(pr->power.states[i]), 0, 
-				sizeof(struct acpi_processor_cx));
+	current_count = 0;
 
 	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -714,22 +716,39 @@ static int acpi_processor_get_power_info
 		    (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE))
 			continue;
 
-		cx.address = (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) ?
-		    0 : reg->address;
-
 		/* There should be an easy way to extract an integer... */
 		obj = (union acpi_object *)&(element->package.elements[1]);
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
 		cx.type = obj->integer.value;
+		/*
+		 * Some buggy BIOSes won't list C1 in _CST -
+		 * Let acpi_processor_get_power_info_default() handle them later
+		 */
+		if (i == 1 && cx.type != ACPI_STATE_C1)
+			current_count++;
 
-		if ((cx.type != ACPI_STATE_C1) &&
-		    (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO))
-			continue;
+		cx.address = reg->address;
+		cx.index = current_count + 1;
 
-		if ((cx.type < ACPI_STATE_C2) || (cx.type > ACPI_STATE_C3))
-			continue;
+		cx.space_id = ACPI_CSTATE_SYSTEMIO;
+		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
+			if (acpi_processor_ffh_cstate_probe
+					(pr->id, &cx, reg) == 0) {
+				cx.space_id = ACPI_CSTATE_FFH;
+			} else if (cx.type != ACPI_STATE_C1) {
+				/*
+				 * C1 is a special case where FIXED_HARDWARE
+				 * can be handled in non-MWAIT way as well.
+				 * In that case, save this _CST entry info.
+				 * That is, we retain space_id of SYSTEM_IO for
+				 * halt based C1.
+				 * Otherwise, ignore this info and continue.
+				 */
+				continue;
+			}
+		}
 
 		obj = (union acpi_object *)&(element->package.elements[2]);
 		if (obj->type != ACPI_TYPE_INTEGER)
@@ -934,12 +953,18 @@ static int acpi_processor_get_power_info
 	/* NOTE: the idle thread may not be running while calling
 	 * this function */
 
-	/* Adding C1 state */
-	acpi_processor_get_power_info_default_c1(pr);
+	/* Zero initialize all the C-states info. */
+	memset(pr->power.states, 0, sizeof(pr->power.states));
+
 	result = acpi_processor_get_power_info_cst(pr);
 	if (result == -ENODEV)
 		acpi_processor_get_power_info_fadt(pr);
 
+	if (result)
+		return result;
+
+	acpi_processor_get_power_info_default(pr);
+
 	pr->power.count = acpi_processor_power_verify(pr);
 
 	/*
Index: linux-2.6.18-rc4/include/acpi/pdc_intel.h
===================================================================
--- linux-2.6.18-rc4.orig/include/acpi/pdc_intel.h
+++ linux-2.6.18-rc4/include/acpi/pdc_intel.h
@@ -13,6 +13,7 @@
 #define ACPI_PDC_SMP_C_SWCOORD		(0x0040)
 #define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
 #define ACPI_PDC_C_C1_FFH		(0x0100)
+#define ACPI_PDC_C_C2C3_FFH		(0x0200)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
@@ -23,8 +24,10 @@
 					 ACPI_PDC_SMP_P_SWCOORD | \
 					 ACPI_PDC_P_FFH)
 
-#define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3 | \
-					 ACPI_PDC_SMP_C1PT | \
-					 ACPI_PDC_C_C1_HALT)
+#define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3  | \
+					 ACPI_PDC_SMP_C1PT  | \
+					 ACPI_PDC_C_C1_HALT | \
+					 ACPI_PDC_C_C1_FFH  | \
+					 ACPI_PDC_C_C2C3_FFH)
 
 #endif				/* __PDC_INTEL_H__ */
Index: linux-2.6.18-rc4/include/acpi/processor.h
===================================================================
--- linux-2.6.18-rc4.orig/include/acpi/processor.h
+++ linux-2.6.18-rc4/include/acpi/processor.h
@@ -29,6 +29,9 @@
 #define DOMAIN_COORD_TYPE_SW_ANY	0xfd
 #define DOMAIN_COORD_TYPE_HW_ALL	0xfe
 
+#define ACPI_CSTATE_SYSTEMIO	(0)
+#define ACPI_CSTATE_FFH		(1)
+
 /* Power Management */
 
 struct acpi_processor_cx;
@@ -58,6 +61,8 @@ struct acpi_processor_cx {
 	u8 valid;
 	u8 type;
 	u32 address;
+	u8 space_id;
+	u8 index;
 	u32 latency;
 	u32 latency_ticks;
 	u32 power;
@@ -206,6 +211,9 @@ void arch_acpi_processor_init_pdc(struct
 #ifdef ARCH_HAS_POWER_INIT
 void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 					unsigned int cpu);
+int acpi_processor_ffh_cstate_probe(unsigned int cpu,
+		struct acpi_processor_cx *cx, struct acpi_power_register *reg);
+void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -214,6 +222,16 @@ static inline void acpi_processor_power_
 	flags->bm_check = 1;
 	return;
 }
+static inline int acpi_processor_ffh_cstate_probe(unsigned int cpu,
+		struct acpi_processor_cx *cx, struct acpi_power_register *reg)
+{
+	return -1;
+}
+static inline void acpi_processor_ffh_cstate_enter(
+		struct acpi_processor_cx *cstate)
+{
+	return;
+}
 #endif
 
 /* in processor_perflib.c */
Index: linux-2.6.18-rc4/include/asm-i386/processor.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-i386/processor.h
+++ linux-2.6.18-rc4/include/asm-i386/processor.h
@@ -312,6 +312,8 @@ static inline void __mwait(unsigned long
 		: :"a" (eax), "c" (ecx));
 }
 
+extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
+
 /* from system description table in BIOS.  Mostly for MCA use, but
 others may find it useful. */
 extern unsigned int machine_id;
Index: linux-2.6.18-rc4/include/asm-x86_64/processor.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-x86_64/processor.h
+++ linux-2.6.18-rc4/include/asm-x86_64/processor.h
@@ -469,6 +469,8 @@ static inline void __mwait(unsigned long
 		: :"a" (eax), "c" (ecx));
 }
 
+extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
+
 #define stack_current() \
 ({								\
 	struct thread_info *ti;					\
