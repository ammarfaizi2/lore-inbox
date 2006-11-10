Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946773AbWKJQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946773AbWKJQsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946712AbWKJQsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:48:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:56758 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946773AbWKJQsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:48:08 -0500
Message-ID: <4554AD45.9080008@us.ibm.com>
Date: Fri, 10 Nov 2006 10:48:05 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH 1/2] OProfile for Cell: Initial profiling support
Content-Type: multipart/mixed;
 boundary="------------080709090103000306020609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709090103000306020609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------080709090103000306020609
Content-Type: text/plain;
 name="oprof-cell-header.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprof-cell-header.diff"

Utility macros, declarations, etc, to support Oprofile for Cell.

Signed-Off-By: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.18/arch/powerpc/oprofile/cell/perf_utils.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18/arch/powerpc/oprofile/cell/perf_utils.h	2006-11-08 21:33:27.178161224 -0600
@@ -0,0 +1,113 @@
+/*
+ * perf_utils.h
+ *
+ * This file contains useful macros, declarations, etc. used
+ * by OProfile for the Cell Broadband Engine.
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Authors: Maynard Johnson <maynardj@us.ibm.com>
+ */
+
+#ifndef PERF_UTILS_H
+#define PERF_UTILS_H
+
+#define UNUSED_WORD ~0
+
+/* This macro should be used with care as it NR_CPUS is 
+ * a maximum value that may not be accurate at runtime.
+ */
+#define NR_NODES	(NR_CPUS >> 1)
+
+/* FIXME:  I don't know if there's a _real_ macro or
+ * function for determining whether or not SMT is enabled.
+ */
+#define is_smt()  1
+
+#define PPU_CYCLES_EVENT_NUM 1	/*  event number for PPU_CYCLES */
+#define CBE_COUNT_ALL_CYCLES 0x42800000	/* PPU cycle event specifier */
+
+#define NUM_THREADS 2
+#define NUM_CNTRS   4
+#define VIRT_CNTR_SW_TIME_NS 100000000	// 0.5 seconds
+
+#define CBE_COUNT_SUPERVISOR_MODE       0
+#define CBE_COUNT_HYPERVISOR_MODE       1
+#define CBE_COUNT_PROBLEM_MODE          2
+#define CBE_COUNT_ALL_MODES             3
+
+/* Macros for the pm07_control registers. */
+#define PM07_CTR_INPUT_MUX(x)                    ((((x) & 1) << 26) & 0x3f)
+#define PM07_CTR_INPUT_CONTROL(x)                (((x) & 1) << 25)
+#define PM07_CTR_POLARITY(x)                     (((x) & 1) << 24)
+#define PM07_CTR_COUNT_CYCLES(x)                 (((x) & 1) << 23)
+#define PM07_CTR_ENABLE(x)                       (((x) & 1) << 22)
+
+
+struct pmc_cntrl_data {
+	unsigned long vcntr;
+	unsigned long evnts;
+	unsigned long masks;
+	unsigned long enabled;
+};
+
+/*
+ * ibm,cbe-perftools rtas parameters
+ */
+
+struct pm_signal {
+	u16 cpu;		/* Processor to modify */
+	u16 sub_unit;		/* hw subunit this applies to (if applicable) */
+	u16 signal_group;	/* Signal Group to Enable/Disable */
+	u8 bus_word;		/* Enable/Disable on this Trace/Trigger/Event
+				   Bus Word(s) (bitmask) */
+	u8 bit;			/* Trigger/Event bit (if applicable) */
+};
+
+/*
+ * rtas call arguments
+ */
+enum {
+	SUBFUNC_RESET = 1,
+	SUBFUNC_ACTIVATE = 2,
+	SUBFUNC_DEACTIVATE = 3,
+
+	PASSTHRU_IGNORE = 0,
+	PASSTHRU_ENABLE = 1,
+	PASSTHRU_DISABLE = 2,
+};
+
+struct pm_cntrl {
+	short int enable;
+	short int stop_at_max;
+	short int trace_mode;
+	short int freeze;
+	short int count_mode;
+};
+
+static struct {
+	u32 group_control;
+	u32 debug_bus_control;
+	struct pm_cntrl pm_cntrl;
+	u32 pm07_cntrl[OP_MAX_COUNTER];
+} pm_regs;
+
+struct oprofile_umask {
+	union {
+		u32 val;
+		struct {
+			u32 pad1:16;
+			u32 sub_unit:4;
+			u32 pad2:2;
+			u32 bus_type:2;
+			u32 bus_word:4;
+			u32 pad3:1;
+			u32 input_control:1;
+			u32 polarity:1;
+			u32 count_cycles:1;
+		};
+	};
+};
+
+
+#endif // PERF_UTILS_H

--------------080709090103000306020609--

