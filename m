Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUG2VnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUG2VnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2VnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:43:12 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:35038 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267455AbUG2VlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:41:13 -0400
Date: Thu, 29 Jul 2004 23:40:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       riel@redhat.com
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040729214053.GJ15895@dualathlon.random>
References: <20040729100307.GA23571@devserv.devel.redhat.com> <20040729142829.2a75c9b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729142829.2a75c9b9.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 02:28:29PM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > Below is a fixed up patch to allow non-root to mlock memory
> 
> I seem to recall that Andrea identified reasons why per-user mlock limits
> were fundamentally broken/unsuitable, but I forget the details.  Perhaps he
> could remind us?

yep, the rlimit for mlocked stuff works only for the pagetables pinning.
In turn it works perfectly for mlock.  But shared memory or hugetlbfs
obviously aren't pinned via the pagetables in the virtual address space,
such things are persistent and non-swappable objects, even killing the
task won't change a thing.

So as described some month ago such patch is insecure and conceptually
flawed since they're using rlimits to control persistent objects that
have absolutely nothing to do with the task itself, which in turns make
the rlimit useless.

the very best one can do right now is the below.

If you remove the shm/hugetlbfs brokeness from the rlimit patch that
will become a safe feature for mlock (for mlock it works fine since
mlock is all about pinning the pagetables, not about persistent objects
that have nothing to do with the task), but it won't change almost
anything for oracle standpoint since it doesn't allow hugetlbfs usage
anyways.

diff -U4 -Nrp linux-2.6.5/fs/hugetlbfs/inode.c linux-2.6.5.cap-mlock/fs/hugetlbfs/inode.c
--- linux-2.6.5/fs/hugetlbfs/inode.c	2004-04-04 05:38:14.000000000 +0200
+++ linux-2.6.5.cap-mlock/fs/hugetlbfs/inode.c	2004-04-05 00:15:41.000000000 +0200
@@ -706,9 +706,9 @@ struct file *hugetlb_zero_setup(size_t s
 	struct dentry *dentry, *root;
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
 
 	if (!is_hugepage_mem_enough(size))
 		return ERR_PTR(-ENOMEM);
diff -U4 -Nrp linux-2.6.5/include/linux/sched.h linux-2.6.5.cap-mlock/include/linux/sched.h
--- linux-2.6.5/include/linux/sched.h	2004-04-05 00:15:03.000000000 +0200
+++ linux-2.6.5.cap-mlock/include/linux/sched.h	2004-04-05 00:15:41.000000000 +0200
@@ -748,8 +748,14 @@ static inline int capable(int cap)
 	return 0;
 }
 #endif
 
+extern int sysctl_disable_cap_mlock;
+static inline int can_do_mlock(void)
+{
+	return likely(sysctl_disable_cap_mlock || capable(CAP_IPC_LOCK));
+}
+
 /*
  * Routines for handling mm_structs
  */
 extern struct mm_struct * mm_alloc(void);
diff -U4 -Nrp linux-2.6.5/include/linux/sysctl.h linux-2.6.5.cap-mlock/include/linux/sysctl.h
--- linux-2.6.5/include/linux/sysctl.h	2004-04-05 00:15:03.000000000 +0200
+++ linux-2.6.5.cap-mlock/include/linux/sysctl.h	2004-04-05 00:16:19.000000000 +0200
@@ -166,8 +166,9 @@ enum
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
  	VM_LAPTOP_MODE=23,      /* vm laptop mode */
  	VM_BLOCK_DUMP=24,       /* block dump mode */
+ 	VM_DISABLE_CAP_MLOCK=25,/* disable CAP_IPC_LOCK checking */
 };
 
 
 /* CTL_NET names: */
diff -U4 -Nrp linux-2.6.5/ipc/shm.c linux-2.6.5.cap-mlock/ipc/shm.c
--- linux-2.6.5/ipc/shm.c	2004-04-05 00:15:03.000000000 +0200
+++ linux-2.6.5.cap-mlock/ipc/shm.c	2004-04-05 00:15:41.000000000 +0200
@@ -502,9 +502,9 @@ asmlinkage long sys_shmctl (int shmid, i
 	{
 /* Allow superuser to lock segment in memory */
 /* Should the pages be faulted in here or leave it to user? */
 /* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK)) {
+		if (!can_do_mlock()) {
 			err = -EPERM;
 			goto out;
 		}
 
diff -U4 -Nrp linux-2.6.5/kernel/capability.c linux-2.6.5.cap-mlock/kernel/capability.c
--- linux-2.6.5/kernel/capability.c	2004-04-04 05:37:36.000000000 +0200
+++ linux-2.6.5.cap-mlock/kernel/capability.c	2004-04-05 00:15:41.000000000 +0200
@@ -13,8 +13,9 @@
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
 kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+int sysctl_disable_cap_mlock = 0;
 
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
 
diff -U4 -Nrp linux-2.6.5/kernel/sysctl.c linux-2.6.5.cap-mlock/kernel/sysctl.c
--- linux-2.6.5/kernel/sysctl.c	2004-04-05 00:15:03.000000000 +0200
+++ linux-2.6.5.cap-mlock/kernel/sysctl.c	2004-04-05 00:18:01.000000000 +0200
@@ -821,9 +821,17 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
-	{ .ctl_name = 0 }
+ 	{
+ 		.ctl_name	= VM_DISABLE_CAP_MLOCK,
+ 		.procname	= "disable_cap_mlock",
+ 		.data		= &sysctl_disable_cap_mlock,
+ 		.maxlen		= sizeof(sysctl_disable_cap_mlock),
+ 		.mode		= 0644,
+ 		.proc_handler	= &proc_dointvec,
+ 	},
+  	{ .ctl_name = 0 }
 };
 
 static ctl_table proc_table[] = {
 	{ .ctl_name = 0 }
diff -U4 -Nrp linux-2.6.5/mm/mlock.c linux-2.6.5.cap-mlock/mm/mlock.c
--- linux-2.6.5/mm/mlock.c	2004-04-04 05:36:16.000000000 +0200
+++ linux-2.6.5.cap-mlock/mm/mlock.c	2004-04-05 00:15:41.000000000 +0200
@@ -56,9 +56,9 @@ static int do_mlock(unsigned long start,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
 	if (end < start)
@@ -138,9 +138,9 @@ static int do_mlockall(int flags)
 	int error;
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
 	if (flags & MCL_FUTURE)
diff -U4 -Nrp linux-2.6.5/mm/mmap.c linux-2.6.5.cap-mlock/mm/mmap.c
--- linux-2.6.5/mm/mmap.c	2004-04-05 00:15:06.000000000 +0200
+++ linux-2.6.5.cap-mlock/mm/mmap.c	2004-04-05 00:15:41.000000000 +0200
@@ -574,9 +574,9 @@ unsigned long __do_mmap_pgoff(struct mm_
 	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED) {
-		if (!capable(CAP_IPC_LOCK))
+		if (!can_do_mlock())
 			return -EPERM;
 		vm_flags |= VM_LOCKED;
 	}
 	/* mlock MCL_FUTURE? */
