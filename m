Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267112AbTAPDmw>; Wed, 15 Jan 2003 22:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTAPDmw>; Wed, 15 Jan 2003 22:42:52 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:8409 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267114AbTAPDmo>;
	Wed, 15 Jan 2003 22:42:44 -0500
Date: Thu, 16 Jan 2003 14:51:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: matthew@wil.cx
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 parisc
Message-Id: <20030116145136.3b0b3dd3.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/parisc/kernel/signal32.c 2.5.58-32bit.6/arch/parisc/kernel/signal32.c
--- 2.5.58-32bit.5/arch/parisc/kernel/signal32.c	2003-01-15 14:49:04.000000000 +1100
+++ 2.5.58-32bit.6/arch/parisc/kernel/signal32.c	2003-01-16 01:41:56.000000000 +1100
@@ -17,57 +17,6 @@
 	struct sigaction32 sa;
 };
 
-static int
-put_old_sigset32(compat_old_sigset_t *up, old_sigset_t *set)
-{
-	compat_old_sigset_t set32 = *set;
-	return put_user(set32, up);
-}
-
-static int
-get_old_segset32(compat_old_sigset_t *up, old_sigset_t *set)
-{
-	compat_old_sigset_t set32;
-	int r;
-
-	if ((r = get_user(set32, up)) == 0)
-		*set = set32;
-
-	return r;
-}
-
-long
-sys32_sigpending(compat_old_sigset_t *set)
-{
-	extern long sys_sigpending(old_sigset_t *set);
-	old_sigset_t pending;
-	int ret;
-
-	KERNEL_SYSCALL(ret, sys_sigpending, &pending);
-
-	/* can't put_user an old_sigset_t -- it is too big */
-	if (put_old_sigset32(set, &pending))
-		return -EFAULT;
-
-	return ret;
-}
-
-int sys32_sigprocmask(int how, compat_old_sigset_t *set, 
-				 compat_old_sigset_t *oset)
-{
-	extern int sys_sigprocmask(int how, old_sigset_t *set, 
-				 old_sigset_t *oset);
-	old_sigset_t s;
-	int ret;
-
-	if (set && get_old_segset32 (set, &s))
-		return -EFAULT;
-	KERNEL_SYSCALL(ret, sys_sigprocmask, how, set ? &s : NULL, oset ? &s : NULL);
-	if (!ret && oset && put_old_sigset32(oset, &s))
-		return -EFAULT;
-	return ret;
-}
-
 static inline void
 sigset_32to64(sigset_t *s64, compat_sigset_t *s32)
 {
diff -ruN 2.5.58-32bit.5/arch/parisc/kernel/syscall.S 2.5.58-32bit.6/arch/parisc/kernel/syscall.S
--- 2.5.58-32bit.5/arch/parisc/kernel/syscall.S	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.58-32bit.6/arch/parisc/kernel/syscall.S	2003-01-16 01:46:03.000000000 +1100
@@ -428,7 +428,7 @@
 	ENTRY_SAME(setreuid)	/* 70 */
 	ENTRY_SAME(setregid)
 	ENTRY_SAME(mincore)
-	ENTRY_DIFF(sigpending)
+	ENTRY_COMP(sigpending)
 	ENTRY_SAME(sethostname)
 	/* Following 3 have linux-common-code structs containing longs -( */
 	ENTRY_DIFF(setrlimit)	/* 75 */
@@ -496,7 +496,7 @@
 	ENTRY_DIFF(adjtimex)
 	ENTRY_SAME(mprotect)	/* 125 */
 	/* old_sigset_t forced to 32 bits.  Beware glibc sigset_t */
-	ENTRY_DIFF(sigprocmask)
+	ENTRY_COMP(sigprocmask)
 	ENTRY_SAME(ni_syscall)		/* create_module */
 	ENTRY_SAME(init_module)
 	ENTRY_SAME(delete_module)
