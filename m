Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbTAPDhi>; Wed, 15 Jan 2003 22:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbTAPDhi>; Wed, 15 Jan 2003 22:37:38 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:57816 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267003AbTAPDhe>;
	Wed, 15 Jan 2003 22:37:34 -0500
Date: Thu, 16 Jan 2003 14:46:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 x86_64
Message-Id: <20030116144623.4f90106a.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here is the x86_64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/x86_64/ia32/ia32entry.S 2.5.58-32bit.6/arch/x86_64/ia32/ia32entry.S
--- 2.5.58-32bit.5/arch/x86_64/ia32/ia32entry.S	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.6/arch/x86_64/ia32/ia32entry.S	2003-01-16 01:44:51.000000000 +1100
@@ -273,7 +273,7 @@
 	.quad sys_setreuid16	/* 70 */
 	.quad sys_setregid16
 	.quad stub32_sigsuspend
-	.quad sys32_sigpending
+	.quad compat_sys_sigpending
 	.quad sys_sethostname
 	.quad sys32_setrlimit	/* 75 */
 	.quad sys32_old_getrlimit	/* old_getrlimit */
@@ -326,7 +326,7 @@
 	.quad sys32_modify_ldt
 	.quad sys32_adjtimex
 	.quad sys32_mprotect		/* 125 */
-	.quad sys32_sigprocmask
+	.quad compat_sys_sigprocmask
 	.quad sys32_module_warning	/* create_module */
 	.quad sys_init_module
 	.quad sys_delete_module
diff -ruN 2.5.58-32bit.5/arch/x86_64/ia32/sys_ia32.c 2.5.58-32bit.6/arch/x86_64/ia32/sys_ia32.c
--- 2.5.58-32bit.5/arch/x86_64/ia32/sys_ia32.c	2003-01-15 16:04:33.000000000 +1100
+++ 2.5.58-32bit.6/arch/x86_64/ia32/sys_ia32.c	2003-01-16 01:45:05.000000000 +1100
@@ -1224,41 +1224,6 @@
 	return ret;
 }
 
-extern asmlinkage long sys_sigprocmask(int how, old_sigset_t *set,
-				      old_sigset_t *oset);
-
-asmlinkage long
-sys32_sigprocmask(int how, compat_old_sigset_t *set, compat_old_sigset_t *oset)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (set && get_user (s, set)) return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
-	set_fs (old_fs);
-	if (ret) return ret;
-	if (oset && put_user (s, oset)) return -EFAULT;
-	return 0;
-}
-
-extern asmlinkage long sys_sigpending(old_sigset_t *set);
-
-asmlinkage long
-sys32_sigpending(compat_old_sigset_t *set)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-		
-	set_fs (KERNEL_DS);
-	ret = sys_sigpending(&s);
-	set_fs (old_fs);
-	if (put_user (s, set)) return -EFAULT;
-	return ret;
-}
-
 extern asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
 asmlinkage long
