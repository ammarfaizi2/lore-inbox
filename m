Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUHXXWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUHXXWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269109AbUHXXTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:19:52 -0400
Received: from holomorphy.com ([207.189.100.168]:2183 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269117AbUHXXSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:18:46 -0400
Date: Tue, 24 Aug 2004 16:18:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: fix text reporting in O(1) proc_pid_statm()
Message-ID: <20040824231841.GH2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1093388816.434.355.camel@cube> <20040824231236.GG2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824231236.GG2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 07:06:56PM -0400, Albert Cahalan wrote:
>> Back in the days of a.out, statm also contained lrs
>> for libraries. ELF broke this.
>> The statm VM size is supposed to count IO mappings.
>> So if your X server maps 64 MB of video RAM, then
>> the statm file should have a value 64 MB larger than
>> the status file has.

On Tue, Aug 24, 2004 at 04:12:36PM -0700, William Lee Irwin III wrote:
> This would not be difficult to perform additional accounting for.
> I'll follow up with that shortly.

Account reserved memory properly as per acahalan's sepecified semantics.


Index: mm4-2.6.8.1/fs/proc/task_mmu.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/task_mmu.c	2004-08-24 10:00:21.530755896 -0700
+++ mm4-2.6.8.1/fs/proc/task_mmu.c	2004-08-24 16:14:48.802211472 -0700
@@ -19,7 +19,7 @@
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
 		"VmLib:\t%8lu kB\n",
-		mm->total_vm << (PAGE_SHIFT-10),
+		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-23 18:29:33.000000000 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-24 16:11:15.251676088 -0700
@@ -226,7 +226,7 @@
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rlimit_rss, rss, total_vm, locked_vm, shared_vm;
-	unsigned long exec_vm, stack_vm, def_flags;
+	unsigned long exec_vm, stack_vm, reserved_vm, def_flags;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
Index: mm4-2.6.8.1/mm/mmap.c
===================================================================
--- mm4-2.6.8.1.orig/mm/mmap.c	2004-08-23 23:33:42.000000000 -0700
+++ mm4-2.6.8.1/mm/mmap.c	2004-08-24 16:13:14.139602376 -0700
@@ -749,6 +749,8 @@
 		mm->stack_vm += pages;
 	if (flags & VM_EXEC)
 		mm->exec_vm += pages;
+	if (flags & (VM_RESERVED|VM_IO))
+		mm->reserved_vm += pages;
 }
 
 /*
