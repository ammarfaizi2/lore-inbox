Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFJXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFJXBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFJXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:01:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7906 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261370AbVFJXAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:00:18 -0400
Subject: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Cc: drepper@redhat.com
Content-Type: text/plain
Date: Fri, 10 Jun 2005 23:58:32 +0100
Message-Id: <1118444314.4823.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Says the man page...

The idea of pselect is that if one wants to wait for an event, either a
signal  or  something on a file descriptor, an atomic test is needed to
prevent race conditions. (Suppose the signal handler sets a global flag
and  returns.  Then  a  test  of this global flag followed by a call of
select() could hang indefinitely if the signal arrived just  after  the
test but just before the call. On the other hand, pselect allows one to
first block signals, handle the signals that have come  in,  then  call
pselect()  with  the  desired sigmask, avoiding the race.)  Since Linux
today does not have a pselect() system call, the current glibc2 routine
still contains this race.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

Index: arch/i386/kernel/syscall_table.S
===================================================================
--- 589b4166efe6ab929ee25b20b2e89935efba504e/arch/i386/kernel/syscall_table.S  (mode:100644)
+++ uncommitted/arch/i386/kernel/syscall_table.S  (mode:100644)
@@ -289,3 +289,5 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_pselect6
+	.long sys_ppoll			/* 290 */
Index: arch/ppc/kernel/misc.S
===================================================================
--- 589b4166efe6ab929ee25b20b2e89935efba504e/arch/ppc/kernel/misc.S  (mode:100644)
+++ uncommitted/arch/ppc/kernel/misc.S  (mode:100644)
@@ -1441,3 +1441,5 @@
 	.long sys_request_key		/* 270 */
 	.long sys_keyctl
 	.long sys_waitid
+	.long sys_pselect6
+	.long sys_ppoll
Index: arch/ppc64/kernel/misc.S
===================================================================
--- 589b4166efe6ab929ee25b20b2e89935efba504e/arch/ppc64/kernel/misc.S  (mode:100644)
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
--- 589b4166efe6ab929ee25b20b2e89935efba504e/arch/ppc64/kernel/signal32.c  (mode:100644)
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
--- 589b4166efe6ab929ee25b20b2e89935efba504e/fs/compat.c  (mode:100644)
+++ uncommitted/fs/compat.c  (mode:100644)
@@ -1782,6 +1782,76 @@
 	return ret;
 }
 
+asmlinkage long
+compat_sys_pselect7(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+		    compat_ulong_t __user *exp, struct compat_timeval __user *tvp,
+		    compat_sigset_t __user *sigmask, compat_size_t sigsetsize)
+{
+	compat_sigset_t s32;
+	sigset_t ksigmask, sigsaved;
+	long ret;
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
+	ret = compat_sys_select(n, inp, outp, exp, tvp);
+
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;
+}
+
+asmlinkage long
+compat_sys_pselect6(int n, compat_ulong_t __user *inp, compat_ulong_t __user *outp,
+		   compat_ulong_t __user *exp, struct compat_timeval __user *tvp,
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
+	return compat_sys_pselect7(n, inp, outp, exp, tvp, compat_ptr(up), sigsetsize);
+}
+
+asmlinkage long
+compat_sys_ppoll(struct pollfd __user * ufds, unsigned int nfds, compat_ulong_t timeout, 
+		 const compat_sigset_t __user *sigmask, compat_size_t sigsetsize)
+{
+	compat_sigset_t s32;
+	sigset_t ksigmask, sigsaved;
+	long ret;
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
+	ret = sys_poll(ufds, nfds, timeout);
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
--- 589b4166efe6ab929ee25b20b2e89935efba504e/fs/select.c  (mode:100644)
+++ uncommitted/fs/select.c  (mode:100644)
@@ -388,12 +388,61 @@
 	return ret;
 }
 
+asmlinkage long
+sys_pselect7(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp, const sigset_t __user *sigmask, size_t sigsetsize)
+{
+	sigset_t ksigmask, sigsaved;
+	long ret;
+
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
+	ret = sys_select(n, inp, outp, exp, tvp);
+
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	return ret;
+}
+
 struct poll_list {
 	struct poll_list *next;
 	int len;
 	struct pollfd entries[0];
 };
 
+/* Most architectures can't handle 7-argument syscalls. So we provide
+   a 6-argument version where the sixth argument is a pointer to a
+   structure which has a uint32_t containing the sigset size, followed
+   by the sigset_t itself. This unfortunately means that libc's
+   pselect() call has to _copy_ the sigset into this structure which
+   it presumably allocates on the stack -- but it's only small, and it
+   means we don't have to screw around with 32/64-bit compatibility
+   layers as we would have to if the struct contained a _pointer_ to the
+   user's original sigset_t. */
+asmlinkage long
+sys_pselect6(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp, void __user *sig)
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
+	return sys_pselect7(n, inp, outp, exp, tvp, up, sigsetsize);
+}
+
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
 
 static void do_pollfd(unsigned int num, struct pollfd * fdpage,
@@ -534,3 +583,27 @@
 	poll_freewait(&table);
 	return err;
 }
+
+asmlinkage long sys_ppoll(struct pollfd __user * ufds, unsigned int nfds, long timeout, const sigset_t __user *sigmask, size_t sigsetsize)
+{
+	sigset_t ksigmask, sigsaved;
+	long ret;
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
+	ret = sys_poll(ufds, nfds, timeout);
+
+	if (sigmask)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+
+	return ret;
+}
Index: include/asm-i386/unistd.h
===================================================================
--- 589b4166efe6ab929ee25b20b2e89935efba504e/include/asm-i386/unistd.h  (mode:100644)
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
--- 589b4166efe6ab929ee25b20b2e89935efba504e/include/asm-ppc/unistd.h  (mode:100644)
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
--- 589b4166efe6ab929ee25b20b2e89935efba504e/include/asm-ppc64/unistd.h  (mode:100644)
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
--- 589b4166efe6ab929ee25b20b2e89935efba504e/include/linux/compat.h  (mode:100644)
+++ uncommitted/include/linux/compat.h  (mode:100644)
@@ -48,6 +48,7 @@
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
 
+extern void sigset_from_compat (sigset_t *set, compat_sigset_t *compat);
 extern int cp_compat_stat(struct kstat *, struct compat_stat __user *);
 extern int get_compat_timespec(struct timespec *, const struct compat_timespec __user *);
 extern int put_compat_timespec(const struct timespec *, struct compat_timespec __user *);

-- 
dwmw2

