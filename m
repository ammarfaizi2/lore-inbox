Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUDBCtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUDBCtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:49:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:51387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263138AbUDBCtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:49:14 -0500
Date: Thu, 1 Apr 2004 18:49:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401184907.5026906b.akpm@osdl.org>
In-Reply-To: <20040402024104.GS18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401170705.Y22989@build.pdx.osdl.net>
	<20040401173034.16e79fee.akpm@osdl.org>
	<20040401175914.A22989@build.pdx.osdl.net>
	<20040402020915.GO18585@dualathlon.random>
	<20040401183026.6844597a.akpm@osdl.org>
	<20040402024104.GS18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > One thing I was wondering was whether /proc/sys/vm/disable_cap_mlock should
>  > hold a GID rather than a boolean.  So you do
>  > 
>  > 	echo groupof oracle > /proc/sys/vm/disable_cap_mlock
> 
>  that's probably optimal OTOH that would complicate the code, I prefer an
>  obviously safe !disable_cap_mlock, if we want to go complicated we can
>  probably wait the userspace solution ;)

That depends on how you structure the code.  If you do it the below way,
it's a one-liner.

(Will the compiler propagate `unlikeliness' out of an inline function?)



 25-akpm/fs/hugetlbfs/inode.c   |    2 +-
 25-akpm/include/linux/sched.h  |    6 ++++++
 25-akpm/include/linux/sysctl.h |    1 +
 25-akpm/ipc/shm.c              |    2 +-
 25-akpm/kernel/capability.c    |    1 +
 25-akpm/kernel/sysctl.c        |    8 ++++++++
 25-akpm/mm/mlock.c             |    4 ++--
 25-akpm/mm/mmap.c              |    2 +-
 8 files changed, 21 insertions(+), 5 deletions(-)

diff -puN fs/hugetlbfs/inode.c~disable-cap-mlock-2 fs/hugetlbfs/inode.c
--- 25/fs/hugetlbfs/inode.c~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/fs/hugetlbfs/inode.c	Thu Apr  1 15:45:20 2004
@@ -707,7 +707,7 @@ struct file *hugetlb_zero_setup(size_t s
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
 
 	if (!is_hugepage_mem_enough(size))
diff -puN include/linux/sched.h~disable-cap-mlock-2 include/linux/sched.h
--- 25/include/linux/sched.h~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/include/linux/sched.h	Thu Apr  1 15:45:20 2004
@@ -690,6 +690,12 @@ static inline int capable(int cap)
 }
 #endif
 
+extern int sysctl_disable_cap_mlock;
+static inline int can_do_mlock(void)
+{
+	return unlikely(sysctl_disable_cap_mlock || capable(CAP_IPC_LOCK));
+}
+
 /*
  * Routines for handling mm_structs
  */
diff -puN include/linux/sysctl.h~disable-cap-mlock-2 include/linux/sysctl.h
--- 25/include/linux/sysctl.h~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/include/linux/sysctl.h	Thu Apr  1 15:45:48 2004
@@ -159,6 +159,7 @@ enum
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
+	VM_DISABLE_CAP_MLOCK=23,/* disable CAP_IPC_LOCK checking */
 };
 
 
diff -puN ipc/shm.c~disable-cap-mlock-2 ipc/shm.c
--- 25/ipc/shm.c~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/ipc/shm.c	Thu Apr  1 15:45:20 2004
@@ -505,7 +505,7 @@ asmlinkage long sys_shmctl (int shmid, i
 /* Allow superuser to lock segment in memory */
 /* Should the pages be faulted in here or leave it to user? */
 /* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK)) {
+		if (!can_do_mlock()) {
 			err = -EPERM;
 			goto out;
 		}
diff -puN kernel/capability.c~disable-cap-mlock-2 kernel/capability.c
--- 25/kernel/capability.c~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/kernel/capability.c	Thu Apr  1 15:45:20 2004
@@ -14,6 +14,7 @@
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
 kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+int sysctl_disable_cap_mlock = 0;
 
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
diff -puN kernel/sysctl.c~disable-cap-mlock-2 kernel/sysctl.c
--- 25/kernel/sysctl.c~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/kernel/sysctl.c	Thu Apr  1 15:45:20 2004
@@ -744,6 +744,14 @@ static ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec
 	},
+	{
+		.ctl_name	= VM_DISABLE_CAP_MLOCK,
+		.procname	= "disable_cap_mlock",
+		.data		= &sysctl_disable_cap_mlock,
+		.maxlen		= sizeof(sysctl_disable_cap_mlock),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -puN mm/mlock.c~disable-cap-mlock-2 mm/mlock.c
--- 25/mm/mlock.c~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/mm/mlock.c	Thu Apr  1 15:45:20 2004
@@ -57,7 +57,7 @@ static int do_mlock(unsigned long start,
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -139,7 +139,7 @@ static int do_mlockall(int flags)
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
diff -puN mm/mmap.c~disable-cap-mlock-2 mm/mmap.c
--- 25/mm/mmap.c~disable-cap-mlock-2	Thu Apr  1 15:45:20 2004
+++ 25-akpm/mm/mmap.c	Thu Apr  1 15:45:20 2004
@@ -536,7 +536,7 @@ unsigned long do_mmap_pgoff(struct file 
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED) {
-		if (!capable(CAP_IPC_LOCK))
+		if (!can_do_mlock())
 			return -EPERM;
 		vm_flags |= VM_LOCKED;
 	}

_

