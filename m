Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUEaWcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUEaWcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUEaWcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:32:08 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26045 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264827AbUEaWVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:21:31 -0400
Date: Tue, 1 Jun 2004 00:21:22 +0200 (MEST)
Message-Id: <200405312221.i4VMLMCJ012362@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.3 for 2.6.7-rc1-mm1, part 5/6:

- driver for virtualised (per-process) performance counters

 virtual.c |  938 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 virtual.h |   13 
 2 files changed, 951 insertions(+)

diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/virtual.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.virtual/drivers/perfctr/virtual.c
--- linux-2.6.7-rc1-mm1/drivers/perfctr/virtual.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.virtual/drivers/perfctr/virtual.c	2004-05-31 23:47:47.802821000 +0200
@@ -0,0 +1,938 @@
+/* $Id: virtual.c,v 1.95 2004/05/31 20:36:37 mikpe Exp $
+ * Virtual per-process performance counters.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/compiler.h>	/* for unlikely() in 2.4.18 and older */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/ptrace.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/perfctr.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include "cpumask.h"
+#include "virtual.h"
+
+/****************************************************************
+ *								*
+ * Data types and macros.					*
+ *								*
+ ****************************************************************/
+
+struct vperfctr {
+/* User-visible fields: (must be first for mmap()) */
+	struct perfctr_cpu_state cpu_state;
+/* Kernel-private fields: */
+	int si_signo;
+	atomic_t count;
+	spinlock_t owner_lock;
+	struct task_struct *owner;
+	/* sampling_timer and bad_cpus_allowed are frequently
+	   accessed, so they get to share a cache line */
+	unsigned int sampling_timer ____cacheline_aligned;
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+	atomic_t bad_cpus_allowed;
+#endif
+#if PERFCTR_INTERRUPT_SUPPORT
+	unsigned int iresume_cstatus;
+#endif
+};
+#define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
+
+#if PERFCTR_INTERRUPT_SUPPORT
+
+static void vperfctr_ihandler(unsigned long pc);
+
+static inline void vperfctr_set_ihandler(void)
+{
+	perfctr_cpu_set_ihandler(vperfctr_ihandler);
+}
+
+static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr)
+{
+	perfctr->iresume_cstatus = 0;
+}
+
+#else
+static inline void vperfctr_set_ihandler(void) { }
+static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr) { }
+#endif
+
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+
+static inline void vperfctr_init_bad_cpus_allowed(struct vperfctr *perfctr)
+{
+	atomic_set(&perfctr->bad_cpus_allowed, 0);
+}
+
+/* Concurrent set_cpus_allowed() is possible. The only lock it
+   can take is the task lock, so we have to take it as well.
+   task_lock/unlock also disables/enables preemption. */
+
+static inline void vperfctr_task_lock(struct task_struct *p)
+{
+	task_lock(p);
+}
+
+static inline void vperfctr_task_unlock(struct task_struct *p)
+{
+	task_unlock(p);
+}
+
+#else	/* !PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED */
+
+static inline void vperfctr_init_bad_cpus_allowed(struct vperfctr *perfctr) { }
+
+/* Concurrent set_cpus_allowed() is impossible or irrelevant.
+   Disabling and enabling preemption suffices for an atomic region. */
+
+static inline void vperfctr_task_lock(struct task_struct *p)
+{
+	preempt_disable();
+}
+
+static inline void vperfctr_task_unlock(struct task_struct *p)
+{
+	preempt_enable();
+}
+
+#endif	/* !PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED */
+
+/****************************************************************
+ *								*
+ * Resource management.						*
+ *								*
+ ****************************************************************/
+
+/* XXX: perhaps relax this to number of _live_ perfctrs */
+static spinlock_t nrctrs_lock = SPIN_LOCK_UNLOCKED;
+static int nrctrs;
+static const char this_service[] = __FILE__;
+
+static int inc_nrctrs(void)
+{
+	const char *other;
+
+	other = NULL;
+	spin_lock(&nrctrs_lock);
+	if (++nrctrs == 1) {
+		other = perfctr_cpu_reserve(this_service);
+		if (other)
+			nrctrs = 0;
+	}
+	spin_unlock(&nrctrs_lock);
+	if (other) {
+		printk(KERN_ERR __FILE__
+		       ": cannot operate, perfctr hardware taken by '%s'\n",
+		       other);
+		return -EBUSY;
+	}
+	vperfctr_set_ihandler();
+	return 0;
+}
+
+static void dec_nrctrs(void)
+{
+	spin_lock(&nrctrs_lock);
+	if (--nrctrs == 0)
+		perfctr_cpu_release(this_service);
+	spin_unlock(&nrctrs_lock);
+}
+
+static struct vperfctr *vperfctr_alloc(void)
+{
+	unsigned long page;
+
+	if (inc_nrctrs() != 0)
+		return ERR_PTR(-EBUSY);
+	page = get_zeroed_page(GFP_KERNEL);
+	if (!page) {
+		dec_nrctrs();
+		return ERR_PTR(-ENOMEM);
+	}
+	SetPageReserved(virt_to_page(page));
+	return (struct vperfctr*) page;
+}
+
+static void vperfctr_free(struct vperfctr *perfctr)
+{
+	ClearPageReserved(virt_to_page(perfctr));
+	free_page((unsigned long)perfctr);
+	dec_nrctrs();
+}
+
+static struct vperfctr *get_empty_vperfctr(void)
+{
+	struct vperfctr *perfctr = vperfctr_alloc();
+	if (!IS_ERR(perfctr)) {
+		atomic_set(&perfctr->count, 1);
+		vperfctr_init_bad_cpus_allowed(perfctr);
+		spin_lock_init(&perfctr->owner_lock);
+	}
+	return perfctr;
+}
+
+static void put_vperfctr(struct vperfctr *perfctr)
+{
+	if (atomic_dec_and_test(&perfctr->count))
+		vperfctr_free(perfctr);
+}
+
+/****************************************************************
+ *								*
+ * Basic counter operations.					*
+ * These must all be called by the owner process only.		*
+ * These must all be called with preemption disabled.		*
+ *								*
+ ****************************************************************/
+
+/* PRE: IS_RUNNING(perfctr)
+ * Suspend the counters.
+ * XXX: When called from switch_to(), perfctr belongs to 'prev'
+ * but current is 'next'.
+ */
+static inline void vperfctr_suspend(struct vperfctr *perfctr)
+{
+	perfctr_cpu_suspend(&perfctr->cpu_state);
+}
+
+static inline void vperfctr_reset_sampling_timer(struct vperfctr *perfctr)
+{
+	/* XXX: base the value on perfctr_info.cpu_khz instead! */
+	perfctr->sampling_timer = HZ/2;
+}
+
+/* PRE: perfctr == current->thread.perfctr && IS_RUNNING(perfctr)
+ * Restart the counters.
+ */
+static inline void vperfctr_resume(struct vperfctr *perfctr)
+{
+	perfctr_cpu_resume(&perfctr->cpu_state);
+	vperfctr_reset_sampling_timer(perfctr);
+}
+
+/* Sample the counters but do not suspend them. */
+static void vperfctr_sample(struct vperfctr *perfctr)
+{
+	if (IS_RUNNING(perfctr)) {
+		perfctr_cpu_sample(&perfctr->cpu_state);
+		vperfctr_reset_sampling_timer(perfctr);
+	}
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+/* vperfctr interrupt handler (XXX: add buffering support) */
+/* PREEMPT note: called in IRQ context with preemption disabled. */
+static void vperfctr_ihandler(unsigned long pc)
+{
+	struct task_struct *tsk = current;
+	struct vperfctr *perfctr;
+	unsigned int pmc_mask;
+	siginfo_t si;
+
+	perfctr = tsk->thread.perfctr;
+	if (!perfctr) {
+		printk(KERN_ERR "%s: BUG! pid %d has no vperfctr\n",
+		       __FUNCTION__, tsk->pid);
+		return;
+	}
+	if (!perfctr_cstatus_has_ictrs(perfctr->cpu_state.cstatus)) {
+		printk(KERN_ERR "%s: BUG! vperfctr has cstatus %#x (pid %d, comm %s)\n",
+		       __FUNCTION__, perfctr->cpu_state.cstatus, tsk->pid, tsk->comm);
+		return;
+	}
+	vperfctr_suspend(perfctr);
+	pmc_mask = perfctr_cpu_identify_overflow(&perfctr->cpu_state);
+	if (!pmc_mask) {
+		printk(KERN_ERR "%s: BUG! pid %d has unidentifiable overflow source\n",
+		       __FUNCTION__, tsk->pid);
+		return;
+	}
+	/* suspend a-mode and i-mode PMCs, leaving only TSC on */
+	/* XXX: some people also want to suspend the TSC */
+	perfctr->iresume_cstatus = perfctr->cpu_state.cstatus;
+	if (perfctr_cstatus_has_tsc(perfctr->iresume_cstatus)) {
+		perfctr->cpu_state.cstatus = perfctr_mk_cstatus(1, 0, 0);
+		vperfctr_resume(perfctr);
+	} else
+		perfctr->cpu_state.cstatus = 0;
+	si.si_signo = perfctr->si_signo;
+	si.si_errno = 0;
+	si.si_code = SI_PMC_OVF;
+	si.si_pmc_ovf_mask = pmc_mask;
+	if (!send_sig_info(si.si_signo, &si, tsk))
+		send_sig(si.si_signo, tsk, 1);
+}
+#endif
+
+/****************************************************************
+ *								*
+ * Process management operations.				*
+ * These must all, with the exception of vperfctr_unlink()	*
+ * and __vperfctr_set_cpus_allowed(), be called by the owner	*
+ * process only.						*
+ *								*
+ ****************************************************************/
+
+/* Called from exit_thread() or do_vperfctr_unlink().
+ * If the counters are running, stop them and sample their final values.
+ * Detach the vperfctr object from its owner task.
+ * PREEMPT note: exit_thread() does not run with preemption disabled.
+ */
+static void vperfctr_unlink(struct task_struct *owner, struct vperfctr *perfctr)
+{
+	/* this synchronises with sys_vperfctr() */
+	spin_lock(&perfctr->owner_lock);
+	perfctr->owner = NULL;
+	spin_unlock(&perfctr->owner_lock);
+
+	/* perfctr suspend+detach must be atomic wrt process suspend */
+	/* this also synchronises with perfctr_set_cpus_allowed() */
+	vperfctr_task_lock(owner);
+	if (IS_RUNNING(perfctr) && owner == current)
+		vperfctr_suspend(perfctr);
+	owner->thread.perfctr = NULL;
+	vperfctr_task_unlock(owner);
+
+	perfctr->cpu_state.cstatus = 0;
+	vperfctr_clear_iresume_cstatus(perfctr);
+	put_vperfctr(perfctr);
+}
+
+void __vperfctr_exit(struct vperfctr *perfctr)
+{
+	vperfctr_unlink(current, perfctr);
+}
+
+/* schedule() --> switch_to() --> .. --> __vperfctr_suspend().
+ * If the counters are running, suspend them.
+ * PREEMPT note: switch_to() runs with preemption disabled.
+ */
+void __vperfctr_suspend(struct vperfctr *perfctr)
+{
+	if (IS_RUNNING(perfctr))
+		vperfctr_suspend(perfctr);
+}
+
+/* schedule() --> switch_to() --> .. --> __vperfctr_resume().
+ * PRE: perfctr == current->thread.perfctr
+ * If the counters are runnable, resume them.
+ * PREEMPT note: switch_to() runs with preemption disabled.
+ */
+void __vperfctr_resume(struct vperfctr *perfctr)
+{
+	if (IS_RUNNING(perfctr)) {
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+		if (unlikely(atomic_read(&perfctr->bad_cpus_allowed)) &&
+		    perfctr_cstatus_nrctrs(perfctr->cpu_state.cstatus)) {
+			perfctr->cpu_state.cstatus = 0;
+			vperfctr_clear_iresume_cstatus(perfctr);
+			BUG_ON(current->state != TASK_RUNNING);
+			send_sig(SIGILL, current, 1);
+			return;
+		}
+#endif
+		vperfctr_resume(perfctr);
+	}
+}
+
+/* Called from update_one_process() [triggered by timer interrupt].
+ * PRE: perfctr == current->thread.perfctr.
+ * Sample the counters but do not suspend them.
+ * Needed to avoid precision loss due to multiple counter
+ * wraparounds between resume/suspend for CPU-bound processes.
+ * PREEMPT note: called in IRQ context with preemption disabled.
+ */
+void __vperfctr_sample(struct vperfctr *perfctr)
+{
+	if (--perfctr->sampling_timer == 0)
+		vperfctr_sample(perfctr);
+}
+
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+/* Called from set_cpus_allowed().
+ * PRE: current holds task_lock(owner)
+ * PRE: owner->thread.perfctr == perfctr
+ */
+void __vperfctr_set_cpus_allowed(struct task_struct *owner,
+				 struct vperfctr *perfctr,
+				 cpumask_t new_mask)
+{
+	cpumask_t tmp;
+
+	cpus_and(tmp, new_mask, perfctr_cpus_forbidden_mask);
+	if (!cpus_empty(tmp)) {
+		atomic_set(&perfctr->bad_cpus_allowed, 1);
+		printk(KERN_WARNING "perfctr: process %d (comm %s) issued unsafe"
+		       " set_cpus_allowed() on process %d (comm %s)\n",
+		       current->pid, current->comm, owner->pid, owner->comm);
+	} else
+		atomic_set(&perfctr->bad_cpus_allowed, 0);
+}
+#endif
+
+/****************************************************************
+ *								*
+ * Virtual perfctr system calls implementation.			*
+ * These can be called by the owner process (tsk == current),	*
+ * a monitor process which has the owner under ptrace ATTACH	*
+ * control (tsk && tsk != current), or anyone with a handle to	*
+ * an unlinked perfctr (!tsk).					*
+ *								*
+ ****************************************************************/
+
+static int do_vperfctr_control(struct vperfctr *perfctr,
+			       const struct vperfctr_control *argp,
+			       struct task_struct *tsk)
+{
+	struct vperfctr_control control;
+	int err;
+	unsigned int next_cstatus;
+	unsigned int nrctrs, i;
+
+	if (!tsk)
+		return -ESRCH;	/* attempt to update unlinked perfctr */
+
+	if (copy_from_user(&control, argp, sizeof control))
+		return -EFAULT;
+
+	if (control.cpu_control.nractrs || control.cpu_control.nrictrs) {
+		cpumask_t tmp, old_mask, new_mask;
+
+		tmp = perfctr_cpus_forbidden_mask;
+		cpus_complement(tmp);
+		old_mask = tsk->cpus_allowed;
+		cpus_and(new_mask, old_mask, tmp);
+
+		if (cpus_empty(new_mask))
+			return -EINVAL;
+		if (!cpus_equal(new_mask, old_mask))
+			set_cpus_allowed(tsk, new_mask);
+	}
+
+	/* PREEMPT note: preemption is disabled over the entire
+	   region since we're updating an active perfctr. */
+	preempt_disable();
+	if (IS_RUNNING(perfctr)) {
+		if (tsk == current)
+			vperfctr_suspend(perfctr);
+		perfctr->cpu_state.cstatus = 0;
+		vperfctr_clear_iresume_cstatus(perfctr);
+	}
+	perfctr->cpu_state.control = control.cpu_control;
+	/* remote access note: perfctr_cpu_update_control() is ok */
+	err = perfctr_cpu_update_control(&perfctr->cpu_state, 0);
+	if (err < 0)
+		goto out;
+	next_cstatus = perfctr->cpu_state.cstatus;
+	if (!perfctr_cstatus_enabled(next_cstatus))
+		goto out;
+
+	/* XXX: validate si_signo? */
+	perfctr->si_signo = control.si_signo;
+
+	if (!perfctr_cstatus_has_tsc(next_cstatus))
+		perfctr->cpu_state.tsc_sum = 0;
+
+	nrctrs = perfctr_cstatus_nrctrs(next_cstatus);
+	for(i = 0; i < nrctrs; ++i)
+		if (!(control.preserve & (1<<i)))
+			perfctr->cpu_state.pmc[i].sum = 0;
+
+	if (tsk == current)
+		vperfctr_resume(perfctr);
+
+ out:
+	preempt_enable();
+	return err;
+}
+
+static int do_vperfctr_iresume(struct vperfctr *perfctr, const struct task_struct *tsk)
+{
+#if PERFCTR_INTERRUPT_SUPPORT
+	unsigned int iresume_cstatus;
+
+	if (!tsk)
+		return -ESRCH;	/* attempt to update unlinked perfctr */
+
+	iresume_cstatus = perfctr->iresume_cstatus;
+	if (!perfctr_cstatus_has_ictrs(iresume_cstatus))
+		return -EPERM;
+
+	/* PREEMPT note: preemption is disabled over the entire
+	   region because we're updating an active perfctr. */
+	preempt_disable();
+
+	if (IS_RUNNING(perfctr) && tsk == current)
+		vperfctr_suspend(perfctr);
+
+	perfctr->cpu_state.cstatus = iresume_cstatus;
+	perfctr->iresume_cstatus = 0;
+
+	/* remote access note: perfctr_cpu_ireload() is ok */
+	perfctr_cpu_ireload(&perfctr->cpu_state);
+
+	if (tsk == current)
+		vperfctr_resume(perfctr);
+
+	preempt_enable();
+
+	return 0;
+#else
+	return -ENOSYS;
+#endif
+}
+
+static int do_vperfctr_unlink(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	if (tsk)
+		vperfctr_unlink(tsk, perfctr);
+	return 0;
+}
+
+static int do_vperfctr_read(struct vperfctr *perfctr,
+			    struct perfctr_sum_ctrs *sump,
+			    struct vperfctr_control *controlp,
+			    const struct task_struct *tsk)
+{
+	struct perfctr_sum_ctrs sum;
+	struct vperfctr_control control;
+
+	/* PREEMPT note: While we're reading our own control, another
+	   process may ptrace ATTACH to us and update our control.
+	   Disable preemption to ensure we get a consistent copy.
+	   Not needed for other cases since the perfctr is either
+	   unlinked or its owner is ptrace ATTACH suspended by us. */
+	if (tsk == current) {
+		preempt_disable();
+		if (sump)
+			vperfctr_sample(perfctr);
+	}
+	if (sump) { //sum = perfctr->cpu_state.sum;
+		int j;
+		sum.tsc = perfctr->cpu_state.tsc_sum;
+		for(j = 0; j < ARRAY_SIZE(sum.pmc); ++j)
+			sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
+	}
+	if (controlp) {
+		control.si_signo = perfctr->si_signo;
+		control.cpu_control = perfctr->cpu_state.control;
+		control.preserve = 0;
+	}
+	if (tsk == current)
+		preempt_enable();
+	if (sump && copy_to_user(sump, &sum, sizeof sum))
+		return -EFAULT;
+	if (controlp && copy_to_user(controlp, &control, sizeof control))
+		return -EFAULT;
+	return 0;
+}
+
+/****************************************************************
+ *								*
+ * Virtual perfctr file operations.				*
+ *								*
+ ****************************************************************/
+
+static int vperfctr_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct vperfctr *perfctr;
+
+	/* Only allow read-only mapping of first page. */
+	if ((vma->vm_end - vma->vm_start) != PAGE_SIZE ||
+	    vma->vm_pgoff != 0 ||
+	    (pgprot_val(vma->vm_page_prot) & _PAGE_RW) ||
+	    (vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
+		return -EPERM;
+	perfctr = filp->private_data;
+	if (!perfctr)
+		return -EPERM;
+	return remap_page_range(vma, vma->vm_start, virt_to_phys(perfctr),
+				PAGE_SIZE, vma->vm_page_prot);
+}
+
+static int vperfctr_release(struct inode *inode, struct file *filp)
+{
+	struct vperfctr *perfctr = filp->private_data;
+	filp->private_data = NULL;
+	if (perfctr)
+		put_vperfctr(perfctr);
+	return 0;
+}
+
+static struct file_operations vperfctr_file_ops = {
+	.mmap = vperfctr_mmap,
+	.release = vperfctr_release,
+};
+
+/****************************************************************
+ *								*
+ * File system for virtual perfctrs. Based on pipefs.		*
+ *								*
+ ****************************************************************/
+
+#define VPERFCTRFS_MAGIC (('V'<<24)|('P'<<16)|('M'<<8)|('C'))
+
+/* The code to set up a `struct file_system_type' for a pseudo fs
+   is unfortunately not the same in 2.4 and 2.6. */
+#include <linux/mount.h> /* needed for 2.6, included by fs.h in 2.4 */
+
+static struct super_block *
+vperfctrfs_get_sb(struct file_system_type *fs_type,
+		  int flags, const char *dev_name, void *data)
+{
+	return get_sb_pseudo(fs_type, "vperfctr:", NULL, VPERFCTRFS_MAGIC);
+}
+
+static struct file_system_type vperfctrfs_type = {
+	.name		= "vperfctrfs",
+	.get_sb		= vperfctrfs_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+/* XXX: check if s/vperfctr_mnt/vperfctrfs_type.kern_mnt/ would work */
+static struct vfsmount *vperfctr_mnt;
+#define vperfctr_fs_init_done()	(vperfctr_mnt != NULL)
+
+static int __init vperfctrfs_init(void)
+{
+	int err = register_filesystem(&vperfctrfs_type);
+	if (!err) {
+		vperfctr_mnt = kern_mount(&vperfctrfs_type);
+		if (!IS_ERR(vperfctr_mnt))
+			return 0;
+		err = PTR_ERR(vperfctr_mnt);
+		unregister_filesystem(&vperfctrfs_type);
+		vperfctr_mnt = NULL;
+	}
+	return err;
+}
+
+static void __exit vperfctrfs_exit(void)
+{
+	unregister_filesystem(&vperfctrfs_type);
+	mntput(vperfctr_mnt);
+}
+
+static struct inode *vperfctr_get_inode(void)
+{
+	struct inode *inode;
+
+	inode = new_inode(vperfctr_mnt->mnt_sb);
+	if (!inode)
+		return NULL;
+	inode->i_fop = &vperfctr_file_ops;
+	inode->i_state = I_DIRTY;
+	inode->i_mode = S_IFCHR | S_IRUSR | S_IWUSR;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_blksize = 0;
+	return inode;
+}
+
+static int vperfctrfs_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations vperfctrfs_dentry_operations = {
+	.d_delete	= vperfctrfs_delete_dentry,
+};
+
+static struct dentry *vperfctr_d_alloc_root(struct inode *inode)
+{
+	struct qstr this;
+	char name[32];
+	struct dentry *dentry;
+
+	sprintf(name, "[%lu]", inode->i_ino);
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = inode->i_ino; /* will go */
+	dentry = d_alloc(vperfctr_mnt->mnt_sb->s_root, &this);
+	if (dentry) {
+		dentry->d_op = &vperfctrfs_dentry_operations;
+		d_add(dentry, inode);
+	}
+	return dentry;
+}
+
+static struct file *vperfctr_get_filp(void)
+{
+	struct file *filp;
+	struct inode *inode;
+	struct dentry *dentry;
+
+	filp = get_empty_filp();
+	if (!filp)
+		goto out;
+	inode = vperfctr_get_inode();
+	if (!inode)
+		goto out_filp;
+	dentry = vperfctr_d_alloc_root(inode);
+	if (!dentry)
+		goto out_inode;
+
+	filp->f_vfsmnt = mntget(vperfctr_mnt);
+	filp->f_dentry = dentry;
+	filp->f_mapping = dentry->d_inode->i_mapping;
+
+	filp->f_pos = 0;
+	filp->f_flags = 0;
+	filp->f_op = &vperfctr_file_ops; /* fops_get() if MODULE */
+	filp->f_mode = FMODE_READ;
+	filp->f_version = 0;
+
+	return filp;
+
+ out_inode:
+	iput(inode);
+ out_filp:
+	put_filp(filp);	/* doesn't run ->release() like fput() does */
+ out:
+	return NULL;
+}
+
+/****************************************************************
+ *								*
+ * Virtual perfctr actual system calls.				*
+ *								*
+ ****************************************************************/
+
+/* tid is the actual task/thread id (née pid, stored as ->pid),
+   pid/tgid is that 2.6 thread group id crap (stored as ->tgid) */
+asmlinkage long sys_vperfctr_open(int tid, int creat)
+{
+	struct file *filp;
+	struct task_struct *tsk;
+	struct vperfctr *perfctr;
+	int err;
+	int fd;
+
+	if (!vperfctr_fs_init_done())
+		return -ENODEV;
+	filp = vperfctr_get_filp();
+	if (!filp)
+		return -ENOMEM;
+	err = fd = get_unused_fd();
+	if (err < 0)
+		goto err_filp;
+	perfctr = NULL;
+	if (creat) {
+		perfctr = get_empty_vperfctr(); /* may sleep */
+		if (IS_ERR(perfctr)) {
+			err = PTR_ERR(perfctr);
+			goto err_fd;
+		}
+	}
+	tsk = current;
+	if (tid != 0 && tid != tsk->pid) { /* remote? */
+		read_lock(&tasklist_lock);
+		tsk = find_task_by_pid(tid);
+		if (tsk)
+			get_task_struct(tsk);
+		read_unlock(&tasklist_lock);
+		err = -ESRCH;
+		if (!tsk)
+			goto err_perfctr;
+		err = ptrace_check_attach(tsk, 0);
+		if (err < 0)
+			goto err_tsk;
+	}
+	if (creat) {
+		/* check+install must be atomic to prevent remote-control races */
+		vperfctr_task_lock(tsk);
+		if (!tsk->thread.perfctr) {
+			perfctr->owner = tsk;
+			tsk->thread.perfctr = perfctr;
+			err = 0;
+		} else
+			err = -EEXIST;
+		vperfctr_task_unlock(tsk);
+		if (err)
+			goto err_tsk;
+	} else {
+		perfctr = tsk->thread.perfctr;
+		/* XXX: Old API needed to allow NULL perfctr here.
+		   Do we want to keep or change that rule? */
+	}
+	filp->private_data = perfctr;
+	if (perfctr)
+		atomic_inc(&perfctr->count);
+	if (tsk != current)
+		put_task_struct(tsk);
+	fd_install(fd, filp);
+	return fd;
+ err_tsk:
+	if (tsk != current)
+		put_task_struct(tsk);
+ err_perfctr:
+	if (perfctr)	/* can only occur if creat != 0 */
+		put_vperfctr(perfctr);
+ err_fd:
+	put_unused_fd(fd);
+ err_filp:
+	fput(filp);
+	return err;
+}
+
+static struct vperfctr *fd_get_vperfctr(int fd)
+{
+	struct vperfctr *perfctr;
+	struct file *filp;
+	int err;
+
+	err = -EBADF;
+	filp = fget(fd);
+	if (!filp)
+		goto out;
+	err = -EINVAL;
+	if (filp->f_op != &vperfctr_file_ops)
+		goto out_filp;
+	perfctr = filp->private_data;
+	if (!perfctr)
+		goto out_filp;
+	atomic_inc(&perfctr->count);
+	fput(filp);
+	return perfctr;
+ out_filp:
+	fput(filp);
+ out:
+	return ERR_PTR(err);
+}
+
+static struct task_struct *vperfctr_get_tsk(struct vperfctr *perfctr)
+{
+	struct task_struct *tsk;
+
+	tsk = current;
+	if (perfctr != current->thread.perfctr) {
+		/* this synchronises with vperfctr_unlink() and itself */
+		spin_lock(&perfctr->owner_lock);
+		tsk = perfctr->owner;
+		if (tsk)
+			get_task_struct(tsk);
+		spin_unlock(&perfctr->owner_lock);
+		if (tsk) {
+			int ret = ptrace_check_attach(tsk, 0);
+			if (ret < 0) {
+				put_task_struct(tsk);
+				return ERR_PTR(ret);
+			}
+		}
+	}
+	return tsk;
+}
+
+static void vperfctr_put_tsk(struct task_struct *tsk)
+{
+	if (tsk && tsk != current)
+		put_task_struct(tsk);
+}
+
+asmlinkage long sys_vperfctr_control(int fd, const struct vperfctr_control *control)
+{
+	struct vperfctr *perfctr;
+	struct task_struct *tsk;
+	int ret;
+
+	perfctr = fd_get_vperfctr(fd);
+	if (IS_ERR(perfctr))
+		return PTR_ERR(perfctr);
+	tsk = vperfctr_get_tsk(perfctr);
+	if (IS_ERR(tsk)) {
+		ret = PTR_ERR(tsk);
+		goto out;
+	}
+	ret = do_vperfctr_control(perfctr, control, tsk);
+	vperfctr_put_tsk(tsk);
+ out:
+	put_vperfctr(perfctr);
+	return ret;
+}
+
+asmlinkage long sys_vperfctr_unlink(int fd)
+{
+	struct vperfctr *perfctr;
+	struct task_struct *tsk;
+	int ret;
+
+	perfctr = fd_get_vperfctr(fd);
+	if (IS_ERR(perfctr))
+		return PTR_ERR(perfctr);
+	tsk = vperfctr_get_tsk(perfctr);
+	if (IS_ERR(tsk)) {
+		ret = PTR_ERR(tsk);
+		goto out;
+	}
+	ret = do_vperfctr_unlink(perfctr, tsk);
+	vperfctr_put_tsk(tsk);
+ out:
+	put_vperfctr(perfctr);
+	return ret;
+}
+
+asmlinkage long sys_vperfctr_iresume(int fd)
+{
+	struct vperfctr *perfctr;
+	struct task_struct *tsk;
+	int ret;
+
+	perfctr = fd_get_vperfctr(fd);
+	if (IS_ERR(perfctr))
+		return PTR_ERR(perfctr);
+	tsk = vperfctr_get_tsk(perfctr);
+	if (IS_ERR(tsk)) {
+		ret = PTR_ERR(tsk);
+		goto out;
+	}
+	ret = do_vperfctr_iresume(perfctr, tsk);
+	vperfctr_put_tsk(tsk);
+ out:
+	put_vperfctr(perfctr);
+	return ret;
+}
+
+asmlinkage long sys_vperfctr_read(int fd, struct perfctr_sum_ctrs *sum, struct vperfctr_control *control)
+{
+	struct vperfctr *perfctr;
+	struct task_struct *tsk;
+	int ret;
+
+	perfctr = fd_get_vperfctr(fd);
+	if (IS_ERR(perfctr))
+		return PTR_ERR(perfctr);
+	tsk = vperfctr_get_tsk(perfctr);
+	if (IS_ERR(tsk)) {
+		ret = PTR_ERR(tsk);
+		goto out;
+	}
+	ret = do_vperfctr_read(perfctr, sum, control, tsk);
+	vperfctr_put_tsk(tsk);
+ out:
+	put_vperfctr(perfctr);
+	return ret;
+}
+
+/****************************************************************
+ *								*
+ * module_init/exit						*
+ *								*
+ ****************************************************************/
+
+int __init vperfctr_init(void)
+{
+	return vperfctrfs_init();
+}
+
+void __exit vperfctr_exit(void)
+{
+	vperfctrfs_exit();
+}
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/virtual.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.virtual/drivers/perfctr/virtual.h
--- linux-2.6.7-rc1-mm1/drivers/perfctr/virtual.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.virtual/drivers/perfctr/virtual.h	2004-05-31 23:47:47.802821000 +0200
@@ -0,0 +1,13 @@
+/* $Id: virtual.h,v 1.13 2004/05/31 18:18:55 mikpe Exp $
+ * Virtual per-process performance counters.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+
+#ifdef CONFIG_PERFCTR_VIRTUAL
+extern int vperfctr_init(void);
+extern void vperfctr_exit(void);
+#else
+static inline int vperfctr_init(void) { return 0; }
+static inline void vperfctr_exit(void) { }
+#endif
