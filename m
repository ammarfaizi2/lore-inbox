Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVLPLoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVLPLoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLPLoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:44:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:32700 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932138AbVLPLoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:44:12 -0500
Subject: [PATCH] [1/6] Add pselect/ppoll system call implementation
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: dhowells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1134732739.7104.54.camel@pmac.infradead.org>
References: <1134732739.7104.54.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 11:43:57 +0000
Message-Id: <1134733438.7104.89.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pselect() and ppoll() system calls. Most of this
implementation is as it was in the -mm kernel for a period of time
already before the difficulties with signal delivery became apparent.

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

 fs/compat.c           |  252 +++++++++++++++++++++++++++++++------
 fs/select.c           |  337 +++++++++++++++++++++++++++++++++++++++++---------
 include/linux/poll.h  |    6 
 include/linux/sched.h |    1 
 4 files changed, 501 insertions(+), 95 deletions(-)

diff -uNrp linux-2.6.15-rc5-mm3/fs/compat.c linux-2.6.15-rc5-mm3-pselect1/fs/compat.c
--- linux-2.6.15-rc5-mm3/fs/compat.c	2005-12-16 10:56:15.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect1/fs/compat.c	2005-12-16 11:01:04.000000000 +0000
@@ -53,6 +53,8 @@
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
 
+extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
@@ -1621,36 +1623,14 @@ static void select_bits_free(void *bits,
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage long
-compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
-		compat_ulong_t __user *exp, struct compat_timeval __user *tvp)
+int compat_core_sys_select(int n, compat_ulong_t __user *inp,
+	compat_ulong_t __user *outp, compat_ulong_t __user *exp, int64_t *timeout)
 {
 	fd_set_bits fds;
 	char *bits;
-	long timeout;
 	int size, max_fdset, ret = -EINVAL;
 	struct fdtable *fdt;
 
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		time_t sec, usec;
-
-		if (!access_ok(VERIFY_READ, tvp, sizeof(*tvp))
-		    || __get_user(sec, &tvp->tv_sec)
-		    || __get_user(usec, &tvp->tv_usec)) {
-			ret = -EFAULT;
-			goto out_nofds;
-		}
-
-		if (sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = ROUND_UP(usec, 1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
 	if (n < 0)
 		goto out_nofds;
 
@@ -1687,19 +1667,7 @@ compat_sys_select(int n, compat_ulong_t 
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
-	ret = do_select(n, &fds, &timeout);
-
-	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
-		time_t sec = 0, usec = 0;
-		if (timeout) {
-			sec = timeout / HZ;
-			usec = timeout % HZ;
-			usec *= (1000000/HZ);
-		}
-		if (put_user(sec, &tvp->tv_sec) ||
-		    put_user(usec, &tvp->tv_usec))
-			ret = -EFAULT;
-	}
+	ret = do_select(n, &fds, timeout);
 
 	if (ret < 0)
 		goto out;
@@ -1720,6 +1688,216 @@ out_nofds:
 	return ret;
 }
 
+asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
+	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+	struct compat_timeval __user *tvp)
+{
+	int64_t timeout = -1;
+	struct compat_timeval tv;
+	int ret;
+
+	if (tvp) {
+		if (copy_from_user(&tv, tvp, sizeof(tv)))
+			return -EFAULT;
+
+		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+			return -EINVAL;
+
+		/* Cast to uint64_t to make GCC stop complaining */
+		if ((uint64_t)tv.tv_sec >= (uint64_t)MAX_INT64_SECONDS)
+			timeout = -1;	/* infinite */
+		else {
+			timeout = ROUND_UP(tv.tv_sec, 1000000/HZ);
+			timeout += tv.tv_sec * HZ;
+		}
+	}
+
+	ret = compat_core_sys_select(n, inp, outp, exp, &timeout);
+
+	if (tvp) {
+		if (current->personality & STICKY_TIMEOUTS)
+			goto sticky;
+		tv.tv_usec = jiffies_to_usecs(do_div((*(uint64_t*)&timeout), HZ));
+		tv.tv_sec = timeout;
+		if (copy_to_user(tvp, &tv, sizeof(tv))) {
+		sticky:
+			/*
+			 * If an application puts its timeval in read-only
+			 * memory, we don't want the Linux-specific update to
+			 * the timeval to cause a fault after the select has
+			 * completed successfully. However, because we're not
+			 * updating the timeval, we can't restart the system
+			 * call.
+			 */
+			if (ret == -ERESTARTNOHAND)
+				ret = -EINTR;
+		}
+	}
+
+	return ret;
+}
+
+#ifdef TIF_RESTORE_SIGMASK
+asmlinkage long compat_sys_pselect7(int n, compat_ulong_t __user *inp,
+	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+	struct compat_timespec __user *tsp, compat_sigset_t __user *sigmask,
+	compat_size_t sigsetsize)
+{
+	compat_sigset_t s32;
+	sigset_t ksigmask, sigsaved;
+	long timeout = MAX_SCHEDULE_TIMEOUT;
+	struct compat_timespec ts;
+	int ret;
+
+	if (tsp) {
+		if (copy_from_user(&ts, tsp, sizeof(ts)))
+			return -EFAULT;
+
+		if (ts.tv_sec < 0 || ts.tv_nsec < 0)
+			return -EINVAL;
+	}
+
+	if (sigmask) {
+		if (sigsetsize != sizeof(compat_sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&s32, sigmask, sizeof(s32)))
+			return -EFAULT;
+		sigset_from_compat(&ksigmask, &s32);
+
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	do {
+		if (tsp) {
+			if ((unsigned long)ts.tv_sec < MAX_SELECT_SECONDS) {
+				timeout = ROUND_UP(ts.tv_nsec, 1000000000/HZ);
+				timeout += ts.tv_sec * (unsigned long)HZ;
+				ts.tv_sec = 0;
+				ts.tv_nsec = 0;
+			} else {
+				ts.tv_sec -= MAX_SELECT_SECONDS;
+				timeout = MAX_SELECT_SECONDS * HZ;
+			}
+		}
+
+		ret = compat_core_sys_select(n, inp, outp, exp, &timeout);
+
+	} while (!ret && !timeout && tsp && (ts.tv_sec || ts.tv_nsec));
+
+	if (tsp && !(current->personality & STICKY_TIMEOUTS)) {
+		ts.tv_sec += timeout / HZ;
+		ts.tv_nsec += (timeout % HZ) * (1000000000/HZ);
+		if (ts.tv_nsec >= 1000000000) {
+			ts.tv_sec++;
+			ts.tv_nsec -= 1000000000;
+		}
+		(void)copy_to_user(tsp, &ts, sizeof(ts));
+	}
+
+	if (ret == -ERESTARTNOHAND) {
+		/* Don't restore the signal mask yet. Let do_signal() deliver the signal
+		   on the way back to userspace, before the signal mask is restored. */
+		if (sigmask) {
+			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+	} else if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;
+}
+
+asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
+	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+	struct compat_timespec __user *tsp, void __user *sig)
+{
+	compat_size_t sigsetsize = 0;
+	compat_uptr_t up = 0;
+
+	if (sig) {
+		if (!access_ok(VERIFY_READ, sig,
+				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
+		    	__get_user(up, (compat_uptr_t __user *)sig) ||
+		    	__get_user(sigsetsize,
+				(compat_size_t __user *)(sig+sizeof(up))))
+			return -EFAULT;
+	}
+	return compat_sys_pselect7(n, inp, outp, exp, tsp, compat_ptr(up),
+					sigsetsize);
+}
+
+asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
+	unsigned int nfds, struct compat_timespec __user *tsp,
+	const compat_sigset_t __user *sigmask, compat_size_t sigsetsize)
+{
+	compat_sigset_t s32;
+	sigset_t ksigmask, sigsaved;
+	struct compat_timespec ts;
+	int64_t timeout = -1;
+	int ret;
+
+	if (tsp) {
+		if (copy_from_user(&ts, tsp, sizeof(ts)))
+			return -EFAULT;
+
+		/* We assume that ts.tv_sec is always lower than
+		   the number of seconds that can be expressed in
+		   an int64_t. Otherwise the compiler bitches at us */
+		timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+		timeout += ts.tv_sec * HZ;
+	}
+
+	if (sigmask) {
+		if (sigsetsize |= sizeof(compat_sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&s32, sigmask, sizeof(s32)))
+			return -EFAULT;
+		sigset_from_compat(&ksigmask, &s32);
+
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	ret = do_sys_poll(ufds, nfds, &timeout);
+
+	/* We can restart this syscall, usually */
+	if (ret == -EINTR) {
+		/* Don't restore the signal mask yet. Let do_signal() deliver the signal
+		   on the way back to userspace, before the signal mask is restored. */
+		if (sigmask) {
+			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+		ret = -ERESTARTNOHAND;
+	} else if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	if (tsp && timeout >= 0) {
+		if (current->personality & STICKY_TIMEOUTS)
+			goto sticky;
+		/* Yes, we know it's actually an int64_t, but it's also positive. */
+		ts.tv_nsec = jiffies_to_usecs(do_div((*(uint64_t*)&timeout), HZ)) * 1000;
+		ts.tv_sec = timeout;
+		if (copy_to_user(tsp, &ts, sizeof(ts))) {
+		sticky:
+			/*
+			 * If an application puts its timeval in read-only
+			 * memory, we don't want the Linux-specific update to
+			 * the timeval to cause a fault after the select has
+			 * completed successfully. However, because we're not
+			 * updating the timeval, we can't restart the system
+			 * call.
+			 */
+			if (ret == -ERESTARTNOHAND && timeout >= 0)
+				ret = -EINTR;
+		}
+	}
+
+	return ret;
+}
+#endif /* TIF_RESTORE_SIGMASK */
+
 #if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 /* Stuff for NFS server syscalls... */
 struct compat_nfsctl_svc {
diff -uNrp linux-2.6.15-rc5-mm3/fs/select.c linux-2.6.15-rc5-mm3-pselect1/fs/select.c
--- linux-2.6.15-rc5-mm3/fs/select.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.15-rc5-mm3-pselect1/fs/select.c	2005-12-16 11:01:04.000000000 +0000
@@ -179,12 +179,11 @@ get_max:
 #define POLLOUT_SET (POLLWRBAND | POLLWRNORM | POLLOUT | POLLERR)
 #define POLLEX_SET (POLLPRI)
 
-int do_select(int n, fd_set_bits *fds, long *timeout)
+int do_select(int n, fd_set_bits *fds, int64_t *timeout)
 {
 	struct poll_wqueues table;
 	poll_table *wait;
 	int retval, i;
-	long __timeout = *timeout;
 
 	rcu_read_lock();
 	retval = max_select_fd(n, fds);
@@ -196,11 +195,12 @@ int do_select(int n, fd_set_bits *fds, l
 
 	poll_initwait(&table);
 	wait = &table.pt;
-	if (!__timeout)
+	if (!*timeout)
 		wait = NULL;
 	retval = 0;
 	for (;;) {
 		unsigned long *rinp, *routp, *rexp, *inp, *outp, *exp;
+		long __timeout;
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -255,22 +255,32 @@ int do_select(int n, fd_set_bits *fds, l
 				*rexp = res_ex;
 		}
 		wait = NULL;
-		if (retval || !__timeout || signal_pending(current))
+		if (retval || !*timeout || signal_pending(current))
 			break;
 		if(table.error) {
 			retval = table.error;
 			break;
 		}
+
+		if (*timeout < 0) {
+			/* Wait indefinitely */
+			__timeout = MAX_SCHEDULE_TIMEOUT;
+		} else if (unlikely(*timeout >= (int64_t)MAX_SCHEDULE_TIMEOUT - 1)) {
+			/* Wait for longer than MAX_SCHEDULE_TIMEOUT. Do it in a loop */
+			__timeout = MAX_SCHEDULE_TIMEOUT - 1;
+			*timeout -= __timeout;
+		} else {
+			__timeout = *timeout;
+			*timeout = 0;
+		}
 		__timeout = schedule_timeout(__timeout);
+		if (*timeout >= 0)
+			*timeout += __timeout;
 	}
 	__set_current_state(TASK_RUNNING);
 
 	poll_freewait(&table);
 
-	/*
-	 * Up-to-date the caller timeout.
-	 */
-	*timeout = __timeout;
 	return retval;
 }
 
@@ -295,36 +305,14 @@ static void select_bits_free(void *bits,
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage long
-sys_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
+static int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
+			   fd_set __user *exp, int64_t *timeout)
 {
 	fd_set_bits fds;
 	char *bits;
-	long timeout;
 	int ret, size, max_fdset;
 	struct fdtable *fdt;
 
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	if (tvp) {
-		time_t sec, usec;
-
-		if (!access_ok(VERIFY_READ, tvp, sizeof(*tvp))
-		    || __get_user(sec, &tvp->tv_sec)
-		    || __get_user(usec, &tvp->tv_usec)) {
-			ret = -EFAULT;
-			goto out_nofds;
-		}
-
-		ret = -EINVAL;
-		if (sec < 0 || usec < 0)
-			goto out_nofds;
-
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = ROUND_UP(usec, 1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
-		}
-	}
-
 	ret = -EINVAL;
 	if (n < 0)
 		goto out_nofds;
@@ -362,18 +350,7 @@ sys_select(int n, fd_set __user *inp, fd
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
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
+	ret = do_select(n, &fds, timeout);
 
 	if (ret < 0)
 		goto out;
@@ -395,6 +372,150 @@ out_nofds:
 	return ret;
 }
 
+asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
+			fd_set __user *exp, struct timeval __user *tvp)
+{
+	int64_t timeout = -1;
+	struct timeval tv;
+	int ret;
+
+	if (tvp) {
+		if (copy_from_user(&tv, tvp, sizeof(tv)))
+			return -EFAULT;
+
+		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+			return -EINVAL;
+
+		/* Cast to uint64_t to make GCC stop complaining */
+		if ((uint64_t)tv.tv_sec >= (uint64_t)MAX_INT64_SECONDS)
+			timeout = -1;	/* infinite */
+		else {
+			timeout = ROUND_UP(tv.tv_sec, 1000000/HZ);
+			timeout += tv.tv_sec * HZ;
+		}
+	}
+
+	ret = core_sys_select(n, inp, outp, exp, &timeout);
+
+	if (tvp) {
+		if (current->personality & STICKY_TIMEOUTS)
+			goto sticky;
+		tv.tv_usec = jiffies_to_usecs(do_div((*(uint64_t*)&timeout), HZ));
+		tv.tv_sec = timeout;
+		if (copy_to_user(tvp, &tv, sizeof(tv))) {
+		sticky:
+			/*
+			 * If an application puts its timeval in read-only
+			 * memory, we don't want the Linux-specific update to
+			 * the timeval to cause a fault after the select has
+			 * completed successfully. However, because we're not
+			 * updating the timeval, we can't restart the system
+			 * call.
+			 */
+			if (ret == -ERESTARTNOHAND)
+				ret = -EINTR;
+		}
+	}
+
+	return ret;
+}
+
+#ifdef TIF_RESTORE_SIGMASK
+asmlinkage long sys_pselect7(int n, fd_set __user *inp, fd_set __user *outp,
+		fd_set __user *exp, struct timespec __user *tsp,
+		const sigset_t __user *sigmask, size_t sigsetsize)
+{
+	int64_t timeout = MAX_SCHEDULE_TIMEOUT;
+	sigset_t ksigmask, sigsaved;
+	struct timespec ts;
+	int ret;
+
+	if (tsp) {
+		if (copy_from_user(&ts, tsp, sizeof(ts)))
+			return -EFAULT;
+
+		if (ts.tv_sec < 0 || ts.tv_nsec < 0)
+			return -EINVAL;
+
+		/* Cast to uint64_t to make GCC stop complaining */
+		if ((uint64_t)ts.tv_sec >= (uint64_t)MAX_INT64_SECONDS)
+			timeout = -1;	/* infinite */
+		else {
+			timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+			timeout += ts.tv_sec * HZ;
+		}
+	}
+
+	if (sigmask) {
+		/* XXX: Don't preclude handling different sized sigset_t's.  */
+		if (sigsetsize != sizeof(sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
+			return -EFAULT;
+
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	ret = core_sys_select(n, inp, outp, exp, &timeout);
+
+	if (tsp) {
+		if (current->personality & STICKY_TIMEOUTS)
+			goto sticky;
+		ts.tv_nsec = jiffies_to_usecs(do_div((*(uint64_t*)&timeout), HZ)) * 1000;
+		ts.tv_sec = timeout;
+		if (copy_to_user(tsp, &ts, sizeof(ts))) {
+		sticky:
+			/*
+			 * If an application puts its timeval in read-only
+			 * memory, we don't want the Linux-specific update to
+			 * the timeval to cause a fault after the select has
+			 * completed successfully. However, because we're not
+			 * updating the timeval, we can't restart the system
+			 * call.
+			 */
+			if (ret == -ERESTARTNOHAND)
+				ret = -EINTR;
+		}
+	}
+
+	if (ret == -ERESTARTNOHAND) {
+		/* Don't restore the signal mask yet. Let do_signal() deliver the signal
+		   on the way back to userspace, before the signal mask is restored. */
+		if (sigmask) {
+			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+	} else if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;
+}
+
+/*
+ * Most architectures can't handle 7-argument syscalls. So we provide a
+ * 6-argument version where the sixth argument is a pointer to a structure
+ * which has a pointer to the sigset_t itself followed by a size_t containing
+ * the sigset size.
+ */
+asmlinkage long sys_pselect6(int n, fd_set __user *inp, fd_set __user *outp,
+	fd_set __user *exp, struct timespec __user *tsp, void __user *sig)
+{
+	size_t sigsetsize = 0;
+	sigset_t __user *up = NULL;
+
+	if (sig) {
+		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
+		    || __get_user(up, (sigset_t * __user *)sig)
+		    || __get_user(sigsetsize,
+				(size_t * __user)(sig+sizeof(void *))))
+			return -EFAULT;
+	}
+
+	return sys_pselect7(n, inp, outp, exp, tsp, up, sigsetsize);
+}
+#endif /* TIF_RESTORE_SIGMASK */
+
 struct poll_list {
 	struct poll_list *next;
 	int len;
@@ -436,16 +557,19 @@ static void do_pollfd(unsigned int num, 
 }
 
 static int do_poll(unsigned int nfds,  struct poll_list *list,
-			struct poll_wqueues *wait, long timeout)
+		   struct poll_wqueues *wait, int64_t *timeout)
 {
 	int count = 0;
 	poll_table* pt = &wait->pt;
 
-	if (!timeout)
+	/* Optimise the no-wait case */
+	if (!(*timeout))
 		pt = NULL;
  
 	for (;;) {
 		struct poll_list *walk;
+		long __timeout;
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		walk = list;
 		while(walk != NULL) {
@@ -453,18 +577,33 @@ static int do_poll(unsigned int nfds,  s
 			walk = walk->next;
 		}
 		pt = NULL;
-		if (count || !timeout || signal_pending(current))
+		if (count || !*timeout || signal_pending(current))
 			break;
 		count = wait->error;
 		if (count)
 			break;
-		timeout = schedule_timeout(timeout);
+
+		if (*timeout < 0) {
+			/* Wait indefinitely */
+			__timeout = MAX_SCHEDULE_TIMEOUT;
+		} else if (unlikely(*timeout >= (int64_t)MAX_SCHEDULE_TIMEOUT - 1)) {
+			/* Wait for longer than MAX_SCHEDULE_TIMEOUT. Do it in a loop */
+			__timeout = MAX_SCHEDULE_TIMEOUT - 1;
+			*timeout -= __timeout;
+		} else {
+			__timeout = *timeout;
+			*timeout = 0;
+		}
+
+		__timeout = schedule_timeout(__timeout);
+		if (*timeout >= 0)
+			*timeout += __timeout;
 	}
 	__set_current_state(TASK_RUNNING);
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds, int64_t *timeout)
 {
 	struct poll_wqueues table;
  	int fdcount, err;
@@ -482,14 +621,6 @@ asmlinkage long sys_poll(struct pollfd _
 	if (nfds > max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
-	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
-			timeout = MAX_SCHEDULE_TIMEOUT;
-	}
-
 	poll_initwait(&table);
 
 	head = NULL;
@@ -519,6 +650,7 @@ asmlinkage long sys_poll(struct pollfd _
 		}
 		i -= pp->len;
 	}
+
 	fdcount = do_poll(nfds, head, &table, timeout);
 
 	/* OK, now copy the revents fields back to user space. */
@@ -547,3 +679,94 @@ out_fds:
 	poll_freewait(&table);
 	return err;
 }
+
+asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
+			long timeout_msecs)
+{
+	int64_t timeout_jiffies = 0;
+
+	if (timeout_msecs) {
+#if HZ > 1000
+		/* We can only overflow if HZ > 1000 */
+		if (timeout_msecs / 1000 > (int64_t)0x7fffffffffffffffULL / (int64_t)HZ)
+			timeout_jiffies = -1;
+		else
+#endif
+			timeout_jiffies = msecs_to_jiffies(timeout_msecs);
+	}
+
+	return do_sys_poll(ufds, nfds, &timeout_jiffies);
+}
+
+#ifdef TIF_RESTORE_SIGMASK
+asmlinkage long sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
+	struct timespec __user *tsp, const sigset_t __user *sigmask,
+	size_t sigsetsize)
+{
+	sigset_t ksigmask, sigsaved;
+	struct timespec ts;
+	int64_t timeout = -1;
+	int ret;
+
+	if (tsp) {
+		if (copy_from_user(&ts, tsp, sizeof(ts)))
+			return -EFAULT;
+
+		/* Cast to uint64_t to make GCC stop complaining */
+		if ((uint64_t)ts.tv_sec >= (uint64_t)MAX_INT64_SECONDS)
+			timeout = -1;	/* infinite */
+		else {
+			timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+			timeout += ts.tv_sec * HZ;
+		}
+	}
+
+	if (sigmask) {
+		/* XXX: Don't preclude handling different sized sigset_t's.  */
+		if (sigsetsize != sizeof(sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
+			return -EFAULT;
+
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	ret = do_sys_poll(ufds, nfds, &timeout);
+
+	/* We can restart this syscall, usually */
+	if (ret == -EINTR) {
+		/* Don't restore the signal mask yet. Let do_signal() deliver the signal
+		   on the way back to userspace, before the signal mask is restored. */
+		if (sigmask) {
+			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+		ret = -ERESTARTNOHAND;
+	} else if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	if (tsp && timeout >= 0) {
+		if (current->personality & STICKY_TIMEOUTS)
+			goto sticky;
+		/* Yes, we know it's actually an int64_t, but it's also positive. */
+		ts.tv_nsec = jiffies_to_usecs(do_div((*(uint64_t*)&timeout), HZ)) * 1000;
+		ts.tv_sec = timeout;
+		if (copy_to_user(tsp, &ts, sizeof(ts))) {
+		sticky:
+			/*
+			 * If an application puts its timeval in read-only
+			 * memory, we don't want the Linux-specific update to
+			 * the timeval to cause a fault after the select has
+			 * completed successfully. However, because we're not
+			 * updating the timeval, we can't restart the system
+			 * call.
+			 */
+			if (ret == -ERESTARTNOHAND && timeout >= 0)
+				ret = -EINTR;
+		}
+	}
+
+	return ret;
+}
+#endif /* TIF_RESTORE_SIGMASK */
diff -uNrp linux-2.6.15-rc5-mm3/include/linux/poll.h linux-2.6.15-rc5-mm3-pselect1/include/linux/poll.h
--- linux-2.6.15-rc5-mm3/include/linux/poll.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.15-rc5-mm3-pselect1/include/linux/poll.h	2005-12-16 11:01:04.000000000 +0000
@@ -92,7 +92,11 @@ void zero_fd_set(unsigned long nr, unsig
 	memset(fdset, 0, FDS_BYTES(nr));
 }
 
-extern int do_select(int n, fd_set_bits *fds, long *timeout);
+#define MAX_INT64_SECONDS (((int64_t)(~((uint64_t)0)>>1)/HZ)-1)
+
+extern int do_select(int n, fd_set_bits *fds, int64_t *timeout);
+extern int do_sys_poll(struct pollfd __user * ufds, unsigned int nfds,
+		       int64_t *timeout);
 
 #endif /* KERNEL */
 
diff -uNrp linux-2.6.15-rc5-mm3/include/linux/sched.h linux-2.6.15-rc5-mm3-pselect1/include/linux/sched.h
--- linux-2.6.15-rc5-mm3/include/linux/sched.h	2005-12-16 10:56:18.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect1/include/linux/sched.h	2005-12-16 11:01:04.000000000 +0000
@@ -816,6 +816,7 @@ struct task_struct {
 	struct sighand_struct *sighand;
 
 	sigset_t blocked, real_blocked;
+	sigset_t saved_sigmask;		/* To be restored with TIF_RESTORE_SIGMASK */
 	struct sigpending pending;
 
 	unsigned long sas_ss_sp;


-- 
dwmw2

