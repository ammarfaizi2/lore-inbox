Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTDXPLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTDXPLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:11:40 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:9471 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263691AbTDXPLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:11:37 -0400
Date: Thu, 24 Apr 2003 17:23:43 +0200 (MEST)
Message-Id: <200304241523.h3OFNhTr009419@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: ak@suse.de
Subject: [PATCH][2.5.68] x86_64 getrusage breakage in ia32 emulation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.68 with IA32 emulation enabled fails in the linking step.
The obsolete sys32_getrusage() wasn't deleted, but it references
put_rusage() which _was_ deleted, resulting in a linkage error.
Simply removing sys32_getrusage() fixes the problem.

/Mikael

--- linux-2.5.68/arch/x86_64/ia32/sys_ia32.c.~1~	2003-04-20 13:08:16.000000000 +0200
+++ linux-2.5.68/arch/x86_64/ia32/sys_ia32.c	2003-04-24 15:07:03.000000000 +0200
@@ -861,24 +861,6 @@
 	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
 
-
-extern asmlinkage long
-sys_getrusage(int who, struct rusage *ru);
-
-asmlinkage long
-sys32_getrusage(int who, struct rusage32 *ru)
-{
-	struct rusage r;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-		
-	set_fs (KERNEL_DS);
-	ret = sys_getrusage(who, &r);
-	set_fs (old_fs);
-	if (put_rusage (ru, &r)) return -EFAULT;
-	return ret;
-}
-
 int sys32_ni_syscall(int call)
 { 
 	printk(KERN_INFO "IA32 syscall %d from %s not implemented\n", call,
