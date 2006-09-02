Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWIBBak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWIBBak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWIBBaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:30:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750767AbWIBBai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:30:38 -0400
Date: Fri, 1 Sep 2006 18:30:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Hentges <oe@hentges.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: 2.6.18-rc5-mm1
Message-Id: <20060901183028.1c6da4df.akpm@osdl.org>
In-Reply-To: <1157158847.20509.10.camel@mhcln03>
References: <20060901015818.42767813.akpm@osdl.org>
	<1157158847.20509.10.camel@mhcln03>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 03:00:47 +0200
Matthias Hentges <oe@hentges.net> wrote:

> 2.6.18-rc5-mm1 oopses on an Asus P5W DH Deluxe board, full dmesg
> attached.
> This did not happen in 2.6.18-rc4-mm3.
> 
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> Oops: 0000 [#1]
> 4K_STACKS SMP 
> last sysfs file: 
> Modules linked in:
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted VLI
> EFLAGS: 00010087   (2.6.18-rc5-mm1 #1) 
> EIP is at rest_init+0x3feffd78/0x20
> eax: 000000da   ebx: c04d5f78   ecx: c04d5f94   edx: c04d2f00
> esi: 000000da   edi: 00000000   ebp: c04d2f00   esp: c0516ffc
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, ti=c0516000 task=c045c200 task.ti=c04d5000)
> Stack: c0105027 
> Call Trace:
>  [<c0105027>] do_IRQ+0x8a/0xac
>  [<c01035a6>] common_interrupt+0x1a/0x20
>  [<c0101a72>] mwait_idle_with_hints+0x36/0x3b
>  [<c0101a83>] mwait_idle+0xc/0x1b
>  [<c0101a26>] cpu_idle+0x5e/0x74
>  [<c04db6fa>] start_kernel+0x363/0x36a
>  =======================
> Code:  Bad EIP value.
> EIP: [<00000000>] rest_init+0x3feffd78/0x20 SS:ESP 0068:c0516ffc
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
>  [<c010ca45>] smp_call_function+0x54/0xff
>  [<c011a270>] printk+0x12/0x16
>  [<c010cb03>] smp_send_stop+0x13/0x1c
>  [<c0119480>] panic+0x49/0xd3
>  [<c010410c>] die+0x273/0x28a
>  [<c01126d4>] do_page_fault+0x40d/0x4db
>  [<c01122c7>] do_page_fault+0x0/0x4db
>  [<c03d1231>] error_code+0x39/0x40
>  [<c013007b>] free_module+0x89/0xc3
>  [<c0105027>] do_IRQ+0x8a/0xac
>  [<c01035a6>] common_interrupt+0x1a/0x20
>  [<c0101a72>] mwait_idle_with_hints+0x36/0x3b
>  [<c0101a83>] mwait_idle+0xc/0x1b
>  [<c0101a26>] cpu_idle+0x5e/0x74
>  [<c04db6fa>] start_kernel+0x363/0x36a
>  =======================

OK, thanks.  That'll be acpi-mwait-c-state-fixes.patch.  I've uploaded the
below revert patch to
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/


diff -puN arch/i386/kernel/acpi/cstate.c~revert-acpi-mwait-c-state-fixes arch/i386/kernel/acpi/cstate.c
--- a/arch/i386/kernel/acpi/cstate.c~revert-acpi-mwait-c-state-fixes
+++ a/arch/i386/kernel/acpi/cstate.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
-#include <linux/cpu.h>
 
 #include <acpi/processor.h>
 #include <asm/acpi.h>
@@ -42,124 +41,5 @@ void acpi_processor_power_init_bm_check(
 		flags->bm_check = 1;
 	}
 }
-EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
-
-/* The code below handles cstate entry with monitor-mwait pair on Intel*/
-
-struct cstate_entry_s {
-	struct {
-		unsigned int eax;
-		unsigned int ecx;
-	} states[ACPI_PROCESSOR_MAX_POWER];
-};
-static struct cstate_entry_s *cpu_cstate_entry;	/* per CPU ptr */
-
-static short mwait_supported[ACPI_PROCESSOR_MAX_POWER];
-
-#define MWAIT_SUBSTATE_MASK	(0xf)
-#define MWAIT_SUBSTATE_SIZE	(4)
-
-#define CPUID_MWAIT_LEAF (5)
-#define CPUID5_ECX_EXTENSIONS_SUPPORTED (0x1)
-#define CPUID5_ECX_INTERRUPT_BREAK	(0x2)
-
-#define MWAIT_ECX_INTERRUPT_BREAK	(0x1)
-
-#define NATIVE_CSTATE_BEYOND_HALT	(2)
-
-int acpi_processor_ffh_cstate_probe(unsigned int cpu,
-		struct acpi_processor_cx *cx, struct acpi_power_register *reg)
-{
-	struct cstate_entry_s *percpu_entry;
-	struct cpuinfo_x86 *c = cpu_data + cpu;
-
-	cpumask_t saved_mask;
-	int retval;
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int edx_part;
-	unsigned int cstate_type; /* C-state type and not ACPI C-state type */
-	unsigned int num_cstate_subtype;
-
-	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF )
-		return -1;
-
-	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
-		return -1;
-
-	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
-	percpu_entry->states[cx->index].eax = 0;
-	percpu_entry->states[cx->index].ecx = 0;
-
-	/* Make sure we are running on right CPU */
-	saved_mask = current->cpus_allowed;
-	retval = set_cpus_allowed(current, cpumask_of_cpu(cpu));
-	if (retval)
-		return -1;
-
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
-
-	/* Check whether this particular cx_type (in CST) is supported or not */
-	cstate_type = (cx->address >> MWAIT_SUBSTATE_SIZE) + 1;
-	edx_part = edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
-	num_cstate_subtype = edx_part & MWAIT_SUBSTATE_MASK;
-
-	retval = 0;
-	if (num_cstate_subtype < (cx->address & MWAIT_SUBSTATE_MASK)) {
-		retval = -1;
-		goto out;
-	}
 
-	/* mwait ecx extensions INTERRUPT_BREAK should be supported for C2/C3 */
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
-	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK)) {
-		retval = -1;
-		goto out;
-	}
-	percpu_entry->states[cx->index].ecx = MWAIT_ECX_INTERRUPT_BREAK;
-
-	/* Use the hint in CST */
-	percpu_entry->states[cx->index].eax = cx->address;
-
-	if (!mwait_supported[cstate_type]) {
-		mwait_supported[cstate_type] = 1;
-		printk(KERN_DEBUG "Monitor-Mwait will be used to enter C-%d "
-		       "state\n", cx->type);
-	}
-
-out:
-	set_cpus_allowed(current, saved_mask);
-	return retval;
-}
-EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
-
-void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
-{
-	unsigned int cpu = smp_processor_id();
-	struct cstate_entry_s *percpu_entry;
-
-	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
-	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
-	                      percpu_entry->states[cx->index].ecx);
-}
-EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
-
-static int __init ffh_cstate_init(void)
-{
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-	if (c->x86_vendor != X86_VENDOR_INTEL)
-		return -1;
-
-	cpu_cstate_entry = alloc_percpu(struct cstate_entry_s);
-	return 0;
-}
-
-static void __exit ffh_cstate_exit(void)
-{
-	if (cpu_cstate_entry) {
-		free_percpu(cpu_cstate_entry);
-		cpu_cstate_entry = NULL;
-	}
-}
-
-arch_initcall(ffh_cstate_init);
-__exitcall(ffh_cstate_exit);
+EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
diff -puN arch/i386/kernel/process.c~revert-acpi-mwait-c-state-fixes arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c~revert-acpi-mwait-c-state-fixes
+++ a/arch/i386/kernel/process.c
@@ -236,28 +236,20 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  * We execute MONITOR against need_resched and enter optimized wait state
  * through MWAIT. Whenever someone changes need_resched, we would be woken
  * up from MWAIT (without an IPI).
- *
- * New with Core Duo processors, MWAIT can take some hints based on CPU
- * capability.
  */
-void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
+static void mwait_idle(void)
 {
-	if (!need_resched()) {
+	local_irq_enable();
+
+	while (!need_resched()) {
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		smp_mb();
-		if (!need_resched())
-			__mwait(eax, ecx);
+		if (need_resched())
+			break;
+		__mwait(0, 0);
 	}
 }
 
-/* Default MONITOR/MWAIT with no hints, used for default C1 state */
-static void mwait_idle(void)
-{
-	local_irq_enable();
-	while (!need_resched())
-		mwait_idle_with_hints(0, 0);
-}
-
 void __devinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_MWAIT)) {
diff -puN arch/x86_64/kernel/process.c~revert-acpi-mwait-c-state-fixes arch/x86_64/kernel/process.c
--- a/arch/x86_64/kernel/process.c~revert-acpi-mwait-c-state-fixes
+++ a/arch/x86_64/kernel/process.c
@@ -235,28 +235,20 @@ void cpu_idle (void)
  * We execute MONITOR against need_resched and enter optimized wait state
  * through MWAIT. Whenever someone changes need_resched, we would be woken
  * up from MWAIT (without an IPI).
- *
- * New with Core Duo processors, MWAIT can take some hints based on CPU
- * capability.
  */
-void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
+static void mwait_idle(void)
 {
-	if (!need_resched()) {
+	local_irq_enable();
+
+	while (!need_resched()) {
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		smp_mb();
-		if (!need_resched())
-			__mwait(eax, ecx);
+		if (need_resched())
+			break;
+		__mwait(0, 0);
 	}
 }
 
-/* Default MONITOR/MWAIT with no hints, used for default C1 state */
-static void mwait_idle(void)
-{
-	local_irq_enable();
-	while (!need_resched())
-		mwait_idle_with_hints(0,0);
-}
-
 void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
 	static int printed;
diff -puN drivers/acpi/processor_idle.c~revert-acpi-mwait-c-state-fixes drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~revert-acpi-mwait-c-state-fixes
+++ a/drivers/acpi/processor_idle.c
@@ -219,23 +219,6 @@ static void acpi_safe_halt(void)
 
 static atomic_t c3_cpu_count;
 
-/* Common C-state entry for C2, C3, .. */
-static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
-{
-	if (cstate->space_id == ACPI_CSTATE_FFH) {
-		/* Call into architectural FFH based C-state */
-		acpi_processor_ffh_cstate_enter(cstate);
-	} else {
-		int unused;
-		/* IO port based C-state */
-		inb(cstate->address);
-		/* Dummy wait op - must do something useless after P_LVL2 read
-		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		unused = inl(acpi_fadt.xpm_tmr_blk.address);
-	}
-}
-
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr = NULL;
@@ -378,7 +361,11 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C2 */
-		acpi_cstate_enter(cx);
+		inb(cx->address);
+		/* Dummy wait op - must do something useless after P_LVL2 read
+		   because chipsets cannot guarantee that STPCLK# signal
+		   gets asserted in time to freeze execution properly. */
+		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 
@@ -414,7 +401,9 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C3 */
-		acpi_cstate_enter(cx);
+		inb(cx->address);
+		/* Dummy wait op (see above) */
+		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		if (pr->flags.bm_check) {
@@ -639,16 +628,20 @@ static int acpi_processor_get_power_info
 	return 0;
 }
 
-static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
+static int acpi_processor_get_power_info_default_c1(struct acpi_processor *pr)
 {
-	if (!pr->power.states[ACPI_STATE_C1].valid) {
-		/* set the first C-State to C1 */
-		/* all processors need to support C1 */
-		pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
-		pr->power.states[ACPI_STATE_C1].valid = 1;
-	}
-	/* the C0 state only exists as a filler in our array */
+
+	/* Zero initialize all the C-states info. */
+	memset(pr->power.states, 0, sizeof(pr->power.states));
+
+	/* set the first C-State to C1 */
+	pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
+
+	/* the C0 state only exists as a filler in our array,
+	 * and all processors need to support C1 */
 	pr->power.states[ACPI_STATE_C0].valid = 1;
+	pr->power.states[ACPI_STATE_C1].valid = 1;
+
 	return 0;
 }
 
@@ -665,7 +658,12 @@ static int acpi_processor_get_power_info
 	if (nocst)
 		return -ENODEV;
 
-	current_count = 0;
+	current_count = 1;
+
+	/* Zero initialize C2 onwards and prepare for fresh CST lookup */
+	for (i = 2; i < ACPI_PROCESSOR_MAX_POWER; i++)
+		memset(&(pr->power.states[i]), 0, 
+				sizeof(struct acpi_processor_cx));
 
 	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -720,39 +718,22 @@ static int acpi_processor_get_power_info
 		    (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE))
 			continue;
 
+		cx.address = (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) ?
+		    0 : reg->address;
+
 		/* There should be an easy way to extract an integer... */
 		obj = (union acpi_object *)&(element->package.elements[1]);
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
 		cx.type = obj->integer.value;
-		/*
-		 * Some buggy BIOSes won't list C1 in _CST -
-		 * Let acpi_processor_get_power_info_default() handle them later
-		 */
-		if (i == 1 && cx.type != ACPI_STATE_C1)
-			current_count++;
 
-		cx.address = reg->address;
-		cx.index = current_count + 1;
+		if ((cx.type != ACPI_STATE_C1) &&
+		    (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO))
+			continue;
 
-		cx.space_id = ACPI_CSTATE_SYSTEMIO;
-		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-			if (acpi_processor_ffh_cstate_probe
-					(pr->id, &cx, reg) == 0) {
-				cx.space_id = ACPI_CSTATE_FFH;
-			} else if (cx.type != ACPI_STATE_C1) {
-				/*
-				 * C1 is a special case where FIXED_HARDWARE
-				 * can be handled in non-MWAIT way as well.
-				 * In that case, save this _CST entry info.
-				 * That is, we retain space_id of SYSTEM_IO for
-				 * halt based C1.
-				 * Otherwise, ignore this info and continue.
-				 */
-				continue;
-			}
-		}
+		if ((cx.type < ACPI_STATE_C2) || (cx.type > ACPI_STATE_C3))
+			continue;
 
 		obj = (union acpi_object *)&(element->package.elements[2]);
 		if (obj->type != ACPI_TYPE_INTEGER)
@@ -957,18 +938,12 @@ static int acpi_processor_get_power_info
 	/* NOTE: the idle thread may not be running while calling
 	 * this function */
 
-	/* Zero initialize all the C-states info. */
-	memset(pr->power.states, 0, sizeof(pr->power.states));
-
+	/* Adding C1 state */
+	acpi_processor_get_power_info_default_c1(pr);
 	result = acpi_processor_get_power_info_cst(pr);
 	if (result == -ENODEV)
 		acpi_processor_get_power_info_fadt(pr);
 
-	if (result)
-		return result;
-
-	acpi_processor_get_power_info_default(pr);
-
 	pr->power.count = acpi_processor_power_verify(pr);
 
 	/*
diff -puN include/acpi/pdc_intel.h~revert-acpi-mwait-c-state-fixes include/acpi/pdc_intel.h
--- a/include/acpi/pdc_intel.h~revert-acpi-mwait-c-state-fixes
+++ a/include/acpi/pdc_intel.h
@@ -13,7 +13,6 @@
 #define ACPI_PDC_SMP_C_SWCOORD		(0x0040)
 #define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
 #define ACPI_PDC_C_C1_FFH		(0x0100)
-#define ACPI_PDC_C_C2C3_FFH		(0x0200)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
 					 ACPI_PDC_C_C1_HALT | \
@@ -24,10 +23,8 @@
 					 ACPI_PDC_SMP_P_SWCOORD | \
 					 ACPI_PDC_P_FFH)
 
-#define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3  | \
-					 ACPI_PDC_SMP_C1PT  | \
-					 ACPI_PDC_C_C1_HALT | \
-					 ACPI_PDC_C_C1_FFH  | \
-					 ACPI_PDC_C_C2C3_FFH)
+#define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3 | \
+					 ACPI_PDC_SMP_C1PT | \
+					 ACPI_PDC_C_C1_HALT)
 
 #endif				/* __PDC_INTEL_H__ */
diff -puN include/acpi/processor.h~revert-acpi-mwait-c-state-fixes include/acpi/processor.h
--- a/include/acpi/processor.h~revert-acpi-mwait-c-state-fixes
+++ a/include/acpi/processor.h
@@ -29,9 +29,6 @@
 #define DOMAIN_COORD_TYPE_SW_ANY	0xfd
 #define DOMAIN_COORD_TYPE_HW_ALL	0xfe
 
-#define ACPI_CSTATE_SYSTEMIO	(0)
-#define ACPI_CSTATE_FFH		(1)
-
 /* Power Management */
 
 struct acpi_processor_cx;
@@ -61,8 +58,6 @@ struct acpi_processor_cx {
 	u8 valid;
 	u8 type;
 	u32 address;
-	u8 space_id;
-	u8 index;
 	u32 latency;
 	u32 latency_ticks;
 	u32 power;
@@ -211,9 +206,6 @@ void arch_acpi_processor_init_pdc(struct
 #ifdef ARCH_HAS_POWER_INIT
 void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 					unsigned int cpu);
-int acpi_processor_ffh_cstate_probe(unsigned int cpu,
-		struct acpi_processor_cx *cx, struct acpi_power_register *reg);
-void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -222,16 +214,6 @@ static inline void acpi_processor_power_
 	flags->bm_check = 1;
 	return;
 }
-static inline int acpi_processor_ffh_cstate_probe(unsigned int cpu,
-		struct acpi_processor_cx *cx, struct acpi_power_register *reg)
-{
-	return -1;
-}
-static inline void acpi_processor_ffh_cstate_enter(
-		struct acpi_processor_cx *cstate)
-{
-	return;
-}
 #endif
 
 /* in processor_perflib.c */
diff -puN include/asm-i386/processor.h~revert-acpi-mwait-c-state-fixes include/asm-i386/processor.h
--- a/include/asm-i386/processor.h~revert-acpi-mwait-c-state-fixes
+++ a/include/asm-i386/processor.h
@@ -306,8 +306,6 @@ static inline void __mwait(unsigned long
 		: :"a" (eax), "c" (ecx));
 }
 
-extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
-
 /* from system description table in BIOS.  Mostly for MCA use, but
 others may find it useful. */
 extern unsigned int machine_id;
diff -puN include/asm-x86_64/processor.h~revert-acpi-mwait-c-state-fixes include/asm-x86_64/processor.h
--- a/include/asm-x86_64/processor.h~revert-acpi-mwait-c-state-fixes
+++ a/include/asm-x86_64/processor.h
@@ -475,8 +475,6 @@ static inline void __mwait(unsigned long
 		: :"a" (eax), "c" (ecx));
 }
 
-extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
-
 #define stack_current() \
 ({								\
 	struct thread_info *ti;					\
_


-- 
VGER BF report: H 0
