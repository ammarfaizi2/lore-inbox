Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWJ2NbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWJ2NbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 08:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWJ2NbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 08:31:24 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:33566 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S965211AbWJ2NbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 08:31:23 -0500
Message-ID: <4544AD24.4040801@qumranet.com>
Date: Sun, 29 Oct 2006 15:31:16 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] KVM: prepare user interface for smp guests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2006 13:31:22.0264 (UTC) FILETIME=[8623F980:01C6FB5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While the current implementation of KVM only supports UP guests,
it should be quite easy to add SMP guest support in the future.
However, I'd like to get the userspace interface right today.

The current interface is specified as a bunch of ioctls on a
/dev/kvm chardev.  Some of the ioctls operate on the entire
virtual machine (creating memory, for example), while others
operate on a specific virtual cpu (vcpu) (running a vcpu or
accessing its registers).

A potential problem with the this is that the cacheline 
containing filp->f_count will ping-pong when different
vcpus are accessed (assuming each vcpu runs on a distinct
cpu).  While with today's hardware entering and exiting guest
mode will likely dominate over this, the hardware will
improve, core counts will rise, and a 64-way guest running
on a 4-socket VT-9 implementation will likely have a lot
of cacheline bouncing.

To address this, we need a filp for every vcpu.  Two
approches have been suggested:

  1. Have the ioctl() that creates a vcpu return a new
     fd

  2. Have a pseudo filesystem to represent the virtual
     machine, a syscall to return an inode in that fs,
     and a directory or file for each vcpu.

(There is also a third approach -- do nothing -- but since
this is a holy userspace interface, and because the changes
clean up the interface somewhat, I'd like to do them)

I've tried to summarize the differences between the two
approaches:

 - fs requires a new syscall, and is therefore more
   intrusive, especially for such a specialized driver.
 - ioctl messes up too much in vfs internals for its
   own good (it wants to export cdev_get().  in the
   patch below I duplicated it because I was lazy).
 - fs is similar to spufs, while ioctl returning an
   fd is probably a (bad) precedent.
 - ioctl is less code.

Patch implementing the ioctl approach below.  Please do
comment.

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <asm/atomic.h>
 
 #include "vmx.h"
 
@@ -208,6 +209,7 @@ struct kvm_memory_slot {
 
 struct kvm {
 	spinlock_t lock; /* protects everything except vcpus */
+	atomic_t count;
 	int nmemslots;
 	struct kvm_memory_slot memslots[KVM_MEMORY_SLOTS];
 	struct list_head active_mmu_pages;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -30,6 +30,8 @@
 #include <linux/debugfs.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/cdev.h>
 
 #include "vmx.h"
 #include "x86_emulate.h"
@@ -39,6 +41,8 @@ MODULE_LICENSE("GPL");
 
 struct kvm_stat kvm_stat;
 
+static struct file_operations kvm_vcpu_ops;
+
 static struct kvm_stats_debugfs_item {
 	const char *name;
 	u32 *data;
@@ -385,11 +389,6 @@ static void __vcpu_clear(void *arg)
 		per_cpu(current_vmcs, cpu) = 0;
 }
 
-static int vcpu_slot(struct kvm_vcpu *vcpu)
-{
-	return vcpu - vcpu->kvm->vcpus;
-}
-
 /*
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
@@ -439,6 +438,15 @@ static struct kvm_vcpu *__vcpu_load(stru
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
+static struct kvm_vcpu *vcpu_get(struct kvm_vcpu *vcpu)
+{
+	mutex_lock(&vcpu->mutex);
+	return __vcpu_load(vcpu);
+}
+
+/*
+ * Switches to specified vcpu, until a matching vcpu_put()
+ */
 static struct kvm_vcpu *vcpu_load(struct kvm *kvm, int vcpu_slot)
 {
 	struct kvm_vcpu *vcpu = &kvm->vcpus[vcpu_slot];
@@ -559,6 +567,7 @@ static int kvm_dev_open(struct inode *in
 		vcpu->mmu.root_hpa = INVALID_PAGE;
 		INIT_LIST_HEAD(&vcpu->free_pages);
 	}
+	atomic_set(&kvm->count, 1);
 	filp->private_data = kvm;
 	return 0;
 }
@@ -617,13 +626,34 @@ static void kvm_free_vcpus(struct kvm *k
 		kvm_free_vcpu(&kvm->vcpus[i]);
 }
 
-static int kvm_dev_release(struct inode *inode, struct file *filp)
+static void kvm_get(struct kvm *kvm)
 {
-	struct kvm *kvm = filp->private_data;
+	atomic_inc(&kvm->count);
+}
+
+static void kvm_put(struct kvm *kvm)
+{
+	if (!atomic_dec_and_test(&kvm->count))
+		return;
 
 	kvm_free_vcpus(kvm);
 	kvm_free_physmem(kvm);
 	kfree(kvm);
+}
+
+static int kvm_dev_release(struct inode *inode, struct file *filp)
+{
+	struct kvm *kvm = filp->private_data;
+
+	kvm_put(kvm);
+	return 0;
+}
+
+static int vcpu_dev_release(struct inode *inode, struct file *filp)
+{
+	struct kvm_vcpu *vcpu = filp->private_data;
+
+	kvm_put(vcpu->kvm);
 	return 0;
 }
 
@@ -1326,14 +1356,30 @@ static void vcpu_put_rsp_rip(struct kvm_
 	vmcs_writel(GUEST_RIP, vcpu->rip);
 }
 
+static struct kobject *cdev_get(struct cdev *p)
+{
+	struct module *owner = p->owner;
+	struct kobject *kobj;
+
+	if (owner && !try_module_get(owner))
+		return NULL;
+	kobj = kobject_get(&p->kobj);
+	if (!kobj)
+		module_put(owner);
+	return kobj;
+}
+
 /*
  * Creates some virtual cpus.  Good luck creating more than one.
  */
-static int kvm_dev_ioctl_create_vcpu(struct kvm *kvm, int n)
+static int kvm_dev_ioctl_create_vcpu(struct kvm *kvm, int n,
+				     struct file *kvm_filp)
 {
 	int r;
+	struct file *filp;
 	struct kvm_vcpu *vcpu;
 	struct vmcs *vmcs;
+	int fd;
 
 	r = -EINVAL;
 	if (n < 0 || n >= KVM_MAX_VCPUS)
@@ -1343,10 +1389,20 @@ static int kvm_dev_ioctl_create_vcpu(str
 
 	mutex_lock(&vcpu->mutex);
 
-	if (vcpu->vmcs) {
-		mutex_unlock(&vcpu->mutex);
-		return -EEXIST;
-	}
+	r = -EEXIST;
+	if (vcpu->vmcs)
+		goto out_unlock;
+
+	r = -ENOMEM;
+	filp = get_empty_filp();
+	if (!filp)
+		goto out_unlock;
+
+	r = get_unused_fd();
+	if (r < 0)
+		goto out_free_filp;
+
+	fd = r;
 
 	vcpu->host_fx_image = (char*)ALIGN((hva_t)vcpu->fx_buf,
 					   FX_IMAGE_ALIGN);
@@ -1372,10 +1428,25 @@ static int kvm_dev_ioctl_create_vcpu(str
 	if (r < 0)
 		goto out_free_vcpus;
 
-	return 0;
+	filp->f_dentry = dget(kvm_filp->f_dentry);
+	filp->f_vfsmnt = mntget(kvm_filp->f_vfsmnt);
+	filp->f_mode = kvm_filp->f_mode;
+	allow_write_access(filp);
+	cdev_get(filp->f_dentry->d_inode->i_cdev);
+	kvm_get(kvm);
+	filp->f_op = fops_get(&kvm_vcpu_ops);
+	filp->private_data = vcpu;
+	fd_install(fd, filp);
+
+	return fd;
 
 out_free_vcpus:
 	kvm_free_vcpu(vcpu);
+	put_unused_fd(fd);
+out_free_filp:
+	fput(filp);
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
 out:
 	return r;
 }
@@ -2553,19 +2624,13 @@ static void save_msrs(struct vmx_msr_ent
 		rdmsrl(e[msr_index].index, e[msr_index].data);
 }
 
-static int kvm_dev_ioctl_run(struct kvm *kvm, struct kvm_run *kvm_run)
+static int vcpu_dev_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
-	struct kvm_vcpu *vcpu;
 	u8 fail;
 	u16 fs_sel, gs_sel, ldt_sel;
 	int fs_gs_ldt_reload_needed;
 
-	if (kvm_run->vcpu < 0 || kvm_run->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
-
-	vcpu = vcpu_load(kvm, kvm_run->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 
 	if (kvm_run->emulated) {
 		skip_emulated_instruction(vcpu);
@@ -2777,7 +2842,7 @@ again:
 			}
 			cond_resched();
 			/* Cannot fail -  no vcpu unplug yet. */
-			vcpu_load(kvm, vcpu_slot(vcpu));
+			vcpu_get(vcpu);
 			goto again;
 		}
 	}
@@ -2786,16 +2851,10 @@ again:
 	return 0;
 }
 
-static int kvm_dev_ioctl_get_regs(struct kvm *kvm, struct kvm_regs *regs)
+static int vcpu_dev_ioctl_get_regs(struct kvm_vcpu *vcpu,
+				   struct kvm_regs *regs)
 {
-	struct kvm_vcpu *vcpu;
-
-	if (regs->vcpu < 0 || regs->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
-
-	vcpu = vcpu_load(kvm, regs->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 
 	regs->rax = vcpu->regs[VCPU_REGS_RAX];
 	regs->rbx = vcpu->regs[VCPU_REGS_RBX];
@@ -2830,16 +2889,10 @@ static int kvm_dev_ioctl_get_regs(struct
 	return 0;
 }
 
-static int kvm_dev_ioctl_set_regs(struct kvm *kvm, struct kvm_regs *regs)
+static int vcpu_dev_ioctl_set_regs(struct kvm_vcpu *vcpu,
+				   struct kvm_regs *regs)
 {
-	struct kvm_vcpu *vcpu;
-
-	if (regs->vcpu < 0 || regs->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
-
-	vcpu = vcpu_load(kvm, regs->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 
 	vcpu->regs[VCPU_REGS_RAX] = regs->rax;
 	vcpu->regs[VCPU_REGS_RBX] = regs->rbx;
@@ -2868,15 +2921,10 @@ static int kvm_dev_ioctl_set_regs(struct
 	return 0;
 }
 
-static int kvm_dev_ioctl_get_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
+static int vcpu_dev_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				    struct kvm_sregs *sregs)
 {
-	struct kvm_vcpu *vcpu;
-
-	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
-	vcpu = vcpu_load(kvm, sregs->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 
 #define get_segment(var, seg) \
 	do { \
@@ -2932,16 +2980,12 @@ static int kvm_dev_ioctl_get_sregs(struc
 	return 0;
 }
 
-static int kvm_dev_ioctl_set_sregs(struct kvm *kvm, struct kvm_sregs *sregs)
+static int vcpu_dev_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				    struct kvm_sregs *sregs)
 {
-	struct kvm_vcpu *vcpu;
 	int mmu_reset_needed = 0;
 
-	if (sregs->vcpu < 0 || sregs->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
-	vcpu = vcpu_load(kvm, sregs->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 
 #define set_segment(var, seg) \
 	do { \
@@ -3016,15 +3060,14 @@ static int kvm_dev_ioctl_set_sregs(struc
 /*
  * Translate a guest virtual address to a guest physical address.
  */
-static int kvm_dev_ioctl_translate(struct kvm *kvm, struct kvm_translation *tr)
+static int vcpu_dev_ioctl_translate(struct kvm_vcpu *vcpu,
+				    struct kvm_translation *tr)
 {
 	unsigned long vaddr = tr->linear_address;
-	struct kvm_vcpu *vcpu;
+	struct kvm *kvm = vcpu->kvm;
 	gpa_t gpa;
 
-	vcpu = vcpu_load(kvm, tr->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 	spin_lock(&kvm->lock);
 	gpa = vcpu->mmu.gva_to_gpa(vcpu, vaddr);
 	tr->physical_address = gpa;
@@ -3037,17 +3080,13 @@ static int kvm_dev_ioctl_translate(struc
 	return 0;
 }
 
-static int kvm_dev_ioctl_interrupt(struct kvm *kvm, struct kvm_interrupt *irq)
+static int vcpu_dev_ioctl_interrupt(struct kvm_vcpu *vcpu,
+				    struct kvm_interrupt *irq)
 {
-	struct kvm_vcpu *vcpu;
-
-	if (irq->vcpu < 0 || irq->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
 	if (irq->irq < 0 || irq->irq >= 256)
 		return -EINVAL;
-	vcpu = vcpu_load(kvm, irq->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+
+	vcpu_get(vcpu);
 
 	set_bit(irq->irq, vcpu->irq_pending);
 	set_bit(irq->irq / BITS_PER_LONG, &vcpu->irq_summary);
@@ -3057,19 +3096,14 @@ static int kvm_dev_ioctl_interrupt(struc
 	return 0;
 }
 
-static int kvm_dev_ioctl_debug_guest(struct kvm *kvm,
-				     struct kvm_debug_guest *dbg)
+static int vcpu_dev_ioctl_debug_guest(struct kvm_vcpu *vcpu,
+				      struct kvm_debug_guest *dbg)
 {
-	struct kvm_vcpu *vcpu;
 	unsigned long dr7 = 0x400;
 	u32 exception_bitmap;
 	int old_singlestep;
 
-	if (dbg->vcpu < 0 || dbg->vcpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
-	vcpu = vcpu_load(kvm, dbg->vcpu);
-	if (!vcpu)
-		return -ENOENT;
+	vcpu_get(vcpu);
 
 	exception_bitmap = vmcs_read32(EXCEPTION_BITMAP);
 	old_singlestep = vcpu->guest_debug.singlestep;
@@ -3111,26 +3145,20 @@ static int kvm_dev_ioctl_debug_guest(str
 	return 0;
 }
 
-static long kvm_dev_ioctl(struct file *filp,
-			  unsigned int ioctl, unsigned long arg)
+static long vcpu_dev_ioctl(struct file *filp,
+			   unsigned int ioctl, unsigned long arg)
 {
-	struct kvm *kvm = filp->private_data;
+	struct kvm_vcpu *vcpu = filp->private_data;
 	int r = -EINVAL;
 
 	switch (ioctl) {
-	case KVM_CREATE_VCPU: {
-		r = kvm_dev_ioctl_create_vcpu(kvm, arg);
-		if (r)
-			goto out;
-		break;
-	}
 	case KVM_RUN: {
 		struct kvm_run kvm_run;
 
 		r = -EFAULT;
 		if (copy_from_user(&kvm_run, (void *)arg, sizeof kvm_run))
 			goto out;
-		r = kvm_dev_ioctl_run(kvm, &kvm_run);
+		r = vcpu_dev_ioctl_run(vcpu, &kvm_run);
 		if (r < 0)
 			goto out;
 		r = -EFAULT;
@@ -3142,10 +3170,7 @@ static long kvm_dev_ioctl(struct file *f
 	case KVM_GET_REGS: {
 		struct kvm_regs kvm_regs;
 
-		r = -EFAULT;
-		if (copy_from_user(&kvm_regs, (void *)arg, sizeof kvm_regs))
-			goto out;
-		r = kvm_dev_ioctl_get_regs(kvm, &kvm_regs);
+		r = vcpu_dev_ioctl_get_regs(vcpu, &kvm_regs);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -3160,7 +3185,7 @@ static long kvm_dev_ioctl(struct file *f
 		r = -EFAULT;
 		if (copy_from_user(&kvm_regs, (void *)arg, sizeof kvm_regs))
 			goto out;
-		r = kvm_dev_ioctl_set_regs(kvm, &kvm_regs);
+		r = vcpu_dev_ioctl_set_regs(vcpu, &kvm_regs);
 		if (r)
 			goto out;
 		r = 0;
@@ -3169,10 +3194,7 @@ static long kvm_dev_ioctl(struct file *f
 	case KVM_GET_SREGS: {
 		struct kvm_sregs kvm_sregs;
 
-		r = -EFAULT;
-		if (copy_from_user(&kvm_sregs, (void *)arg, sizeof kvm_sregs))
-			goto out;
-		r = kvm_dev_ioctl_get_sregs(kvm, &kvm_sregs);
+		r = vcpu_dev_ioctl_get_sregs(vcpu, &kvm_sregs);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -3187,7 +3209,7 @@ static long kvm_dev_ioctl(struct file *f
 		r = -EFAULT;
 		if (copy_from_user(&kvm_sregs, (void *)arg, sizeof kvm_sregs))
 			goto out;
-		r = kvm_dev_ioctl_set_sregs(kvm, &kvm_sregs);
+		r = vcpu_dev_ioctl_set_sregs(vcpu, &kvm_sregs);
 		if (r)
 			goto out;
 		r = 0;
@@ -3199,7 +3221,7 @@ static long kvm_dev_ioctl(struct file *f
 		r = -EFAULT;
 		if (copy_from_user(&tr, (void *)arg, sizeof tr))
 			goto out;
-		r = kvm_dev_ioctl_translate(kvm, &tr);
+		r = vcpu_dev_ioctl_translate(vcpu, &tr);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -3214,7 +3236,7 @@ static long kvm_dev_ioctl(struct file *f
 		r = -EFAULT;
 		if (copy_from_user(&irq, (void *)arg, sizeof irq))
 			goto out;
-		r = kvm_dev_ioctl_interrupt(kvm, &irq);
+		r = vcpu_dev_ioctl_interrupt(vcpu, &irq);
 		if (r)
 			goto out;
 		r = 0;
@@ -3226,12 +3248,32 @@ static long kvm_dev_ioctl(struct file *f
 		r = -EFAULT;
 		if (copy_from_user(&dbg, (void *)arg, sizeof dbg))
 			goto out;
-		r = kvm_dev_ioctl_debug_guest(kvm, &dbg);
+		r = vcpu_dev_ioctl_debug_guest(vcpu, &dbg);
 		if (r)
 			goto out;
 		r = 0;
 		break;
 	}
+	default:
+		;
+	}
+out:
+	return r;
+}
+
+static long kvm_dev_ioctl(struct file *filp,
+			  unsigned int ioctl, unsigned long arg)
+{
+	struct kvm *kvm = filp->private_data;
+	int r = -EINVAL;
+
+	switch (ioctl) {
+	case KVM_CREATE_VCPU: {
+		r = kvm_dev_ioctl_create_vcpu(kvm, arg, filp);
+		if (r < 0)
+			goto out;
+		break;
+	}
 	case KVM_SET_MEMORY_REGION: {
 		struct kvm_memory_region kvm_mem;
 
@@ -3292,6 +3334,13 @@ static int kvm_dev_mmap(struct file *fil
 	return 0;
 }
 
+static struct file_operations kvm_vcpu_ops = {
+	.owner		= THIS_MODULE,
+	.release        = vcpu_dev_release,
+	.unlocked_ioctl = vcpu_dev_ioctl,
+	.compat_ioctl   = vcpu_dev_ioctl,
+};
+
 static struct file_operations kvm_chardev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= kvm_dev_open,
Index: linux-2.6/include/linux/kvm.h
===================================================================
--- linux-2.6.orig/include/linux/kvm.h
+++ linux-2.6/include/linux/kvm.h
@@ -1,13 +1,6 @@
 #ifndef __LINUX_KVM_H
 #define __LINUX_KVM_H
 
-/*
- * Userspace interface for /dev/kvm - kernel based virtual machine
- *
- * Note: this interface is considered experimental and may change without
- *       notice.
- */
-
 #include <asm/types.h>
 #include <linux/ioctl.h>
 
@@ -88,10 +81,6 @@ struct kvm_run {
 
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
-	/* in */
-	__u32 vcpu;
-	__u32 padding;
-
 	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
 	__u64 rax, rbx, rcx, rdx;
 	__u64 rsi, rdi, rsp, rbp;
@@ -118,10 +107,6 @@ struct kvm_dtable {
 
 /* for KVM_GET_SREGS and KVM_SET_SREGS */
 struct kvm_sregs {
-	/* in */
-	__u32 vcpu;
-	__u32 padding;
-
 	/* out (KVM_GET_SREGS) / in (KVM_SET_SREGS) */
 	struct kvm_segment cs, ds, es, fs, gs, ss;
 	struct kvm_segment tr, ldt;
@@ -152,7 +137,6 @@ struct kvm_translation {
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
 	/* in */
-	__u32 vcpu;
 	__u32 irq;
 };
 
@@ -165,8 +149,8 @@ struct kvm_breakpoint {
 /* for KVM_DEBUG_GUEST */
 struct kvm_debug_guest {
 	/* int */
-	__u32 vcpu;
 	__u32 enabled;
+	__u32 padding;
 	struct kvm_breakpoint breakpoints[4];
 	__u32 singlestep;
 };
@@ -183,6 +167,11 @@ struct kvm_dirty_log {
 
 #define KVMIO 0xAE
 
+/*
+ * Vcpu-specific operations
+ *
+ * Use with file descriptors returned from ioctl(KVM_CREATE_VCPU)
+ */
 #define KVM_RUN                   _IOWR(KVMIO, 2, struct kvm_run)
 #define KVM_GET_REGS              _IOWR(KVMIO, 3, struct kvm_regs)
 #define KVM_SET_REGS              _IOW(KVMIO, 4, struct kvm_regs)
@@ -191,6 +180,12 @@ struct kvm_dirty_log {
 #define KVM_TRANSLATE             _IOWR(KVMIO, 7, struct kvm_translation)
 #define KVM_INTERRUPT             _IOW(KVMIO, 8, struct kvm_interrupt)
 #define KVM_DEBUG_GUEST           _IOW(KVMIO, 9, struct kvm_debug_guest)
+
+/*
+ * Guest-wide operations
+ *
+ * Use with file descriptors returned from open("/dev/kvm")
+ */
 #define KVM_SET_MEMORY_REGION     _IOW(KVMIO, 10, struct kvm_memory_region)
 #define KVM_CREATE_VCPU           _IOW(KVMIO, 11, int /* vcpu_slot */)
 #define KVM_GET_DIRTY_LOG         _IOW(KVMIO, 12, struct kvm_dirty_log)




-- 
error compiling committee.c: too many arguments to function

