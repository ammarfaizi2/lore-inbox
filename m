Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFOLlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFOLlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFOLlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:41:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63455 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261365AbVFOLgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:36:52 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <42ADA880.60303@redhat.com>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>
	 <1118655702.2840.24.camel@localhost.localdomain>
	 <20050613110556.GA26039@infradead.org>
	 <20050613111422.GT22349@devserv.devel.redhat.com>
	 <1118661848.2840.34.camel@localhost.localdomain>
	 <42ADA880.60303@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 12:36:54 +0100
Message-Id: <1118835415.22181.68.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 08:38 -0700, Ulrich Drepper wrote:
> > Eep -- I hadn't noticed that difference. Will update patch
> accordingly. 
> 
> And change [the poll timeout] to expect a 64bit value I hope...

I believe that 64-bit int types in syscalls are a pain on some
architectures because of restrictions on precisely which register pairs
may be used. I think I'd rather just use a struct timespec, which also
makes it consistent with pselect().

> > The other documented difference (other than the signal mask bit) is that
> > pselect() is documented not to modify the timeout parameter. I'm not
> > sure whether I should preserve that difference, or not.
> 
> As long as there is a configuration where the timeout value is not
> modified, it doesn't matter.  That is the case for select() using a
> personality switch.

I've made pselect() consistent with select() by using the same
personality switch to control its behaviour.

I've also fixed select() so that timeouts of greater than LONG_MAX
jiffies are implemented accurately, instead of being infinite.

Do this look OK?

Index: arch/i386/kernel/syscall_table.S
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/arch/i386/kernel/syscall_table.S  (mode:100644)
+++ uncommitted/arch/i386/kernel/syscall_table.S  (mode:100644)
@@ -289,3 +289,5 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_pselect6
+	.long sys_ppoll			/* 290 */
Index: arch/ppc/kernel/misc.S
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/arch/ppc/kernel/misc.S  (mode:100644)
+++ uncommitted/arch/ppc/kernel/misc.S  (mode:100644)
@@ -1441,3 +1441,5 @@
 	.long sys_request_key		/* 270 */
 	.long sys_keyctl
 	.long sys_waitid
+	.long sys_pselect6
+	.long sys_ppoll
Index: arch/ppc64/kernel/misc.S
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/arch/ppc64/kernel/misc.S  (mode:100644)
+++ uncommitted/arch/ppc64/kernel/misc.S  (mode:100644)
@@ -953,10 +953,12 @@
 	.llong .compat_sys_mq_getsetattr
 	.llong .sys_ni_syscall		/* 268 reserved for sys_kexec_load */
 	.llong .sys32_add_key
-	.llong .sys32_request_key
+	.llong .sys32_request_key	/* 270 */
 	.llong .compat_sys_keyctl
 	.llong .compat_sys_waitid
-
+	.llong .compat_sys_pselect6
+	.llong .compat_sys_ppoll
+	
 	.balign 8
 _GLOBAL(sys_call_table)
 	.llong .sys_restart_syscall	/* 0 */
@@ -1232,3 +1234,5 @@
 	.llong .sys_request_key		/* 270 */
 	.llong .sys_keyctl
 	.llong .sys_waitid
+	.llong .sys_pselect6
+	.llong .sys_ppoll
Index: arch/ppc64/kernel/signal32.c
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/arch/ppc64/kernel/signal32.c  (mode:100644)
+++ uncommitted/arch/ppc64/kernel/signal32.c  (mode:100644)
@@ -112,17 +112,6 @@
 	}
 }
 
-static inline void sigset_from_compat(sigset_t *set, compat_sigset_t *compat)
-{
-	switch (_NSIG_WORDS) {
-	case 4: set->sig[3] = compat->sig[6] | (((long)compat->sig[7]) << 32);
-	case 3: set->sig[2] = compat->sig[4] | (((long)compat->sig[5]) << 32);
-	case 2: set->sig[1] = compat->sig[2] | (((long)compat->sig[3]) << 32);
-	case 1: set->sig[0] = compat->sig[0] | (((long)compat->sig[1]) << 32);
-	}
-}
-
-
 /*
  * Save the current user registers on the user stack.
  * We only save the altivec registers if the process has used
Index: fs/compat.c
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/fs/compat.c  (mode:100644)
+++ uncommitted/fs/compat.c  (mode:100644)
@@ -1687,35 +1687,13 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage long
-compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
-		compat_ulong_t __user *exp, struct compat_timeval __user *tvp)
+int compat_core_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+			   compat_ulong_t __user *exp, long *timeout)
 {
 	fd_set_bits fds;
 	char *bits;
-	long timeout;
 	int size, max_fdset, ret = -EINVAL;
 
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
 
@@ -1749,19 +1727,7 @@
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
@@ -1782,6 +1748,173 @@
 	return ret;
 }
 
+asmlinkage long
+compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+		compat_ulong_t __user *exp, struct compat_timeval __user *tvp)
+{
+	long timeout = MAX_SCHEDULE_TIMEOUT;
+	struct compat_timeval tv;
+	int ret;
+
+	if (tvp) {
+		if (copy_from_user(&tv, tvp, sizeof(tv)))
+			return -EFAULT;
+
+		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+			return -EINVAL;
+	}
+	
+	do {
+		if (tvp) {
+			if ((unsigned long) tv.tv_sec < MAX_SELECT_SECONDS) {
+				timeout = ROUND_UP(tv.tv_usec, 1000000/HZ);
+				timeout += tv.tv_sec * (unsigned long) HZ;
+				tv.tv_sec = 0;
+				tv.tv_usec = 0;
+			} else {
+				tv.tv_sec -= MAX_SELECT_SECONDS;
+				timeout = MAX_SELECT_SECONDS * HZ;
+			}
+		}
+		
+		ret = compat_core_sys_select(n, inp, outp, exp, &timeout);
+
+	} while (!ret && !timeout && tvp && (tv.tv_sec || tv.tv_usec));
+
+	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
+		tv.tv_sec += timeout / HZ;
+		tv.tv_usec += (timeout % HZ) * 1000000/HZ;
+		if (tv.tv_usec >= 1000000) {
+			tv.tv_sec++;
+			tv.tv_usec -= 1000000;
+		}
+		(void)copy_to_user(tvp, &tv, sizeof(tv));
+	}
+
+	return ret;
+}
+asmlinkage long
+compat_sys_pselect7(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+		    compat_ulong_t __user *exp, struct compat_timespec __user *tsp,
+		    compat_sigset_t __user *sigmask, compat_size_t sigsetsize)
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
+			if ((unsigned long) ts.tv_sec < MAX_SELECT_SECONDS) {
+				timeout = ROUND_UP(ts.tv_nsec, 1000000000/HZ);
+				timeout += ts.tv_sec * (unsigned long) HZ;
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
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;
+}
+
+asmlinkage long
+compat_sys_pselect6(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+		   compat_ulong_t __user *exp, struct compat_timespec __user *tsp,
+		    void __user *sig)
+{
+	compat_size_t sigsetsize = 0;
+	compat_uptr_t up = 0;
+
+	if (sig) {
+		if (!access_ok(VERIFY_READ, sig, sizeof(compat_uptr_t) + sizeof(compat_size_t))
+		    || __get_user(up, (compat_uptr_t __user *)sig)
+		    || __get_user(sigsetsize, (compat_size_t __user *)(sig+sizeof(up))))
+			return -EFAULT;
+	}
+	return compat_sys_pselect7(n, inp, outp, exp, tsp, compat_ptr(up), sigsetsize);
+}
+
+#define MAX_INT64_SECONDS (((int64_t)(~((uint64_t)0)>>1)/HZ)-1)
+
+asmlinkage long
+compat_sys_ppoll(struct pollfd __user * ufds, unsigned int nfds, struct compat_timespec __user *tsp, 
+		 const compat_sigset_t __user *sigmask, compat_size_t sigsetsize)
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
+		if (ts.tv_sec < MAX_INT64_SECONDS) {
+			timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+			timeout += ts.tv_sec * HZ;
+		} else
+			timeout = MAX_SCHEDULE_TIMEOUT;
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
+	ret = do_sys_poll(ufds, nfds, timeout);
+
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;	
+}
+
 #if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 /* Stuff for NFS server syscalls... */
 struct compat_nfsctl_svc {
Index: fs/select.c
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/fs/select.c  (mode:100644)
+++ uncommitted/fs/select.c  (mode:100644)
@@ -292,35 +292,13 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage long
-sys_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
+static int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
+			   fd_set __user *exp, long *timeout)
 {
 	fd_set_bits fds;
 	char *bits;
-	long timeout;
 	int ret, size, max_fdset;
 
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
@@ -355,18 +333,7 @@
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
@@ -388,6 +355,133 @@
 	return ret;
 }
 
+asmlinkage long
+sys_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
+{
+	long timeout = MAX_SCHEDULE_TIMEOUT;
+	struct timeval tv;
+	int ret;
+
+	if (tvp) {
+		if (copy_from_user(&tv, tvp, sizeof(tv)))
+			return -EFAULT;
+
+		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+			return -EINVAL;
+	}
+
+	do {
+		if (tvp) {
+			if ((unsigned long) tv.tv_sec < MAX_SELECT_SECONDS) {
+				timeout = ROUND_UP(tv.tv_usec, 1000000/HZ);
+				timeout += tv.tv_sec * (unsigned long) HZ;
+				tv.tv_sec = 0;
+				tv.tv_usec = 0;
+			} else {
+				tv.tv_sec -= MAX_SELECT_SECONDS;
+				timeout = MAX_SELECT_SECONDS * HZ;
+			}
+		}
+
+		ret = core_sys_select(n, inp, outp, exp, &timeout);
+
+	} while (!ret && !timeout && tvp && (tv.tv_sec || tv.tv_usec));
+
+	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
+		tv.tv_sec += timeout / HZ;
+		tv.tv_usec += (timeout % HZ) * 1000000/HZ;
+		if (tv.tv_usec >= 1000000) {
+			tv.tv_sec++;
+			tv.tv_usec -= 1000000;
+		}
+		(void)copy_to_user(tvp, &tv, sizeof(tv));
+	}
+
+	return ret;
+}
+
+asmlinkage long
+sys_pselect7(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, 
+	     struct timespec __user *tsp, const sigset_t __user *sigmask, size_t sigsetsize)
+{
+	long timeout = MAX_SCHEDULE_TIMEOUT;
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
+	do {
+		if (tsp) {
+			if ((unsigned long) ts.tv_sec < MAX_SELECT_SECONDS) {
+				timeout = ROUND_UP(ts.tv_nsec, 1000000000/HZ);
+				timeout += ts.tv_sec * (unsigned long) HZ;
+				ts.tv_sec = 0;
+				ts.tv_nsec = 0;
+			} else {
+				ts.tv_sec -= MAX_SELECT_SECONDS;
+				timeout = MAX_SELECT_SECONDS * HZ;
+			}
+		}
+
+		ret = core_sys_select(n, inp, outp, exp, &timeout);
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
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	return ret;
+}
+
+/* Most architectures can't handle 7-argument syscalls. So we provide
+   a 6-argument version where the sixth argument is a pointer to a
+   structure which has a pointer to the sigset_t itself followed by
+   a size_t containing the sigset size. */
+asmlinkage long
+sys_pselect6(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp,
+	     struct timespec __user *tsp, void __user *sig)
+{
+	size_t sigsetsize = 0;
+	sigset_t __user *up = NULL;
+
+	if (sig) {
+		if (!access_ok(VERIFY_READ, sig, sizeof(void *) + sizeof(size_t))
+		    || __get_user(up, (sigset_t * __user *)sig)
+		    || __get_user(sigsetsize, (size_t * __user)(sig+sizeof(void *))))
+			return -EFAULT;
+	}
+	
+	return sys_pselect7(n, inp, outp, exp, tsp, up, sigsetsize);
+}
+
+
 struct poll_list {
 	struct poll_list *next;
 	int len;
@@ -457,7 +551,7 @@
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+int do_sys_poll(struct pollfd __user * ufds, unsigned int nfds, int64_t timeout)
 {
 	struct poll_wqueues table;
  	int fdcount, err;
@@ -469,14 +563,6 @@
 	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
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
@@ -506,7 +592,25 @@
 		}
 		i -= pp->len;
 	}
-	fdcount = do_poll(nfds, head, &table, timeout);
+
+	do {
+		long timeo;
+		
+		if (unlikely(timeout >= (int64_t)MAX_SCHEDULE_TIMEOUT - 1)) {
+			timeo = MAX_SCHEDULE_TIMEOUT - 1;
+			timeout -= timeo;
+		} else {
+			if (timeout < 0)
+				timeo = MAX_SCHEDULE_TIMEOUT;
+			else
+				timeo = timeout;
+
+			timeout = 0;
+		}
+
+	    fdcount = do_poll(nfds, head, &table, timeo);
+
+	} while (!fdcount && !signal_pending(current) && timeout);
 
 	/* OK, now copy the revents fields back to user space. */
 	walk = head;
@@ -534,3 +638,56 @@
 	poll_freewait(&table);
 	return err;
 }
+
+asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+{
+	if (timeout) {
+		/* Careful about overflow in the intermediate values */
+		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
+			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
+		else /* Negative or overflow */
+			timeout = -1;
+	}
+
+	return do_sys_poll(ufds, nfds, (int64_t)timeout);
+}
+
+#define MAX_INT64_SECONDS (((int64_t)(~((uint64_t)0)>>1)/HZ)-1)
+
+asmlinkage long sys_ppoll(struct pollfd __user * ufds, unsigned int nfds, struct timespec __user *tsp,
+			  const sigset_t __user *sigmask, size_t sigsetsize)
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
+		if (ts.tv_sec < MAX_INT64_SECONDS) {
+			timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+			timeout += ts.tv_sec * HZ;
+		} else
+			timeout = MAX_SCHEDULE_TIMEOUT;
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
+	ret = do_sys_poll(ufds, nfds, timeout);
+
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;
+}
Index: include/asm-i386/unistd.h
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/include/asm-i386/unistd.h  (mode:100644)
+++ uncommitted/include/asm-i386/unistd.h  (mode:100644)
@@ -294,8 +294,10 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
+#define __NR_pselect6		289
+#define __NR_ppoll		290
 
-#define NR_syscalls 289
+#define NR_syscalls 291
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
Index: include/asm-ppc/unistd.h
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/include/asm-ppc/unistd.h  (mode:100644)
+++ uncommitted/include/asm-ppc/unistd.h  (mode:100644)
@@ -277,8 +277,10 @@
 #define __NR_request_key	270
 #define __NR_keyctl		271
 #define __NR_waitid		272
+#define __NR_pselect6		273
+#define __NR_ppoll		274
 
-#define __NR_syscalls		273
+#define __NR_syscalls		275
 
 #define __NR(n)	#n
 
Index: include/asm-ppc64/unistd.h
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/include/asm-ppc64/unistd.h  (mode:100644)
+++ uncommitted/include/asm-ppc64/unistd.h  (mode:100644)
@@ -283,8 +283,10 @@
 #define __NR_request_key	270
 #define __NR_keyctl		271
 #define __NR_waitid		272
+#define __NR_pselect6		273
+#define __NR_ppoll		274
 
-#define __NR_syscalls		273
+#define __NR_syscalls		275
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
Index: include/linux/compat.h
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/include/linux/compat.h  (mode:100644)
+++ uncommitted/include/linux/compat.h  (mode:100644)
@@ -48,6 +48,7 @@
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
 
+extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
 extern int cp_compat_stat(struct kstat *, struct compat_stat __user *);
 extern int get_compat_timespec(struct timespec *, const struct compat_timespec __user *);
 extern int put_compat_timespec(const struct timespec *, struct compat_timespec __user *);
Index: include/linux/poll.h
===================================================================
--- 719924701adccf053de08548a2195cba0a6198e0/include/linux/poll.h  (mode:100644)
+++ uncommitted/include/linux/poll.h  (mode:100644)
@@ -93,6 +93,7 @@
 }
 
 extern int do_select(int n, fd_set_bits *fds, long *timeout);
+extern int do_sys_poll(struct pollfd __user * ufds, unsigned int nfds, int64_t timeout);
 
 #endif /* KERNEL */
 


-- 
dwmw2

