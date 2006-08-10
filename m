Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWHJT7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWHJT7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWHJT7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:64235 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932653AbWHJTg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:57 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [98/145] x86_64: Fix most sparse warnings in sys_ia32.c
Message-Id: <20060810193655.F02EB13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:55 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Mostly by adding casts.

I didn't touch the "invalid access past ..." which are caused
by the sigset conversion.
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/ia32/sys_ia32.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

Index: linux/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- linux.orig/arch/x86_64/ia32/sys_ia32.c
+++ linux/arch/x86_64/ia32/sys_ia32.c
@@ -60,6 +60,7 @@
 #include <linux/highuid.h>
 #include <linux/vmalloc.h>
 #include <linux/fsnotify.h>
+#include <linux/sysctl.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -389,7 +390,9 @@ sys32_rt_sigprocmask(int how, compat_sig
 		}
 	}
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL,
+	ret = sys_rt_sigprocmask(how,
+				 set ? (sigset_t __user *)&s : NULL,
+				 oset ? (sigset_t __user *)&s : NULL,
 				 sigsetsize); 
 	set_fs (old_fs);
 	if (ret) return ret;
@@ -541,7 +544,7 @@ sys32_sysinfo(struct sysinfo32 __user *i
 	int bitcount = 0;
 	
 	set_fs (KERNEL_DS);
-	ret = sys_sysinfo(&s);
+	ret = sys_sysinfo((struct sysinfo __user *)&s);
 	set_fs (old_fs);
 
         /* Check to see if any memory value is too large for 32-bit and scale
@@ -589,7 +592,7 @@ sys32_sched_rr_get_interval(compat_pid_t
 	mm_segment_t old_fs = get_fs ();
 	
 	set_fs (KERNEL_DS);
-	ret = sys_sched_rr_get_interval(pid, &t);
+	ret = sys_sched_rr_get_interval(pid, (struct timespec __user *)&t);
 	set_fs (old_fs);
 	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
@@ -605,7 +608,7 @@ sys32_rt_sigpending(compat_sigset_t __us
 	mm_segment_t old_fs = get_fs();
 		
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigpending(&s, sigsetsize);
+	ret = sys_rt_sigpending((sigset_t __user *)&s, sigsetsize);
 	set_fs (old_fs);
 	if (!ret) {
 		switch (_NSIG_WORDS) {
@@ -630,7 +633,7 @@ sys32_rt_sigqueueinfo(int pid, int sig, 
 	if (copy_siginfo_from_user32(&info, uinfo))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, &info);
+	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
 	set_fs (old_fs);
 	return ret;
 }
@@ -666,9 +669,6 @@ sys32_sysctl(struct sysctl_ia32 __user *
 	size_t oldlen;
 	int __user *namep;
 	long ret;
-	extern int do_sysctl(int *name, int nlen, void *oldval, size_t *oldlenp,
-		     void *newval, size_t newlen);
-
 
 	if (copy_from_user(&a32, args32, sizeof (a32)))
 		return -EFAULT;
@@ -692,7 +692,8 @@ sys32_sysctl(struct sysctl_ia32 __user *
 
 	set_fs(KERNEL_DS);
 	lock_kernel();
-	ret = do_sysctl(namep, a32.nlen, oldvalp, &oldlen, newvalp, (size_t) a32.newlen);
+	ret = do_sysctl(namep, a32.nlen, oldvalp, (size_t __user *)&oldlen,
+			newvalp, (size_t) a32.newlen);
 	unlock_kernel();
 	set_fs(old_fs);
 
@@ -743,7 +744,8 @@ sys32_sendfile(int out_fd, int in_fd, co
 		return -EFAULT;
 		
 	set_fs(KERNEL_DS);
-	ret = sys_sendfile(out_fd, in_fd, offset ? &of : NULL, count);
+	ret = sys_sendfile(out_fd, in_fd, offset ? (off_t __user *)&of : NULL,
+			   count);
 	set_fs(old_fs);
 	
 	if (offset && put_user(of, offset))
@@ -831,7 +833,7 @@ long sys32_ustat(unsigned dev, struct us
 	
 	seg = get_fs(); 
 	set_fs(KERNEL_DS); 
-	ret = sys_ustat(dev,&u); 
+	ret = sys_ustat(dev, (struct ustat __user *)&u);
 	set_fs(seg);
 	if (ret >= 0) { 
 		if (!access_ok(VERIFY_WRITE,u32p,sizeof(struct ustat32)) || 
