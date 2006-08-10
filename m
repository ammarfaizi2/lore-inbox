Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWHJUO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWHJUO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWHJTfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:20368 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932487AbWHJTfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [28/145] x86_64: Add portable getcpu call
Message-Id: <20060810193541.9C30213B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:41 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

For NUMA optimization and some other algorithms it is useful to have a fast
to get the current CPU and node numbers in user space.

x86-64 added a fast way to do this in a vsyscall. This adds a generic
syscall for other architectures to make it a generic portable facility.

I expect some of them will also implement it as a faster vsyscall.

The cache is an optimization for the x86-64 vsyscall optimization. Since
what the syscall returns is an approximation anyways and user space
often wants very fast results it can be cached for some time.  The norma
methods to get this information in user space are relatively slow

The vsyscall is in a better position to manage the cache because it has direct 
access to a fast time stamp (jiffies). For the generic syscall optimization
it doesn't help much, but enforce a valid argument to keep programs
portable

I only added an i386 syscall entry for now. Other architectures can follow.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/syscall_table.S |    1 +
 arch/x86_64/ia32/ia32entry.S     |    1 +
 include/asm-i386/unistd.h        |    1 +
 include/linux/syscalls.h         |    2 ++
 kernel/sys.c                     |   26 ++++++++++++++++++++++++++
 5 files changed, 31 insertions(+)

Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c
+++ linux/kernel/sys.c
@@ -28,6 +28,7 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
+#include <linux/getcpu.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2062,3 +2063,28 @@ asmlinkage long sys_prctl(int option, un
 	}
 	return error;
 }
+
+asmlinkage long sys_getcpu(unsigned *cpup, unsigned *nodep, struct getcpu_cache *cache)
+{
+	int err = 0;
+	int cpu = get_cpu();
+	put_cpu();
+	if (cpup)
+		err |= put_user(cpu, cpup);
+	if (nodep)
+		err |= put_user(cpu_to_node(cpu), nodep);
+	if (cache) {
+		/* Not needed for this implementation, but make sure user programs pass
+		   something valid. We only use t0 and t1 because these are available in both
+	  	   32bit and 64bit ABI (no need for a compat_getcpu). 32bit has enough
+		   padding. */
+		unsigned long t0, t1;
+		get_user(t0, &cache->t0);
+		get_user(t1, &cache->t1);
+		t0++;
+		t1++;
+		put_user(t0, &cache->t0);
+		put_user(t1, &cache->t1);
+	}
+	return err ? -EFAULT : 0;
+}
Index: linux/include/linux/syscalls.h
===================================================================
--- linux.orig/include/linux/syscalls.h
+++ linux/include/linux/syscalls.h
@@ -53,6 +53,7 @@ struct mq_attr;
 struct compat_stat;
 struct compat_timeval;
 struct robust_list_head;
+struct getcpu_cache;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -596,5 +597,6 @@ asmlinkage long sys_get_robust_list(int 
 				    size_t __user *len_ptr);
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
+asmlinkage long sys_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *cache);
 
 #endif
Index: linux/arch/i386/kernel/syscall_table.S
===================================================================
--- linux.orig/arch/i386/kernel/syscall_table.S
+++ linux/arch/i386/kernel/syscall_table.S
@@ -317,3 +317,4 @@ ENTRY(sys_call_table)
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
 	.long sys_move_pages
+	.long sys_getcpu
Index: linux/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32entry.S
+++ linux/arch/x86_64/ia32/ia32entry.S
@@ -713,4 +713,5 @@ ia32_sys_call_table:
 	.quad sys_tee
 	.quad compat_sys_vmsplice
 	.quad compat_sys_move_pages
+	.quad sys_getcpu
 ia32_syscall_end:		
Index: linux/include/asm-i386/unistd.h
===================================================================
--- linux.orig/include/asm-i386/unistd.h
+++ linux/include/asm-i386/unistd.h
@@ -323,6 +323,7 @@
 #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
+#define __NR_getcpu		318
 
 #ifdef __KERNEL__
 
