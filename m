Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTK1XwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 18:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTK1XwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 18:52:10 -0500
Received: from holomorphy.com ([199.26.172.102]:19140 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263573AbTK1Xv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 18:51:58 -0500
Date: Fri, 28 Nov 2003 15:51:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031128235155.GA19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128072148.GY8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 08:15:58PM -0800, William Lee Irwin III wrote:
>> This is a forward port of Hugh Dickins' patch to implement ABI-
>> preserving large software PAGE_SIZE support, effectively "large VM
>> blocksize". It's also been called "subpages". "pgcl" is an abbreviation
>> for "page clustering", after the historical but different BSD notion.

On Thu, Nov 27, 2003 at 11:21:48PM -0800, William Lee Irwin III wrote:
> Now also ported to 2.6.0-test11:
> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/pgcl-2.6.0-test11-1.gz
> This also corrects some PAGE_SHIFT instances that crept into mm/mmap.c
> while I wasn't looking and drops sym2 driver changes.

Looks like I missed the update to the Committed_AS accounting in exec.c
during the conversion. The reduced granularity on RLIMIT_STACK, stack
fault alignment,  and the argument size Committed_AS accounting bothers
me. I should teach copy_folio() etc. to cope with unaligned pages, but
there appears to be some pain wrt. how far and wide to hunt for ptes
(i.e. this requires some design effort).

I do the swap bits a bit differently from the original, so the
swapfile accounting needs a unit conversion.

This also arranges for pr_debug()-based logging of Committed_AS
accounting, which is useful while this thing is still prototypical in
nature, but will eventually get removed for "production" patch posting
along with several other things of a similar nature.


-- wli


diff -prauN pgcl-2.6.0-test11-1/fs/exec.c pgcl-2.6.0-test11-2/fs/exec.c
--- pgcl-2.6.0-test11-1/fs/exec.c	2003-11-27 21:55:19.000000000 -0800
+++ pgcl-2.6.0-test11-2/fs/exec.c	2003-11-28 15:25:51.000000000 -0800
@@ -417,7 +417,7 @@ int setup_arg_pages(struct linux_binprm 
 #else
 	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
-	arg_size = STACK_TOP - (MMUPAGE_MASK & (unsigned long) mm->arg_start);
+	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
 
 	bprm->p += stack_base;
diff -prauN pgcl-2.6.0-test11-1/include/linux/mman.h pgcl-2.6.0-test11-2/include/linux/mman.h
--- pgcl-2.6.0-test11-1/include/linux/mman.h	2003-11-26 12:43:05.000000000 -0800
+++ pgcl-2.6.0-test11-2/include/linux/mman.h	2003-11-28 15:26:08.000000000 -0800
@@ -14,18 +14,42 @@ extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern atomic_t vm_committed_space;
 
+#define vm_acct_memory(pages)						\
+do {									\
+	long __pages__ = (pages);					\
+	pr_debug("%d: vm_acct_memory(%ld) in %s at %s:%d\n",		\
+		current->pid,						\
+		__pages__,						\
+		__FUNCTION__,						\
+		__FILE__,						\
+		__LINE__);						\
+	__vm_acct_memory(__pages__);					\
+} while (0)
+
+#define vm_unacct_memory(pages)						\
+do {									\
+	long __pages__ = (pages);					\
+	pr_debug("%d: vm_unacct_memory(%ld) in %s at %s:%d\n",		\
+		current->pid,						\
+		__pages__,						\
+		__FUNCTION__,						\
+		__FILE__,						\
+		__LINE__);						\
+	__vm_unacct_memory(__pages__);					\
+} while (0)
+
 #ifdef CONFIG_SMP
-extern void vm_acct_memory(long pages);
+void __vm_acct_memory(long pages);
 #else
-static inline void vm_acct_memory(long pages)
+static inline void __vm_acct_memory(long pages)
 {
 	atomic_add(pages, &vm_committed_space);
 }
 #endif
 
-static inline void vm_unacct_memory(long pages)
+static inline void __vm_unacct_memory(long pages)
 {
-	vm_acct_memory(-pages);
+	__vm_acct_memory(-pages);
 }
 
 /*
diff -prauN pgcl-2.6.0-test11-1/include/linux/security.h pgcl-2.6.0-test11-2/include/linux/security.h
--- pgcl-2.6.0-test11-1/include/linux/security.h	2003-11-26 12:44:57.000000000 -0800
+++ pgcl-2.6.0-test11-2/include/linux/security.h	2003-11-28 15:26:01.000000000 -0800
@@ -84,6 +84,18 @@ struct nfsctl_arg;
 struct sched_param;
 struct swap_info_struct;
 
+#define security_vm_enough_memory(pages)				\
+({									\
+	long __pages__ = (pages);					\
+	pr_debug("%d: vm_enough_memory(%ld) in %s at %s:%d\n",		\
+		current->pid,						\
+		__pages__,						\
+		__FUNCTION__,						\
+		__FILE__,						\
+		__LINE__);						\
+	__security_vm_enough_memory(__pages__);				\
+})
+
 #ifdef CONFIG_SECURITY
 
 /**
@@ -1245,7 +1257,7 @@ static inline int security_syslog(int ty
 	return security_ops->syslog(type);
 }
 
-static inline int security_vm_enough_memory(long pages)
+static inline int __security_vm_enough_memory(long pages)
 {
 	return security_ops->vm_enough_memory(pages);
 }
@@ -1911,7 +1923,7 @@ static inline int security_syslog(int ty
 	return cap_syslog(type);
 }
 
-static inline int security_vm_enough_memory(long pages)
+static inline int __security_vm_enough_memory(long pages)
 {
 	return cap_vm_enough_memory(pages);
 }
diff -prauN pgcl-2.6.0-test11-1/mm/swap.c pgcl-2.6.0-test11-2/mm/swap.c
--- pgcl-2.6.0-test11-1/mm/swap.c	2003-11-27 21:55:21.000000000 -0800
+++ pgcl-2.6.0-test11-2/mm/swap.c	2003-11-28 14:14:50.000000000 -0800
@@ -367,7 +367,7 @@ unsigned int pagevec_lookup(struct pagev
 
 static DEFINE_PER_CPU(long, committed_space) = 0;
 
-void vm_acct_memory(long pages)
+void __vm_acct_memory(long pages)
 {
 	long *local;
 
@@ -380,7 +380,7 @@ void vm_acct_memory(long pages)
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL(vm_acct_memory);
+EXPORT_SYMBOL(__vm_acct_memory);
 #endif
 
 #ifdef CONFIG_SMP
diff -prauN pgcl-2.6.0-test11-1/mm/swapfile.c pgcl-2.6.0-test11-2/mm/swapfile.c
--- pgcl-2.6.0-test11-1/mm/swapfile.c	2003-11-27 21:55:21.000000000 -0800
+++ pgcl-2.6.0-test11-2/mm/swapfile.c	2003-11-28 01:23:45.000000000 -0800
@@ -1151,8 +1151,8 @@ asmlinkage long sys_swapoff(const char _
 		swap_list_unlock();
 		goto out_dput;
 	}
-	if (!security_vm_enough_memory(p->pages))
-		vm_unacct_memory(p->pages);
+	if (!security_vm_enough_memory(PAGE_MMUCOUNT*p->pages))
+		vm_unacct_memory(PAGE_MMUCOUNT*p->pages);
 	else {
 		err = -ENOMEM;
 		swap_list_unlock();
