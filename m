Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUHFUcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUHFUcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUHFU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:29:54 -0400
Received: from holomorphy.com ([207.189.100.168]:21199 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268292AbUHFU1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:27:35 -0400
Date: Fri, 6 Aug 2004 13:24:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: PROC_FS=n link errors
Message-ID: <20040806202414.GP17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040806195804.GC2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806195804.GC2746@fs.tum.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>> Changes since 2.6.8-rc2-mm2:
>> +consolidate-prof_cpu_mask.patch
>> +profile_tick.patch
>> Consolidate a lot of the kernel profiling code.
>>...

On Fri, Aug 06, 2004 at 09:58:05PM +0200, Adrian Bunk wrote:
> Theses patches cause the following link errors with CONFIG_PROC_FS=n:
> <--  snip  -->
> ...
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.text+0x45ce): In function `init_irq_proc':
> : undefined reference to `create_prof_cpu_mask'

Ugh. Okay, here goes:

Fix up compile with CONFIG_PROC_FS=n. Accomplish this by conditionally
declaring create_prof_cpu_mask(), privatizing create_proc_profile(),
and unconditionally including profile_hit() and profile_tick().


Index: mm1-2.6.8-rc3/fs/proc/proc_misc.c
===================================================================
--- mm1-2.6.8-rc3.orig/fs/proc/proc_misc.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/fs/proc/proc_misc.c	2004-08-06 12:58:18.426562816 -0700
@@ -662,7 +662,6 @@
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
 #endif
-	create_proc_profile();
 #ifdef CONFIG_MAGIC_SYSRQ
 	entry = create_proc_entry("sysrq-trigger", S_IWUSR, NULL);
 	if (entry)
Index: mm1-2.6.8-rc3/include/linux/profile.h
===================================================================
--- mm1-2.6.8-rc3.orig/include/linux/profile.h	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/include/linux/profile.h	2004-08-06 12:57:46.501416176 -0700
@@ -17,10 +17,13 @@
 
 /* init basic kernel profiler */
 void __init profile_init(void);
-void create_prof_cpu_mask(struct proc_dir_entry *);
 void profile_tick(int, struct pt_regs *);
 void profile_hit(int, void *);
-void create_proc_profile(void);
+#ifdef CONFIG_PROC_FS
+void create_prof_cpu_mask(struct proc_dir_entry *);
+#else
+#define create_prof_cpu_mask(x)			do { (void)(x); } while (0)
+#endif
 
 enum profile_type {
 	EXIT_TASK,
Index: mm1-2.6.8-rc3/kernel/profile.c
===================================================================
--- mm1-2.6.8-rc3.orig/kernel/profile.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/kernel/profile.c	2004-08-06 13:12:19.567689928 -0700
@@ -162,11 +162,6 @@
 EXPORT_SYMBOL_GPL(profile_event_register);
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
-#ifdef CONFIG_PROC_FS
-#include <linux/proc_fs.h>
-#include <asm/uaccess.h>
-#include <asm/ptrace.h>
-
 void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
@@ -185,6 +180,11 @@
 		profile_hit(type, (void *)profile_pc(regs));
 }
 
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
@@ -287,7 +287,7 @@
 	.write		= write_profile,
 };
 
-void __init create_proc_profile(void)
+static int __init create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
 
@@ -298,4 +298,5 @@
 	entry->proc_fops = &proc_profile_operations;
 	entry->size = (1+prof_len) * sizeof(unsigned int);
 }
+module_init(create_proc_profile);
 #endif /* CONFIG_PROC_FS */
