Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUITV0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUITV0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUITV0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:26:14 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:10903 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S267367AbUITV0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:26:10 -0400
Date: Mon, 20 Sep 2004 14:26:02 -0700
Message-Id: <200409202126.i8KLQ2om000780@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Richard Henderson <rth@twiddle.net>, linux-arch@vger.kernel.org
Subject: Re: waitid fallout
In-Reply-To: Arnd Bergmann's message of  Saturday, 18 September 2004 15:03:03 +0200 <200409181503.07369.arnd@arndb.de>
X-Zippy-Says: Oh, FISH sticks, CHEEZ WHIZ, GIN fizz, SHOW BIZ!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just noticed it's changed in BK now. However, the respective
> changes in the compat_sys_waitid() code and include/linux/syscalls.h
> are still missing.

Sorry for that oversight.  This patch updates the x86-64's compat code to
handle the new argument to waitid.


Index: linux-2.6/include/linux/syscalls.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/syscalls.h,v
retrieving revision 1.12
diff -B -b -p -u -r1.12 syscalls.h
--- linux-2.6/include/linux/syscalls.h 31 Aug 2004 17:35:25 -0000 1.12
+++ linux-2.6/include/linux/syscalls.h 20 Sep 2004 19:55:29 -0000
@@ -163,7 +163,8 @@ asmlinkage void sys_exit_group(int error
 asmlinkage long sys_wait4(pid_t pid, unsigned int __user *stat_addr,
 				int options, struct rusage __user *ru);
 asmlinkage long sys_waitid(int which, pid_t pid,
-			   	struct siginfo __user *infop, int options);
+			   struct siginfo __user *infop,
+			   int options, struct rusage __user *ru);
 asmlinkage long sys_waitpid(pid_t pid, unsigned int __user *stat_addr, int options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
Index: linux-2.6/arch/x86_64/ia32/sys_ia32.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/ia32/sys_ia32.c,v
retrieving revision 1.69
diff -B -b -p -u -r1.69 sys_ia32.c
--- linux-2.6/arch/x86_64/ia32/sys_ia32.c 31 Aug 2004 17:35:25 -0000 1.69
+++ linux-2.6/arch/x86_64/ia32/sys_ia32.c 20 Sep 2004 20:01:06 -0000
@@ -1152,19 +1152,26 @@ asmlinkage long sys32_clone(unsigned int
 }
 
 asmlinkage long sys32_waitid(int which, compat_pid_t pid,
-			     siginfo_t32 __user *uinfo, int options)
+			     siginfo_t32 __user *uinfo, int options,
+			     struct compat_rusage __user *uru)
 {
 	siginfo_t info;
+	struct rusage ru;
 	long ret;
 	mm_segment_t old_fs = get_fs();
 
 	info.si_signo = 0;
 	set_fs (KERNEL_DS);
-	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options);
+	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options,
+			 uru ? &ru : NULL);
 	set_fs (old_fs);
 
 	if (ret < 0 || info.si_signo == 0)
 		return ret;
+
+	if (uru && (ret = put_compat_rusage(&ru, uru)))
+		return ret;
+
 	BUG_ON(info.si_code & __SI_MASK);
 	info.si_code |= __SI_CHLD;
 	return ia32_copy_siginfo_to_user(uinfo, &info);
