Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUDQKA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUDQKA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:00:59 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:45755 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263777AbUDQJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:49:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Consolidate sys32_select
Date: Fri, 16 Apr 2004 18:05:55 +0200
User-Agent: KMail/1.6.1
References: <200404161800.22367.arnd@arndb.de>
In-Reply-To: <200404161800.22367.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404161805.55224.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys32_select has seven mostly but not exactly identical versions,
so consolidate them as compat_sys_select. Based on the ppc64
implementation, which most closely resembles sys_select.
One bug that was not caught by LTP has been fixed since the
first version of this patch.

tested x86_64, ia64 and s390.

 arch/ia64/ia32/ia32_entry.S        |    2
 arch/ia64/ia32/sys_ia32.c          |  108 ---------------------
 arch/mips/kernel/linux32.c         |  161 -------------------------------
 arch/mips/kernel/scall64-n32.S     |    2
 arch/mips/kernel/scall64-o32.S     |    2
 arch/parisc/kernel/sys_parisc32.c  |  121 -----------------------
 arch/parisc/kernel/syscall_table.S |    2
 arch/ppc64/kernel/sys_ppc32.c      |  163 --------------------------------
 arch/s390/kernel/compat_linux.c    |  154 ------------------------------
 arch/s390/kernel/compat_wrapper.S  |   14 +-
 arch/s390/kernel/syscalls.S        |    2
 arch/sparc64/kernel/sys_sparc32.c  |  152 -----------------------------
 arch/sparc64/kernel/sys_sunos32.c  |    9 -
 arch/sparc64/kernel/systbls.S      |    4
 arch/x86_64/ia32/ia32entry.S       |    2
 arch/x86_64/ia32/sys_ia32.c        |  105 --------------------
 fs/compat.c                        |  188 +++++++++++++++++++++++++++++++++++++
 include/linux/compat.h             |    4
 18 files changed, 218 insertions(+), 977 deletions(-)

===== arch/ia64/ia32/ia32_entry.S 1.36 vs edited =====
--- 1.36/arch/ia64/ia32/ia32_entry.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/ia64/ia32/ia32_entry.S	Thu Apr 15 17:30:49 2004
@@ -350,7 +350,7 @@
 	data8 sys_setfsgid	/* 16-bit version */
 	data8 sys_llseek	  /* 140 */
 	data8 sys32_getdents
-	data8 sys32_select
+	data8 compat_sys_select
 	data8 sys_flock
 	data8 sys32_msync
 	data8 compat_sys_readv	  /* 145 */
===== arch/ia64/ia32/sys_ia32.c 1.95 vs edited =====
--- 1.95/arch/ia64/ia32/sys_ia32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/ia64/ia32/sys_ia32.c	Thu Apr 15 17:30:49 2004
@@ -776,110 +776,6 @@
 	return error;
 }
 
-/*
- * We can actually return ERESTARTSYS instead of EINTR, but I'd
- * like to be certain this leads to no problems. So I return
- * EINTR just for safety.
- *
- * Update: ERESTARTSYS breaks at least the xview clock binary, so
- * I'm trying ERESTARTNOHAND which restart only when you want to.
- */
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-#define ROUND_UP_TIME(x,y) (((x)+(y)-1)/(y))
-
-asmlinkage long
-sys32_select (int n, fd_set *inp, fd_set *outp, fd_set *exp, struct compat_timeval *tvp32)
-{
-	fd_set_bits fds;
-	char *bits;
-	long timeout;
-	int ret, size;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp32) {
-		time_t sec, usec;
-
-		ret = -EFAULT;
-		if (get_user(sec, &tvp32->tv_sec) || get_user(usec, &tvp32->tv_usec))
-			goto out_nofds;
-
-		ret = -EINVAL;
-		if (sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = ROUND_UP_TIME(usec, 1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words.
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	if ((ret = get_fd_set(n, inp, fds.in)) ||
-	    (ret = get_fd_set(n, outp, fds.out)) ||
-	    (ret = get_fd_set(n, exp, fds.ex)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp32 && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		if (put_user(sec, &tvp32->tv_sec) || put_user(usec, &tvp32->tv_usec)) {
-			ret = -EFAULT;
-			goto out;
-		}
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set(n, inp, fds.res_in);
-	set_fd_set(n, outp, fds.res_out);
-	set_fd_set(n, exp, fds.res_ex);
-
-out:
-	kfree(bits);
-out_nofds:
-	return ret;
-}
-
 struct sel_arg_struct {
 	unsigned int n;
 	unsigned int inp;
@@ -895,8 +791,8 @@
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
-	return sys32_select(a.n, (fd_set *) A(a.inp), (fd_set *) A(a.outp), (fd_set *) A(a.exp),
-			    (struct compat_timeval *) A(a.tvp));
+	return compat_sys_select(a.n, compat_ptr(a.inp), compat_ptr(a.outp),
+				 compat_ptr(a.exp), compat_ptr(a.tvp));
 }
 
 #define SEMOP		 1
===== arch/mips/kernel/linux32.c 1.23 vs edited =====
--- 1.23/arch/mips/kernel/linux32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/mips/kernel/linux32.c	Thu Apr 15 17:30:49 2004
@@ -519,167 +519,6 @@
 bad_file:
 	return ret;
 }
-/*
- * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
- * 64-bit unsigned longs.
- */
-
-static inline int
-get_fd_set32(unsigned long n, unsigned long *fdset, u32 *ufdset)
-{
-	if (ufdset) {
-		unsigned long odd;
-
-		if (verify_area(VERIFY_WRITE, ufdset, n*sizeof(u32)))
-			return -EFAULT;
-
-		odd = n & 1UL;
-		n &= ~1UL;
-		while (n) {
-			unsigned long h, l;
-			__get_user(l, ufdset);
-			__get_user(h, ufdset+1);
-			ufdset += 2;
-			*fdset++ = h << 32 | l;
-			n -= 2;
-		}
-		if (odd)
-			__get_user(*fdset, ufdset);
-	} else {
-		/* Tricky, must clear full unsigned long in the
-		 * kernel fdset at the end, this makes sure that
-		 * actually happens.
-		 */
-		memset(fdset, 0, ((n + 1) & ~1)*sizeof(u32));
-	}
-	return 0;
-}
-
-static inline void
-set_fd_set32(unsigned long n, u32 *ufdset, unsigned long *fdset)
-{
-	unsigned long odd;
-
-	if (!ufdset)
-		return;
-
-	odd = n & 1UL;
-	n &= ~1UL;
-	while (n) {
-		unsigned long h, l;
-		l = *fdset++;
-		h = l >> 32;
-		__put_user(l, ufdset);
-		__put_user(h, ufdset+1);
-		ufdset += 2;
-		n -= 2;
-	}
-	if (odd)
-		__put_user(*fdset, ufdset);
-}
-
-/*
- * We can actually return ERESTARTSYS instead of EINTR, but I'd
- * like to be certain this leads to no problems. So I return
- * EINTR just for safety.
- *
- * Update: ERESTARTSYS breaks at least the xview clock binary, so
- * I'm trying ERESTARTNOHAND which restart only when you want to.
- */
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-
-asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct compat_timeval *tvp)
-{
-	fd_set_bits fds;
-	char *bits;
-	unsigned long nn;
-	long timeout;
-	int ret, size;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		time_t sec, usec;
-
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
-			goto out_nofds;
-
-		ret = -EINVAL;
-		if(sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = (usec + 1000000/HZ - 1) / (1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words.
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	nn = (n + 8*sizeof(u32) - 1) / (8*sizeof(u32));
-	if ((ret = get_fd_set32(nn, fds.in, inp)) ||
-	    (ret = get_fd_set32(nn, fds.out, outp)) ||
-	    (ret = get_fd_set32(nn, fds.ex, exp)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		put_user(sec, &tvp->tv_sec);
-		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set32(nn, inp, fds.res_in);
-	set_fd_set32(nn, outp, fds.res_out);
-	set_fd_set32(nn, exp, fds.res_ex);
-
-out:
-	kfree(bits);
-out_nofds:
-	return ret;
-}
-
 
 asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid,
 	struct compat_timespec *interval)
===== arch/mips/kernel/scall64-n32.S 1.3 vs edited =====
--- 1.3/arch/mips/kernel/scall64-n32.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/mips/kernel/scall64-n32.S	Thu Apr 15 17:30:49 2004
@@ -132,7 +132,7 @@
 	PTR	compat_sys_writev
 	PTR	sys_access			/* 6020 */
 	PTR	sys_pipe
-	PTR	sys32_select
+	PTR	compat_sys_select
 	PTR	sys_sched_yield
 	PTR	sys_mremap
 	PTR	sys_msync			/* 6025 */
===== arch/mips/kernel/scall64-o32.S 1.3 vs edited =====
--- 1.3/arch/mips/kernel/scall64-o32.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/mips/kernel/scall64-o32.S	Thu Apr 15 17:30:49 2004
@@ -397,7 +397,7 @@
 	sys	sys_setfsgid	1
 	sys	sys32_llseek	5			/* 4140 */
 	sys	sys32_getdents	3
-	sys	sys32_select	5
+	sys	compat_sys_select	5
 	sys	sys_flock	2
 	sys	sys_msync	3
 	sys	compat_sys_readv	3		/* 4145 */
===== arch/parisc/kernel/sys_parisc32.c 1.26 vs edited =====
--- 1.26/arch/parisc/kernel/sys_parisc32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/parisc/kernel/sys_parisc32.c	Thu Apr 15 17:30:49 2004
@@ -488,126 +488,6 @@
 		__put_user(*fdset, ufdset);
 }
 
-/*** This is a virtual copy of sys_select from fs/select.c and probably
- *** should be compared to it from time to time
- ***/
-static inline void *select_bits_alloc(int size)
-{
-	return kmalloc(6 * size, GFP_KERNEL);
-}
-
-static inline void select_bits_free(void *bits, int size)
-{
-	kfree(bits);
-}
-
-/*
- * We can actually return ERESTARTSYS instead of EINTR, but I'd
- * like to be certain this leads to no problems. So I return
- * EINTR just for safety.
- *
- * Update: ERESTARTSYS breaks at least the xview clock binary, so
- * I'm trying ERESTARTNOHAND which restart only when you want to.
- */
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-#define DIVIDE_ROUND_UP(x,y) (((x)+(y)-1)/(y))
-
-asmlinkage long
-sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct compat_timeval *tvp)
-{
-	fd_set_bits fds;
-	char *bits;
-	long timeout;
-	int ret, size, err;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		struct compat_timeval tv32;
-		time_t sec, usec;
-
-		if ((ret = copy_from_user(&tv32, tvp, sizeof tv32)))
-			goto out_nofds;
-
-		sec = tv32.tv_sec;
-		usec = tv32.tv_usec;
-
-		ret = -EINVAL;
-		if (sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = DIVIDE_ROUND_UP(usec, 1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words. 
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	if ((ret = get_fd_set32(n, inp, fds.in)) ||
-	    (ret = get_fd_set32(n, outp, fds.out)) ||
-	    (ret = get_fd_set32(n, exp, fds.ex)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		err = put_user(sec, &tvp->tv_sec);
-		err |= __put_user(usec, &tvp->tv_usec);
-		if (err)
-			ret = -EFAULT;
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set32(n, inp, fds.res_in);
-	set_fd_set32(n, outp, fds.res_out);
-	set_fd_set32(n, exp, fds.res_ex);
-
-out:
-	select_bits_free(bits, size);
-out_nofds:
-	return ret;
-}
-
 struct msgbuf32 {
     int mtype;
     char mtext[1];
@@ -664,7 +544,6 @@
 	kfree(mb);
 	return err;
 }
-
 
 asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
 {
===== arch/parisc/kernel/syscall_table.S 1.5 vs edited =====
--- 1.5/arch/parisc/kernel/syscall_table.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/parisc/kernel/syscall_table.S	Thu Apr 15 17:30:49 2004
@@ -232,7 +232,7 @@
 	ENTRY_DIFF(getdents)
 	/* it is POSSIBLE that select will be OK because even though fd_set
 	 * contains longs, the macros and sizes are clever. */
-	ENTRY_DIFF(select)
+	ENTRY_COMP(select)
 	ENTRY_SAME(flock)
 	ENTRY_SAME(msync)
 	/* struct iovec contains pointers */
===== arch/ppc64/kernel/sys_ppc32.c 1.87 vs edited =====
--- 1.87/arch/ppc64/kernel/sys_ppc32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Thu Apr 15 17:30:49 2004
@@ -226,167 +226,12 @@
 	return error;
 }
 
-/*
- * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
- * 64-bit unsigned longs.
- */
-static inline int
-get_fd_set32(unsigned long n, unsigned long *fdset, u32 *ufdset)
-{
-	if (ufdset) {
-		unsigned long odd;
-
-		if (verify_area(VERIFY_WRITE, ufdset, n*sizeof(u32)))
-			return -EFAULT;
-
-		odd = n & 1UL;
-		n &= ~1UL;
-		while (n) {
-			unsigned long h, l;
-			__get_user(l, ufdset);
-			__get_user(h, ufdset+1);
-			ufdset += 2;
-			*fdset++ = h << 32 | l;
-			n -= 2;
-		}
-		if (odd)
-			__get_user(*fdset, ufdset);
-	} else {
-		/* Tricky, must clear full unsigned long in the
-		 * kernel fdset at the end, this makes sure that
-		 * actually happens.
-		 */
-		memset(fdset, 0, ((n + 1) & ~1)*sizeof(u32));
-	}
-	return 0;
-}
-
-static inline void
-set_fd_set32(unsigned long n, u32 *ufdset, unsigned long *fdset)
-{
-	unsigned long odd;
-
-	if (!ufdset)
-		return;
-
-	odd = n & 1UL;
-	n &= ~1UL;
-	while (n) {
-		unsigned long h, l;
-		l = *fdset++;
-		h = l >> 32;
-		__put_user(l, ufdset);
-		__put_user(h, ufdset+1);
-		ufdset += 2;
-		n -= 2;
-	}
-	if (odd)
-		__put_user(*fdset, ufdset);
-}
-
-
-
-#define MAX_SELECT_SECONDS ((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-
-asmlinkage long sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tvp_x)
-{
-	fd_set_bits fds;
-	struct compat_timeval *tvp = (struct compat_timeval *)AA(tvp_x);
-	char *bits;
-	unsigned long nn;
-	long timeout;
-	int ret, size, max_fdset;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		time_t sec, usec;
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
-			goto out_nofds;
-
-		ret = -EINVAL;
-		if(sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = (usec + 1000000/HZ - 1) / (1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-
-	/* max_fdset can increase, so grab it once to avoid race */
-	max_fdset = current->files->max_fdset;
-	if (n > max_fdset)
-		n = max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words. 
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	nn = (n + 8*sizeof(u32) - 1) / (8*sizeof(u32));
-	if ((ret = get_fd_set32(nn, fds.in, inp)) ||
-	    (ret = get_fd_set32(nn, fds.out, outp)) ||
-	    (ret = get_fd_set32(nn, fds.ex, exp)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		put_user(sec, &tvp->tv_sec);
-		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set32(nn, inp, fds.res_in);
-	set_fd_set32(nn, outp, fds.res_out);
-	set_fd_set32(nn, exp, fds.res_ex);
-  
-out:
-	kfree(bits);
-
-out_nofds:
-	return ret;
-}
-
-int ppc32_select(u32 n, u32* inp, u32* outp, u32* exp, u32 tvp_x)
+asmlinkage long ppc32_select(u32 n, compat_ulong_t __user *inp,
+		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+		compat_uptr_t tvp_x)
 {
 	/* sign extend n */
-	return sys32_select((int)n, inp, outp, exp, tvp_x);
+	return compat_sys_select((int)n, inp, outp, exp, compat_ptr(tvp_x));
 }
 
 int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
===== arch/s390/kernel/compat_linux.c 1.20 vs edited =====
--- 1.20/arch/s390/kernel/compat_linux.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/s390/kernel/compat_linux.c	Thu Apr 15 17:30:49 2004
@@ -503,160 +503,6 @@
 
 /* end of readdir & getdents */
 
-/*
- * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
- * 64-bit unsigned longs.
- */
-
-static inline int
-get_fd_set32(unsigned long n, unsigned long *fdset, u32 *ufdset)
-{
-	if (ufdset) {
-		unsigned long odd;
-
-		if (verify_area(VERIFY_WRITE, ufdset, n*sizeof(u32)))
-			return -EFAULT;
-
-		odd = n & 1UL;
-		n &= ~1UL;
-		while (n) {
-			unsigned long h, l;
-			__get_user(l, ufdset);
-			__get_user(h, ufdset+1);
-			ufdset += 2;
-			*fdset++ = h << 32 | l;
-			n -= 2;
-		}
-		if (odd)
-			__get_user(*fdset, ufdset);
-	} else {
-		/* Tricky, must clear full unsigned long in the
-		 * kernel fdset at the end, this makes sure that
-		 * actually happens.
-		 */
-		memset(fdset, 0, ((n + 1) & ~1)*sizeof(u32));
-	}
-	return 0;
-}
-
-static inline void
-set_fd_set32(unsigned long n, u32 *ufdset, unsigned long *fdset)
-{
-	unsigned long odd;
-
-	if (!ufdset)
-		return;
-
-	odd = n & 1UL;
-	n &= ~1UL;
-	while (n) {
-		unsigned long h, l;
-		l = *fdset++;
-		h = l >> 32;
-		__put_user(l, ufdset);
-		__put_user(h, ufdset+1);
-		ufdset += 2;
-		n -= 2;
-	}
-	if (odd)
-		__put_user(*fdset, ufdset);
-}
-
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-
-asmlinkage long sys32_select(int n, u32 *inp, u32 *outp, u32 *exp,
-				struct compat_timeval *tvp)
-{
-	fd_set_bits fds;
-	char *bits;
-	unsigned long nn;
-	long timeout;
-	int ret, size;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		int sec, usec;
-
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
-			goto out_nofds;
-
-		ret = -EINVAL;
-		if(sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = (usec + 1000000/HZ - 1) / (1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words. 
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	nn = (n + 8*sizeof(u32) - 1) / (8*sizeof(u32));
-	if ((ret = get_fd_set32(nn, fds.in, inp)) ||
-	    (ret = get_fd_set32(nn, fds.out, outp)) ||
-	    (ret = get_fd_set32(nn, fds.ex, exp)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
-		int sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		put_user(sec, &tvp->tv_sec);
-		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set32(nn, inp, fds.res_in);
-	set_fd_set32(nn, outp, fds.res_out);
-	set_fd_set32(nn, exp, fds.res_ex);
-
-out:
-	kfree(bits);
-out_nofds:
-	return ret;
-}
-
 int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
===== arch/s390/kernel/compat_wrapper.S 1.10 vs edited =====
--- 1.10/arch/s390/kernel/compat_wrapper.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/s390/kernel/compat_wrapper.S	Thu Apr 15 17:30:49 2004
@@ -641,14 +641,14 @@
 	llgfr	%r4,%r4			# unsigned int
 	jg	sys32_getdents		# branch to system call
 
-	.globl  sys32_select_wrapper 
-sys32_select_wrapper:
+	.globl  compat_sys_select_wrapper 
+compat_sys_select_wrapper:
 	lgfr	%r2,%r2			# int
-	llgtr	%r3,%r3			# fd_set *
-	llgtr	%r4,%r4			# fd_set *
-	llgtr	%r5,%r5			# fd_set *
-	llgtr	%r6,%r6			# struct timeval_emu31 *
-	jg	sys32_select		# branch to system call
+	llgtr	%r3,%r3			# compat_fd_set *
+	llgtr	%r4,%r4			# compat_fd_set *
+	llgtr	%r5,%r5			# compat_fd_set *
+	llgtr	%r6,%r6			# struct compat_timeval *
+	jg	compat_sys_select	# branch to system call
 
 	.globl  sys32_flock_wrapper 
 sys32_flock_wrapper:
===== arch/s390/kernel/syscalls.S 1.10 vs edited =====
--- 1.10/arch/s390/kernel/syscalls.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/s390/kernel/syscalls.S	Thu Apr 15 17:30:49 2004
@@ -150,7 +150,7 @@
 SYSCALL(sys_setfsgid16,sys_ni_syscall,sys32_setfsgid16_wrapper)	/* old setfsgid16 syscall */
 SYSCALL(sys_llseek,sys_llseek,sys32_llseek_wrapper)		/* 140 */
 SYSCALL(sys_getdents,sys_getdents,sys32_getdents_wrapper)
-SYSCALL(sys_select,sys_select,sys32_select_wrapper)
+SYSCALL(sys_select,sys_select,compat_sys_select_wrapper)
 SYSCALL(sys_flock,sys_flock,sys32_flock_wrapper)
 SYSCALL(sys_msync,sys_msync,sys32_msync_wrapper)
 SYSCALL(sys_readv,sys_readv,compat_sys_readv_wrapper)		/* 145 */
===== arch/sparc64/kernel/sys_sparc32.c 1.96 vs edited =====
--- 1.96/arch/sparc64/kernel/sys_sparc32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Thu Apr 15 17:30:49 2004
@@ -964,158 +964,6 @@
 
 /* end of readdir & getdents */
 
-/*
- * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
- * 64-bit unsigned longs.
- */
-
-static int get_fd_set32(unsigned long n, unsigned long *fdset, u32 *ufdset)
-{
-	if (ufdset) {
-		unsigned long odd;
-
-		if (verify_area(VERIFY_WRITE, ufdset, n*sizeof(u32)))
-			return -EFAULT;
-
-		odd = n & 1UL;
-		n &= ~1UL;
-		while (n) {
-			unsigned long h, l;
-			__get_user(l, ufdset);
-			__get_user(h, ufdset+1);
-			ufdset += 2;
-			*fdset++ = h << 32 | l;
-			n -= 2;
-		}
-		if (odd)
-			__get_user(*fdset, ufdset);
-	} else {
-		/* Tricky, must clear full unsigned long in the
-		 * kernel fdset at the end, this makes sure that
-		 * actually happens.
-		 */
-		memset(fdset, 0, ((n + 1) & ~1)*sizeof(u32));
-	}
-	return 0;
-}
-
-static void set_fd_set32(unsigned long n, u32 *ufdset, unsigned long *fdset)
-{
-	unsigned long odd;
-
-	if (!ufdset)
-		return;
-
-	odd = n & 1UL;
-	n &= ~1UL;
-	while (n) {
-		unsigned long h, l;
-		l = *fdset++;
-		h = l >> 32;
-		__put_user(l, ufdset);
-		__put_user(h, ufdset+1);
-		ufdset += 2;
-		n -= 2;
-	}
-	if (odd)
-		__put_user(*fdset, ufdset);
-}
-
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-
-asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tvp_x)
-{
-	fd_set_bits fds;
-	struct compat_timeval *tvp = (struct compat_timeval *)AA(tvp_x);
-	char *bits;
-	unsigned long nn;
-	long timeout;
-	int ret, size;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		time_t sec, usec;
-
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
-			goto out_nofds;
-
-		ret = -EINVAL;
-		if(sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = (usec + 1000000/HZ - 1) / (1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words. 
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	nn = (n + 8*sizeof(u32) - 1) / (8*sizeof(u32));
-	if ((ret = get_fd_set32(nn, fds.in, inp)) ||
-	    (ret = get_fd_set32(nn, fds.out, outp)) ||
-	    (ret = get_fd_set32(nn, fds.ex, exp)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		put_user(sec, &tvp->tv_sec);
-		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set32(nn, inp, fds.res_in);
-	set_fd_set32(nn, outp, fds.res_out);
-	set_fd_set32(nn, exp, fds.res_ex);
-
-out:
-	kfree(bits);
-out_nofds:
-	return ret;
-}
-
 int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
===== arch/sparc64/kernel/sys_sunos32.c 1.40 vs edited =====
--- 1.40/arch/sparc64/kernel/sys_sunos32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/sparc64/kernel/sys_sunos32.c	Thu Apr 15 17:30:49 2004
@@ -528,18 +528,15 @@
 	return ret;
 }
 
-/* SunOS mount system call emulation */
-extern asmlinkage int
-sys32_select(int n, u32 inp, u32 outp, u32 exp, u32 tvp);
-
 asmlinkage int sunos_select(int width, u32 inp, u32 outp, u32 exp, u32 tvp_x)
 {
 	int ret;
 
 	/* SunOS binaries expect that select won't change the tvp contents */
-	ret = sys32_select (width, inp, outp, exp, tvp_x);
+	ret = compat_sys_select(width, compat_ptr(inp), compat_ptr(outp),
+				compat_ptr(exp), compat_ptr(tvp_x));
 	if (ret == -EINTR && tvp_x) {
-		struct compat_timeval *tvp = (struct compat_timeval *)A(tvp_x);
+		struct compat_timeval *tvp = compat_ptr(tvp_x);
 		time_t sec, usec;
 
 		__get_user(sec, &tvp->tv_sec);
===== arch/sparc64/kernel/systbls.S 1.53 vs edited =====
--- 1.53/arch/sparc64/kernel/systbls.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/sparc64/kernel/systbls.S	Thu Apr 15 17:30:49 2004
@@ -37,7 +37,7 @@
 	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
 /*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
-/*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
+/*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, compat_sys_select, sys_setfsgid
 	.word sys_fsync, sys_setpriority32, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 /*100*/ .word sys_getpriority, sys32_rt_sigreturn, sys32_rt_sigaction, sys32_rt_sigprocmask, sys32_rt_sigpending
 	.word sys32_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
@@ -65,7 +65,7 @@
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word compat_sys_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
+/*230*/	.word compat_sys_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
 	.word compat_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
===== arch/x86_64/ia32/ia32entry.S 1.32 vs edited =====
--- 1.32/arch/x86_64/ia32/ia32entry.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/x86_64/ia32/ia32entry.S	Thu Apr 15 17:30:49 2004
@@ -447,7 +447,7 @@
 	.quad sys_setfsgid16
 	.quad sys_llseek		/* 140 */
 	.quad sys32_getdents
-	.quad sys32_select
+	.quad compat_sys_select
 	.quad sys_flock
 	.quad sys_msync
 	.quad compat_sys_readv		/* 145 */
===== arch/x86_64/ia32/sys_ia32.c 1.58 vs edited =====
--- 1.58/arch/x86_64/ia32/sys_ia32.c	Thu Apr 15 17:25:08 2004
+++ edited/arch/x86_64/ia32/sys_ia32.c	Thu Apr 15 17:30:49 2004
@@ -606,107 +606,6 @@
 	return error;
 }
 
-/*
- * We can actually return ERESTARTSYS instead of EINTR, but I'd
- * like to be certain this leads to no problems. So I return
- * EINTR just for safety.
- *
- * Update: ERESTARTSYS breaks at least the xview clock binary, so
- * I'm trying ERESTARTNOHAND which restart only when you want to.
- */
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
-#define ROUND_UP_TIME(x,y) (((x)+(y)-1)/(y))
-
-asmlinkage long
-sys32_select(int n, fd_set *inp, fd_set *outp, fd_set *exp, struct compat_timeval *tvp32)
-{
-	fd_set_bits fds;
-	char *bits;
-	long timeout;
-	int ret, size;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp32) {
-		time_t sec, usec;
-
-		get_user(sec, &tvp32->tv_sec);
-		get_user(usec, &tvp32->tv_usec);
-
-		ret = -EINVAL;
-		if (sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = ROUND_UP_TIME(usec, 1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
-	ret = -EINVAL;
-	if (n < 0)
-		goto out_nofds;
-
-	if (n > current->files->max_fdset)
-		n = current->files->max_fdset;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words. 
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	if ((ret = get_fd_set(n, inp, fds.in)) ||
-	    (ret = get_fd_set(n, outp, fds.out)) ||
-	    (ret = get_fd_set(n, exp, fds.ex)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp32 && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		put_user(sec, (int *)&tvp32->tv_sec);
-		put_user(usec, (int *)&tvp32->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	set_fd_set(n, inp, fds.res_in);
-	set_fd_set(n, outp, fds.res_out);
-	set_fd_set(n, exp, fds.res_ex);
-
-out:
-	kfree(bits);
-out_nofds:
-	return ret;
-}
-
 struct sel_arg_struct {
 	unsigned int n;
 	unsigned int inp;
@@ -722,8 +621,8 @@
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
-	return sys32_select(a.n, (fd_set *)A(a.inp), (fd_set *)A(a.outp), (fd_set *)A(a.exp),
-			    (struct compat_timeval *)A(a.tvp));
+	return compat_sys_select(a.n, compat_ptr(a.inp), compat_ptr(a.outp),
+				 compat_ptr(a.exp), compat_ptr(a.tvp));
 }
 
 /*
===== fs/compat.c 1.23 vs edited =====
--- 1.23/fs/compat.c	Thu Apr 15 17:25:08 2004
+++ edited/fs/compat.c	Thu Apr 15 17:31:49 2004
@@ -1211,3 +1211,191 @@
 
 	return retval;
 }
+
+#define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
+
+#define ROUND_UP(x,y) (((x)+(y)-1)/(y))
+
+/*
+ * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
+ * 64-bit unsigned longs.
+ */
+static inline
+int compat_get_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
+			unsigned long *fdset)
+{
+	nr = ROUND_UP(nr, __COMPAT_NFDBITS);
+	if (ufdset) {
+		unsigned long odd;
+
+		if (verify_area(VERIFY_WRITE, ufdset, nr*sizeof(compat_ulong_t)))
+			return -EFAULT;
+
+		odd = nr & 1UL;
+		nr &= ~1UL;
+		while (nr) {
+			unsigned long h, l;
+			__get_user(l, ufdset);
+			__get_user(h, ufdset+1);
+			ufdset += 2;
+			*fdset++ = h << 32 | l;
+			nr -= 2;
+		}
+		if (odd)
+			__get_user(*fdset, ufdset);
+	} else {
+		/* Tricky, must clear full unsigned long in the
+		 * kernel fdset at the end, this makes sure that
+		 * actually happens.
+		 */
+		memset(fdset, 0, ((nr + 1) & ~1)*sizeof(compat_ulong_t));
+	}
+	return 0;
+}
+
+static inline
+void compat_set_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
+			unsigned long *fdset)
+{
+	unsigned long odd;
+	nr = ROUND_UP(nr, __COMPAT_NFDBITS);
+
+	if (!ufdset)
+		return;
+
+	odd = nr & 1UL;
+	nr &= ~1UL;
+	while (nr) {
+		unsigned long h, l;
+		l = *fdset++;
+		h = l >> 32;
+		__put_user(l, ufdset);
+		__put_user(h, ufdset+1);
+		ufdset += 2;
+		nr -= 2;
+	}
+	if (odd)
+		__put_user(*fdset, ufdset);
+}
+
+
+/*
+ * This is a virtual copy of sys_select from fs/select.c and probably
+ * should be compared to it from time to time
+ */
+static void *select_bits_alloc(int size)
+{
+	return kmalloc(6 * size, GFP_KERNEL);
+}
+
+static void select_bits_free(void *bits, int size)
+{
+	kfree(bits);
+}
+
+/*
+ * We can actually return ERESTARTSYS instead of EINTR, but I'd
+ * like to be certain this leads to no problems. So I return
+ * EINTR just for safety.
+ *
+ * Update: ERESTARTSYS breaks at least the xview clock binary, so
+ * I'm trying ERESTARTNOHAND which restart only when you want to.
+ */
+#define MAX_SELECT_SECONDS \
+	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
+
+asmlinkage long
+compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+		compat_ulong_t __user *exp, struct compat_timeval __user *tvp)
+{
+	fd_set_bits fds;
+	char *bits;
+	long timeout;
+	int ret, size, max_fdset;
+
+	timeout = MAX_SCHEDULE_TIMEOUT;
+	if (tvp) {
+		time_t sec, usec;
+
+		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
+		    || (ret = __get_user(sec, &tvp->tv_sec))
+		    || (ret = __get_user(usec, &tvp->tv_usec)))
+			goto out_nofds;
+
+		ret = -EINVAL;
+		if (sec < 0 || usec < 0)
+			goto out_nofds;
+
+		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
+			timeout = ROUND_UP(usec, 1000000/HZ);
+			timeout += sec * (unsigned long) HZ;
+		}
+	}
+
+	ret = -EINVAL;
+	if (n < 0)
+		goto out_nofds;
+
+	/* max_fdset can increase, so grab it once to avoid race */
+	max_fdset = current->files->max_fdset;
+	if (n > max_fdset)
+		n = max_fdset;
+
+	/*
+	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
+	 * since we used fdset we need to allocate memory in units of
+	 * long-words. 
+	 */
+	ret = -ENOMEM;
+	size = FDS_BYTES(n);
+	bits = select_bits_alloc(size);
+	if (!bits)
+		goto out_nofds;
+	fds.in      = (unsigned long *)  bits;
+	fds.out     = (unsigned long *) (bits +   size);
+	fds.ex      = (unsigned long *) (bits + 2*size);
+	fds.res_in  = (unsigned long *) (bits + 3*size);
+	fds.res_out = (unsigned long *) (bits + 4*size);
+	fds.res_ex  = (unsigned long *) (bits + 5*size);
+
+	if ((ret = compat_get_fd_set(n, inp, fds.in)) ||
+	    (ret = compat_get_fd_set(n, outp, fds.out)) ||
+	    (ret = compat_get_fd_set(n, exp, fds.ex)))
+		goto out;
+	zero_fd_set(n, fds.res_in);
+	zero_fd_set(n, fds.res_out);
+	zero_fd_set(n, fds.res_ex);
+
+	ret = do_select(n, &fds, &timeout);
+
+	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
+		time_t sec = 0, usec = 0;
+		if (timeout) {
+			sec = timeout / HZ;
+			usec = timeout % HZ;
+			usec *= (1000000/HZ);
+		}
+		if (put_user(sec, &tvp->tv_sec) ||
+		    put_user(usec, &tvp->tv_usec))
+			ret = -EFAULT;
+	}
+
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
+	compat_set_fd_set(n, inp, fds.res_in);
+	compat_set_fd_set(n, outp, fds.res_out);
+	compat_set_fd_set(n, exp, fds.res_ex);
+
+out:
+	select_bits_free(bits, size);
+out_nofds:
+	return ret;
+}
+
===== include/linux/compat.h 1.21 vs edited =====
--- 1.21/include/linux/compat.h	Thu Apr 15 17:25:08 2004
+++ edited/include/linux/compat.h	Thu Apr 15 17:30:49 2004
@@ -126,5 +126,9 @@
 int compat_do_execve(char * filename, compat_uptr_t __user *argv,
 	        compat_uptr_t __user *envp, struct pt_regs * regs);
 
+asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
+		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+		struct compat_timeval __user *tvp);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */

> 

