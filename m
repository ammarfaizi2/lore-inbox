Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932861AbWJIOMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWJIOMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWJIOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:53 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:33265 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932903AbWJIOLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:24 -0400
Date: Mon, 9 Oct 2006 07:10:15 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAFQ4026103@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] 2.6.18 perfmon2 : session allocation
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This file contains some resource accounting functions for:
	- sampling buffer memory managment
	- context management

pfm_reserve_buf_space(size_t size), pfm_release_buf_space(size_t size):
	- keep track of memory used for sampling buffers
	- there is a per process limit set using the RLIMIT_MEMLOCK attribute
	- there is a global limit controlled by perfmon and configurable via /sys/kernel/perfmon/buf_size_max


pfm_reserve_session(struct pfm_context *ctx, u32 cpu), pfm_release_session(struct pfm_context *ctx, u32 cpu):
	- keep track of per-thread and system-wide sessions
	- handles mutual exclusion between per-thread and system-wide context
	- ensure no two system-wide context can be bound to the same CPU

(this patch was missing from my previous posting on LKML).


--- linux-2.6.18.base/perfmon/perfmon_res.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_res.c	2006-09-25 12:10:13.000000000 -0700
@@ -0,0 +1,318 @@
+/*
+ * perfmon_res.c:  perfmon2 resource allocations
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * The initial version of perfmon.c was written by
+ * Ganesh Venkitachalam, IBM Corp.
+ *
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
+ * David Mosberger, Hewlett Packard Co.
+ *
+ * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
+ * by Stephane Eranian, Hewlett Packard Co.
+ *
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *                David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://perfmon2.sf.net
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
+#include <linux/spinlock.h>
+#include <linux/perfmon.h>
+#include <linux/module.h>
+
+static struct pfm_sessions pfm_sessions;
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_sessions_lock);
+
+/*
+ * sampling buffer allocated by perfmon must be
+ * checked against max usage thresholds for security
+ * reasons.
+ *
+ * The first level check is against the system wide limit
+ * as indicated by the system administrator in /proc/sys/kernel/perfmon
+ *
+ * The second level check is on a per-process basis using
+ * RLIMIT_MEMLOCK limit.
+ *
+ * Operating on the current task only.
+ */
+int pfm_reserve_buf_space(size_t size)
+{
+	struct mm_struct *mm;
+	unsigned long locked;
+	unsigned long buf_mem, buf_mem_max;
+
+	spin_lock(&pfm_sessions_lock);
+
+	/*
+	 * check against global buffer limit
+	 */
+	buf_mem_max = pfm_controls.smpl_buf_size_max;
+	buf_mem = pfm_sessions.pfs_cur_smpl_buf_mem + size;
+
+	if (buf_mem <= buf_mem_max) {
+		pfm_sessions.pfs_cur_smpl_buf_mem = buf_mem;
+
+		PFM_DBG("buf_mem_max=%lu current_buf_mem=%lu",
+			buf_mem_max,
+			buf_mem);
+	}
+	spin_unlock(&pfm_sessions_lock);
+
+	if (buf_mem > buf_mem_max) {
+		PFM_DBG("smpl buffer memory threshold reached");
+		return -ENOMEM;
+	}
+
+	/*
+	 * check against RLIMIT_MEMLOCK
+	 */
+	mm = get_task_mm(current);
+
+	down_write(&mm->mmap_sem);
+
+	locked  = mm->locked_vm << PAGE_SHIFT;
+	locked += size;
+
+	if (locked > current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur) {
+
+		PFM_DBG("RLIMIT_MEMLOCK reached ask_locked=%lu rlim_cur=%lu",
+			locked,
+			current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur);
+
+		up_write(&mm->mmap_sem);
+		mmput(mm);
+		goto unres;
+	}
+
+	mm->locked_vm = locked >> PAGE_SHIFT;
+
+	up_write(&mm->mmap_sem);
+
+	mmput(mm);
+
+	return 0;
+
+unres:
+	/*
+	 * remove global buffer memory allocation
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	pfm_sessions.pfs_cur_smpl_buf_mem -= size;
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return -ENOMEM;
+}
+
+void pfm_release_buf_space(size_t size)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(current);
+	if (mm) {
+		down_write(&mm->mmap_sem);
+
+		mm->locked_vm -= size >> PAGE_SHIFT;
+		PFM_DBG("locked_vm=%lu size=%zu", mm->locked_vm, size);
+		up_write(&mm->mmap_sem);
+
+		mmput(mm);
+	}
+
+	spin_lock(&pfm_sessions_lock);
+
+	pfm_sessions.pfs_cur_smpl_buf_mem -= size;
+
+	spin_unlock(&pfm_sessions_lock);
+}
+
+int pfm_reserve_session(struct pfm_context *ctx, u32 cpu)
+{
+	int is_system;
+
+	is_system = ctx->flags.system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	if (pfm_arch_reserve_session(&pfm_sessions, ctx, cpu))
+		goto abort;
+
+	if (is_system) {
+
+		BUG_ON(cpu != smp_processor_id());
+
+		/*
+		 * cannot mix system wide and per-task sessions
+		 */
+		if (pfm_sessions.pfs_task_sessions > 0) {
+			PFM_DBG("system wide imppossible, %u conflicting"
+				"task_sessions\n",
+			  	pfm_sessions.pfs_task_sessions);
+			goto abort_undo;
+		}
+
+		if (cpu_isset(cpu, pfm_sessions.pfs_sys_cpumask)) {
+			PFM_DBG("syswide not possible, conflicting session "
+				"on CPU%u\n", cpu);
+			goto abort_undo;
+		}
+
+		PFM_DBG("reserving syswide session on CPU%u currently "
+			"on CPU%u\n",
+			cpu,
+			smp_processor_id());
+
+		cpu_set(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		pfm_sessions.pfs_sys_sessions++ ;
+	} else {
+		if (pfm_sessions.pfs_sys_sessions)
+			goto abort_undo;
+		pfm_sessions.pfs_task_sessions++;
+	}
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+
+abort_undo:
+	/*
+	 * must undo arch-specific reservation
+	 */
+	pfm_arch_release_session(&pfm_sessions, ctx, cpu);
+abort:
+	spin_unlock(&pfm_sessions_lock);
+
+	return -EBUSY;
+}
+
+int pfm_release_session(struct pfm_context *ctx, u32 cpu)
+{
+	int is_system;
+
+	is_system = ctx->flags.system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	if (is_system) {
+		cpu_clear(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		pfm_sessions.pfs_sys_sessions--;
+	} else {
+		pfm_sessions.pfs_task_sessions--;
+	}
+
+	pfm_arch_release_session(&pfm_sessions, ctx, cpu);
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+}
+
+static struct _pfm_pmu_config empty_config={
+	.pmu_name = "Unknown",
+	.version = "0.0"
+};
+
+ssize_t pfm_sysfs_session_show(char *buf, size_t sz, int what)
+{
+	struct _pfm_pmu_config *p;
+	ssize_t ret = -EINVAL;
+
+	spin_lock(&pfm_sessions_lock);
+
+	if (pfm_pmu_conf)
+		p = pfm_pmu_conf;
+	else
+		p = &empty_config;
+
+	switch(what) {
+		case 0: ret = snprintf(buf, sz, "%u\n", pfm_sessions.pfs_task_sessions);
+			break;
+		case 1: ret = snprintf(buf, sz, "%u\n", pfm_sessions.pfs_sys_sessions);
+			break;
+		case 2: ret = snprintf(buf, sz, "%zu\n", pfm_sessions.pfs_cur_smpl_buf_mem);
+			break;
+	}
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return ret;
+}
+int pfm_sessions_block(void)
+{
+	int ret = 0;
+
+	spin_lock(&pfm_sessions_lock);
+
+	if (pfm_sessions.pfs_task_sessions || pfm_sessions.pfs_sys_sessions)
+		ret = -1;
+
+	pfm_pmu_conf_get(0);
+
+	/* disable creation of new contexts */
+	atomic_inc(&perfmon_disabled);
+
+	spin_unlock(&pfm_sessions_lock);
+	return ret;
+}
+EXPORT_SYMBOL(pfm_sessions_block);
+
+void pfm_sessions_unblock(void)
+{
+	atomic_dec(&perfmon_disabled);
+	pfm_pmu_conf_put();
+}
+EXPORT_SYMBOL(pfm_sessions_unblock);
+
+
