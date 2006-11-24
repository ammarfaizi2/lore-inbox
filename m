Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966216AbWKXV7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966216AbWKXV7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966223AbWKXV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:59:11 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:40895 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966225AbWKXV7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:59:09 -0500
Date: Fri, 24 Nov 2006 16:59:04 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 8/16] LTTng 0.6.36 for 2.6.18 : Timestamp
Message-ID: <20061124215904.GI25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:58:06 up 93 days, 19:06,  4 users,  load average: 0.61, 0.62, 0.43
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Architecture specific timestamping primitives.

patch08-2.6.18-lttng-core-0.6.36-timestamp.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- /dev/null
+++ b/include/asm-alpha/ltt.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_ALPHA_LTT_H
+#define _ASM_ALPHA_LTT_H
+/*
+ * linux/include/asm-alpha/ltt.h
+ *
+ * Copyright (C) 2005 - Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * alpha architecture specific definitions for ltt
+ */
+
+#define LTT_HAS_TSC
+
+#endif
--- /dev/null
+++ b/include/asm-arm26/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_ARM26_LTT_H
+#define _ASM_ARM26_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-arm/ltt.h
@@ -0,0 +1,82 @@
+/*
+ * linux/include/asm-arm/ltt.h
+ *
+ * Copyright (C) 2005, Mathieu Desnoyers
+ *
+ * ARM definitions for tracing system
+ */
+
+#ifndef _ASM_ARM_LTT_H
+#define _ASM_ARM_LTT_H
+
+#include <linux/jiffies.h>
+#include <linux/seqlock.h>
+
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_ARM
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+
+#undef LTT_HAS_TSC
+
+#define LTTNG_LOGICAL_SHIFT 13
+
+extern atomic_t lttng_logical_clock;
+
+static inline u32 ltt_get_timestamp32(void)
+{
+	unsigned long seq;
+	unsigned long try = 5;
+	u32 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+
+/* The shift overflow doesn't matter */
+static inline u64 ltt_get_timestamp64(void)
+{
+	unsigned long seq;
+	unsigned long try = 5;
+	u64 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies_64 << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+/* this has to be called with the write seqlock held */
+static inline void ltt_reset_timestamp(void)
+{
+	atomic_set(&lttng_logical_clock, 0);
+}
+
+
+static inline unsigned int ltt_frequency(void)
+{
+  return HZ << LTTNG_LOGICAL_SHIFT;
+}
+
+
+static inline u32 ltt_freq_scale(void)
+{
+  return 1;
+}
+
+
+
+#endif
--- /dev/null
+++ b/include/asm-cris/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_CRIS_LTT_H
+#define _ASM_CRIS_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-frv/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_FRV_LTT_H
+#define _ASM_FRV_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-generic/ltt.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_LTT_H
+#define _ASM_GENERIC_LTT_H
+/*
+ * linux/include/asm-generic/ltt.h
+ *
+ * Copyright (C) 2005 - Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Architecture dependent definitions for ltt
+ * Architecture without TSC
+ */
+
+#endif
--- /dev/null
+++ b/include/asm-h8300/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_H8300_LTT_H
+#define _ASM_H8300_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-i386/ltt.h
@@ -0,0 +1,154 @@
+#ifndef _ASM_I386_LTT_H
+#define _ASM_I386_LTT_H
+/*
+ * linux/include/asm-i386/ltt.h
+ *
+ * Copyright (C) 2005,2006 - Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * i386 time and TSC definitions for ltt
+ */
+
+#include <linux/jiffies.h>
+#include <linux/seqlock.h>
+
+#include <asm/timex.h>
+#include <asm/processor.h>
+
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_I386
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+
+#define LTTNG_LOGICAL_SHIFT 13
+
+extern atomic_t lttng_logical_clock;
+
+/* The shift overflow doesn't matter
+ * We use the xtime seq_lock to protect 64 bits clock and
+ * 32 bits ltt logical clock coherency.
+ *
+ * try 5 times. If it still fails, we are cleary in a NMI nested over
+ * the seq_lock. Return 0 -> error.
+ *
+ * 0 is considered an erroneous value.
+ */
+
+static inline u32 ltt_timestamp_no_tsc32(void)
+{
+	unsigned long seq;
+	unsigned long try = 5;
+	u32 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+
+static inline u64 ltt_timestamp_no_tsc64(void)
+{
+	unsigned long seq;
+	unsigned long try = 5;
+	u64 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies_64 << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+u64 ltt_heartbeat_read_synthetic_tsc(void);
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+
+static inline u32 ltt_get_timestamp32(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+		return ltt_timestamp_no_tsc32();
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return get_cycles(); /* only need the 32 LSB */
+#else
+	return ltt_timestamp_no_tsc32();
+#endif
+}
+
+static inline u64 ltt_get_timestamp64(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+		return ltt_timestamp_no_tsc64();
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+	return ltt_heartbeat_read_synthetic_tsc();
+#else
+	return get_cycles();
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+#else
+	return ltt_timestamp_no_tsc64();
+#endif
+}
+
+/* this has to be called with the write seqlock held */
+static inline void ltt_reset_timestamp(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc) {
+		atomic_set(&lttng_logical_clock, 0);
+		return;
+	}
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return;
+#else
+	atomic_set(&lttng_logical_clock, 0);
+	return;
+#endif
+}
+
+static inline unsigned int ltt_frequency(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+  	return HZ << LTTNG_LOGICAL_SHIFT;
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return cpu_khz;
+#else
+	return HZ << LTTNG_LOGICAL_SHIFT;
+#endif
+}
+
+static inline u32 ltt_freq_scale(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+  	return 1;
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return 1000;
+#else
+	return 1;
+#endif
+
+}
+
+#endif //_ASM_I386_LTT_H
--- /dev/null
+++ b/include/asm-ia64/ltt.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_IA64_LTT_H
+#define _ASM_IA64_LTT_H
+
+#define LTT_HAS_TSC
+
+#endif
--- /dev/null
+++ b/include/asm-m32r/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_M32R_LTT_H
+#define _ASM_M32R_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-m68k/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_M68K_LTT_H
+#define _ASM_M68K_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-m68knommu/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_M68KNOMMU_LTT_H
+#define _ASM_M68KNOMMU_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-mips/ltt.h
@@ -0,0 +1,50 @@
+/*
+ * linux/include/asm-mips/ltt.h
+ *
+ * Copyright (C) 2005, Mathieu Desnoyers
+ *
+ * MIPS definitions for tracing system
+ */
+
+#ifndef _ASM_MIPS_LTT_H
+#define _ASM_MIPS_LTT_H
+
+#define LTT_HAS_TSC
+
+/* Current arch type */
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_MIPS
+
+/* Current variant type */
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+
+#include <linux/ltt-core.h>
+#include <asm/timex.h>
+#include <asm/processor.h>
+
+u64 ltt_heartbeat_read_synthetic_tsc(void);
+
+/* MIPS get_cycles only returns a 32 bits TSC (see timex.h). The assumption
+ * there is that the reschedule is done every 8 seconds or so, so we must
+ * make sure there is at least an event (heartbeat) between  each TSC wrap
+ * around. We use the LTT synthetic TSC exactly for this. */
+static inline u32 ltt_get_timestamp32(void)
+{
+	return get_cycles();
+}
+
+static inline u64 ltt_get_timestamp64(void)
+{
+	return ltt_heartbeat_read_synthetic_tsc();
+}
+
+static inline unsigned int ltt_frequency(void)
+{
+	return mips_hpt_frequency;
+}
+
+static inline u32 ltt_freq_scale(void)
+{
+	return 1;
+}
+
+#endif //_ASM_MIPS_LTT_H
--- a/include/asm-mips/mipsregs.h
+++ b/include/asm-mips/mipsregs.h
@@ -383,6 +383,7 @@ #define ST0_XX			0x80000000	/* MIPS IV n
  */
 #define  CAUSEB_EXCCODE		2
 #define  CAUSEF_EXCCODE		(_ULCAST_(31)  <<  2)
+#define  CAUSE_EXCCODE(cause)	(((cause) & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE)
 #define  CAUSEB_IP		8
 #define  CAUSEF_IP		(_ULCAST_(255) <<  8)
 #define  CAUSEB_IP0		8
--- a/include/asm-mips/timex.h
+++ b/include/asm-mips/timex.h
@@ -51,4 +51,6 @@ static inline cycles_t get_cycles (void)
 	return read_c0_count();
 }
 
+extern unsigned int mips_hpt_frequency;
+
 #endif /*  _ASM_TIMEX_H */
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -771,6 +771,7 @@ EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL(to_tm);
 EXPORT_SYMBOL(rtc_mips_set_time);
 EXPORT_SYMBOL(rtc_mips_get_time);
+EXPORT_SYMBOL(mips_hpt_frequency);
 
 unsigned long long sched_clock(void)
 {
--- /dev/null
+++ b/include/asm-parisc/ltt.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_PARISC_LTT_H
+#define _ASM_PARISC_LTT_H
+
+#define LTT_HAS_TSC
+
+#endif
--- /dev/null
+++ b/include/asm-powerpc/ltt.h
@@ -0,0 +1,47 @@
+/*
+ * linux/include/asm-powerpc/ltt.h
+ *
+ * Copyright (C) 2005, Mathieu Desnoyers
+ *
+ * POWERPC definitions for tracing system
+ */
+
+#ifndef _ASM_POWERPC_LTT_H
+#define _ASM_POWERPC_LTT_H
+
+#define LTT_HAS_TSC
+
+/* Current arch type */
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_POWERPC
+
+/* Current variant type */
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+
+#include <linux/ltt-core.h>
+#include <asm/timex.h>
+#include <asm/time.h>
+#include <asm/processor.h>
+
+u64 ltt_heartbeat_read_synthetic_tsc(void);
+
+static inline u32 ltt_get_timestamp32(void)
+{
+	return get_tbl();
+}
+
+static inline u64 ltt_get_timestamp64(void)
+{
+	return get_tb();
+}
+
+static inline unsigned int ltt_frequency(void)
+{
+	return tb_ticks_per_sec;
+}
+
+static inline u32 ltt_freq_scale(void)
+{
+	return 1;
+}
+
+#endif //_ASM_POWERPC_LTT_H
--- /dev/null
+++ b/include/asm-ppc/ltt.h
@@ -0,0 +1,150 @@
+/*
+ * linux/include/asm-ppc/ltt.h
+ *
+ * Copyright (C)	2002, Karim Yaghmour
+ *		 	2005, Mathieu Desnoyers
+ *
+ * PowerPC definitions for tracing system
+ */
+
+#ifndef _ASM_PPC_LTT_H
+#define _ASM_PPC_LTT_H
+
+#include <linux/config.h>
+#include <linux/jiffies.h>
+
+/* Current arch type */
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_PPC
+
+/* PowerPC variants */
+#define LTT_ARCH_VARIANT_PPC_4xx 1	/* 4xx systems (IBM embedded series) */
+#define LTT_ARCH_VARIANT_PPC_6xx 2	/* 6xx/7xx/74xx/8260/POWER3 systems
+					   (desktop flavor) */
+#define LTT_ARCH_VARIANT_PPC_8xx 3	/* 8xx system (Motoral embedded series)
+					 */
+#define LTT_ARCH_VARIANT_PPC_ISERIES 4	/* 8xx system (iSeries) */
+
+/* Current variant type */
+#if defined(CONFIG_4xx)
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_PPC_4xx
+#elif defined(CONFIG_6xx)
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_PPC_6xx
+#elif defined(CONFIG_8xx)
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_PPC_8xx
+#elif defined(CONFIG_PPC_ISERIES)
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_PPC_ISERIES
+#else
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+#endif
+
+#define LTTNG_LOGICAL_SHIFT 13
+
+extern atomic_t lttng_logical_clock;
+
+
+/* The shift overflow doesn't matter */
+static inline u32 _ltt_get_timestamp32(void)
+{	
+	unsigned long seq;
+	unsigned long try = 5;
+	u32 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+static inline _ltt_get_tb32(u32 *p)
+{
+	unsigned lo;
+	asm volatile("mftb %0"
+		 : "=r" (lo));
+	p[0] = lo;
+}
+
+static inline u32 ltt_get_timestamp32(void)
+{
+	u32 ret;
+	if ((get_pvr() >> 16) == 1)
+		ret = _ltt_get_timestamp32();
+	else
+		_ltt_get_tb32((u32*)&ret);
+	return ret;
+}
+
+/* The shift overflow doesn't matter */
+static inline u64 _ltt_get_timestamp64(void)
+{	
+	unsigned long seq;
+	unsigned long try = 5;
+	u64 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies_64 << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+#ifdef SMP
+#define pvr_ver (PVR_VER(current_cpu_data.pvr))
+#else
+#define pvr_ver (PVR_VER(mfspr(SPRN_PVR)))
+#endif
+
+/* from arch/ppc/xmon/xmon.c */
+static inline void _ltt_get_tb64(unsigned *p)
+{
+	unsigned hi, lo, hiagain;
+
+	do {
+		asm volatile("mftbu %0; mftb %1; mftbu %2"
+			 : "=r" (hi), "=r" (lo), "=r" (hiagain));
+	} while (hi != hiagain);
+	p[0] = hi;
+	p[1] = lo;
+}
+
+static inline u64 ltt_get_timestamp64(void)
+{
+	u64 ret;
+	if (pvr_ver == 1)
+  		ret = _ltt_get_timestamp64();
+	else
+		_ltt_get_tb64((unsigned*)&ret);
+	return ret;
+}
+
+/* this has to be called with the write seqlock held */
+static inline void ltt_reset_timestamp(void)
+{
+	if (pvr_ver == 1)
+		atomic_set(&lttng_logical_clock, 0);
+}
+
+static inline unsigned int ltt_frequency(void)
+{
+	if (pvr_ver == 1)
+		return HZ << LTTNG_LOGICAL_SHIFT;
+	else
+		return (tb_ticks_per_jiffy * HZ);
+}
+
+static inline u32 ltt_freq_scale(void)
+{
+	return 1;
+}
+
+#endif //_ASM_PPC_LTT_H
--- /dev/null
+++ b/include/asm-s390/ltt.h
@@ -0,0 +1,20 @@
+/*
+ * linux/include/asm-s390/ltt.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * S/390 definitions for tracing system
+ */
+
+#ifndef _ASM_S390_LTT_H
+#define _ASM_S390_LTT_H
+
+#define LTT_HAS_TSC
+
+/* Current arch type */
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_S390
+
+/* Current variant type */
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+
+#endif//_ASM_S390_LTT_H
--- /dev/null
+++ b/include/asm-sh64/ltt.h
@@ -0,0 +1,14 @@
+/*
+ * linux/include/asm-sh64/ltt.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * SuperH definitions for tracing system
+ */
+
+#ifndef _ASM_SH_LTT_H
+#define _ASM_SH_LTT_H
+
+#include <asm-generic/ltt.h>
+
+#endif
--- /dev/null
+++ b/include/asm-sh/ltt.h
@@ -0,0 +1,14 @@
+/*
+ * linux/include/asm-sh/ltt.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * SuperH definitions for tracing system
+ */
+
+#ifndef _ASM_SH_LTT_H
+#define _ASM_SH_LTT_H
+
+#include <asm-generic/ltt.h>
+
+#endif
--- /dev/null
+++ b/include/asm-sparc64/ltt.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_SPARC64_LTT_H
+#define _ASM_SPARC64_LTT_H
+/*
+ * linux/include/asm-sparc64/ltt.h
+ *
+ * Copyright (C) 2005 - Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ * Copyright (C) 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * sparc64 time and TSC definitions for ltt
+ */
+
+#define LTT_HAS_TSC
+
+#endif
--- /dev/null
+++ b/include/asm-sparc/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_SPARC_LTT_H
+#define _ASM_SPARC_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-um/ltt.h
@@ -0,0 +1,13 @@
+/*
+ * linux/include/asm-um/ltt.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ * 
+ */
+
+#ifndef _ASM_SH_LTT_H
+#define _ASM_SH_LTT_H
+
+#include <asm-generic/ltt.h>
+
+#endif
--- /dev/null
+++ b/include/asm-v850/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_V850_LTT_H
+#define _ASM_V850_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--- /dev/null
+++ b/include/asm-x86_64/ltt.h
@@ -0,0 +1,149 @@
+#ifndef _ASM_X86_64_LTT_H
+#define _ASM_X86_64_LTT_H
+/*
++ * linux/include/asm-x86_64/ltt.h
++ *
++ * x86_64 time and TSC definitions for ltt
++ */
+
+#include <asm/timex.h>
+#include <asm/processor.h>
+
+#define LTT_ARCH_TYPE LTT_ARCH_TYPE_X86_64
+#define LTT_ARCH_VARIANT LTT_ARCH_VARIANT_NONE
+
+#define LTTNG_LOGICAL_SHIFT 13
+
+extern atomic_t lttng_logical_clock;
+
+/* The shift overflow doesn't matter
+ * We use the xtime seq_lock to protect 64 bits clock and
+ * 32 bits ltt logical clock coherency.
+ *
+ * try 5 times. If it still fails, we are cleary in a NMI nested over
+ * the seq_lock. Return 0 -> error.
+ *
+ * 0 is considered an erroneous value.
+ */
+
+static inline u32 ltt_timestamp_no_tsc_32(void)
+{
+	unsigned long seq;
+	unsigned long try = 5;
+	u32 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+
+static inline u64 ltt_timestamp_no_tsc(void)
+{
+	unsigned long seq;
+	unsigned long try = 5;
+	u64 ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		ret = (jiffies_64 << LTTNG_LOGICAL_SHIFT) 
+			| (atomic_add_return(1, &lttng_logical_clock));
+	} while (read_seqretry(&xtime_lock, seq) && (--try) > 0);
+
+	if (try == 0)
+		return 0;
+	else
+		return ret;
+}
+
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+u64 ltt_heartbeat_read_synthetic_tsc(void);
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+
+static inline u32 ltt_get_timestamp32(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+		return ltt_timestamp_no_tsc32();
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return get_cycles(); /* only need the 32 LSB */
+#else
+	return ltt_timestamp_no_tsc32();
+#endif
+}
+
+static inline u64 ltt_get_timestamp64(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+		return ltt_timestamp_no_tsc64();
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+#ifdef CONFIG_LTT_SYNTHETIC_TSC
+	return ltt_heartbeat_read_synthetic_tsc();
+#else
+	return get_cycles();
+#endif //CONFIG_LTT_SYNTHETIC_TSC
+#else
+	return ltt_timestamp_no_tsc64();
+#endif
+}
+
+/* this has to be called with the write seqlock held */
+static inline void ltt_reset_timestamp(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc) {
+		atomic_set(&lttng_logical_clock, 0);
+		return;
+	}
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return;
+#else
+	atomic_set(&lttng_logical_clock, 0);
+	return;
+#endif
+}
+
+static inline unsigned int ltt_frequency(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+  	return HZ << LTTNG_LOGICAL_SHIFT;
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return cpu_khz;
+#else
+	return HZ << LTTNG_LOGICAL_SHIFT;
+#endif
+}
+
+static inline u32 ltt_freq_scale(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+  	return 1;
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	return 1000;
+#else
+	return 1;
+#endif
+
+}
+
+#endif //_ASM_X86_64_LTT_H
--- /dev/null
+++ b/include/asm-xtensa/ltt.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_XTENSA_LTT_H
+#define _ASM_XTENSA_LTT_H
+
+#include <asm-generic/ltt.h>
+#endif
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
