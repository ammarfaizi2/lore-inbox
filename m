Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267985AbTAHXwL>; Wed, 8 Jan 2003 18:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267988AbTAHXwL>; Wed, 8 Jan 2003 18:52:11 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:20747 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267985AbTAHXvz>; Wed, 8 Jan 2003 18:51:55 -0500
Date: Thu, 9 Jan 2003 00:00:35 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: [PATCH] OProfile Pentium IV support
Message-ID: <20030109000035.GA53798@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18WQ7g-0005Lj-00*7jrKkUJ7xYM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a compile-tested-only port of Graydon Hoare's driver. Please
give it a test and report back.

Note that the #ifdef CONFIG_SMP would go away if we had a #define
smp_num_siblings 1 somewhere. linux/smp.h isn't really the right place
(it's arch-specific ...) but would do I suppose.

You'll need a recentish oprofile, e.g.
http://www.movement.uklinux.net/oprofile-0.5cvs.tar.gz

thanks,
john


diff -X dontdiff -Naur linux-linus/arch/i386/kernel/nmi.c linux/arch/i386/kernel/nmi.c
--- linux-linus/arch/i386/kernel/nmi.c	2003-01-03 03:06:40.000000000 +0000
+++ linux/arch/i386/kernel/nmi.c	2003-01-03 03:23:10.000000000 +0000
@@ -63,8 +63,6 @@
    CRU_ESCR0 (with any non-null event selector) through a complemented
    max threshold. [IA32-Vol3, Section 14.9.9] */
 #define MSR_P4_IQ_COUNTER0	0x30C
-#define MSR_P4_IQ_CCCR0		0x36C
-#define MSR_P4_CRU_ESCR0	0x3B8
 #define P4_NMI_CRU_ESCR0	(P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
 #define P4_NMI_IQ_CCCR0	\
 	(P4_CCCR_OVF_PMI|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/Makefile linux/arch/i386/oprofile/Makefile
--- linux-linus/arch/i386/oprofile/Makefile	2002-12-16 03:45:18.000000000 +0000
+++ linux/arch/i386/oprofile/Makefile	2003-01-08 23:04:14.000000000 +0000
@@ -7,4 +7,4 @@
 
 oprofile-y				:= $(DRIVER_OBJS) init.o timer_int.o
 oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
-					   op_model_ppro.o
+					   op_model_ppro.o op_model_p4.o
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/nmi_int.c linux/arch/i386/oprofile/nmi_int.c
--- linux-linus/arch/i386/oprofile/nmi_int.c	2003-01-03 03:06:40.000000000 +0000
+++ linux/arch/i386/oprofile/nmi_int.c	2003-01-08 23:04:07.000000000 +0000
@@ -214,12 +214,61 @@
 	.stop		= nmi_stop
 };
  
+
+#ifndef CONFIG_X86_64
+
+static int __init p4_init(enum oprofile_cpu * cpu)
+{
+	__u8 cpu_model = current_cpu_data.x86_model;
+
+	if (cpu_model > 3)
+		return 0;
+
+#ifndef CONFIG_SMP
+	*cpu = OPROFILE_CPU_P4;
+	model = &op_p4_spec;
+#else
+	switch (smp_num_siblings) {
+		case 1:
+			*cpu = OPROFILE_CPU_P4;
+			model = &op_p4_spec;
+			return 1;
+
+		case 2:
+			*cpu = OPROFILE_CPU_P4_HT2;
+			model = &op_p4_ht2_spec;
+			return 1;
+	}
+#endif
+
+	printk(KERN_INFO "oprofile: P4 HyperThreading detected with > 2 threads\n");
+	printk(KERN_INFO "oprofile: Reverting to timer mode.\n");
+	return 0;
+}
+
+
+static int __init ppro_init(enum oprofile_cpu * cpu)
+{
+	__u8 cpu_model = current_cpu_data.x86_model;
+
+	if (cpu_model > 5) {
+		*cpu = OPROFILE_CPU_PIII;
+	} else if (cpu_model > 2) {
+		*cpu = OPROFILE_CPU_PII;
+	} else {
+		*cpu = OPROFILE_CPU_PPRO;
+	}
+
+	model = &op_ppro_spec;
+	return 1;
+}
+
+#endif /* CONFIG_X86_64 */
  
 int __init nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
 {
 	__u8 vendor = current_cpu_data.x86_vendor;
 	__u8 family = current_cpu_data.x86;
-	__u8 cpu_model = current_cpu_data.x86_model;
  
 	if (!cpu_has_apic)
 		return 0;
@@ -235,21 +284,24 @@
  
 #ifndef CONFIG_X86_64
 		case X86_VENDOR_INTEL:
-			/* Less than a P6-class processor */
-			if (family != 6)
-				return 0;
-	 
-			if (cpu_model > 5) {
-				*cpu = OPROFILE_CPU_PIII;
-			} else if (cpu_model > 2) {
-				*cpu = OPROFILE_CPU_PII;
-			} else {
-				*cpu = OPROFILE_CPU_PPRO;
+			switch (family) {
+				/* Pentium IV */
+				case 0xf:
+					if (!p4_init(cpu))
+						return 0;
+					break;
+
+				/* A P6-class processor */
+				case 6:
+					if (!ppro_init(cpu))
+						return 0;
+					break;
+
+				default:
+					return 0;
 			}
- 
-			model = &op_ppro_spec;
 			break;
-#endif
+#endif /* CONFIG_X86_64 */
 
 		default:
 			return 0;
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_counter.h linux/arch/i386/oprofile/op_counter.h
--- linux-linus/arch/i386/oprofile/op_counter.h	2002-12-16 03:45:18.000000000 +0000
+++ linux/arch/i386/oprofile/op_counter.h	2003-01-03 03:07:21.000000000 +0000
@@ -10,7 +10,7 @@
 #ifndef OP_COUNTER_H
 #define OP_COUNTER_H
  
-#define OP_MAX_COUNTER 4
+#define OP_MAX_COUNTER 8
  
 /* Per-perfctr configuration as set via
  * oprofilefs.
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_model_p4.c linux/arch/i386/oprofile/op_model_p4.c
--- linux-linus/arch/i386/oprofile/op_model_p4.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/i386/oprofile/op_model_p4.c	2003-01-08 23:02:13.000000000 +0000
@@ -0,0 +1,669 @@
+/**
+ * @file op_model_p4.c
+ * P4 model-specific MSR operations
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author Graydon Hoare
+ */
+
+#include <linux/oprofile.h>
+#include <asm/msr.h>
+#include <asm/ptrace.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+
+#include "op_x86_model.h"
+#include "op_counter.h"
+
+#define NUM_EVENTS 39
+
+#define NUM_COUNTERS_NON_HT 8
+#define NUM_ESCRS_NON_HT 45
+#define NUM_CCCRS_NON_HT 18
+#define NUM_CONTROLS_NON_HT (NUM_ESCRS_NON_HT + NUM_CCCRS_NON_HT)
+
+#define NUM_COUNTERS_HT2 4
+#define NUM_ESCRS_HT2 23
+#define NUM_CCCRS_HT2 9
+#define NUM_CONTROLS_HT2 (NUM_ESCRS_HT2 + NUM_CCCRS_HT2)
+
+static unsigned int num_counters = NUM_COUNTERS_NON_HT;
+static unsigned int num_cccrs = NUM_CCCRS_NON_HT;
+
+
+/* this has to be checked dynamically since the
+   hyper-threadedness of a chip is discovered at
+   kernel boot-time. */
+static inline void setup_num_counters(void)
+{
+#ifdef CONFIG_SMP
+	if (smp_num_siblings == 2) {		
+		num_counters = NUM_COUNTERS_HT2;
+		num_cccrs = NUM_CCCRS_HT2;
+	}
+#endif
+}
+
+
+/* tables to simulate simplified hardware view of p4 registers */
+struct p4_counter_binding {
+	int virt_counter;
+	int counter_address;
+	int cccr_address;
+};
+
+struct p4_event_binding {
+	int escr_select;  /* value to put in CCCR */
+	int event_select; /* value to put in ESCR */
+	struct {
+		int virt_counter; /* for this counter... */
+		int escr_address; /* use this ESCR       */
+	} bindings[2];
+};
+
+/* nb: these CTR_* defines are a duplicate of defines in
+   libop/op_events.c. */
+
+
+#define CTR_BPU_0      (1 << 0)
+#define CTR_MS_0       (1 << 1)
+#define CTR_FLAME_0    (1 << 2)
+#define CTR_IQ_4       (1 << 3)
+#define CTR_BPU_2      (1 << 4)
+#define CTR_MS_2       (1 << 5)
+#define CTR_FLAME_2    (1 << 6)
+#define CTR_IQ_5       (1 << 7)
+
+static struct p4_counter_binding p4_counters [NUM_COUNTERS_NON_HT] = {
+	{ CTR_BPU_0,   MSR_P4_BPU_PERFCTR0,   MSR_P4_BPU_CCCR0 },
+	{ CTR_MS_0,    MSR_P4_MS_PERFCTR0,    MSR_P4_MS_CCCR0 },
+	{ CTR_FLAME_0, MSR_P4_FLAME_PERFCTR0, MSR_P4_FLAME_CCCR0 },
+	{ CTR_IQ_4,    MSR_P4_IQ_PERFCTR4,    MSR_P4_IQ_CCCR4 },
+	{ CTR_BPU_2,   MSR_P4_BPU_PERFCTR2,   MSR_P4_BPU_CCCR2 },
+	{ CTR_MS_2,    MSR_P4_MS_PERFCTR2,    MSR_P4_MS_CCCR2 },
+	{ CTR_FLAME_2, MSR_P4_FLAME_PERFCTR2, MSR_P4_FLAME_CCCR2 },
+	{ CTR_IQ_5,    MSR_P4_IQ_PERFCTR5,    MSR_P4_IQ_CCCR5 }
+};
+
+/* p4 event codes in libop/op_event.h are indices into this table. */
+
+static struct p4_event_binding p4_events[NUM_EVENTS] = {
+	
+	{ /* BRANCH_RETIRED */
+		0x05, 0x06, 
+		{ {CTR_IQ_4, MSR_P4_CRU_ESCR2},
+		  {CTR_IQ_5, MSR_P4_CRU_ESCR3} }
+	},
+	
+	{ /* MISPRED_BRANCH_RETIRED */
+		0x04, 0x03, 
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR0},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR1} }
+	},
+	
+	{ /* TC_DELIVER_MODE */
+		0x01, 0x01,
+		{ { CTR_MS_0, MSR_P4_TC_ESCR0},  
+		  { CTR_MS_2, MSR_P4_TC_ESCR1} }
+	},
+	
+	{ /* BPU_FETCH_REQUEST */
+		0x00, 0x03, 
+		{ { CTR_BPU_0, MSR_P4_BPU_ESCR0},
+		  { CTR_BPU_2, MSR_P4_BPU_ESCR1} }
+	},
+
+	{ /* ITLB_REFERENCE */
+		0x03, 0x18,
+		{ { CTR_BPU_0, MSR_P4_ITLB_ESCR0},
+		  { CTR_BPU_2, MSR_P4_ITLB_ESCR1} }
+	},
+
+	{ /* MEMORY_CANCEL */
+		0x05, 0x02,
+		{ { CTR_FLAME_0, MSR_P4_DAC_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_DAC_ESCR1} }
+	},
+
+	{ /* MEMORY_COMPLETE */
+		0x02, 0x08,
+		{ { CTR_FLAME_0, MSR_P4_SAAT_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_SAAT_ESCR1} }
+	},
+
+	{ /* LOAD_PORT_REPLAY */
+		0x02, 0x04, 
+		{ { CTR_FLAME_0, MSR_P4_SAAT_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_SAAT_ESCR1} }
+	},
+
+	{ /* STORE_PORT_REPLAY */
+		0x02, 0x05,
+		{ { CTR_FLAME_0, MSR_P4_SAAT_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_SAAT_ESCR1} }
+	},
+
+	{ /* MOB_LOAD_REPLAY */
+		0x02, 0x03,
+		{ { CTR_BPU_0, MSR_P4_MOB_ESCR0},
+		  { CTR_BPU_2, MSR_P4_MOB_ESCR1} }
+	},
+
+	{ /* PAGE_WALK_TYPE */
+		0x04, 0x01,
+		{ { CTR_BPU_0, MSR_P4_PMH_ESCR0},
+		  { CTR_BPU_2, MSR_P4_PMH_ESCR1} }
+	},
+
+	{ /* BSQ_CACHE_REFERENCE */
+		0x07, 0x0c, 
+		{ { CTR_BPU_0, MSR_P4_BSU_ESCR0},
+		  { CTR_BPU_2, MSR_P4_BSU_ESCR1} }
+	},
+
+	{ /* IOQ_ALLOCATION */
+		0x06, 0x03, 
+		{ { CTR_BPU_0, MSR_P4_FSB_ESCR0},
+		  {-1,-1} }
+	},
+
+	{ /* IOQ_ACTIVE_ENTRIES */
+		0x06, 0x1a, 
+		{ { CTR_BPU_2, MSR_P4_FSB_ESCR1},
+		  {-1,-1} }
+	},
+
+	{ /* FSB_DATA_ACTIVITY */
+		0x06, 0x17, 
+		{ { CTR_BPU_0, MSR_P4_FSB_ESCR0},
+		  { CTR_BPU_2, MSR_P4_FSB_ESCR1} }
+	},
+
+	{ /* BSQ_ALLOCATION */
+		0x07, 0x05, 
+		{ { CTR_BPU_0, MSR_P4_BSU_ESCR0},
+		  {-1,-1} }
+	},
+
+	{ /* BSQ_ACTIVE_ENTRIES */
+		0x07, 0x06,
+		{ { CTR_BPU_2, MSR_P4_BSU_ESCR1 /* guess */},  
+		  {-1,-1} }
+	},
+
+	{ /* X87_ASSIST */
+		0x05, 0x03, 
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR2},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR3} }
+	},
+
+	{ /* SSE_INPUT_ASSIST */
+		0x01, 0x34,
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+  
+	{ /* PACKED_SP_UOP */
+		0x01, 0x08, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+  
+	{ /* PACKED_DP_UOP */
+		0x01, 0x0c, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+
+	{ /* SCALAR_SP_UOP */
+		0x01, 0x0a, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+
+	{ /* SCALAR_DP_UOP */
+		0x01, 0x0e,
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+
+	{ /* 64BIT_MMX_UOP */
+		0x01, 0x02, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+  
+	{ /* 128BIT_MMX_UOP */
+		0x01, 0x1a, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+
+	{ /* X87_FP_UOP */
+		0x01, 0x04, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+  
+	{ /* X87_SIMD_MOVES_UOP */
+		0x01, 0x2e, 
+		{ { CTR_FLAME_0, MSR_P4_FIRM_ESCR0},
+		  { CTR_FLAME_2, MSR_P4_FIRM_ESCR1} }
+	},
+  
+	{ /* MACHINE_CLEAR */
+		0x05, 0x02, 
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR2},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR3} }
+	},
+
+	{ /* GLOBAL_POWER_EVENTS */
+		0x06, 0x13 /* manual says 0x05 */, 
+		{ { CTR_BPU_0, MSR_P4_FSB_ESCR0},
+		  { CTR_BPU_2, MSR_P4_FSB_ESCR1} }
+	},
+  
+	{ /* TC_MS_XFER */
+		0x00, 0x05, 
+		{ { CTR_MS_0, MSR_P4_MS_ESCR0},
+		  { CTR_MS_2, MSR_P4_MS_ESCR1} }
+	},
+
+	{ /* UOP_QUEUE_WRITES */
+		0x00, 0x09,
+		{ { CTR_MS_0, MSR_P4_MS_ESCR0},
+		  { CTR_MS_2, MSR_P4_MS_ESCR1} }
+	},
+
+	{ /* FRONT_END_EVENT */
+		0x05, 0x08,
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR2},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR3} }
+	},
+
+	{ /* EXECUTION_EVENT */
+		0x05, 0x0c,
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR2},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR3} }
+	},
+
+	{ /* REPLAY_EVENT */
+		0x05, 0x09,
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR2},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR3} }
+	},
+
+	{ /* INSTR_RETIRED */
+		0x04, 0x02, 
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR0},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR1} }
+	},
+
+	{ /* UOPS_RETIRED */
+		0x04, 0x01,
+		{ { CTR_IQ_4, MSR_P4_CRU_ESCR0},
+		  { CTR_IQ_5, MSR_P4_CRU_ESCR1} }
+	},
+
+	{ /* UOP_TYPE */    
+		0x02, 0x02, 
+		{ { CTR_IQ_4, MSR_P4_RAT_ESCR0},
+		  { CTR_IQ_5, MSR_P4_RAT_ESCR1} }
+	},
+
+	{ /* RETIRED_MISPRED_BRANCH_TYPE */
+		0x02, 0x05, 
+		{ { CTR_MS_0, MSR_P4_TBPU_ESCR0},
+		  { CTR_MS_2, MSR_P4_TBPU_ESCR1} }
+	},
+
+	{ /* RETIRED_BRANCH_TYPE */
+		0x02, 0x04,
+		{ { CTR_MS_0, MSR_P4_TBPU_ESCR0},
+		  { CTR_MS_2, MSR_P4_TBPU_ESCR1} }
+	}
+};
+
+
+#define MISC_PMC_ENABLED_P(x) ((x) & 1 << 7)
+
+#define ESCR_RESERVED_BITS 0x80000003
+#define ESCR_CLEAR(escr) ((escr) &= ESCR_RESERVED_BITS)
+#define ESCR_SET_USR_0(escr, usr) ((escr) |= (((usr) & 1) << 2))
+#define ESCR_SET_OS_0(escr, os) ((escr) |= (((os) & 1) << 3))
+#define ESCR_SET_USR_1(escr, usr) ((escr) |= (((usr) & 1)))
+#define ESCR_SET_OS_1(escr, os) ((escr) |= (((os) & 1) << 1))
+#define ESCR_SET_EVENT_SELECT(escr, sel) ((escr) |= (((sel) & 0x1f) << 25))
+#define ESCR_SET_EVENT_MASK(escr, mask) ((escr) |= (((mask) & 0xffff) << 9))
+#define ESCR_READ(escr,high,ev,i) do {rdmsr(ev->bindings[(i)].escr_address, (escr), (high));} while (0);
+#define ESCR_WRITE(escr,high,ev,i) do {wrmsr(ev->bindings[(i)].escr_address, (escr), (high));} while (0);
+
+#define CCCR_RESERVED_BITS 0x38030FFF
+#define CCCR_CLEAR(cccr) ((cccr) &= CCCR_RESERVED_BITS)
+#define CCCR_SET_REQUIRED_BITS(cccr) ((cccr) |= 0x00030000)
+#define CCCR_SET_ESCR_SELECT(cccr, sel) ((cccr) |= (((sel) & 0x07) << 13))
+#define CCCR_SET_PMI_OVF_0(cccr) ((cccr) |= (1<<26))
+#define CCCR_SET_PMI_OVF_1(cccr) ((cccr) |= (1<<27))
+#define CCCR_SET_ENABLE(cccr) ((cccr) |= (1<<12))
+#define CCCR_SET_DISABLE(cccr) ((cccr) &= ~(1<<12))
+#define CCCR_READ(low, high, i) do {rdmsr (p4_counters[(i)].cccr_address, (low), (high));} while (0);
+#define CCCR_WRITE(low, high, i) do {wrmsr (p4_counters[(i)].cccr_address, (low), (high));} while (0);
+#define CCCR_OVF_P(cccr) ((cccr) & (1U<<31))
+#define CCCR_CLEAR_OVF(cccr) ((cccr) &= (~(1U<<31)))
+
+#define CTR_READ(l,h,i) do {rdmsr(p4_counters[(i)].counter_address, (l), (h));} while (0);
+#define CTR_WRITE(l,i) do {wrmsr(p4_counters[(i)].counter_address, -(u32)(l), -1);} while (0);
+#define CTR_OVERFLOW_P(ctr) (!((ctr) & 0x80000000))
+
+/* these access the underlying cccrs 1-18, not the subset of 8 bound to "virtual counters" */
+#define RAW_CCCR_READ(low, high, i) do {rdmsr (MSR_P4_BPU_CCCR0 + (i), (low), (high));} while (0);
+#define RAW_CCCR_WRITE(low, high, i) do {wrmsr (MSR_P4_BPU_CCCR0 + (i), (low), (high));} while (0);
+
+
+/* this assigns a "stagger" to the current CPU, which is used throughout
+   the code in this module as an extra array offset, to select the "even"
+   or "odd" part of all the divided resources. */
+static inline unsigned int get_stagger(void)
+{
+#ifdef CONFIG_SMP
+	int cpu;
+	if (smp_num_siblings > 1) {
+		cpu = smp_processor_id();
+		return (cpu_sibling_map[cpu] > cpu) ? 0 : 1;
+	}
+#endif	
+	return 0;
+}
+
+
+/* finally, mediate access to a real hardware counter
+   by passing a "virtual" counter numer to this macro,
+   along with your stagger setting. */
+#define VIRT_CTR(stagger, i) ((i) + ((num_counters) * (stagger)))
+
+static unsigned long reset_value[NUM_COUNTERS_NON_HT];
+
+
+static void p4_fill_in_addresses(struct op_msrs * const msrs)
+{
+	int i; 
+	unsigned int addr, stag;
+
+	setup_num_counters();
+	stag = get_stagger();
+
+	/* the 8 counter registers we pay attention to */
+	for (i = 0; i < num_counters; ++i)
+		msrs->counters.addrs[i] = 
+			p4_counters[VIRT_CTR(stag, i)].counter_address;
+
+	/* 18 CCCR registers */
+	for (i=stag, addr = MSR_P4_BPU_CCCR0;
+	     addr <= MSR_P4_IQ_CCCR5; ++i, addr += (1 + stag)) 
+		msrs->controls.addrs[i] = addr;
+	
+	/* 43 ESCR registers */
+	for (addr = MSR_P4_BSU_ESCR0;
+	     addr <= MSR_P4_SSU_ESCR0; ++i, addr += (1 + stag)){ 
+		msrs->controls.addrs[i] = addr;
+	}
+	
+	for (addr = MSR_P4_MS_ESCR0;
+	     addr <= MSR_P4_TC_ESCR1; ++i, addr += (1 + stag)){ 
+		msrs->controls.addrs[i] = addr;
+	}
+	
+	for (addr = MSR_P4_IX_ESCR0;
+	     addr <= MSR_P4_CRU_ESCR3; ++i, addr += (1 + stag)){ 
+		msrs->controls.addrs[i] = addr;
+	}
+
+	/* there are 2 remaining non-contiguously located ESCRs */
+
+	if (num_counters == NUM_COUNTERS_NON_HT) {		
+		/* standard non-HT CPUs handle both remaining ESCRs*/
+		msrs->controls.addrs[i++] = MSR_P4_CRU_ESCR5;
+		msrs->controls.addrs[i++] = MSR_P4_CRU_ESCR4;
+
+	} else if (stag == 0) {
+		/* HT CPUs give the first remainder to the even thread, as
+		   the 32nd control register */
+		msrs->controls.addrs[i++] = MSR_P4_CRU_ESCR4;
+
+	} else {
+		/* and two copies of the second to the odd thread,
+		   for the 31st and 32nd control registers */
+		msrs->controls.addrs[i++] = MSR_P4_CRU_ESCR5;
+		msrs->controls.addrs[i++] = MSR_P4_CRU_ESCR5;
+	}
+}
+
+
+static void pmc_setup_one_p4_counter(unsigned int ctr)
+{
+	int i;
+	int const maxbind = 2;
+	unsigned int cccr = 0;
+	unsigned int escr = 0;
+	unsigned int high = 0;
+	unsigned int counter_bit;
+	struct p4_event_binding * ev = 0;
+	unsigned int stag;
+
+	stag = get_stagger();
+	
+	/* convert from counter *number* to counter *bit* */
+	counter_bit = 1 << ctr;
+	
+	/* find our event binding structure. */
+	if (counter_config[ctr].event < 0 || counter_config[ctr].event > NUM_EVENTS) {
+		printk(KERN_ERR 
+		       "oprofile: P4 event code 0x%lx out of range\n", 
+		       counter_config[ctr].event);
+		return;
+	}
+	
+	ev = &(p4_events[counter_config[ctr].event - 1]);
+	
+	for (i = 0; i < maxbind; i++) {
+		if (ev->bindings[i].virt_counter & counter_bit) {
+			
+			/* modify ESCR */
+			ESCR_READ(escr, high, ev, i);
+			ESCR_CLEAR(escr);
+			if (stag == 0) {
+				ESCR_SET_USR_0(escr, counter_config[ctr].user);
+				ESCR_SET_OS_0(escr, counter_config[ctr].kernel);
+			} else {
+				ESCR_SET_USR_1(escr, counter_config[ctr].user);
+				ESCR_SET_OS_1(escr, counter_config[ctr].kernel);
+			}
+			ESCR_SET_EVENT_SELECT(escr, ev->event_select);
+			ESCR_SET_EVENT_MASK(escr, counter_config[ctr].unit_mask);			
+			ESCR_WRITE(escr, high, ev, i);
+		       
+			/* modify CCCR */
+			CCCR_READ(cccr, high, VIRT_CTR(stag, ctr));
+			CCCR_CLEAR(cccr);
+			CCCR_SET_REQUIRED_BITS(cccr);
+			CCCR_SET_ESCR_SELECT(cccr, ev->escr_select);
+			if (stag == 0) {
+				CCCR_SET_PMI_OVF_0(cccr);
+			} else {
+				CCCR_SET_PMI_OVF_1(cccr);
+			}
+			CCCR_WRITE(cccr, high, VIRT_CTR(stag, ctr));
+			return;
+		}
+	}
+}
+
+
+static void p4_setup_ctrs(struct op_msrs const * const msrs)
+{
+	unsigned int i;
+	unsigned int low, high;
+	unsigned int addr;
+	unsigned int stag;
+
+	stag = get_stagger();
+
+	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+	if (! MISC_PMC_ENABLED_P(low)) {
+		printk(KERN_ERR "oprofile: P4 PMC not available\n");
+		return;
+	}
+
+	/* clear all cccrs (including those outside our concern) */
+	for (i = stag ; i < num_cccrs ; i += (1 + stag)) {
+		RAW_CCCR_READ(low, high, i);
+		CCCR_CLEAR(low);
+		CCCR_SET_REQUIRED_BITS(low);
+		RAW_CCCR_WRITE(low, high, i);
+	}
+
+	/* clear all escrs (including those outside out concern) */
+	for (addr = MSR_P4_BSU_ESCR0 + stag;
+	     addr <= MSR_P4_SSU_ESCR0; addr += (1 + stag)){ 
+		wrmsr(addr, 0, 0);
+	}
+	
+	for (addr = MSR_P4_MS_ESCR0 + stag;
+	     addr <= MSR_P4_TC_ESCR1; addr += (1 + stag)){ 
+		wrmsr(addr, 0, 0);
+	}
+	
+	for (addr = MSR_P4_IX_ESCR0 + stag;
+	     addr <= MSR_P4_CRU_ESCR3; addr += (1 + stag)){ 
+		wrmsr(addr, 0, 0);
+	}
+
+	if (num_counters == NUM_COUNTERS_NON_HT) {		
+		wrmsr(MSR_P4_CRU_ESCR4, 0, 0);
+		wrmsr(MSR_P4_CRU_ESCR5, 0, 0);
+	} else if (stag == 0) {
+		wrmsr(MSR_P4_CRU_ESCR4, 0, 0);
+	} else {
+		wrmsr(MSR_P4_CRU_ESCR5, 0, 0);
+	}		
+	
+	/* setup all counters */
+	for (i = 0 ; i < num_counters ; ++i) {
+		if (counter_config[i].event) {
+			reset_value[i] = counter_config[i].count;
+			pmc_setup_one_p4_counter(i);
+			CTR_WRITE(counter_config[i].count, VIRT_CTR(stag, i));
+		} else {
+			reset_value[i] = 0;
+		}
+	}
+}
+
+
+static int p4_check_ctrs(unsigned int const cpu, 
+			  struct op_msrs const * const msrs,
+			  struct pt_regs * const regs)
+{
+	unsigned long ctr, low, high, stag, real;
+	int i;
+
+	stag = get_stagger();
+
+	for (i = 0; i < num_counters; ++i) {
+		
+		if (!counter_config[i].event) 
+			continue;
+
+		/* 
+		 * there is some eccentricity in the hardware which
+		 * requires that we perform 2 extra corrections:
+		 *
+		 * - check both the CCCR:OVF flag for overflow and the
+		 *   counter high bit for un-flagged overflows.
+		 *
+		 * - write the counter back twice to ensure it gets
+		 *   updated properly.
+		 * 
+		 * the former seems to be related to extra NMIs happening
+		 * during the current NMI; the latter is reported as errata
+		 * N15 in intel doc 249199-029, pentium 4 specification
+		 * update, though their suggested work-around does not
+		 * appear to solve the problem.
+		 */
+		
+		real = VIRT_CTR(stag, i);
+
+		CCCR_READ(low, high, real);
+ 		CTR_READ(ctr, high, real);
+		if (CCCR_OVF_P(low) || CTR_OVERFLOW_P(ctr)) {
+			oprofile_add_sample(regs->eip, i, cpu);
+ 			CTR_WRITE(reset_value[i], real);
+			CCCR_CLEAR_OVF(low);
+			CCCR_WRITE(low, high, real);
+ 			CTR_WRITE(reset_value[i], real);
+			/* P4 quirk: you have to re-unmask the apic vector */
+			apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
+			return 1;
+		}
+	}
+
+	/* P4 quirk: you have to re-unmask the apic vector */
+	apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
+	return 0;
+}
+
+
+static void p4_start(struct op_msrs const * const msrs)
+{
+	unsigned int low, high, stag;
+	int i;
+
+	stag = get_stagger();
+
+	for (i = 0; i < num_counters; ++i) {
+		if (!reset_value[i]) continue;
+		CCCR_READ(low, high, VIRT_CTR(stag, i));
+		CCCR_SET_ENABLE(low);
+		CCCR_WRITE(low, high, VIRT_CTR(stag, i));
+	}
+}
+
+
+static void p4_stop(struct op_msrs const * const msrs)
+{
+	unsigned int low, high, stag;
+	int i;
+
+	stag = get_stagger();
+
+	for (i = 0; i < num_counters; ++i) {
+		CCCR_READ(low, high, VIRT_CTR(stag, i));
+		CCCR_SET_DISABLE(low);
+		CCCR_WRITE(low, high, VIRT_CTR(stag, i));
+	}
+}
+
+
+#ifdef CONFIG_SMP
+struct op_x86_model_spec const op_p4_ht2_spec = {
+	.num_counters = NUM_COUNTERS_HT2,
+	.num_controls = NUM_CONTROLS_HT2,
+	.fill_in_addresses = &p4_fill_in_addresses,
+	.setup_ctrs = &p4_setup_ctrs,
+	.check_ctrs = &p4_check_ctrs,
+	.start = &p4_start,
+	.stop = &p4_stop
+};
+#endif
+
+struct op_x86_model_spec const op_p4_spec = {
+	.num_counters = NUM_COUNTERS_NON_HT,
+	.num_controls = NUM_CONTROLS_NON_HT,
+	.fill_in_addresses = &p4_fill_in_addresses,
+	.setup_ctrs = &p4_setup_ctrs,
+	.check_ctrs = &p4_check_ctrs,
+	.start = &p4_start,
+	.stop = &p4_stop
+};
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_x86_model.h linux/arch/i386/oprofile/op_x86_model.h
--- linux-linus/arch/i386/oprofile/op_x86_model.h	2002-12-16 03:45:18.000000000 +0000
+++ linux/arch/i386/oprofile/op_x86_model.h	2003-01-08 23:02:47.000000000 +0000
@@ -11,8 +11,8 @@
 #ifndef OP_X86_MODEL_H
 #define OP_X86_MODEL_H
 
-/* will need re-working for Pentium IV */
-#define MAX_MSR 4
+/* Pentium IV needs all these */
+#define MAX_MSR 63
  
 struct op_saved_msr {
 	unsigned int high;
@@ -47,6 +47,8 @@
 };
 
 extern struct op_x86_model_spec const op_ppro_spec;
+extern struct op_x86_model_spec const op_p4_spec;
+extern struct op_x86_model_spec const op_p4_ht2_spec;
 extern struct op_x86_model_spec const op_athlon_spec;
 
 #endif /* OP_X86_MODEL_H */
diff -X dontdiff -Naur linux-linus/include/asm-i386/msr.h linux/include/asm-i386/msr.h
--- linux-linus/include/asm-i386/msr.h	2003-01-03 02:59:14.000000000 +0000
+++ linux/include/asm-i386/msr.h	2003-01-03 03:18:54.000000000 +0000
@@ -93,6 +93,90 @@
 #define MSR_IA32_MC0_ADDR		0x402
 #define MSR_IA32_MC0_MISC		0x403
 
+/* Pentium IV performance counter MSRs */
+#define MSR_P4_BPU_PERFCTR0 		0x300
+#define MSR_P4_BPU_PERFCTR1 		0x301
+#define MSR_P4_BPU_PERFCTR2 		0x302
+#define MSR_P4_BPU_PERFCTR3 		0x303
+#define MSR_P4_MS_PERFCTR0 		0x304
+#define MSR_P4_MS_PERFCTR1 		0x305
+#define MSR_P4_MS_PERFCTR2 		0x306
+#define MSR_P4_MS_PERFCTR3 		0x307
+#define MSR_P4_FLAME_PERFCTR0 		0x308
+#define MSR_P4_FLAME_PERFCTR1 		0x309
+#define MSR_P4_FLAME_PERFCTR2 		0x30a
+#define MSR_P4_FLAME_PERFCTR3 		0x30b
+#define MSR_P4_IQ_PERFCTR0 		0x30c
+#define MSR_P4_IQ_PERFCTR1 		0x30d
+#define MSR_P4_IQ_PERFCTR2 		0x30e
+#define MSR_P4_IQ_PERFCTR3 		0x30f
+#define MSR_P4_IQ_PERFCTR4 		0x310
+#define MSR_P4_IQ_PERFCTR5 		0x311
+#define MSR_P4_BPU_CCCR0 		0x360
+#define MSR_P4_BPU_CCCR1 		0x361
+#define MSR_P4_BPU_CCCR2 		0x362
+#define MSR_P4_BPU_CCCR3 		0x363
+#define MSR_P4_MS_CCCR0 		0x364
+#define MSR_P4_MS_CCCR1 		0x365
+#define MSR_P4_MS_CCCR2 		0x366
+#define MSR_P4_MS_CCCR3 		0x367
+#define MSR_P4_FLAME_CCCR0 		0x368
+#define MSR_P4_FLAME_CCCR1 		0x369
+#define MSR_P4_FLAME_CCCR2 		0x36a
+#define MSR_P4_FLAME_CCCR3 		0x36b
+#define MSR_P4_IQ_CCCR0 		0x36c
+#define MSR_P4_IQ_CCCR1 		0x36d
+#define MSR_P4_IQ_CCCR2 		0x36e
+#define MSR_P4_IQ_CCCR3 		0x36f
+#define MSR_P4_IQ_CCCR4 		0x370
+#define MSR_P4_IQ_CCCR5 		0x371
+#define MSR_P4_ALF_ESCR0 		0x3ca
+#define MSR_P4_ALF_ESCR1 		0x3cb
+#define MSR_P4_BPU_ESCR0 		0x3b2
+#define MSR_P4_BPU_ESCR1 		0x3b3
+#define MSR_P4_BSU_ESCR0 		0x3a0
+#define MSR_P4_BSU_ESCR1 		0x3a1
+#define MSR_P4_CRU_ESCR0 		0x3b8
+#define MSR_P4_CRU_ESCR1 		0x3b9
+#define MSR_P4_CRU_ESCR2 		0x3cc
+#define MSR_P4_CRU_ESCR3 		0x3cd
+#define MSR_P4_CRU_ESCR4 		0x3e0
+#define MSR_P4_CRU_ESCR5 		0x3e1
+#define MSR_P4_DAC_ESCR0 		0x3a8
+#define MSR_P4_DAC_ESCR1 		0x3a9
+#define MSR_P4_FIRM_ESCR0 		0x3a4
+#define MSR_P4_FIRM_ESCR1 		0x3a5
+#define MSR_P4_FLAME_ESCR0 		0x3a6
+#define MSR_P4_FLAME_ESCR1 		0x3a7
+#define MSR_P4_FSB_ESCR0 		0x3a2
+#define MSR_P4_FSB_ESCR1 		0x3a3
+#define MSR_P4_IQ_ESCR0 		0x3ba
+#define MSR_P4_IQ_ESCR1 		0x3bb
+#define MSR_P4_IS_ESCR0 		0x3b4
+#define MSR_P4_IS_ESCR1 		0x3b5
+#define MSR_P4_ITLB_ESCR0 		0x3b6
+#define MSR_P4_ITLB_ESCR1 		0x3b7
+#define MSR_P4_IX_ESCR0 		0x3c8
+#define MSR_P4_IX_ESCR1 		0x3c9
+#define MSR_P4_MOB_ESCR0 		0x3aa
+#define MSR_P4_MOB_ESCR1 		0x3ab
+#define MSR_P4_MS_ESCR0 		0x3c0
+#define MSR_P4_MS_ESCR1 		0x3c1
+#define MSR_P4_PMH_ESCR0 		0x3ac
+#define MSR_P4_PMH_ESCR1 		0x3ad
+#define MSR_P4_RAT_ESCR0 		0x3bc
+#define MSR_P4_RAT_ESCR1 		0x3bd
+#define MSR_P4_SAAT_ESCR0 		0x3ae
+#define MSR_P4_SAAT_ESCR1 		0x3af
+#define MSR_P4_SSU_ESCR0 		0x3be
+#define MSR_P4_SSU_ESCR1 		0x3bf    /* guess: not defined in manual */
+#define MSR_P4_TBPU_ESCR0 		0x3c2
+#define MSR_P4_TBPU_ESCR1 		0x3c3
+#define MSR_P4_TC_ESCR0 		0x3c4
+#define MSR_P4_TC_ESCR1 		0x3c5
+#define MSR_P4_U2L_ESCR0 		0x3b0
+#define MSR_P4_U2L_ESCR1 		0x3b1
+
 /* AMD Defined MSRs */
 #define MSR_K6_EFER			0xC0000080
 #define MSR_K6_STAR			0xC0000081
diff -X dontdiff -Naur linux-linus/include/linux/oprofile.h linux/include/linux/oprofile.h
--- linux-linus/include/linux/oprofile.h	2003-01-03 02:59:14.000000000 +0000
+++ linux/include/linux/oprofile.h	2003-01-03 03:27:27.000000000 +0000
@@ -21,12 +21,22 @@
 struct dentry;
 struct file_operations;
  
+/* This is duplicated from user-space so
+ * must be kept in sync :(
+ */
 enum oprofile_cpu {
 	OPROFILE_CPU_PPRO,
 	OPROFILE_CPU_PII,
 	OPROFILE_CPU_PIII,
 	OPROFILE_CPU_ATHLON,
-	OPROFILE_CPU_TIMER
+	OPROFILE_CPU_TIMER,
+	OPROFILE_UNUSED1, /* 2.4's RTC mode */
+	OPROFILE_CPU_P4,
+	OPROFILE_CPU_IA64,
+	OPROFILE_CPU_IA64_1,
+	OPROFILE_CPU_IA64_2,
+	OPROFILE_CPU_HAMMER,
+	OPROFILE_CPU_P4_HT2
 };
 
 /* Operations structure to be filled in */
