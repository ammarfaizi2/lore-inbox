Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVC3Sfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVC3Sfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVC3Sfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:35:53 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:44460 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262372AbVC3Sfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:35:31 -0500
Subject: [patch 2/3] x86_64: remove duplicated sys_time64
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       ak@suse.de
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:32:16 +0200
Message-Id: <20050330173216.426CFEFECF@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Andi Kleen <ak@suse.de>

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

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/x86_64/kernel/sys_x86_64.c |   14 --------------
 linux-2.6.11-paolo/include/asm-x86_64/unistd.h     |    3 ++-
 2 files changed, 2 insertions(+), 15 deletions(-)

diff -puN include/asm-x86_64/unistd.h~x86_64-remove-sys-time-x86-64 include/asm-x86_64/unistd.h
--- linux-2.6.11/include/asm-x86_64/unistd.h~x86_64-remove-sys-time-x86-64	2005-03-29 17:39:38.000000000 +0200
+++ linux-2.6.11-paolo/include/asm-x86_64/unistd.h	2005-03-29 17:47:36.000000000 +0200
@@ -462,7 +462,7 @@ __SYSCALL(__NR_fremovexattr, sys_fremove
 #define __NR_tkill	200
 __SYSCALL(__NR_tkill, sys_tkill) 
 #define __NR_time      201
-__SYSCALL(__NR_time, sys_time64)
+__SYSCALL(__NR_time, sys_time)
 #define __NR_futex     202
 __SYSCALL(__NR_futex, sys_futex)
 #define __NR_sched_setaffinity    203
@@ -600,6 +600,7 @@ do { \
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #endif
 
diff -puN arch/x86_64/kernel/sys_x86_64.c~x86_64-remove-sys-time-x86-64 arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.11/arch/x86_64/kernel/sys_x86_64.c~x86_64-remove-sys-time-x86-64	2005-03-29 17:39:38.000000000 +0200
+++ linux-2.6.11-paolo/arch/x86_64/kernel/sys_x86_64.c	2005-03-29 17:40:30.000000000 +0200
@@ -158,17 +158,3 @@ asmlinkage long wrap_sys_shmat(int shmid
 	unsigned long raddr;
 	return do_shmat(shmid,shmaddr,shmflg,&raddr) ?: (long)raddr;
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
