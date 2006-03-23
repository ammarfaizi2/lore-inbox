Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWCWFtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWCWFtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCWFtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:49:32 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:60327 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932440AbWCWFtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:49:31 -0500
Date: Thu, 23 Mar 2006 16:46:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org
Subject: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-Id: <20060323164623.699f569e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a copy of the compatibility version of struct timex in each 64 bit
architecture.  This patch just creates a global one and replaces all the
usages of the old ones.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ia64/ia32/sys_ia32.c         |   15 +--------------
 arch/mips/kernel/linux32.c        |   15 +--------------
 arch/parisc/kernel/sys_parisc32.c |   37 ++++---------------------------------
 arch/powerpc/kernel/sys_ppc32.c   |   15 +--------------
 arch/s390/kernel/compat_linux.c   |   15 +--------------
 arch/sparc64/kernel/sys_sparc32.c |   15 +--------------
 arch/x86_64/ia32/sys_ia32.c       |   19 +++----------------
 include/linux/compat.h            |   26 ++++++++++++++++++++++++++
 8 files changed, 38 insertions(+), 119 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

e6210e0939966f84850ef6896799a24fc8ca45d2
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 70dba1f..676b141 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -2606,23 +2606,10 @@ sys32_setresgid(compat_gid_t rgid, compa
 
 /* Handle adjtimex compatibility. */
 
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
 extern int do_adjtimex(struct timex *);
 
 asmlinkage long
-sys32_adjtimex(struct timex32 *utp)
+sys32_adjtimex(struct compat_timex *utp)
 {
 	struct timex txc;
 	int ret;
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 013bc93..f33e779 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -1159,22 +1159,9 @@ out:
 
 /* Handle adjtimex compatibility. */
 
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
 extern int do_adjtimex(struct timex *);
 
-asmlinkage int sys32_adjtimex(struct timex32 __user *utp)
+asmlinkage int sys32_adjtimex(struct compat_timex __user *utp)
 {
 	struct timex txc;
 	int ret;
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index 6135690..ca1d8db 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -567,43 +567,14 @@ asmlinkage int sys32_sendfile64(int out_
 }
 
 
-struct timex32 {
-	unsigned int modes;	/* mode selector */
-	int offset;		/* time offset (usec) */
-	int freq;		/* frequency offset (scaled ppm) */
-	int maxerror;		/* maximum error (usec) */
-	int esterror;		/* estimated error (usec) */
-	int status;		/* clock command/status */
-	int constant;		/* pll time constant */
-	int precision;		/* clock precision (usec) (read only) */
-	int tolerance;		/* clock frequency tolerance (ppm)
-				 * (read only)
-				 */
-	struct compat_timeval time;	/* (read only) */
-	int tick;		/* (modified) usecs between clock ticks */
-
-	int ppsfreq;           /* pps frequency (scaled ppm) (ro) */
-	int jitter;            /* pps jitter (us) (ro) */
-	int shift;              /* interval duration (s) (shift) (ro) */
-	int stabil;            /* pps stability (scaled ppm) (ro) */
-	int jitcnt;            /* jitter limit exceeded (ro) */
-	int calcnt;            /* calibration intervals (ro) */
-	int errcnt;            /* calibration errors (ro) */
-	int stbcnt;            /* stability limit exceeded (ro) */
-
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
-	int  :32; int  :32; int  :32; int  :32;
-};
-
-asmlinkage long sys32_adjtimex(struct timex32 __user *txc_p32)
+asmlinkage long sys32_adjtimex(struct compat_timex __user *txc_p32)
 {
 	struct timex txc;
-	struct timex32 t32;
+	struct compat_timex t32;
 	int ret;
 	extern int do_adjtimex(struct timex *txc);
 
-	if(copy_from_user(&t32, txc_p32, sizeof(struct timex32)))
+	if(copy_from_user(&t32, txc_p32, sizeof(struct compat_timex)))
 		return -EFAULT;
 #undef CP
 #define CP(x) txc.x = t32.x
@@ -620,7 +591,7 @@ asmlinkage long sys32_adjtimex(struct ti
 	CP(time.tv_sec); CP(time.tv_usec); CP(tick); CP(ppsfreq); CP(jitter);
 	CP(shift); CP(stabil); CP(jitcnt); CP(calcnt); CP(errcnt);
 	CP(stbcnt);
-	return copy_to_user(txc_p32, &t32, sizeof(struct timex32)) ? -EFAULT : ret;
+	return copy_to_user(txc_p32, &t32, sizeof(struct compat_timex)) ? -EFAULT : ret;
 }
 
 
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index cd75ab2..d9867f5 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -162,22 +162,9 @@ asmlinkage long compat_sys_sysfs(u32 opt
 }
 
 /* Handle adjtimex compatibility. */
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
 extern int do_adjtimex(struct timex *);
 
-asmlinkage long compat_sys_adjtimex(struct timex32 __user *utp)
+asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp)
 {
 	struct timex txc;
 	int ret;
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index cc058dc..9809264 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -707,22 +707,9 @@ asmlinkage long sys32_sendfile64(int out
 
 /* Handle adjtimex compatibility. */
 
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
 extern int do_adjtimex(struct timex *);
 
-asmlinkage long sys32_adjtimex(struct timex32 __user *utp)
+asmlinkage long sys32_adjtimex(struct compat_timex __user *utp)
 {
 	struct timex txc;
 	int ret;
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index 0e41df0..48f02f2 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -947,22 +947,9 @@ asmlinkage long compat_sys_sendfile64(in
 
 /* Handle adjtimex compatibility. */
 
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
 extern int do_adjtimex(struct timex *);
 
-asmlinkage long sys32_adjtimex(struct timex32 __user *utp)
+asmlinkage long sys32_adjtimex(struct compat_timex __user *utp)
 {
 	struct timex txc;
 	int ret;
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
index 2bc55af..a0baeeb 100644
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -781,30 +781,17 @@ sys32_sendfile(int out_fd, int in_fd, co
 
 /* Handle adjtimex compatibility. */
 
-struct timex32 {
-	u32 modes;
-	s32 offset, freq, maxerror, esterror;
-	s32 status, constant, precision, tolerance;
-	struct compat_timeval time;
-	s32 tick;
-	s32 ppsfreq, jitter, shift, stabil;
-	s32 jitcnt, calcnt, errcnt, stbcnt;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-	s32  :32; s32  :32; s32  :32; s32  :32;
-};
-
 extern int do_adjtimex(struct timex *);
 
 asmlinkage long
-sys32_adjtimex(struct timex32 __user *utp)
+sys32_adjtimex(struct compat_timex __user *utp)
 {
 	struct timex txc;
 	int ret;
 
 	memset(&txc, 0, sizeof(struct timex));
 
-	if (!access_ok(VERIFY_READ, utp, sizeof(struct timex32)) ||
+	if (!access_ok(VERIFY_READ, utp, sizeof(struct compat_timex)) ||
 	   __get_user(txc.modes, &utp->modes) ||
 	   __get_user(txc.offset, &utp->offset) ||
 	   __get_user(txc.freq, &utp->freq) ||
@@ -829,7 +816,7 @@ sys32_adjtimex(struct timex32 __user *ut
 
 	ret = do_adjtimex(&txc);
 
-	if (!access_ok(VERIFY_WRITE, utp, sizeof(struct timex32)) ||
+	if (!access_ok(VERIFY_WRITE, utp, sizeof(struct compat_timex)) ||
 	   __put_user(txc.modes, &utp->modes) ||
 	   __put_user(txc.offset, &utp->offset) ||
 	   __put_user(txc.freq, &utp->freq) ||
diff --git a/include/linux/compat.h b/include/linux/compat.h
index c9ab2a2..859f957 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -45,6 +45,32 @@ struct compat_tms {
 	compat_clock_t		tms_cstime;
 };
 
+struct compat_timex {
+	compat_uint_t modes;
+	compat_long_t offset;
+	compat_long_t freq;
+	compat_long_t maxerror;
+	compat_long_t esterror;
+	compat_int_t status;
+	compat_long_t constant;
+	compat_long_t precision;
+	compat_long_t tolerance;
+	struct compat_timeval time;
+	compat_long_t tick;
+	compat_long_t ppsfreq;
+	compat_long_t jitter;
+	compat_int_t shift;
+	compat_long_t stabil;
+	compat_long_t jitcnt;
+	compat_long_t calcnt;
+	compat_long_t errcnt;
+	compat_long_t stbcnt;
+
+	compat_int_t :32; compat_int_t :32; compat_int_t :32; compat_int_t :32;
+	compat_int_t :32; compat_int_t :32; compat_int_t :32; compat_int_t :32;
+	compat_int_t :32; compat_int_t :32; compat_int_t :32; compat_int_t :32;
+};
+
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
 typedef struct {
-- 
1.2.4

