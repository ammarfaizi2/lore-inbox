Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWCWFts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWCWFts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWCWFtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:49:47 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:62119 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932445AbWCWFto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:49:44 -0500
Date: Thu, 23 Mar 2006 16:48:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org
Subject: [PATCH 2/2] consolidate sys32/compat_adjtimex
Message-Id: <20060323164856.3706c6bc.sfr@canb.auug.org.au>
In-Reply-To: <20060323164623.699f569e.sfr@canb.auug.org.au>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create compat_sys_adjtimex and use it an all appropriate places.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/alpha/kernel/osf_sys.c        |    1 -
 arch/ia64/ia32/sys_ia32.c          |   62 -----------------------------------
 arch/mips/kernel/linux32.c         |   61 ----------------------------------
 arch/mips/kernel/scall64-n32.S     |    2 +
 arch/mips/kernel/scall64-o32.S     |    2 +
 arch/parisc/kernel/sys_parisc32.c  |   29 ----------------
 arch/parisc/kernel/syscall_table.S |    2 +
 arch/powerpc/kernel/sys_ppc32.c    |   60 ----------------------------------
 arch/s390/kernel/compat_linux.c    |   61 ----------------------------------
 arch/s390/kernel/compat_wrapper.S  |    8 ++---
 arch/s390/kernel/syscalls.S        |    2 +
 arch/sparc64/kernel/sys_sparc32.c  |   61 ----------------------------------
 arch/sparc64/kernel/systbls.S      |    2 +
 arch/x86_64/ia32/ia32entry.S       |    2 +
 arch/x86_64/ia32/sys_ia32.c        |   64 ------------------------------------
 include/linux/compat.h             |    2 +
 include/linux/timex.h              |    2 +
 kernel/compat.c                    |   59 +++++++++++++++++++++++++++++++++
 18 files changed, 73 insertions(+), 409 deletions(-)

This has been built on PowerPC and booted on iSeries and ntpdate seems to
be OK.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

8ed1fd60f5e45c9a24c0c9da0f0d70a7334c84a6
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 7fb14f4..31afe3d 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -821,7 +821,6 @@ osf_setsysinfo(unsigned long op, void __
    affects all sorts of things, like timeval and itimerval.  */
 
 extern struct timezone sys_tz;
-extern int do_adjtimex(struct timex *);
 
 struct timeval32
 {
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 676b141..759c394 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -25,7 +25,6 @@
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
-#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -2603,65 +2602,4 @@ sys32_setresgid(compat_gid_t rgid, compa
 	ssgid = (sgid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)sgid);
 	return sys_setresgid(srgid, segid, ssgid);
 }
-
-/* Handle adjtimex compatibility. */
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long
-sys32_adjtimex(struct compat_timex *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if(put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
 #endif /* NOTYET */
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index f33e779..3f40c37 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -30,7 +30,6 @@
 #include <linux/utime.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
-#include <linux/timex.h>
 #include <linux/dnotify.h>
 #include <linux/module.h>
 #include <linux/binfmts.h>
@@ -1157,66 +1156,6 @@ out:
 	return err;
 }
 
-/* Handle adjtimex compatibility. */
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage int sys32_adjtimex(struct compat_timex __user *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if (get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if (put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset,
 	s32 count)
 {
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 02c8267..05a2c05 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -273,7 +273,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_pivot_root
 	PTR	sys32_sysctl
 	PTR	sys_prctl
-	PTR	sys32_adjtimex
+	PTR	compat_sys_adjtimex
 	PTR	compat_sys_setrlimit		/* 6155 */
 	PTR	sys_chroot
 	PTR	sys_sync
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 797e0d8..19c4ca4 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -328,7 +328,7 @@ sys_call_table:
 	PTR	sys_setdomainname
 	PTR	sys32_newuname
 	PTR	sys_ni_syscall			/* sys_modify_ldt */
-	PTR	sys32_adjtimex
+	PTR	compat_sys_adjtimex
 	PTR	sys_mprotect			/* 4125 */
 	PTR	compat_sys_sigprocmask
 	PTR	sys_ni_syscall			/* was creat_module */
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index ca1d8db..d286f68 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -21,7 +21,6 @@
 #include <linux/times.h>
 #include <linux/utsname.h>
 #include <linux/time.h>
-#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -567,34 +566,6 @@ asmlinkage int sys32_sendfile64(int out_
 }
 
 
-asmlinkage long sys32_adjtimex(struct compat_timex __user *txc_p32)
-{
-	struct timex txc;
-	struct compat_timex t32;
-	int ret;
-	extern int do_adjtimex(struct timex *txc);
-
-	if(copy_from_user(&t32, txc_p32, sizeof(struct compat_timex)))
-		return -EFAULT;
-#undef CP
-#define CP(x) txc.x = t32.x
-	CP(modes); CP(offset); CP(freq); CP(maxerror); CP(esterror);
-	CP(status); CP(constant); CP(precision); CP(tolerance);
-	CP(time.tv_sec); CP(time.tv_usec); CP(tick); CP(ppsfreq); CP(jitter);
-	CP(shift); CP(stabil); CP(jitcnt); CP(calcnt); CP(errcnt);
-	CP(stbcnt);
-	ret = do_adjtimex(&txc);
-#undef CP
-#define CP(x) t32.x = txc.x
-	CP(modes); CP(offset); CP(freq); CP(maxerror); CP(esterror);
-	CP(status); CP(constant); CP(precision); CP(tolerance);
-	CP(time.tv_sec); CP(time.tv_usec); CP(tick); CP(ppsfreq); CP(jitter);
-	CP(shift); CP(stabil); CP(jitcnt); CP(calcnt); CP(errcnt);
-	CP(stbcnt);
-	return copy_to_user(txc_p32, &t32, sizeof(struct compat_timex)) ? -EFAULT : ret;
-}
-
-
 struct sysinfo32 {
 	s32 uptime;
 	u32 loads[3];
diff --git a/arch/parisc/kernel/syscall_table.S b/arch/parisc/kernel/syscall_table.S
index 71011ea..89b6c56 100644
--- a/arch/parisc/kernel/syscall_table.S
+++ b/arch/parisc/kernel/syscall_table.S
@@ -207,7 +207,7 @@
 	/* struct sockaddr... */
 	ENTRY_SAME(recvfrom)
 	/* struct timex contains longs */
-	ENTRY_DIFF(adjtimex)
+	ENTRY_COMP(adjtimex)
 	ENTRY_SAME(mprotect)		/* 125 */
 	/* old_sigset_t forced to 32 bits.  Beware glibc sigset_t */
 	ENTRY_COMP(sigprocmask)
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index d9867f5..ec274e6 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -24,7 +24,6 @@
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
-#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -161,65 +160,6 @@ asmlinkage long compat_sys_sysfs(u32 opt
 	return sys_sysfs((int)option, arg1, arg2);
 }
 
-/* Handle adjtimex compatibility. */
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp)
-{
-	struct timex txc;
-	int ret;
-	
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if(put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 asmlinkage long compat_sys_pause(void)
 {
 	current->state = TASK_INTERRUPTIBLE;
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 9809264..5e14de3 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -26,7 +26,6 @@
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
-#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -705,66 +704,6 @@ asmlinkage long sys32_sendfile64(int out
 	return ret;
 }
 
-/* Handle adjtimex compatibility. */
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long sys32_adjtimex(struct compat_timex __user *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if(get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if(put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 #ifdef CONFIG_SYSCTL
 struct __sysctl_args32 {
 	u32 name;
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 50e8013..199da68 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -551,10 +551,10 @@ sys32_newuname_wrapper:
 	llgtr	%r2,%r2			# struct new_utsname *
 	jg	s390x_newuname		# branch to system call
 
-	.globl  sys32_adjtimex_wrapper 
-sys32_adjtimex_wrapper:
-	llgtr	%r2,%r2			# struct timex_emu31 *
-	jg	sys32_adjtimex		# branch to system call
+	.globl  compat_sys_adjtimex_wrapper
+compat_sys_adjtimex_wrapper:
+	llgtr	%r2,%r2			# struct compat_timex *
+	jg	compat_sys_adjtimex	# branch to system call
 
 	.globl  sys32_mprotect_wrapper 
 sys32_mprotect_wrapper:
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 7c88d85..2f56654 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -132,7 +132,7 @@ SYSCALL(sys_clone_glue,sys_clone_glue,sy
 SYSCALL(sys_setdomainname,sys_setdomainname,sys32_setdomainname_wrapper)
 SYSCALL(sys_newuname,s390x_newuname,sys32_newuname_wrapper)
 NI_SYSCALL							/* modify_ldt for i386 */
-SYSCALL(sys_adjtimex,sys_adjtimex,sys32_adjtimex_wrapper)
+SYSCALL(sys_adjtimex,sys_adjtimex,compat_sys_adjtimex_wrapper)
 SYSCALL(sys_mprotect,sys_mprotect,sys32_mprotect_wrapper)	/* 125 */
 SYSCALL(sys_sigprocmask,sys_sigprocmask,compat_sys_sigprocmask_wrapper)
 NI_SYSCALL							/* old "create module" */
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index 48f02f2..2e906ba 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -19,7 +19,6 @@
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
-#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -945,66 +944,6 @@ asmlinkage long compat_sys_sendfile64(in
 	return ret;
 }
 
-/* Handle adjtimex compatibility. */
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long sys32_adjtimex(struct compat_timex __user *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if (get_user(txc.modes, &utp->modes) ||
-	    __get_user(txc.offset, &utp->offset) ||
-	    __get_user(txc.freq, &utp->freq) ||
-	    __get_user(txc.maxerror, &utp->maxerror) ||
-	    __get_user(txc.esterror, &utp->esterror) ||
-	    __get_user(txc.status, &utp->status) ||
-	    __get_user(txc.constant, &utp->constant) ||
-	    __get_user(txc.precision, &utp->precision) ||
-	    __get_user(txc.tolerance, &utp->tolerance) ||
-	    __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	    __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	    __get_user(txc.tick, &utp->tick) ||
-	    __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	    __get_user(txc.jitter, &utp->jitter) ||
-	    __get_user(txc.shift, &utp->shift) ||
-	    __get_user(txc.stabil, &utp->stabil) ||
-	    __get_user(txc.jitcnt, &utp->jitcnt) ||
-	    __get_user(txc.calcnt, &utp->calcnt) ||
-	    __get_user(txc.errcnt, &utp->errcnt) ||
-	    __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if (put_user(txc.modes, &utp->modes) ||
-	    __put_user(txc.offset, &utp->offset) ||
-	    __put_user(txc.freq, &utp->freq) ||
-	    __put_user(txc.maxerror, &utp->maxerror) ||
-	    __put_user(txc.esterror, &utp->esterror) ||
-	    __put_user(txc.status, &utp->status) ||
-	    __put_user(txc.constant, &utp->constant) ||
-	    __put_user(txc.precision, &utp->precision) ||
-	    __put_user(txc.tolerance, &utp->tolerance) ||
-	    __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	    __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	    __put_user(txc.tick, &utp->tick) ||
-	    __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	    __put_user(txc.jitter, &utp->jitter) ||
-	    __put_user(txc.shift, &utp->shift) ||
-	    __put_user(txc.stabil, &utp->stabil) ||
-	    __put_user(txc.jitcnt, &utp->jitcnt) ||
-	    __put_user(txc.calcnt, &utp->calcnt) ||
-	    __put_user(txc.errcnt, &utp->errcnt) ||
-	    __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 /* This is just a version for 32-bit applications which does
  * not force O_LARGEFILE on.
  */
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index c3adb7a..3b250f2 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -63,7 +63,7 @@ sys_call_table32:
 /*200*/	.word sys32_ssetmask, sys_sigsuspend, compat_sys_newlstat, sys_uselib, compat_sys_old_readdir
 	.word sys32_readahead, sys32_socketcall, sys32_syslog, sys32_lookup_dcookie, sys32_fadvise64
 /*210*/	.word sys32_fadvise64_64, sys32_tgkill, sys32_waitpid, sys_swapoff, sys32_sysinfo
-	.word sys32_ipc, sys32_sigreturn, sys_clone, sys32_ioprio_get, sys32_adjtimex
+	.word sys32_ipc, sys32_sigreturn, sys_clone, sys32_ioprio_get, compat_sys_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys32_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
 /*230*/	.word sys32_select, compat_sys_time, sys_nis_syscall, compat_sys_stime, compat_sys_statfs64
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index 00dee17..7549a43 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -501,7 +501,7 @@ ia32_sys_call_table:
 	.quad sys_setdomainname
 	.quad sys_uname
 	.quad sys_modify_ldt
-	.quad sys32_adjtimex
+	.quad compat_sys_adjtimex
 	.quad sys32_mprotect		/* 125 */
 	.quad compat_sys_sigprocmask
 	.quad quiet_ni_syscall		/* create_module */
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
index a0baeeb..4a5cae0 100644
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -30,7 +30,6 @@
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
-#include <linux/timex.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -779,69 +778,6 @@ sys32_sendfile(int out_fd, int in_fd, co
 	return ret;
 }
 
-/* Handle adjtimex compatibility. */
-
-extern int do_adjtimex(struct timex *);
-
-asmlinkage long
-sys32_adjtimex(struct compat_timex __user *utp)
-{
-	struct timex txc;
-	int ret;
-
-	memset(&txc, 0, sizeof(struct timex));
-
-	if (!access_ok(VERIFY_READ, utp, sizeof(struct compat_timex)) ||
-	   __get_user(txc.modes, &utp->modes) ||
-	   __get_user(txc.offset, &utp->offset) ||
-	   __get_user(txc.freq, &utp->freq) ||
-	   __get_user(txc.maxerror, &utp->maxerror) ||
-	   __get_user(txc.esterror, &utp->esterror) ||
-	   __get_user(txc.status, &utp->status) ||
-	   __get_user(txc.constant, &utp->constant) ||
-	   __get_user(txc.precision, &utp->precision) ||
-	   __get_user(txc.tolerance, &utp->tolerance) ||
-	   __get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __get_user(txc.tick, &utp->tick) ||
-	   __get_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __get_user(txc.jitter, &utp->jitter) ||
-	   __get_user(txc.shift, &utp->shift) ||
-	   __get_user(txc.stabil, &utp->stabil) ||
-	   __get_user(txc.jitcnt, &utp->jitcnt) ||
-	   __get_user(txc.calcnt, &utp->calcnt) ||
-	   __get_user(txc.errcnt, &utp->errcnt) ||
-	   __get_user(txc.stbcnt, &utp->stbcnt))
-		return -EFAULT;
-
-	ret = do_adjtimex(&txc);
-
-	if (!access_ok(VERIFY_WRITE, utp, sizeof(struct compat_timex)) ||
-	   __put_user(txc.modes, &utp->modes) ||
-	   __put_user(txc.offset, &utp->offset) ||
-	   __put_user(txc.freq, &utp->freq) ||
-	   __put_user(txc.maxerror, &utp->maxerror) ||
-	   __put_user(txc.esterror, &utp->esterror) ||
-	   __put_user(txc.status, &utp->status) ||
-	   __put_user(txc.constant, &utp->constant) ||
-	   __put_user(txc.precision, &utp->precision) ||
-	   __put_user(txc.tolerance, &utp->tolerance) ||
-	   __put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
-	   __put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
-	   __put_user(txc.tick, &utp->tick) ||
-	   __put_user(txc.ppsfreq, &utp->ppsfreq) ||
-	   __put_user(txc.jitter, &utp->jitter) ||
-	   __put_user(txc.shift, &utp->shift) ||
-	   __put_user(txc.stabil, &utp->stabil) ||
-	   __put_user(txc.jitcnt, &utp->jitcnt) ||
-	   __put_user(txc.calcnt, &utp->calcnt) ||
-	   __put_user(txc.errcnt, &utp->errcnt) ||
-	   __put_user(txc.stbcnt, &utp->stbcnt))
-		ret = -EFAULT;
-
-	return ret;
-}
-
 asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 859f957..24d659c 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -207,5 +207,7 @@ static inline int compat_timespec_compar
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
+asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/include/linux/timex.h b/include/linux/timex.h
index b7ca120..87f9bdf 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -348,6 +348,8 @@ time_interpolator_reset(void)
 /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
 extern u64 current_tick_length(void);
 
+extern int do_adjtimex(struct timex *);
+
 #endif /* KERNEL */
 
 #endif /* LINUX_TIMEX_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index 8c9cd88..b9bdd12 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -21,6 +21,7 @@
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/security.h>
+#include <linux/timex.h>
 
 #include <asm/uaccess.h>
 
@@ -898,3 +899,61 @@ asmlinkage long compat_sys_rt_sigsuspend
 	return -ERESTARTNOHAND;
 }
 #endif /* __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND */
+
+asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp)
+{
+	struct timex txc;
+	int ret;
+
+	memset(&txc, 0, sizeof(struct timex));
+
+	if (!access_ok(VERIFY_READ, utp, sizeof(struct compat_timex)) ||
+			__get_user(txc.modes, &utp->modes) ||
+			__get_user(txc.offset, &utp->offset) ||
+			__get_user(txc.freq, &utp->freq) ||
+			__get_user(txc.maxerror, &utp->maxerror) ||
+			__get_user(txc.esterror, &utp->esterror) ||
+			__get_user(txc.status, &utp->status) ||
+			__get_user(txc.constant, &utp->constant) ||
+			__get_user(txc.precision, &utp->precision) ||
+			__get_user(txc.tolerance, &utp->tolerance) ||
+			__get_user(txc.time.tv_sec, &utp->time.tv_sec) ||
+			__get_user(txc.time.tv_usec, &utp->time.tv_usec) ||
+			__get_user(txc.tick, &utp->tick) ||
+			__get_user(txc.ppsfreq, &utp->ppsfreq) ||
+			__get_user(txc.jitter, &utp->jitter) ||
+			__get_user(txc.shift, &utp->shift) ||
+			__get_user(txc.stabil, &utp->stabil) ||
+			__get_user(txc.jitcnt, &utp->jitcnt) ||
+			__get_user(txc.calcnt, &utp->calcnt) ||
+			__get_user(txc.errcnt, &utp->errcnt) ||
+			__get_user(txc.stbcnt, &utp->stbcnt))
+		return -EFAULT;
+
+	ret = do_adjtimex(&txc);
+
+	if (!access_ok(VERIFY_WRITE, utp, sizeof(struct compat_timex)) ||
+			__put_user(txc.modes, &utp->modes) ||
+			__put_user(txc.offset, &utp->offset) ||
+			__put_user(txc.freq, &utp->freq) ||
+			__put_user(txc.maxerror, &utp->maxerror) ||
+			__put_user(txc.esterror, &utp->esterror) ||
+			__put_user(txc.status, &utp->status) ||
+			__put_user(txc.constant, &utp->constant) ||
+			__put_user(txc.precision, &utp->precision) ||
+			__put_user(txc.tolerance, &utp->tolerance) ||
+			__put_user(txc.time.tv_sec, &utp->time.tv_sec) ||
+			__put_user(txc.time.tv_usec, &utp->time.tv_usec) ||
+			__put_user(txc.tick, &utp->tick) ||
+			__put_user(txc.ppsfreq, &utp->ppsfreq) ||
+			__put_user(txc.jitter, &utp->jitter) ||
+			__put_user(txc.shift, &utp->shift) ||
+			__put_user(txc.stabil, &utp->stabil) ||
+			__put_user(txc.jitcnt, &utp->jitcnt) ||
+			__put_user(txc.calcnt, &utp->calcnt) ||
+			__put_user(txc.errcnt, &utp->errcnt) ||
+			__put_user(txc.stbcnt, &utp->stbcnt))
+		ret = -EFAULT;
+
+	return ret;
+}
-- 
1.2.4

