Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSJaXFW>; Thu, 31 Oct 2002 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbSJaXFU>; Thu, 31 Oct 2002 18:05:20 -0500
Received: from kim.it.uu.se ([130.238.12.178]:30920 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265469AbSJaXEI>;
	Thu, 31 Oct 2002 18:04:08 -0500
Date: Fri, 1 Nov 2002 00:10:33 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210312310.AAA07609@kim.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] performance counters 3.1 for 2.5.45 [2/4]: per-process counters
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 2 of 4 of perfctr-3.1 for the 2.5.45 kernel:
the high-level driver for virtualised per-process counters.

 drivers/perfctr/virtual.c |  738 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/vperfctr.h  |  105 ++++++
 2 files changed, 843 insertions(+)

diff -uN linux-2.5.45/drivers/perfctr/virtual.c linux-2.5.45.perfctr-3.1/drivers/perfctr/virtual.c
--- linux-2.5.45/drivers/perfctr/virtual.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.45.perfctr-3.1/drivers/perfctr/virtual.c	Thu Oct 31 23:16:59 2002
@@ -0,0 +1,738 @@
+/* $Id: virtual.c,v 1.56 2002/10/31 22:16:59 mikpe Exp $
+ * Virtual per-process performance counters.
+ *
+ * Copyright (C) 1999-2002  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/ptrace.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/vperfctr.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define VERSION "3.1"
+
+/****************************************************************
+ *								*
+ * Data types and macros.					*
+ *								*
+ ****************************************************************/
+
+struct vperfctr {
+/* User-visible fields: (must be first for mmap()) */
+	struct vperfctr_state state;
+/* Kernel-private fields: */
+	atomic_t count;
+	spinlock_t owner_lock;
+	struct task_struct *owner;
+#ifdef CONFIG_SMP
+	unsigned int sampling_timer;
+#endif
+#if PERFCTR_INTERRUPT_SUPPORT
+	unsigned int iresume_cstatus;
+#endif
+};
+#define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->state.cpu_state.cstatus)
+
+static struct file_operations vperfctr_file_ops;	/* forward */
+static struct file *vperfctr_get_filp(void);		/* forward */
+
+/****************************************************************
+ *								*
+ * Basic counter operations.					*
+ * These must all be called by the owner process only.		*
+ * These must all be called with preemption disabled.		*
+ *								*
+ ****************************************************************/
+
+/* PRE: perfctr == TASK_VPERFCTR(current) && IS_RUNNING(perfctr)
+ * Suspend the counters.
+ */
+static inline void vperfctr_suspend(struct vperfctr *perfctr)
+{
+	perfctr_cpu_suspend(&perfctr->state.cpu_state);
+}
+
+static inline void vperfctr_reset_sampling_timer(struct vperfctr *perfctr)
+{
+#ifdef CONFIG_SMP
+	/* XXX: base the value on perfctr_cpu_info.khz instead! */
+	perfctr->sampling_timer = HZ/2;
+#endif
+}
+
+/* PRE: perfctr == TASK_VPERFCTR(current) && IS_RUNNING(perfctr)
+ * Restart the counters.
+ */
+static inline void vperfctr_resume(struct vperfctr *perfctr)
+{
+	perfctr_cpu_resume(&perfctr->state.cpu_state);
+	vperfctr_reset_sampling_timer(perfctr);
+}
+
+/* Sample the counters but do not suspend them. */
+static void vperfctr_sample(struct vperfctr *perfctr)
+{
+	if( IS_RUNNING(perfctr) ) {
+		perfctr_cpu_sample(&perfctr->state.cpu_state);
+		vperfctr_reset_sampling_timer(perfctr);
+	}
+}
+
+/****************************************************************
+ *								*
+ * Overflow interrupt support.					*
+ *								*
+ ****************************************************************/
+
+#if PERFCTR_INTERRUPT_SUPPORT
+
+/* PREEMPT note: called in IRQ context with preemption disabled. */
+static void vperfctr_ihandler(unsigned long pc)
+{
+	struct task_struct *tsk = current;
+	struct vperfctr *perfctr;
+	unsigned int pmc_mask;
+	siginfo_t si;
+
+	perfctr = tsk->thread.vperfctr;
+	if( !perfctr ) {
+		printk(KERN_ERR "%s: BUG! pid %d has no vperfctr\n",
+		       __FUNCTION__, tsk->pid);
+		return;
+	}
+	if( !perfctr_cstatus_has_ictrs(perfctr->state.cpu_state.cstatus) ) {
+		printk(KERN_ERR "%s: BUG! vperfctr has cstatus %#x (pid %d, comm %s)\n",
+		       __FUNCTION__, perfctr->state.cpu_state.cstatus, tsk->pid, tsk->comm);
+		return;
+	}
+	vperfctr_suspend(perfctr);
+	pmc_mask = perfctr_cpu_identify_overflow(&perfctr->state.cpu_state);
+	if( !pmc_mask ) {
+		printk(KERN_ERR "%s: BUG! pid %d has unidentifiable overflow source\n",
+		       __FUNCTION__, tsk->pid);
+		return;
+	}
+	/* suspend a-mode and i-mode PMCs, leaving only TSC on */
+	perfctr->iresume_cstatus = perfctr->state.cpu_state.cstatus;
+	if( perfctr_cstatus_has_tsc(perfctr->iresume_cstatus) ) {
+		perfctr->state.cpu_state.cstatus = perfctr_mk_cstatus(1, 0, 0);
+		vperfctr_resume(perfctr);
+	} else
+		perfctr->state.cpu_state.cstatus = 0;
+	si.si_signo = perfctr->state.si_signo;
+	si.si_errno = 0;
+	si.si_code = SI_PMC_OVF;
+	si.si_pmc_ovf_mask = pmc_mask;
+	if( !send_sig_info(si.si_signo, &si, tsk) )
+		send_sig(si.si_signo, tsk, 1);
+}
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
+static int sys_vperfctr_iresume(struct vperfctr *perfctr, int is_remote)
+{
+	unsigned int iresume_cstatus;
+
+	iresume_cstatus = perfctr->iresume_cstatus;
+	if( !perfctr_cstatus_has_ictrs(iresume_cstatus) )
+		return -EPERM;
+
+	/* PREEMPT note: preemption is disabled over the entire
+	   region because we're updating an active perfctr. */
+	preempt_disable();
+
+	if( IS_RUNNING(perfctr) && !is_remote )
+		vperfctr_suspend(perfctr);
+
+	perfctr->state.cpu_state.cstatus = iresume_cstatus;
+	perfctr->iresume_cstatus = 0;
+
+	/* remote access note: perfctr_cpu_ireload() is ok */
+	perfctr_cpu_ireload(&perfctr->state.cpu_state);
+
+	if( !is_remote )
+		vperfctr_resume(perfctr);
+
+	preempt_enable();
+
+	return 0;
+}
+
+#else /* PERFCTR_INTERRUPT_SUPPORT */
+static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr) { }
+static inline void vperfctr_set_ihandler(void) { }
+static inline int sys_vperfctr_iresume(struct vperfctr *perfctr, int is_remote)
+{
+	return -ENOSYS;
+}
+#endif /* PERFCTR_INTERRUPT_SUPPORT */
+
+/****************************************************************
+ *								*
+ * Resource management.						*
+ *								*
+ ****************************************************************/
+
+/* XXX: perhaps relax this to number of _live_ perfctrs */
+static spinlock_t nrctrs_lock = SPIN_LOCK_UNLOCKED;
+int nrctrs = 0;
+static const char this_service[] = __FILE__;
+
+static int inc_nrctrs(void)
+{
+	const char *other;
+
+	other = NULL;
+	spin_lock(&nrctrs_lock);
+	if( ++nrctrs == 1 )
+		other = perfctr_cpu_reserve(this_service);
+	spin_unlock(&nrctrs_lock);
+	if( other ) {
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
+	if( --nrctrs == 0 )
+		perfctr_cpu_release(this_service);
+	spin_unlock(&nrctrs_lock);
+}
+
+static struct vperfctr *vperfctr_alloc(void)
+{
+	unsigned long page;
+
+	if( inc_nrctrs() != 0 )
+		return NULL;
+	page = get_zeroed_page(GFP_KERNEL);
+	if( !page ) {
+		dec_nrctrs();
+		return NULL;
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
+	if( perfctr ) {
+		perfctr->state.magic = VPERFCTR_MAGIC;
+		atomic_set(&perfctr->count, 1);
+		spin_lock_init(&perfctr->owner_lock);
+	}
+	return perfctr;
+}
+
+static void put_vperfctr(struct vperfctr *perfctr)
+{
+	if( atomic_dec_and_test(&perfctr->count) )
+		vperfctr_free(perfctr);
+}
+
+/****************************************************************
+ *								*
+ * Process management operations.				*
+ * These must all, with the exception of __vperfctr_exit(),	*
+ * be called by the owner process only.				*
+ *								*
+ ****************************************************************/
+
+/* Called from exit_thread() or sys_vperfctr_unlink().
+ * The vperfctr has just been detached from its owner.
+ * If the counters are running, stop them and sample their final values.
+ * Mark this perfctr as dead and decrement its use count.
+ * PREEMPT note: exit_thread() does not run with preemption disabled.
+ */
+void __vperfctr_exit(struct vperfctr *perfctr)
+{
+	struct task_struct *owner;
+
+	spin_lock(&perfctr->owner_lock);
+	owner = perfctr->owner;
+	/* owner->thread.perfctr = NULL was done by the caller */
+	perfctr->owner = NULL;
+	spin_unlock(&perfctr->owner_lock);
+
+	if( IS_RUNNING(perfctr) && owner == current ) {
+		preempt_disable();
+		vperfctr_suspend(perfctr);
+		preempt_enable();
+	}
+	perfctr->state.cpu_state.cstatus = 0;
+	vperfctr_clear_iresume_cstatus(perfctr);
+	put_vperfctr(perfctr);
+}
+
+/* schedule() --> switch_to() --> .. --> __vperfctr_suspend().
+ * If the counters are running, suspend them.
+ * PREEMPT note: switch_to() runs with preemption disabled.
+ */
+void __vperfctr_suspend(struct vperfctr *perfctr)
+{
+	if( IS_RUNNING(perfctr) )
+		vperfctr_suspend(perfctr);
+}
+
+/* schedule() --> switch_to() --> .. --> __vperfctr_resume().
+ * PRE: perfctr == TASK_VPERFCTR(current)
+ * If the counters are runnable, resume them.
+ * PREEMPT note: switch_to() runs with preemption disabled.
+ */
+void __vperfctr_resume(struct vperfctr *perfctr)
+{
+	if( IS_RUNNING(perfctr) )
+		vperfctr_resume(perfctr);
+}
+
+#ifdef CONFIG_SMP
+/* Called from update_one_process() [triggered by timer interrupt].
+ * PRE: perfctr == TASK_VPERFCTR(current).
+ * Sample the counters but do not suspend them.
+ * Needed on SMP to avoid precision loss due to multiple counter
+ * wraparounds between resume/suspend for CPU-bound processes.
+ * PREEMPT note: called in IRQ context with preemption disabled.
+ */
+void __vperfctr_sample(struct vperfctr *perfctr)
+{
+	if( --perfctr->sampling_timer == 0 )
+		vperfctr_sample(perfctr);
+}
+#endif
+
+/****************************************************************
+ *								*
+ * Virtual perfctr "system calls".				*
+ * These can be called by the owner process, or by a monitor	*
+ * process which has the owner under ptrace ATTACH control.	*
+ *								*
+ ****************************************************************/
+
+static int sys_vperfctr_control(struct vperfctr *perfctr,
+				struct vperfctr_control *argp,
+				int is_remote)
+{
+	struct vperfctr_control control;
+	int err;
+	unsigned int next_cstatus;
+	unsigned int nrctrs, i;
+
+	if( copy_from_user(&control, argp, sizeof control) )
+		return -EFAULT;
+	/* PREEMPT note: preemption is disabled over the entire
+	   region since we're updating an active perfctr. */
+	preempt_disable();
+	if( IS_RUNNING(perfctr) ) {
+		if( !is_remote )
+			vperfctr_suspend(perfctr);
+		perfctr->state.cpu_state.cstatus = 0;
+		vperfctr_clear_iresume_cstatus(perfctr);
+	}
+	perfctr->state.cpu_state.control = control.cpu_control;
+	/* remote access note: perfctr_cpu_update_control() is ok */
+	err = perfctr_cpu_update_control(&perfctr->state.cpu_state);
+	if( err < 0 )
+		goto out;
+	next_cstatus = perfctr->state.cpu_state.cstatus;
+	if( !perfctr_cstatus_enabled(next_cstatus) )
+		goto out;
+
+	/* XXX: validate si_signo? */
+	perfctr->state.si_signo = control.si_signo;
+
+	if( !perfctr_cstatus_has_tsc(next_cstatus) )
+		perfctr->state.cpu_state.sum.tsc = 0;
+
+	nrctrs = perfctr_cstatus_nrctrs(next_cstatus);
+	for(i = 0; i < nrctrs; ++i)
+		if( !(control.preserve & (1<<i)) )
+			perfctr->state.cpu_state.sum.pmc[i] = 0;
+
+	if( !is_remote )
+		vperfctr_resume(perfctr);
+ out:
+	preempt_enable();
+	return err;
+}
+
+static int sys_vperfctr_unlink(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	(tsk ? tsk : current)->thread.vperfctr = NULL;
+	__vperfctr_exit(perfctr);
+	return 0;
+}
+
+/*
+ * Sample the counters and update state.
+ * This operation is used on processors like the pre-MMX Intel P5,
+ * which cannot sample the counter registers in user-mode.
+ */
+static int sys_vperfctr_sample(struct vperfctr *perfctr, int is_remote)
+{
+	if( !is_remote ) {
+		preempt_disable();
+		vperfctr_sample(perfctr);
+		preempt_enable();
+	}
+	return 0;
+}
+
+static int vperfctr_attach_task(struct task_struct *tsk, int creat)
+{
+	struct file *filp;
+	int err;
+	int fd;
+	struct vperfctr *perfctr;
+
+	filp = vperfctr_get_filp();
+	err = -ENOMEM;
+	if( !filp )
+		return err;
+	err = fd = get_unused_fd();
+	if( err < 0 )
+		goto out_filp;
+	if( creat ) {
+		perfctr = get_empty_vperfctr();
+		err = -ENOMEM;
+		if( !perfctr )
+			goto out_fd;
+		err = -EEXIST;
+		if( tsk->thread.vperfctr )
+			goto out_perfctr;
+		perfctr->owner = tsk;
+		tsk->thread.vperfctr = perfctr;
+	} else {
+		perfctr = tsk->thread.vperfctr;
+		err = -ENODEV;
+		if( !perfctr )
+			goto out_fd;
+	}
+	atomic_inc(&perfctr->count);
+	filp->private_data = perfctr;
+	fd_install(fd, filp);
+	return fd;
+ out_perfctr:
+	put_vperfctr(perfctr);
+ out_fd:
+	put_unused_fd(fd);
+ out_filp:
+	fput(filp);
+	return err;
+}
+
+static int vperfctr_attach_pid(int pid, int creat)
+{
+	struct task_struct *tsk;
+	int ret;
+
+	if( pid == 0 || pid == current->pid )
+		return vperfctr_attach_task(current, creat);
+	read_lock(&tasklist_lock);
+	tsk = find_task_by_pid(pid);
+	if( tsk )
+		get_task_struct(tsk);
+	read_unlock(&tasklist_lock);
+	ret = -ESRCH;
+	if( !tsk )
+		return ret;
+	ret = ptrace_check_attach(tsk, 0);
+	if( ret == 0 )
+		ret = vperfctr_attach_task(tsk, creat);
+	put_task_struct(tsk);
+	return ret;
+}
+
+static int sys_vperfctr_info(struct perfctr_cpu_info *argp)
+{
+	if( copy_to_user(argp, &perfctr_cpu_info, sizeof perfctr_cpu_info) )
+		return -EFAULT;
+	return 0;
+}
+
+static int init_done;
+
+asmlinkage int sys_vperfctr(unsigned int cmd, int whom, void *arg)
+{
+	struct vperfctr *perfctr;
+	struct task_struct *tsk;
+	struct file *filp;
+	int ret;
+
+	if( !init_done )
+		return -ENODEV;
+	switch( cmd ) {
+	case VPERFCTR_INFO:
+		return sys_vperfctr_info((struct perfctr_cpu_info*)arg);
+	case VPERFCTR_OPEN:
+		return vperfctr_attach_pid(whom, 0);
+	case VPERFCTR_CREAT:
+		return vperfctr_attach_pid(whom, 1);
+	}
+	ret = -EBADF;
+	filp = fget(whom);
+	if( !filp )
+		return ret;
+	if( filp->f_op != &vperfctr_file_ops )
+		goto out_filp;
+	perfctr = filp->private_data;
+	ret = -EINVAL;
+	if( !perfctr )
+		goto out_filp;
+	tsk = NULL;
+	if( perfctr != current->thread.vperfctr ) {
+		spin_lock(&perfctr->owner_lock);
+		tsk = perfctr->owner;
+		if( tsk )
+			get_task_struct(tsk);
+		spin_unlock(&perfctr->owner_lock);
+		ret = -ESRCH;
+		if( !tsk )
+			goto out_filp;
+		ret = ptrace_check_attach(tsk, 0);
+		if( ret < 0 )
+			goto out_tsk;
+	}
+	switch( cmd ) {
+	case VPERFCTR_CONTROL:
+		ret = sys_vperfctr_control(perfctr, (struct vperfctr_control*)arg, tsk != NULL);
+		break;
+	case VPERFCTR_UNLINK:
+		/* remote access note: unlink needs the owner task_struct */
+		ret = sys_vperfctr_unlink(perfctr, tsk);
+		break;
+	case VPERFCTR_SAMPLE:
+		ret = sys_vperfctr_sample(perfctr, tsk != NULL);
+		break;
+	case VPERFCTR_IRESUME:
+		ret = sys_vperfctr_iresume(perfctr, tsk != NULL);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+ out_tsk:
+	if( tsk )
+		put_task_struct(tsk);
+ out_filp:
+	fput(filp);
+	return ret;
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
+	if( (vma->vm_end - vma->vm_start) != PAGE_SIZE ||
+	    vma->vm_pgoff != 0 ||
+	    (pgprot_val(vma->vm_page_prot) & _PAGE_RW) ||
+	    (vma->vm_flags & (VM_WRITE | VM_MAYWRITE)) )
+		return -EPERM;
+	perfctr = filp->private_data;
+	if( !perfctr )
+		return -EPERM;
+	return remap_page_range(vma, vma->vm_start, virt_to_phys(perfctr),
+				PAGE_SIZE, vma->vm_page_prot);
+}
+
+static int vperfctr_release(struct inode *inode, struct file *filp)
+{
+	struct vperfctr *perfctr = filp->private_data;
+	filp->private_data = NULL;
+	if( perfctr )
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
+ * Virtual perfctr file system. Based on pipefs.		*
+ *								*
+ ****************************************************************/
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
+static struct vfsmount *vperfctr_mnt;
+
+static struct inode *vperfctr_get_inode(void)
+{
+	struct inode *inode;
+
+	inode = new_inode(vperfctr_mnt->mnt_sb);
+	if( !inode )
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
+	if( dentry ) {
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
+	if( !filp )
+		goto out;
+	inode = vperfctr_get_inode();
+	if( !inode )
+		goto out_filp;
+	dentry = vperfctr_d_alloc_root(inode);
+	if( !dentry )
+		goto out_inode;
+
+	filp->f_vfsmnt = mntget(vperfctr_mnt);
+	filp->f_dentry = dentry;
+
+	filp->f_pos = 0;
+	filp->f_flags = 0;
+	filp->f_op = &vperfctr_file_ops; /* use fops_get() if MODULE */
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
+#define VPERFCTRFS_MAGIC (('V'<<24)|('P'<<16)|('M'<<8)|('C'))
+
+static struct super_block *
+vperfctrfs_get_sb(struct file_system_type *fs_type,
+		  int flags, char *dev_name, void *data)
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
+static int __init vperfctrfs_init(void)
+{
+	int err = register_filesystem(&vperfctrfs_type);
+	if( !err ) {
+		vperfctr_mnt = kern_mount(&vperfctrfs_type);
+		if( !IS_ERR(vperfctr_mnt) )
+			return 0;
+		err = PTR_ERR(vperfctr_mnt);
+		unregister_filesystem(&vperfctrfs_type);
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
+/****************************************************************
+ *								*
+ * module_init/exit						*
+ *								*
+ ****************************************************************/
+
+static int __init vperfctr_init(void)
+{
+	int err;
+
+	err = perfctr_cpu_init();
+	if( err ) {
+		printk(KERN_INFO "vperfctr: not supported by this processor\n");
+		return err;
+	}
+	err = vperfctrfs_init();
+	if( err )
+		return err;
+	printk(KERN_INFO "vperfctr: version %s, cpu type %s at %lu kHz\n",
+	       VERSION,
+	       perfctr_cpu_name[perfctr_cpu_info.type],
+	       cpu_khz);
+	init_done = 1;
+	return 0;
+}
+
+static void __exit vperfctr_exit(void)
+{
+	vperfctrfs_exit();
+	perfctr_cpu_exit();
+}
+
+module_init(vperfctr_init)
+module_exit(vperfctr_exit)
diff -uN linux-2.5.45/include/linux/vperfctr.h linux-2.5.45.perfctr-3.1/include/linux/vperfctr.h
--- linux-2.5.45/include/linux/vperfctr.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.45.perfctr-3.1/include/linux/vperfctr.h	Thu Oct 31 22:36:50 2002
@@ -0,0 +1,105 @@
+/* $Id: vperfctr.h,v 1.1 2002/10/31 21:36:50 mikpe Exp $
+ * Virtual Per-Process Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 1999-2002  Mikael Pettersson
+ */
+#ifndef _LINUX_VPERFCTR_H
+#define _LINUX_VPERFCTR_H
+
+#include <asm/perfctr.h>
+
+/* user's view of mmap:ed virtual perfctr */
+struct vperfctr_state {
+	unsigned int magic;
+	int si_signo;
+	struct perfctr_cpu_state cpu_state;
+};
+
+/* `struct vperfctr_state' binary layout version number */
+#define VPERFCTR_STATE_MAGIC	0x0201	/* 2.1 */
+#define VPERFCTR_MAGIC	((VPERFCTR_STATE_MAGIC<<16)|PERFCTR_CPU_STATE_MAGIC)
+
+/* parameter in VPERFCTR_CONTROL command */
+struct vperfctr_control {
+	int si_signo;
+	struct perfctr_cpu_control cpu_control;
+	unsigned long preserve;
+};
+
+/*
+ * sys_vperfctr(unsigned int cmd, int whom, void *arg)
+ *
+ *	cmd			   whom, arg
+ */
+#define VPERFCTR_INFO	 0	/* 0, struct perfctr_cpu_info* */
+#define VPERFCTR_SAMPLE	 1	/* fd, NULL */
+#define VPERFCTR_UNLINK	 2	/* fd, NULL */
+#define VPERFCTR_CONTROL 3	/* fd, struct vperfctr_control* */
+#define VPERFCTR_IRESUME 4	/* fd, NULL */
+#define VPERFCTR_OPEN	 5	/* pid, NULL */
+#define VPERFCTR_CREAT	 6	/* pid, NULL */
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_PERFCTR_VIRTUAL
+
+struct vperfctr;	/* opaque */
+
+/* process management operations */
+extern struct vperfctr *__vperfctr_copy(struct vperfctr*);
+extern void __vperfctr_exit(struct vperfctr*);
+extern void __vperfctr_suspend(struct vperfctr*);
+extern void __vperfctr_resume(struct vperfctr*);
+extern void __vperfctr_sample(struct vperfctr*);
+
+static inline void vperfctr_copy_thread(struct thread_struct *thread)
+{
+	thread->vperfctr = NULL;
+}
+
+static inline void vperfctr_exit_thread(struct thread_struct *thread)
+{
+	struct vperfctr *vperfctr = thread->vperfctr;
+	if( vperfctr ) {
+		thread->vperfctr = NULL;
+		__vperfctr_exit(vperfctr);
+	}
+}
+
+static inline void vperfctr_suspend_thread(struct thread_struct *prev)
+{
+	struct vperfctr *vperfctr = prev->vperfctr;
+	if( vperfctr )
+		__vperfctr_suspend(vperfctr);
+}
+
+/* PRE: next is current */
+static inline void vperfctr_resume_thread(struct thread_struct *next)
+{
+	struct vperfctr *vperfctr = next->vperfctr;
+	if( vperfctr )
+		__vperfctr_resume(vperfctr);
+}
+
+static inline void vperfctr_sample_thread(struct thread_struct *thread)
+{
+#ifdef CONFIG_SMP
+	struct vperfctr *vperfctr = thread->vperfctr;
+	if( vperfctr )
+		__vperfctr_sample(vperfctr);
+#endif
+}
+
+#else	/* !CONFIG_PERFCTR_VIRTUAL */
+
+static inline void vperfctr_copy_thread(struct thread_struct *t) { }
+static inline void vperfctr_exit_thread(struct thread_struct *t) { }
+static inline void vperfctr_suspend_thread(struct thread_struct *t) { }
+static inline void vperfctr_resume_thread(struct thread_struct *t) { }
+static inline void vperfctr_sample_thread(struct thread_struct *t) { }
+
+#endif	/* CONFIG_PERFCTR_VIRTUAL */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_VPERFCTR_H */
