Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968125AbWLELHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968125AbWLELHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968118AbWLELHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:07:43 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:64821 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759952AbWLELHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:07:33 -0500
Date: Tue, 5 Dec 2006 03:07:08 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B785d017560@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] 2.6.19 perfmon2 : session allocation
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


pfm_reserve_session(int is_system, u32 cpu), pfm_release_session(int is_system, u32 cpu):
	- keep track of per-thread and system-wide sessions
	- handle mutual exclusion between per-thread and system-wide context
	- ensure no two system-wide context can be bound to the same CPU
	- register/unregister idle notifier for system-wide context




--- linux-2.6.19.base/perfmon/perfmon_res.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/perfmon/perfmon_res.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,361 @@
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
+/*
+ * global information about all sessions
+ * mostly used to synchronize between system wide and per-process
+ */
+struct pfm_sessions {
+	u32		pfs_task_sessions;/* #num loaded per-thread sessions */
+	u32		pfs_idle_active;  /* idle notifier is active (system-wide) */
+	size_t		pfs_smpl_buffer_mem_cur; /* current smpl buf mem usage */
+	cpumask_t	pfs_sys_cpumask;  /* bitmask of used cpus (system-wide) */
+};
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&pfm_sessions_lock, flags);
+
+	/*
+	 * check against global buffer limit
+	 */
+	buf_mem_max = pfm_controls.smpl_buffer_mem_max;
+	buf_mem = pfm_sessions.pfs_smpl_buffer_mem_cur + size;
+
+	if (buf_mem <= buf_mem_max) {
+		pfm_sessions.pfs_smpl_buffer_mem_cur = buf_mem;
+
+		PFM_DBG("buf_mem_max=%lu current_buf_mem=%lu",
+			buf_mem_max,
+			buf_mem);
+	}
+	spin_unlock_irqrestore(&pfm_sessions_lock, flags);
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
+	spin_lock_irqsave(&pfm_sessions_lock, flags);
+
+	pfm_sessions.pfs_smpl_buffer_mem_cur -= size;
+
+	spin_unlock_irqrestore(&pfm_sessions_lock, flags);
+
+	return -ENOMEM;
+}
+/*
+ *There exist multiple paths leading to this function. We need to
+ * be very careful withlokcing on the mmap_sem as it may already be
+ * held by the time we come here.
+ * The following paths exist:
+ *
+ * exit path:
+ * sys_exit_group
+ *    do_group_exit
+ *     do_exit
+ *      exit_mm
+ *       mmput
+ *        exit_mmap
+ *         remove_vma
+ *          fput
+ *           __fput
+ *            pfm_close
+ *             __pfm_close
+ *              pfm_context_free
+ * 	         pfm_release_buf_space
+ * munmap path:
+ * sys_munmap
+ *  do_munmap
+ *   remove_vma
+ *    fput
+ *     __fput
+ *      pfm_close
+ *       __pfm_close
+ *        pfm_context_free
+ *         pfm_release_buf_space
+ *
+ * close path:
+ * sys_close
+ *  filp_close
+ *   fput
+ *    __fput
+ *     pfm_close
+ *      __pfm_close
+ *       pfm_context_free
+ *        pfm_release_buf_space
+ *
+ * The issue is that on the munmap() path, the mmap_sem is already held
+ * in write-mode by the time we come here. To avoid the deadlock, we need
+ * to know where we are coming from and skip down_write(). If is fairly
+ * difficult to know this because of the lack of good hooks and
+ * the fact that, there may not have been any mmap() of the sampling buffer
+ * (i.e. create_context() followed by close() or exit()).
+ *
+ * We use a set flag ctx->flags.mmap_nlock which is toggle in the vm_ops
+ * callback in remove_vma() which is called systematically for the call, so
+ * on all but the pure close() path. The exit path does not already hold
+ * the lock but this is exit so there is no task->mm by the time we come here.
+ *
+ * The mmap_nlock is set only when unmapping and this is the LAST reference
+ * to the file (i.e., close() followed by munmap()). 
+ */
+void pfm_release_buf_space(struct pfm_context *ctx, size_t size)
+{
+	unsigned long flags;
+	struct mm_struct *mm;
+
+	mm = get_task_mm(current);
+	if (mm) {
+		if (ctx->flags.mmap_nlock == 0) {
+			PFM_DBG("doing down_write");
+			down_write(&mm->mmap_sem);
+		}
+
+		mm->locked_vm -= size >> PAGE_SHIFT;
+
+		PFM_DBG("locked_vm=%lu size=%zu", mm->locked_vm, size);
+
+		if (ctx->flags.mmap_nlock == 0)
+			up_write(&mm->mmap_sem);
+
+		mmput(mm);
+	}
+
+	spin_lock_irqsave(&pfm_sessions_lock, flags);
+
+	pfm_sessions.pfs_smpl_buffer_mem_cur -= size;
+
+	spin_unlock_irqrestore(&pfm_sessions_lock, flags);
+}
+
+int pfm_reserve_session(int is_system, u32 cpu)
+{
+	unsigned long flags;
+	u32 nsys_cpus;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock_irqsave(&pfm_sessions_lock, flags);
+
+	nsys_cpus = cpus_weight(pfm_sessions.pfs_sys_cpumask);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		nsys_cpus,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	if (is_system) {
+		/*
+		 * cannot mix system wide and per-task sessions
+		 */
+		if (pfm_sessions.pfs_task_sessions > 0) {
+			PFM_DBG("system wide imppossible, %u conflicting"
+				" task_sessions\n",
+			  	pfm_sessions.pfs_task_sessions);
+			goto abort;
+		}
+
+		if (cpu_isset(cpu, pfm_sessions.pfs_sys_cpumask)) {
+			PFM_DBG("syswide not possible, conflicting session "
+				"on CPU%u\n", cpu);
+			goto abort;
+		}
+
+		PFM_DBG("reserving syswide session on CPU%u currently "
+			"on CPU%u\n",
+			cpu,
+			smp_processor_id());
+
+		cpu_set(cpu, pfm_sessions.pfs_sys_cpumask);
+		nsys_cpus++;
+
+		if (nsys_cpus == 1) {
+			pfm_arch_idle_notifier_register();
+			pfm_sessions.pfs_idle_active = 1;
+		}
+	} else {
+		if (nsys_cpus)
+			goto abort;
+		pfm_sessions.pfs_task_sessions++;
+	}
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		nsys_cpus,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	spin_unlock_irqrestore(&pfm_sessions_lock, flags);
+
+	return 0;
+
+abort:
+	spin_unlock_irqrestore(&pfm_sessions_lock, flags);
+
+	return -EBUSY;
+}
+
+/*
+ * called from __pfm_unload_context()
+ */
+int pfm_release_session(int is_system, u32 cpu)
+{
+	unsigned long flags;
+	int need_unreg = 0;
+
+	spin_lock_irqsave(&pfm_sessions_lock, flags);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		cpus_weight(pfm_sessions.pfs_sys_cpumask),
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	if (is_system) {
+		cpu_clear(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		if (   !cpus_weight(pfm_sessions.pfs_sys_cpumask)
+		     && pfm_sessions.pfs_idle_active) {
+			pfm_sessions.pfs_idle_active = 0;
+			need_unreg = 1;
+		}
+	} else
+		pfm_sessions.pfs_task_sessions--;
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		cpus_weight(pfm_sessions.pfs_sys_cpumask),
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	spin_unlock_irqrestore(&pfm_sessions_lock, flags);
+
+	if (need_unreg)
+		pfm_arch_idle_notifier_unregister();
+
+	return 0;
+}
+
+/*
+ * called from perfmon_sysfs.c:
+ *  what=0 : pfs_task_sessions
+ *  what=1 : cpus_weight(pfs_sys_cpumask)
+ *  what=2 : smpl_buffer_mem_cur
+ *
+ * return number of bytes written into buf (up to sz)
+ */
+ssize_t pfm_sysfs_session_show(char *buf, size_t sz, int what)
+{
+	unsigned long flags;
+	ssize_t val = 0;
+
+	if (pfm_pmu_conf) {
+		spin_lock_irqsave(&pfm_sessions_lock, flags);
+		switch (what) {
+		case 0: val = pfm_sessions.pfs_task_sessions;
+			break;
+		case 1: val = cpus_weight(pfm_sessions.pfs_sys_cpumask);
+			break;
+		case 2: val = pfm_sessions.pfs_smpl_buffer_mem_cur;
+			break;
+		}
+		spin_unlock_irqrestore(&pfm_sessions_lock, flags);
+	}
+	snprintf(buf, sz, "%zu\n", val);
+
+	return strlen(buf);
+}
