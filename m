Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280084AbRKHOui>; Thu, 8 Nov 2001 09:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280110AbRKHOu3>; Thu, 8 Nov 2001 09:50:29 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:43767 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S280084AbRKHOuO>; Thu, 8 Nov 2001 09:50:14 -0500
Date: Thu, 8 Nov 2001 15:20:38 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Cc: Ville Herva <vherva@niksula.hut.fi>
Subject: [patch] Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108152038.A728@zodiak.ecademix.com>
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com> <20011107224824.G26218@niksula.cs.hut.fi> <20011107234025.A602@zodiak.ecademix.com> <20011108081006.S1504@niksula.cs.hut.fi> <20011108094637.B615@zodiak.ecademix.com> <20011108104634.T1504@niksula.cs.hut.fi> <20011108100014.A704@zodiak.ecademix.com> <20011108111330.U1504@niksula.cs.hut.fi> <20011108111421.A612@zodiak.ecademix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108111421.A612@zodiak.ecademix.com>; from Peter.Seiderer@ciselant.de on Thu, Nov 08, 2001 at 11:14:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2001 at 11:14:21AM +0100, Peter Seiderer wrote:
> Hello,
> the SIGXFSZ signal is produced in the file mm/filemap.c (linx-2.4.14) in
> line 2771:
> 
> 2769:	if (limit != RLIM_INFINITY) {
> 2770:		if (pos >= limit) {
> 2771:			send_sig(SIGXFSZ, current, 0);
> 2772:			goto out;
> 2773:		}
> 
> The valus at this point are
> limit:         0x7fffffff
> RLIM_INFINITY: 0xffffffff
> pos:           0x80004000
> 
> where limit comes from:
> unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
> 
> but I did not yet detected the point(s) where
> current->rlim[RLIMIT_FSIZE].rlim_cur
> is(are) set/changed.
> Peter
> 

Investigated a litte bit in the kernel I detected there is a
sys_getrlimit function and a sys_old_getrlimit function which is
called in arch i386, m68k, sh, ppc, s390, cris, arm which mangles the
RLIM_INFINITY: 0xffffffff to 0x7fffffff.

The problem is that it is now impossible to set the limits to
RLIM_INFINITY while only 0x7fffffff is given as input.

Therefor I programed analog to sys_old_getrlimit the function sys_old_setrlimit
which mangles all values >= 0x7fffffff to 0xffffffff (see attached patch).

Peter



--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_RLIM_INFINITY

diff -ru linux-2.4.14_orig/arch/arm/kernel/calls.S linux-2.4.14/arch/arm/kernel/calls.S
--- linux-2.4.14_orig/arch/arm/kernel/calls.S	Mon Oct  8 19:39:18 2001
+++ linux-2.4.14/arch/arm/kernel/calls.S	Thu Nov  8 14:48:58 2001
@@ -89,7 +89,7 @@
 		.long	SYMBOL_NAME(sys_sigsuspend_wrapper)
 		.long	SYMBOL_NAME(sys_sigpending)
 		.long	SYMBOL_NAME(sys_sethostname)
-/* 75 */	.long	SYMBOL_NAME(sys_setrlimit)
+/* 75 */	.long	SYMBOL_NAME(sys_old_setrlimit)
 		.long	SYMBOL_NAME(sys_old_getrlimit)
 		.long	SYMBOL_NAME(sys_getrusage)
 		.long	SYMBOL_NAME(sys_gettimeofday)
diff -ru linux-2.4.14_orig/arch/cris/kernel/entry.S linux-2.4.14/arch/cris/kernel/entry.S
--- linux-2.4.14_orig/arch/cris/kernel/entry.S	Mon Oct  8 20:43:54 2001
+++ linux-2.4.14/arch/cris/kernel/entry.S	Thu Nov  8 14:48:40 2001
@@ -833,7 +833,7 @@
 	.long SYMBOL_NAME(sys_sigsuspend)
 	.long SYMBOL_NAME(sys_sigpending)
 	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
+	.long SYMBOL_NAME(sys_old_setrlimit)	/* 75 */
 	.long SYMBOL_NAME(sys_old_getrlimit)
 	.long SYMBOL_NAME(sys_getrusage)
 	.long SYMBOL_NAME(sys_gettimeofday)
diff -ru linux-2.4.14_orig/arch/i386/kernel/entry.S linux-2.4.14/arch/i386/kernel/entry.S
--- linux-2.4.14_orig/arch/i386/kernel/entry.S	Sat Nov  3 02:18:49 2001
+++ linux-2.4.14/arch/i386/kernel/entry.S	Thu Nov  8 13:57:47 2001
@@ -471,7 +471,7 @@
 	.long SYMBOL_NAME(sys_sigsuspend)
 	.long SYMBOL_NAME(sys_sigpending)
 	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
+	.long SYMBOL_NAME(sys_old_setrlimit)	/* 75 */
 	.long SYMBOL_NAME(sys_old_getrlimit)
 	.long SYMBOL_NAME(sys_getrusage)
 	.long SYMBOL_NAME(sys_gettimeofday)
diff -ru linux-2.4.14_orig/arch/m68k/kernel/entry.S linux-2.4.14/arch/m68k/kernel/entry.S
--- linux-2.4.14_orig/arch/m68k/kernel/entry.S	Mon Oct  8 19:39:18 2001
+++ linux-2.4.14/arch/m68k/kernel/entry.S	Thu Nov  8 14:46:53 2001
@@ -500,7 +500,7 @@
 	.long SYMBOL_NAME(sys_sigsuspend)
 	.long SYMBOL_NAME(sys_sigpending)
 	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
+	.long SYMBOL_NAME(sys_old_setrlimit)	/* 75 */
 	.long SYMBOL_NAME(sys_old_getrlimit)
 	.long SYMBOL_NAME(sys_getrusage)
 	.long SYMBOL_NAME(sys_gettimeofday)
diff -ru linux-2.4.14_orig/arch/ppc/kernel/misc.S linux-2.4.14/arch/ppc/kernel/misc.S
--- linux-2.4.14_orig/arch/ppc/kernel/misc.S	Sat Nov  3 02:43:54 2001
+++ linux-2.4.14/arch/ppc/kernel/misc.S	Thu Nov  8 14:47:54 2001
@@ -988,7 +988,7 @@
 	.long sys_sigsuspend
 	.long sys_sigpending
 	.long sys_sethostname
-	.long sys_setrlimit	/* 75 */
+	.long sys_old_setrlimit	/* 75 */
 	.long sys_old_getrlimit
 	.long sys_getrusage
 	.long sys_gettimeofday
diff -ru linux-2.4.14_orig/arch/s390/kernel/entry.S linux-2.4.14/arch/s390/kernel/entry.S
--- linux-2.4.14_orig/arch/s390/kernel/entry.S	Thu Oct 11 18:04:57 2001
+++ linux-2.4.14/arch/s390/kernel/entry.S	Thu Nov  8 14:48:24 2001
@@ -442,7 +442,7 @@
         .long  sys_sigsuspend_glue
         .long  sys_sigpending
         .long  sys_sethostname
-        .long  sys_setrlimit            /* 75 */
+        .long  sys_old_setrlimit            /* 75 */
         .long  sys_old_getrlimit
         .long  sys_getrusage
         .long  sys_gettimeofday
diff -ru linux-2.4.14_orig/arch/sh/kernel/entry.S linux-2.4.14/arch/sh/kernel/entry.S
--- linux-2.4.14_orig/arch/sh/kernel/entry.S	Mon Oct  8 19:39:18 2001
+++ linux-2.4.14/arch/sh/kernel/entry.S	Thu Nov  8 14:47:13 2001
@@ -1151,7 +1151,7 @@
 	.long SYMBOL_NAME(sys_sigsuspend)
 	.long SYMBOL_NAME(sys_sigpending)
 	.long SYMBOL_NAME(sys_sethostname)
-	.long SYMBOL_NAME(sys_setrlimit)	/* 75 */
+	.long SYMBOL_NAME(sys_old_setrlimit)	/* 75 */
 	.long SYMBOL_NAME(sys_old_getrlimit)
 	.long SYMBOL_NAME(sys_getrusage)
 	.long SYMBOL_NAME(sys_gettimeofday)
diff -ru linux-2.4.14_orig/kernel/sys.c linux-2.4.14/kernel/sys.c
--- linux-2.4.14_orig/kernel/sys.c	Tue Sep 18 23:10:43 2001
+++ linux-2.4.14/kernel/sys.c	Thu Nov  8 14:54:11 2001
@@ -1133,6 +1133,39 @@
 	return 0;
 }
 
+#if !defined(__ia64__)
+
+/*
+ *	Analog to sys_old_getrlimit the back compatibility for setrlimit.
+ */
+
+asmlinkage long sys_old_setrlimit(unsigned int resource, struct rlimit *rlim)
+{
+        struct rlimit new_rlim, *old_rlim;
+
+        if (resource >= RLIM_NLIMITS)
+                return -EINVAL;
+        if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
+                return -EFAULT;
+        old_rlim = current->rlim + resource;
+        if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
+             (new_rlim.rlim_max > old_rlim->rlim_max)) &&
+            !capable(CAP_SYS_RESOURCE))
+                return -EPERM;
+        if (resource == RLIMIT_NOFILE) {
+                if (new_rlim.rlim_cur > NR_OPEN || new_rlim.rlim_max > NR_OPEN)
+                        return -EPERM;
+        }
+	if (new_rlim.rlim_cur >= 0x7FFFFFFF)
+		new_rlim.rlim_cur = RLIM_INFINITY;
+	if (new_rlim.rlim_max >= 0x7FFFFFFF)
+		new_rlim.rlim_max = RLIM_INFINITY;
+        *old_rlim = new_rlim;
+        return 0;
+}
+
+#endif
+
 /*
  * It would make sense to put struct rusage in the task_struct,
  * except that would make the task_struct be *really big*.  After

--AqsLC8rIMeq19msA--
