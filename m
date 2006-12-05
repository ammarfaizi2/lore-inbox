Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968093AbWLELN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968093AbWLELN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968159AbWLELIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:08:34 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:59837 "EHLO
	gundega.hpl.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968158AbWLELIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:08:11 -0500
Date: Tue, 5 Dec 2006 03:07:15 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B7FVF017638@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] 2.6.19 perfmon2 : default sampling format
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This file implements the default sampling buffer format.

in this format, the buffer is composed of two major sections:
	- a buffer header
	- the samples

Each sample is composed of:
	- a fixed size header
	- an optional variable size body containing the values
	  of PMDs of interest as specified by user per counter

The sample header contains:
	- the PID, TID
	- CPU where the PMU interrupt occurred
	- active event set number
	- a unique timestamp for the CPU where the interrupt occurred
	- the index of the PMD register that overflowed
	- the last reset value of that overflowd PMD

Samples are stored contiguously. No aggregation is made. When multiple
counters overflow at the same time, multiple samples are written but
they have the same timestamp.

When the end of the buffer is reached, monitoring is stopped. A user
notification may be requested. Otherwise the buffer has reached its
saturation point until a pfm_restart() is issued.

The format works for all architectures in both 32-bit and 64-bit.
Samples for all events sets are store in the same buffer.




--- linux-2.6.19.base/perfmon/perfmon_dfl_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/perfmon/perfmon_dfl_smpl.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,285 @@
+/*
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ *               Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the new default sampling buffer format
+ * for the perfmon2 subsystem.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+
+#include <linux/perfmon.h>
+#include <linux/perfmon_dfl_smpl.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("new perfmon default sampling format");
+MODULE_LICENSE("GPL");
+
+static int pfm_dfl_fmt_validate(u32 ctx_flags, u16 npmds, void *data)
+{
+	struct pfm_dfl_smpl_arg *arg = data;
+	u64 min_buf_size;
+
+	if (data == NULL) {
+		PFM_DBG("no argument passed");
+		return -EINVAL;
+	}
+
+	/*
+	 * sanity check in case size_t is smaller then u64
+	 */
+#if BITS_PER_LONG == 4
+#define MAX_SIZE_T	(1ULL<<(sizeof(size_t)<<3))
+	if (sizeof(size_t) < sizeof(arg->buf_size)) {
+		if (arg->buf_size >= MAX_SIZE_T)
+			return -ETOOBIG;
+	}
+#endif
+	
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(struct pfm_dfl_smpl_hdr)
+	             + (sizeof(struct pfm_dfl_smpl_entry) + (npmds*sizeof(u64)));
+
+	PFM_DBG("validate ctx_flags=0x%x flags=0x%x npmds=%u "
+		   "min_buf_size=%llu buf_size=%llu\n",
+		   ctx_flags,
+		   arg->buf_flags,
+		   npmds,
+		   (unsigned long long)min_buf_size,
+		   (unsigned long long)arg->buf_size);
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_get_size(u32 flags, void *data, size_t *size)
+{
+	struct pfm_dfl_smpl_arg *arg = data;
+
+	/*
+	 * size has been validated in default_validate
+	 * we can never loose bits from buf_size.
+	 */
+	*size = (size_t)arg->buf_size;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_init(struct pfm_context *ctx, void *buf, u32 ctx_flags,
+			    u16 npmds, void *data)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+	struct pfm_dfl_smpl_arg *arg = data;
+
+	hdr = buf;
+
+	hdr->hdr_version = PFM_DFL_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_buf_flags = arg->buf_flags;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+	hdr->hdr_overflows = 0;
+	hdr->hdr_count = 0;
+	hdr->hdr_min_buf_space = sizeof(struct pfm_dfl_smpl_entry) + (npmds*sizeof(u64));
+
+	PFM_DBG("buffer=%p buf_size=%llu hdr_size=%zu hdr_version=%u.%u "
+		  "min_space=%llu npmds=%u",
+		  buf,
+		  (unsigned long long)hdr->hdr_buf_size,
+		  sizeof(*hdr),
+		  PFM_VERSION_MAJOR(hdr->hdr_version),
+		  PFM_VERSION_MINOR(hdr->hdr_version),
+		  (unsigned long long)hdr->hdr_min_buf_space,
+		  npmds);
+
+	return 0;
+}
+
+/*
+ * called from pfm_overflow_handler() to record a new sample
+ *
+ * context is locked, interrupts are disabled (no preemption)
+ */
+static int pfm_dfl_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+	struct pfm_dfl_smpl_entry *ent;
+	void *cur, *last;
+	u64 *e;
+	size_t entry_size, min_size;
+	u16 npmds, i;
+	u16 ovfl_pmd;
+
+	hdr = buf;
+	cur = buf+hdr->hdr_cur_offs;
+	last = buf+hdr->hdr_buf_size;
+	ovfl_pmd = arg->ovfl_pmd;
+	min_size = hdr->hdr_min_buf_space;
+
+	/*
+	 * precheck for sanity
+	 */
+	if ((last - cur) < min_size)
+		goto full;
+
+	npmds = arg->num_smpl_pmds;
+
+	ent = (struct pfm_dfl_smpl_entry *)cur;
+
+	entry_size = sizeof(*ent) + (npmds << 3);
+
+	/* position for first pmd */
+	e = (u64 *)(ent+1);
+
+	hdr->hdr_count++;
+
+	PFM_DBG_ovfl("count=%llu cur=%p last=%p free_bytes=%zu ovfl_pmd=%d "
+		       "npmds=%u",
+		       (unsigned long long)hdr->hdr_count,
+		       cur, last,
+		       (last-cur),
+		       ovfl_pmd,
+		       npmds);
+
+	/*
+	 * current = task running at the time of the overflow.
+	 *
+	 * per-task mode:
+	 * 	- this is usually the task being monitored.
+	 * 	  Under certain conditions, it might be a different task
+	 *
+	 * system-wide:
+	 * 	- this is not necessarily the task controlling the session
+	 */
+	ent->pid = current->pid;
+	ent->ovfl_pmd = ovfl_pmd;
+	ent->last_reset_val = arg->pmd_last_reset;
+
+	/*
+	 * where did the fault happen (includes slot number)
+	 */
+	ent->ip = ip;
+
+	ent->tstamp = tstamp;
+	ent->cpu = smp_processor_id();
+	ent->set = arg->active_set;
+	ent->tgid = current->tgid;
+
+	/*
+	 * selectively store PMDs in increasing index number
+	 */
+	if (npmds) {
+		u64 *val = arg->smpl_pmds_values;
+		for(i=0; i < npmds; i++) {
+			*e++ = *val++;
+		}
+	}
+
+	/*
+	 * update position for next entry
+	 */
+	hdr->hdr_cur_offs += entry_size;
+	cur += entry_size;
+
+	/*
+	 * post check to avoid losing the last sample
+	 */
+	if ((last - cur) < min_size)
+		goto full;
+
+	/* reset before returning from interrupt handler */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+full:
+	PFM_DBG_ovfl("sampling buffer full free=%zu, count=%llu",
+		     last-cur,
+		     (unsigned long long)hdr->hdr_count);
+
+	/*
+	 * increment number of buffer overflows.
+	 * important to detect duplicate set of samples.
+	 */
+	hdr->hdr_overflows++;
+
+	/*
+	 * request notification and masking of monitoring.
+	 * Notification is still subject to the overflowed
+	 * register having the FL_NOTIFY flag set.
+	 */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY| PFM_OVFL_CTRL_MASK;
+
+	return -ENOBUFS; /* we are full, sorry */
+}
+
+static int pfm_dfl_fmt_restart(int is_active, u32 *ovfl_ctrl, void *buf)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+
+	hdr = buf;
+
+	hdr->hdr_count = 0;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+
+	*ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_exit(void *buf)
+{
+	return 0;
+}
+
+static struct pfm_smpl_fmt dfl_fmt={
+	.fmt_name = "default",
+	.fmt_version = 0x10000,
+	.fmt_arg_size = sizeof(struct pfm_dfl_smpl_arg),
+	.fmt_validate = pfm_dfl_fmt_validate,
+	.fmt_getsize = pfm_dfl_fmt_get_size,
+	.fmt_init = pfm_dfl_fmt_init,
+	.fmt_handler = pfm_dfl_fmt_handler,
+	.fmt_restart = pfm_dfl_fmt_restart,
+	.fmt_exit = pfm_dfl_fmt_exit,
+	.fmt_flags = PFM_FMT_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+
+static int pfm_dfl_fmt_init_module(void)
+{
+	return pfm_fmt_register(&dfl_fmt);
+}
+
+static void pfm_dfl_fmt_cleanup_module(void)
+{
+	pfm_fmt_unregister(&dfl_fmt);
+}
+
+module_init(pfm_dfl_fmt_init_module);
+module_exit(pfm_dfl_fmt_cleanup_module);
--- linux-2.6.19.base/include/linux/perfmon_dfl_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/include/linux/perfmon_dfl_smpl.h	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,78 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ *               Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the new dfl sampling buffer format
+ * for perfmon2 subsystem.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#ifndef __PERFMON_DFL_SMPL_H__
+#define __PERFMON_DFL_SMPL_H__ 1
+
+/*
+ * format specific parameters (passed at context creation)
+ */
+struct pfm_dfl_smpl_arg {
+	__u64 buf_size;		/* size of the buffer in bytes */
+	__u32 buf_flags;	/* buffer specific flags */
+	__u32 reserved1;	/* for future use */
+	__u64 reserved[6];	/* for future use */
+};
+
+/*
+ * This header is at the beginning of the sampling buffer returned to the user.
+ * It is directly followed by the first record.
+ */
+struct pfm_dfl_smpl_hdr {
+	__u64 hdr_count;	/* how many valid entries */
+	__u64 hdr_cur_offs;	/* current offset from top of buffer */
+	__u64 hdr_overflows;	/* #overflows for buffer */
+	__u64 hdr_buf_size;	/* bytes in the buffer */
+	__u64 hdr_min_buf_space;/* minimal buffer size (internal use) */
+	__u32 hdr_version;	/* smpl format version */
+	__u32 hdr_buf_flags;	/* copy of buf_flags */
+	__u64 hdr_reserved[10];	/* for future use */
+};
+
+/*
+ * Entry header in the sampling buffer.  The header is directly followed
+ * with the values of the PMD registers of interest saved in increasing
+ * index order: PMD4, PMD5, and so on. How many PMDs are present depends
+ * on how the session was programmed.
+ *
+ * In the case where multiple counters overflow at the same time, multiple
+ * entries are written consecutively.
+ *
+ * last_reset_value member indicates the initial value of the overflowed PMD.
+ */
+struct pfm_dfl_smpl_entry {
+	__u32	pid;		/* thread id (for NPTL, this is gettid()) */
+	__u16	ovfl_pmd;	/* index of overflowed PMD for this sample */
+	__u16	reserved;	/* for future use */
+	__u64	last_reset_val;	/* initial value of overflowed PMD */
+	__u64	ip;		/* where did the overflow interrupt happened  */
+	__u64	tstamp;		/* overflow timetamp */
+	__u16	cpu;		/* cpu on which the overfow occurred */
+	__u16	set;		/* event set active when overflow ocurred   */
+	__u32	tgid;		/* thread group id (for NPTL, this is getpid())*/
+};
+
+#define PFM_DFL_SMPL_VERSION_MAJ 1U
+#define PFM_DFL_SMPL_VERSION_MIN 0U
+#define PFM_DFL_SMPL_VERSION (((PFM_DFL_SMPL_VERSION_MAJ&0xffff)<<16)|\
+				(PFM_DFL_SMPL_VERSION_MIN & 0xffff))
+
+#endif /* __PERFMON_DFL_SMPL_H__ */
