Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUGBTVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUGBTVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUGBTVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:21:13 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36816 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264853AbUGBTTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:19:52 -0400
Date: Fri, 2 Jul 2004 21:19:43 +0200 (MEST)
Message-Id: <200407021919.i62JJh0J004586@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm5] perfctr low-level documentation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch adds documentation for perfctr's low-level
drivers in Documentation/perfctr/. The internal API
between perfctr's low-level and high-level drivers
is described, as are the architecture-specific data
structures users use to control and inspect the counters.

The system call interface is not yet documented. I'm
considering Christoph Hellwig's suggestion of moving
the API back to /proc/<pid>/, but with multiple files
and open/read/write/mmap instead of ioctl. I believe I
can make that work, but it would take a couple of days
to implement properly. Please indicate if you would like
this change or not.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 Documentation/perfctr/low-level-api.txt   |  216 ++++++++++++++++++++++++++
 Documentation/perfctr/low-level-ppc32.txt |  164 ++++++++++++++++++++
 Documentation/perfctr/low-level-x86.txt   |  246 ++++++++++++++++++++++++++++++
 3 files changed, 626 insertions(+)

diff -ruN linux-2.6.7-mm5/Documentation/perfctr/low-level-api.txt linux-2.6.7-mm5.perfctr-low-level-docs/Documentation/perfctr/low-level-api.txt
--- linux-2.6.7-mm5/Documentation/perfctr/low-level-api.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-mm5.perfctr-low-level-docs/Documentation/perfctr/low-level-api.txt	2004-07-02 20:57:05.000000000 +0200
@@ -0,0 +1,216 @@
+$Id: low-level-api.txt,v 1.1 2004/07/02 18:57:05 mikpe Exp $
+
+PERFCTR LOW-LEVEL DRIVERS API
+=============================
+
+This document describes the common low-level API.
+See low-level-$ARCH.txt for architecture-specific documentation.
+
+General Model
+=============
+The model is that of a processor with:
+- A non-programmable clock-like counter, the "TSC".
+  The TSC frequency is assumed to be constant, but it is not
+  assumed to be identical to the core frequency.
+  The TSC may be absent.
+- A set of programmable counters, the "perfctrs" or "pmcs".
+  Control data may be per-counter, global, or both.
+  The counters are not assumed to be interchangeable.
+
+  A normal counter that simply counts events is referred to
+  as an "accumulation-mode" or "a-mode" counter. Its total
+  count is computed by adding the counts for the individual
+  periods during which the counter is active. Two per-counter
+  state variables are used for this: "sum", which is the
+  total count up to but not including the current period,
+  and "start", which records the value of the hardware counter
+  at the start of the current period. At the end of a period,
+  the hardware counter's value is read again, and the increment
+  relative the start value is added to the sum. This strategy
+  is used because it avoids a number of hardware problems.
+
+  A counter that has been programmed to generate an interrupt
+  on overflow is referred to as an "interrupt-mode" or "i-mode"
+  counter. I-mode counters are initialised to specific values,
+  and after overflowing are reset to their (re)start values.
+  The total event count is available just as for a-mode counters.
+
+  The set of counters may be empty, in which case only the
+  TSC (which must be present) can be sampled.
+
+Contents of <asm-$ARCH/perfctr.h>
+=================================
+
+"struct perfctr_sum_ctrs"
+-------------------------
+struct perfctr_sum_ctrs {
+	unsigned long long tsc;
+	unsigned long long pmc[..];	/* one per counter */
+};
+
+Architecture-specific container for counter values.
+Used in the kernel/user API, but not by the low-level drivers.
+
+"struct perfctr_cpu_control"
+----------------------------
+This struct includes at least the following fields:
+
+	unsigned int tsc_on;
+	unsigned int nractrs;		/* # of a-mode counters */
+	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int pmc_map[..];	/* one per counter: virt-to-phys mapping */
+	unsigned int evntsel[..];	/* one per counter: hw control data */
+	int ireset[..];			/* one per counter: i-mode (re)start value */
+
+Architecture-specific container for control data.
+Used both in the kernel/user API and by the low-level drivers
+(embedded in "struct perfctr_cpu_state").
+
+"tsc_on" is non-zero if the TSC should be sampled.
+
+"nractrs" is the number of a-mode counters, corresponding to
+elements 0..nractrs-1 in the per-counter arrays.
+
+"nrictrs" is the number of i-mode counters, corresponding to
+elements nractrs..nractrs+nrictrs-1 in the per-counter arrays.
+
+"nractrs+nrictrs" is the total number of counters to program
+and sample. A-mode and i-mode counters are separated in order
+to allow quick enumeration of either set, which is needed in
+some low-level driver operations.
+
+"pmc_map[]" maps each counter to its corresponding hardware counter
+identification. No two counters may map to the same hardware counter.
+This mapping is present because the hardware may have asymmetric
+counters or other addressing quirks, which means that a counter's index
+may not suffice to address its hardware counter.
+
+"evntsel[]" contains the per-counter control data. Architecture-specific
+global control data, if any, is placed in architecture-specific fields.
+
+"ireset[]" contains the (re)start values for the i-mode counters.
+Only indices nractrs..nractrs+nrictrs-1 are used.
+
+"struct perfctr_cpu_state"
+--------------------------
+This struct includes at least the following fields:
+
+	unsigned int cstatus;
+	unsigned int tsc_start;
+	unsigned long long tsc_sum;
+	struct {
+		unsigned int map;
+		unsigned int start;
+		unsigned long long sum;
+	} pmc[..];	/* one per counter; the size is not part of the user ABI */
+#ifdef __KERNEL__
+	struct perfctr_cpu_control control;
+#endif
+
+This type records the state and control data for a collection
+of counters. It is used by many low-level operations, and may
+be exported to user-space via mmap().
+
+"cstatus" is a re-encoding of control.tsc_on/nractrs/nrictrs,
+used because it reduces overheads in key low-level operations.
+Operations on cstatus values include:
+- unsigned int perfctr_mk_cstatus(unsigned int tsc_on, unsigned int nractrs, unsigned int nrictrs);
+  Construct a cstatus value.
+- unsigned int perfctr_cstatus_enabled(unsigned int cstatus);
+  Check if any part (tsc_on, nractrs, nrictrs) of the cstatus is non-zero.
+- int perfctr_cstatus_has_tsc(unsigned int cstatus);
+  Check if the tsc_on part of the cstatus is non-zero.
+- unsigned int perfctr_cstatus_nrctrs(unsigned int cstatus);
+  Retrieve nractrs+nrictrs from the cstatus.
+- unsigned int perfctr_cstatus_has_ictrs(unsigned int cstatus);
+  Check if the nrictrs part of cstatus is non-zero.
+
+"tsc_start" and "tsc_sum" record the state of the TSC.
+
+"pmc[]" contains the per-counter state, in the "start" and "sum"
+fields. The "map" field contains the corresponding hardware counter
+identification, from the counter's entry in "control.pmc_map[]";
+it is copied into pmc[] to reduce overheads in key low-level operations.
+
+"control" contains the control data which determines the
+behaviour of the counters.
+
+User-space overflow signal handler items
+----------------------------------------
+After a counter has overflowed, a user-space signal handler may
+be invoked with a "struct siginfo" identifying the source of the
+signal and the set of overflown counters.
+
+#define SI_PMC_OVF	..
+
+Value to be stored in "si.si_code".
+
+#define si_pmc_ovf_mask	..
+
+Field in which to store a bit-mask of the overflown counters.
+
+Kernel-internal API
+-------------------
+
+/* Driver init/exit.
+   perfctr_cpu_init() performs hardware detection and may fail. */
+extern int perfctr_cpu_init(void);
+extern void perfctr_cpu_exit(void);
+
+/* CPU type name. Set if perfctr_cpu_init() was successful. */
+extern char *perfctr_cpu_name;
+
+/* Hardware reservation. A high-level driver must reserve the
+   hardware before it may use it, and release it afterwards.
+   "service" is a unique string identifying the high-level driver.
+   perfctr_cpu_reserve() returns NULL on success; if another
+   high-level driver has reserved the hardware, then that
+   driver's "service" string is returned. */
+extern const char *perfctr_cpu_reserve(const char *service);
+extern void perfctr_cpu_release(const char *service);
+
+/* PRE: state has no running interrupt-mode counters.
+   Check that the new control data is valid.
+   Update the low-level driver's private control data.
+   is_global should be zero for per-process counters and non-zero
+   for global-mode counters.
+   Returns a negative error code if the control data is invalid. */
+extern int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global);
+
+/* Stop i-mode counters. Update sums and start values.
+   Read a-mode counters. Subtract from start and accumulate into sums.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_suspend(struct perfctr_cpu_state *state);
+
+/* Reset i-mode counters to their start values.
+   Write control registers.
+   Read a-mode counters and update their start values.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_resume(struct perfctr_cpu_state *state);
+
+/* Perform an efficient combined suspend/resume operation.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_sample(struct perfctr_cpu_state *state);
+
+/* The type of a perfctr overflow interrupt handler.
+   It will be called in IRQ context, with preemption disabled. */
+typedef void (*perfctr_ihandler_t)(unsigned long pc);
+
+/* Install a perfctr overflow interrupt handler.
+   Should be called after perfctr_cpu_reserve() but before
+   any counter state has been activated. */
+extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
+
+/* PRE: The state has been suspended and sampled by perfctr_cpu_suspend().
+   Should be called from the high-level driver's perfctr_ihandler_t,
+   and preemption must not have been enabled.
+   Identify which counters have overflown, reset their start values
+   from ireset[], and perform any necessary hardware cleanup.
+   Returns a bit-mask of the overflown counters. */
+extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
+
+/* Call perfctr_cpu_ireload() just before perfctr_cpu_resume() to
+   bypass internal caching and force a reload of the i-mode pmcs.
+   This ensures that perfctr_cpu_identify_overflow()'s state changes
+   are propagated to the hardware. */
+extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
diff -ruN linux-2.6.7-mm5/Documentation/perfctr/low-level-ppc32.txt linux-2.6.7-mm5.perfctr-low-level-docs/Documentation/perfctr/low-level-ppc32.txt
--- linux-2.6.7-mm5/Documentation/perfctr/low-level-ppc32.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-mm5.perfctr-low-level-docs/Documentation/perfctr/low-level-ppc32.txt	2004-07-02 20:57:05.000000000 +0200
@@ -0,0 +1,164 @@
+$Id: low-level-ppc32.txt,v 1.1 2004/07/02 18:57:05 mikpe Exp $
+
+PERFCTRS PPC32 LOW-LEVEL API
+============================
+
+See low-level-api.txt for the common low-level API.
+This document only describes ppc32-specific behaviour.
+For detailed hardware control register layouts, see
+the manufacturers' documentation.
+
+Supported processors
+====================
+- PowerPC 604, 604e, 604ev.
+- PowerPC 750/740, 750CX, 750FX, 750GX.
+- PowerPC 7400, 7410, 7451/7441, 7457/7447.
+- Any generic PowerPC with a timebase register.
+
+Contents of <asm-$ARCH/perfctr.h>
+=================================
+
+"struct perfctr_sum_ctrs"
+-------------------------
+struct perfctr_sum_ctrs {
+	unsigned long long tsc;
+	unsigned long long pmc[8];
+};
+
+The pmc[] array has room for 8 counters.
+
+"struct perfctr_cpu_control"
+----------------------------
+struct perfctr_cpu_control {
+	unsigned int tsc_on;
+	unsigned int nractrs;		/* # of a-mode counters */
+	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int pmc_map[8];
+	unsigned int evntsel[8];	/* one per counter, even on P5 */
+	int ireset[8];			/* [0,0x7fffffff], for i-mode counters */
+	struct {
+		unsigned int mmcr0;	/* sans PMC{1,2}SEL */
+		unsigned int mmcr2;	/* only THRESHMULT */
+		/* IABR/DABR/BAMR not supported */
+	} ppc;
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+The per-counter arrays have room for 8 elements.
+
+ireset[] values must be non-negative, since overflow occurs on
+the non-negative-to-negative transition.
+
+The ppc sub-struct contains PowerPC-specific control data:
+- mmcr0: global control data for the MMCR0 SPR; the event
+  selectors for PMC1 and PMC2 are in evntsel[], not in mmcr0
+- mmcr2: global control data for the MMCR2 SPR; only the
+  THRESHMULT field can be specified
+
+"struct perfctr_cpu_state"
+--------------------------
+struct perfctr_cpu_state {
+	unsigned int cstatus;
+	struct {	/* k1 is opaque in the user ABI */
+		unsigned int id;
+		int isuspend_cpu;
+	} k1;
+	/* The two tsc fields must be inlined. Placing them in a
+	   sub-struct causes unwanted internal padding on x86-64. */
+	unsigned int tsc_start;
+	unsigned long long tsc_sum;
+	struct {
+		unsigned int map;
+		unsigned int start;
+		unsigned long long sum;
+	} pmc[8];	/* the size is not part of the user ABI */
+#ifdef __KERNEL__
+	unsigned int ppc_mmcr[3];
+	struct perfctr_cpu_control control;
+#endif
+};
+
+The k1 sub-struct is used by the low-level driver for
+caching purposes. "id" identifies the control data, and
+"isuspend_cpu" identifies the CPU on which the i-mode
+counters were last suspended.
+
+The pmc[] array has room for 8 elements.
+
+ppc_mmcr[] is computed from control by the low-level driver,
+and provides the data for the MMCR0, MMCR1, and MMCR2 SPRs.
+
+User-space overflow signal handler items
+----------------------------------------
+#ifdef __KERNEL__
+#define SI_PMC_OVF	(__SI_FAULT|'P')
+#else
+#define SI_PMC_OVF	('P')
+#endif
+#define si_pmc_ovf_mask	_sifields._pad[0]
+
+Kernel-internal API
+-------------------
+
+In perfctr_cpu_update_control(), the is_global parameter
+is ignored. (It is only relevant for x86.)
+
+CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK is never defined.
+(It is only relevant for x86.)
+
+Overflow interrupt handling is not yet implemented.
+
+Processor-specific Notes
+========================
+
+General
+-------
+pmc_map[] contains a counter number, an integer between 0 and 5.
+It never contains an SPR number.
+
+Basic operation (the strategy for a-mode counters, caching
+control register contents, recording "suspend CPU" for i-mode
+counters) is the same as in the x86 driver.
+
+PowerPC 604/750/74xx
+--------------------
+These processors use similar hardware layouts, differing
+mainly in the number of counter and control registers.
+The set of available events differ greatly, but that only
+affects users, not the low-level driver itself.
+
+The hardware has 2 (604), 4 (604e/750/7400/7410), or 6
+(745x) counters (PMC1 to PMC6), and 1 (604), 2 (604e/750),
+or 3 (74xx) control registers (MMCR0 to MMCR2).
+
+MMCR0 contains global control bits, and the event selection
+fields for PMC1 and PMC2. MMCR1 contains event selection fields
+for PMC3-PMC6. MMCR2 contains the THRESHMULT flag, which
+specifies how MMCR0[THRESHOLD] should be scaled.
+
+In control.ppc.mmcr0, the PMC1SEL and PMC2SEL fields (0x00001FFF)
+are reserved. The PMXE flag (0x04000000) may only be set when
+the driver supports overflow interrupts.
+
+If FCECE or TRIGGER is set in MMCR0 on a 74xx processor, then
+MMCR0 can change asynchronously. The driver handles this, at
+the cost of some additional work in perfctr_cpu_suspend().
+Not setting these flags avoids that overhead.
+
+In control.ppc.mmcr2, only the THRESHMULT flag (0x80000000)
+may be set, and only on 74xx processors.
+
+The SIA (sampled instruction address) register is not used.
+The SDA (sampled data address) register is 604/604e-only,
+and is not used. The BAMR (breakpoint address mask) register
+is not used, but it is cleared by the driver.
+
+Generic PowerPC with timebase
+-----------------------------
+The driver supports any PowerPC as long as it has a timebase
+register, and the TB frequency is available via Open Firmware.
+In this case, the only valid usage mode is with tsc_on == 1
+and nractrs == nrictrs == 0 in the control data.
diff -ruN linux-2.6.7-mm5/Documentation/perfctr/low-level-x86.txt linux-2.6.7-mm5.perfctr-low-level-docs/Documentation/perfctr/low-level-x86.txt
--- linux-2.6.7-mm5/Documentation/perfctr/low-level-x86.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-mm5.perfctr-low-level-docs/Documentation/perfctr/low-level-x86.txt	2004-07-02 20:57:05.000000000 +0200
@@ -0,0 +1,246 @@
+$Id: low-level-x86.txt,v 1.1 2004/07/02 18:57:05 mikpe Exp $
+
+PERFCTRS X86 LOW-LEVEL API
+==========================
+
+See low-level-api.txt for the common low-level API.
+This document only describes x86-specific behaviour.
+For detailed hardware control register layouts, see
+the manufacturers' documentation.
+
+Supported processors
+====================
+- Intel P5, P5MMX, P6, P4.
+- AMD K7, K8. (P6 clones, with some changes)
+- Cyrix 6x86MX, MII, and III. (good P5 clones)
+- Centaur WinChip C6, 2, and 3. (bad P5 clones)
+- VIA C3. (bad P6 clone)
+- Any generic x86 with a TSC.
+
+Contents of <asm-$ARCH/perfctr.h>
+=================================
+
+"struct perfctr_sum_ctrs"
+-------------------------
+struct perfctr_sum_ctrs {
+	unsigned long long tsc;
+	unsigned long long pmc[18];
+};
+
+The pmc[] array has room for 18 counters.
+
+"struct perfctr_cpu_control"
+----------------------------
+struct perfctr_cpu_control {
+	unsigned int tsc_on;
+	unsigned int nractrs;		/* # of a-mode counters */
+	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int pmc_map[18];
+	unsigned int evntsel[18];	/* one per counter, even on P5 */
+	struct {
+		unsigned int escr[18];
+		unsigned int pebs_enable;	/* for replay tagging */
+		unsigned int pebs_matrix_vert;	/* for replay tagging */
+	} p4;
+	int ireset[18];			/* < 0, for i-mode counters */
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+The per-counter arrays have room for 18 elements.
+
+ireset[] values must be negative, since overflow occurs on
+the negative-to-non-negative transition.
+
+The p4 sub-struct contains P4-specific control data:
+- escr[]: the control data to write to the ESCR register
+  associatied with the counter
+- pebs_enable: the control data to write to the PEBS_ENABLE MSR
+- pebs_matrix_vert: the control data to write to the
+  PEBS_MATRIX_VERT MSR
+
+"struct perfctr_cpu_state"
+--------------------------
+struct perfctr_cpu_state {
+	unsigned int cstatus;
+	struct {	/* k1 is opaque in the user ABI */
+		unsigned int id;
+		int isuspend_cpu;
+	} k1;
+	/* The two tsc fields must be inlined. Placing them in a
+	   sub-struct causes unwanted internal padding on x86-64. */
+	unsigned int tsc_start;
+	unsigned long long tsc_sum;
+	struct {
+		unsigned int map;
+		unsigned int start;
+		unsigned long long sum;
+	} pmc[18];	/* the size is not part of the user ABI */
+#ifdef __KERNEL__
+	struct perfctr_cpu_control control;
+	unsigned int p4_escr_map[18];
+#endif
+};
+
+The k1 sub-struct is used by the low-level driver for
+caching purposes. "id" identifies the control data, and
+"isuspend_cpu" identifies the CPU on which the i-mode
+counters were last suspended.
+
+The pmc[] array has room for 18 elements.
+
+p4_escr_map[] is computed from control by the low-level driver,
+and provides the MSR number for the counter's associated ESCR.
+
+User-space overflow signal handler items
+----------------------------------------
+#ifdef __KERNEL__
+#define SI_PMC_OVF	(__SI_FAULT|'P')
+#else
+#define SI_PMC_OVF	('P')
+#endif
+#define si_pmc_ovf_mask	_sifields._pad[0]
+
+Kernel-internal API
+-------------------
+
+In perfctr_cpu_update_control(), the is_global parameter controls
+whether monitoring the other thread (T1) on HT P4s is permitted
+or not. On other processors the parameter is ignored.
+
+SMP kernels define CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK and
+"extern cpumask_t perfctr_cpus_forbidden_mask;".
+On HT P4s, resource conflicts can occur because both threads
+(T0 and T1) in a processor share the same perfctr registers.
+To prevent conflicts, only thread 0 in each processor is allowed
+to access the counters. perfctr_cpus_forbidden_mask contains the
+smp_processor_id()'s of each processor's thread 1, and it is the
+responsibility of the high-level driver to ensure that it never
+accesses the perfctr state from a forbidden thread.
+
+Overflow interrupt handling requires local APIC support in the kernel.
+
+Processor-specific Notes
+========================
+
+General
+-------
+pmc_map[] contains a counter number, as used by the RDPMC instruction.
+It never contains an MSR number.
+
+Counters are 32, 40, or 48 bits wide. The driver always only
+reads the low 32 bits. This avoids performance issues, and
+errata on some processors.
+
+Writing to counters or their control registers tends to be
+very expensive. This is why a-mode counters only use read
+operations on the counter registers. Caching of control
+register contents is done to avoid writing them. "Suspend CPU"
+is recorded for i-mode counters to avoid writing the counter
+registers when the counters are resumed (their control
+registers must be written at both suspend and resume, however).
+
+Some processors are unable to stop the counters (Centaur/VIA),
+and some are unable to reinitialise them to arbitrary values (P6).
+Storing the counters' total counts in the hardware counters
+would break as soon as context-switches occur. This is another
+reason why the accumulate-differences method for maintaining the
+counter values is used.
+
+Intel P5
+--------
+The hardware stores both counters' control data in a single
+control register, the CESR MSR. The evntsel values are
+limited to 16 bits each, and are combined by the low-level
+driver to form the value for the CESR. Apart from that,
+the evntsel values direct images of the CESR.
+
+Bits 0xFE00 in an evntsel value are reserved.
+At least one evntsel CPL bit (0x00C0) must be set.
+
+For Cyrix' P5 clones, evntsel bits 0xFA00  are reserved.
+
+For Centaur's P5 clones, evntsel bits 0xFF00 are reserved.
+It has no CPL bits to set. The TSC is broken and cannot be used.
+
+Intel P6
+--------
+The evntsel values are mapped directly onto the counters'
+EVNTSEL control registers.
+
+The global enable bit (22) in EVNTSEL0 must be set. That bit is
+reserved in EVNTSEL1.
+
+Bits 21 and 19 (0x00280000) in each evntsel are reserved.
+
+For an i-mode counter, bit 20 (0x00100000) of its evntsel must be
+set. For a-mode counters, that bit must not be set.
+
+Hardware quirk: Counters are 40 bits wide, but writing to a
+counter only writes the low 32 bits: remaining bits are
+sign-extended from bit 31.
+
+AMD K7/K8
+---------
+Similar to Intel P6. The main difference is that each evntsel has
+its own enable bit, which must be set.
+
+VIA C3
+------
+Superficially similar to Intel P6, but only PERFCTR1/EVNTSEL1
+are programmable. pmc_map[0] must be 1, if nractrs == 1.
+
+Bits 0xFFFFFE00 in the evntsel are reserved. There are no auxiliary
+control bits to set.
+
+Generic
+-------
+Only permits TSC sampling, with tsc_on == 1 and nractrs == nrictrs == 0
+in the control data.
+
+Intel P4
+--------
+For each counter, its evntsel[] value is mapped onto its CCCR
+control register, and its p4.escr[] value is mapped onto its
+associated ESCR control register.
+
+The ESCR register number is computed from the hardware counter
+number (from pmc_map[]) and the ESCR SELECT field in the CCCR,
+and is cached in p4_escr_map[].
+
+pmc_map[] contains the value to pass to RDPMC when reading the
+counter. It is strongly recommended to set bit 31 (fast rdpmc).
+
+In each evntsel/CCCR value:
+- the OVF, OVF_PMI_T1 and hardware-reserved bits (0xB80007FF)
+  are reserved and must not be set
+- bit 11 (EXTENDED_CASCADE) is only permitted on P4 models >= 2,
+  and for counters 12 and 15-17
+- bits 16 and 17 (ACTIVE_THREAD) must both be set on non-HT processors
+- at least one of bits 12 (ENABLE), 30 (CASCADE), or 11 (EXTENDED_CASCADE)
+  must be set
+- bit 26 (OVF_PMI_T0) must be clear for a-mode counters, and set
+  for i-mode counters; if bit 25 (FORCE_OVF) also is set, then
+  the corresponding ireset[] value must be exactly -1
+
+In each p4.escr[] value:
+- bit 32 is reserved and must not be set
+- the CPL_T1 field (bits 0 and 1) must be zero except on HT processors
+  when global-mode counters are used
+- IQ_ESCR0 and IQ_ESCR1 can only be used on P4 models <= 2
+
+PEBS is not supported, but the replay tagging bits in PEBS_ENABLE
+and PEBS_MATRIX_VERT may be used.
+
+If p4.pebs_enable is zero, then p4.pebs_matrix_vert must also be zero.
+
+If p4.pebs_enable is non-zero:
+- only bits 24, 10, 9, 2, 1, and 0 may be set; note that in contrast
+  to Intel's documentation, bit 25 (ENABLE_PEBS_MY_THR) is not needed
+  and must not be set
+- bit 24 (UOP_TAG) must be set
+- at least one of bits 10, 9, 2, 1, or 0 must be set
+- in p4.pebs_matrix_vert, all bits except 1 and 0 must be clear,
+  and at least one of bits 1 and 0 must be set
