Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVG1Psy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVG1Psy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVG1PqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:46:17 -0400
Received: from [151.97.230.9] ([151.97.230.9]:40868 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261469AbVG1Po3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:44:29 -0400
Subject: [patch 1/1] x86_64: remove duplicated sys_time64
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       ak@suse.de
From: blaisorblade@yahoo.it
Date: Thu, 28 Jul 2005 17:46:49 +0200
Message-Id: <20050728154654.2F242187CF@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Andi Kleen <ak@suse.de>

I'm resending this patch again for 4th time since it wasn't merged nor it is
in -mm. The first time it didn't look right because of Andi looking at an
older tree, but it later was sorted out, and he Acked the patch.

Keeping this function does not makes sense because it's a copied (and buggy)
copy of sys_time. The only difference is that now.tv_sec (which is a time_t,
i.e. a 64-bit long) is copied (and truncated) into a int (32-bit).

The prototype is the same (they both take a long __user *), so let's drop this
and redirect it to sys_time (and make sure it exists by defining
__ARCH_WANT_SYS_TIME).

Only disadvantage is that the sys_stime definition is also compiled (may be
fixed if needed by adding a separate __ARCH_WANT_SYS_STIME macro, and defining
it for all arch's defining __ARCH_WANT_SYS_TIME except x86_64).

Not compile-tested, sorry.

Acked-by: Andi Kleen <ak@suse.de>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/x86_64/kernel/sys_x86_64.c |   14 --------------
 linux-2.6.git-paolo/include/asm-x86_64/unistd.h     |    3 ++-
 2 files changed, 2 insertions(+), 15 deletions(-)

diff -puN include/asm-x86_64/unistd.h~x86_64-remove-sys-time-x86-64 include/asm-x86_64/unistd.h
--- linux-2.6.git/include/asm-x86_64/unistd.h~x86_64-remove-sys-time-x86-64	2005-07-28 17:45:26.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/unistd.h	2005-07-28 17:45:26.000000000 +0200
@@ -462,7 +462,7 @@ __SYSCALL(__NR_fremovexattr, sys_fremove
 #define __NR_tkill	200
 __SYSCALL(__NR_tkill, sys_tkill) 
 #define __NR_time      201
-__SYSCALL(__NR_time, sys_time64)
+__SYSCALL(__NR_time, sys_time)
 #define __NR_futex     202
 __SYSCALL(__NR_futex, sys_futex)
 #define __NR_sched_setaffinity    203
@@ -608,6 +608,7 @@ do { \
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #endif
 
diff -puN arch/x86_64/kernel/sys_x86_64.c~x86_64-remove-sys-time-x86-64 arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.git/arch/x86_64/kernel/sys_x86_64.c~x86_64-remove-sys-time-x86-64	2005-07-28 17:45:26.000000000 +0200
+++ linux-2.6.git-paolo/arch/x86_64/kernel/sys_x86_64.c	2005-07-28 17:45:26.000000000 +0200
@@ -161,17 +161,3 @@ asmlinkage long sys_uname(struct new_uts
 		err |= copy_to_user(&name->machine, "i686", 5); 		
 	return err ? -EFAULT : 0;
 }
-
-asmlinkage long sys_time64(long __user * tloc)
-{
-	struct timeval now; 
-	int i; 
-
-	do_gettimeofday(&now);
-	i = now.tv_sec;
-	if (tloc) {
-		if (put_user(i,tloc))
-			i = -EFAULT;
-	}
-	return i;
-}
_
