Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265505AbSJXO6y>; Thu, 24 Oct 2002 10:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSJXO6B>; Thu, 24 Oct 2002 10:58:01 -0400
Received: from kim.it.uu.se ([130.238.12.178]:6594 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265477AbSJXOyw>;
	Thu, 24 Oct 2002 10:54:52 -0400
Date: Thu, 24 Oct 2002 17:01:03 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210241501.RAA03591@kim.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: [3/4] per-process counters
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is perfctr-3.0-pre2 for 2.5.44. This is the 2.5-ready version
of the Linux/x86 performance-monitoring counters kernel extension.
Please consider it for inclusion in 2.5/2.6.

This is part 3 of 4: adding files to support per-process counters.
The kernel will still compile with this patch set applied.

/Mikael

 virtual.c        |  691 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 virtual.h        |   18 +
 virtual_compat.c |  111 ++++++++
 virtual_compat.h |   45 +++
 4 files changed, 865 insertions(+)

diff -ruN linux-2.5.44/drivers/perfctr/virtual.c linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual.c
--- linux-2.5.44/drivers/perfctr/virtual.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual.c	Wed Oct 23 23:27:21 2002
@@ -0,0 +1,691 @@
+/* $Id: virtual.c,v 1.52 2002/10/20 21:54:46 mikpe Exp $
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
+#include <linux/perfctr.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include "compat.h"
+#include "virtual.h"
+#include "virtual_compat.h"
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
+	/* XXX: base the value on perfctr_info.cpu_khz instead! */
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
+static void vperfctr_ihandler(unsigned long pc)
+{
+	struct task_struct *tsk = current;
+	struct vperfctr *perfctr;
+	unsigned int pmc_mask;
+	siginfo_t si;
+
+	perfctr = tsk->thread.perfctr;
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
+	if( IS_RUNNING(perfctr) && owner == current )
+		vperfctr_suspend(perfctr);
+	perfctr->state.cpu_state.cstatus = 0;
+	vperfctr_clear_iresume_cstatus(perfctr);
+	put_vperfctr(perfctr);
+}
+
+/* schedule() --> switch_to() --> .. --> __vperfctr_suspend().
+ * If the counters are running, suspend them.
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
+static void vperfctr_stop(struct vperfctr *perfctr, int is_remote)
+{
+	if( IS_RUNNING(perfctr) ) {
+		if( !is_remote )
+			vperfctr_suspend(perfctr);
+		perfctr->state.cpu_state.cstatus = 0;
+		vperfctr_clear_iresume_cstatus(perfctr);
+	}
+}
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
+	vperfctr_stop(perfctr, is_remote);
+	perfctr->state.cpu_state.control = control.cpu_control;
+	/* remote access note: perfctr_cpu_update_control() is ok */
+	err = perfctr_cpu_update_control(&perfctr->state.cpu_state);
+	if( err < 0 )
+		return err;
+	next_cstatus = perfctr->state.cpu_state.cstatus;
+	if( !perfctr_cstatus_enabled(next_cstatus) )
+		return 0;
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
+
+	return 0;
+}
+
+static int sys_vperfctr_unlink(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	(tsk ? tsk : current)->thread.perfctr = NULL;
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
+	if( !is_remote )
+		vperfctr_sample(perfctr);
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
+		if( tsk->thread.perfctr )
+			goto out_perfctr;
+		perfctr->owner = tsk;
+		tsk->thread.perfctr = perfctr;
+	} else {
+		perfctr = tsk->thread.perfctr;
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
+int sys_vperfctr(unsigned int cmd, int whom, void *arg)
+{
+	struct vperfctr *perfctr;
+	struct task_struct *tsk;
+	struct file *filp;
+	int ret;
+
+	switch( cmd ) {
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
+	if( perfctr != current->thread.perfctr ) {
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
+int __init vperfctr_init(void)
+{
+	return vperfctrfs_init();
+}
+
+void __exit vperfctr_exit(void)
+{
+	vperfctrfs_exit();
+}
diff -ruN linux-2.5.44/drivers/perfctr/virtual.h linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual.h
--- linux-2.5.44/drivers/perfctr/virtual.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual.h	Wed Oct 23 21:38:10 2002
@@ -0,0 +1,18 @@
+/* $Id: virtual.h,v 1.8 2002/10/20 21:52:32 mikpe Exp $
+ * Virtual per-process performance counters.
+ *
+ * Copyright (C) 1999-2002  Mikael Pettersson
+ */
+
+#ifdef CONFIG_PERFCTR_VIRTUAL
+extern int vperfctr_init(void);
+extern void vperfctr_exit(void);
+extern int sys_vperfctr(unsigned int cmd, int whom, void *arg);
+#else
+static inline int vperfctr_init(void) { return 0; }
+static inline void vperfctr_exit(void) { }
+static inline int sys_vperfctr(unsigned int cmd, int whom, void *arg)
+{
+	return -ENOSYS;
+}
+#endif
diff -ruN linux-2.5.44/drivers/perfctr/virtual_compat.c linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual_compat.c
--- linux-2.5.44/drivers/perfctr/virtual_compat.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual_compat.c	Wed Oct 23 23:16:14 2002
@@ -0,0 +1,111 @@
+/* $Id: virtual_compat.c,v 1.1 2002/10/11 08:47:05 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Virtual perfctrs backwards compatibility support code.
+ *
+ * Copyright (C) 2002  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/sched.h>
+#include <asm/processor.h>
+
+/* Implement ptrace_check_attach() for older kernels. */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,15)
+#include "compat.h"
+#define task_has_cpu(tsk)	((tsk)->has_cpu)
+int ptrace_check_attach(struct task_struct *child, int kill)
+{
+	if (!(child->ptrace & PT_PTRACED))
+		return -ESRCH;
+
+	if (child->p_pptr != current)
+		return -ESRCH;
+
+	if (!kill) {
+		if (child->state != TASK_STOPPED)
+			return -ESRCH;
+#ifdef CONFIG_SMP
+		/* Make sure the child gets off its CPU.. */
+		for (;;) {
+			task_lock(child);
+			if (!task_has_cpu(child))
+				break;
+			task_unlock(child);
+			do {
+				if (child->state != TASK_STOPPED)
+					return -ESRCH;
+				barrier();
+				cpu_relax();
+			} while (task_has_cpu(child));
+		}
+		task_unlock(child);
+#endif		
+	}
+
+	/* All systems go.. */
+	return 0;
+}
+#endif	/* < 2.4.15 */
+
+/* Simulate 2.5's struct file_system_type in 2.4. */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#include <linux/module.h>
+#define IN_VIRTUAL_COMPAT_C
+#include "virtual_compat.h"
+
+#define VPERFCTRFS_MAGIC	(('V'<<24)|('P'<<16)|('M'<<8)|('C'))
+
+static int vperfctrfs_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = VPERFCTRFS_MAGIC;
+	buf->f_bsize = 1024;
+	buf->f_namelen = 255;
+	return 0;
+}
+
+static struct super_operations vperfctrfs_ops = {
+	.statfs = vperfctrfs_statfs,
+};
+
+static struct super_block *vperfctrfs_read_super(struct super_block *sb, void *date, int silent)
+{
+	struct inode *root = new_inode(sb);
+	if( !root )
+		return NULL;
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_uid = root->i_gid = 0;
+	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+	sb->s_blocksize = 1024;
+	sb->s_blocksize_bits = 10;
+	sb->s_magic = VPERFCTRFS_MAGIC;
+	sb->s_op = &vperfctrfs_ops;
+	sb->s_root = d_alloc(NULL, &(const struct qstr) { "vperfctrfs:", 11, 0 });
+	if( !sb->s_root ) {
+		iput(root);
+		return NULL;
+	}
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	d_instantiate(sb->s_root, root);
+	return sb;
+}
+
+static DECLARE_FSTYPE(actual_vperfctrfs_type, "vperfctrfs",
+		      vperfctrfs_read_super, FS_NOMOUNT);
+
+int perfctr_register_filesystem(struct perfctr_file_system_type *fake_fs_type)
+{
+	return register_filesystem(&actual_vperfctrfs_type);
+}
+
+void perfctr_unregister_filesystem(struct perfctr_file_system_type *fake_fs_type)
+{
+	unregister_filesystem(&actual_vperfctrfs_type);
+}
+
+struct vfsmount *perfctr_kern_mount(struct perfctr_file_system_type *fake_fs_type)
+{
+	return kern_mount(&actual_vperfctrfs_type);
+}
+
+#endif	/* < 2.5.0 */
diff -ruN linux-2.5.44/drivers/perfctr/virtual_compat.h linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual_compat.h
--- linux-2.5.44/drivers/perfctr/virtual_compat.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/virtual_compat.h	Wed Oct 23 23:10:48 2002
@@ -0,0 +1,45 @@
+/* $Id: virtual_compat.h,v 1.1 2002/10/11 08:47:05 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Virtual perfctrs backwards compatibility support code.
+ *
+ * Copyright (C) 2002  Mikael Pettersson
+ */
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,15)
+extern int ptrace_check_attach(struct task_struct *child, int kill);
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+/* Gross hacks to simulate 2.5's get_sb_pseudo() and differently
+   shaped struct file_system_type in 2.4. */
+
+struct perfctr_file_system_type {
+	const char *name;
+	struct super_block *(*get_sb)(struct perfctr_file_system_type*, int, char*, void*);
+	void (*kill_sb)(void);
+};
+
+extern int perfctr_register_filesystem(struct perfctr_file_system_type*);
+extern void perfctr_unregister_filesystem(struct perfctr_file_system_type*);
+extern struct vfsmount *perfctr_kern_mount(struct perfctr_file_system_type*);
+
+#if !defined(IN_VIRTUAL_COMPAT_C)
+/* Hack the name space seen in virtual.c */
+#define file_system_type perfctr_file_system_type
+static inline struct super_block *
+get_sb_pseudo(struct file_system_type *fs_type,
+	      const char *name, void *whatever, unsigned int magic)
+{
+	return NULL;
+}
+#define kill_anon_super (void(*)(void))0
+#undef register_filesystem
+#define register_filesystem(fs) perfctr_register_filesystem(fs)
+#undef unregister_filesystem
+#define unregister_filesystem(fs) perfctr_unregister_filesystem(fs)
+#undef kern_mount
+#define kern_mount(fs) perfctr_kern_mount(fs)
+#endif	/* IN_VIRTUAL_COMPAT_C */
+
+#endif	/* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
