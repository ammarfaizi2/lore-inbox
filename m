Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318513AbSGSJtr>; Fri, 19 Jul 2002 05:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSGSJtr>; Fri, 19 Jul 2002 05:49:47 -0400
Received: from alcor.twinsun.com ([198.147.65.9]:1971 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id <S318513AbSGSJtn>;
	Fri, 19 Jul 2002 05:49:43 -0400
Date: Fri, 19 Jul 2002 02:52:04 -0700 (PDT)
From: Paul Eggert <eggert@twinsun.com>
Message-Id: <200207190952.g6J9q4I07044@sic.twinsun.com>
To: linux-kernel@vger.kernel.org
CC: rms@gnu.org, Alan Cox <alan@redhat.com>
In-reply-to: <200207171430.g6HEUvY23619@aztec.santafe.edu> (rms@gnu.org)
Subject: [PATCH] 'select' failure or signal should not update timeout
References: <200207171430.g6HEUvY23619@aztec.santafe.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This follows up a thread in the emacs-pretesters mailing list about a
problem with Emacs, 'select', SA_RESTART, and interrupts.]

> Date: Wed, 17 Jul 2002 08:30:57 -0600 (MDT)
> From: Richard Stallman <rms@gnu.org>
> 
> Is it true today that restarting a `select' call after a signal (with
> SA_RESTART) alters the contents of the user's timeout parameter?

I looked into this a bit more, and it turns out to be a problem in the
Linux kernel.  POSIX 1003.1-2001
<http://www.opengroup.org/onlinepubs/007904975/functions/select.html>
says that 'select' may modify its timeout argument only "upon
successful completion".  However, the Linux kernel sometimes modifies
the timeout argument even when 'select' fails or is interrupted.

Here is a program that illustrates the problem.  At the end of this
message I enclose a proposed patch to the Linux kernel to fix the
problem.

	/* Conformance test for POSIX 1003.1-2001's requirement that select()
	   must not update its timeout argument unless it succeeds.  */

	#include <signal.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/time.h>
	#include <unistd.h>

	static void
	moan (char const *string)
	{
	  perror (string);
	  exit (1);
	}

	struct timeval timeout;
	struct timeval timeout_when_in_handler;
	struct sigaction act;

	void
	handle_sigalrm (int sig)
	{
	  timeout_when_in_handler = timeout;
	}

	enum { TIMEOUT_SECONDS = 5 };

	int
	main (int argc, char **argv)
	{
	  act.sa_handler = handle_sigalrm;
	  act.sa_flags = SA_RESTART;
	  if (sigaction (SIGALRM, &act, 0) != 0)
	    moan ("sigaction");
	  timeout.tv_sec = TIMEOUT_SECONDS;
	  timeout_when_in_handler = timeout;
	  alarm (TIMEOUT_SECONDS / 2);
	  if (select (0, 0, 0, 0, &timeout) != 0)
	    {
	      if (timeout.tv_sec != TIMEOUT_SECONDS)
		{
		  perror ("select");
		  fprintf (stderr, "select failed, but timeout was updated to %ld.%.9ld seconds\n",
			   (long) timeout.tv_sec, timeout.tv_usec);
		}
	    }

	  if (timeout_when_in_handler.tv_sec != TIMEOUT_SECONDS)
	    fprintf (stderr, "timeout was updated to %ld.%.9ld seconds while signal handler was active\n",
		     (long) timeout_when_in_handler.tv_sec,
		     timeout_when_in_handler.tv_usec);

	  return 0;
	}


Here is a proposed patch to Linux kernel 2.5.26.  The patch also
applies to Linux 2.4.18, though you have to ignore the patches to
files that do not exist in 2.4.18.  I haven't tested this patch, but
it's pretty straightforward.

diff -prU6 2.5.26/arch/ia64/ia32/sys_ia32.c 2.5.26-select/arch/ia64/ia32/sys_ia32.c
--- 2.5.26/arch/ia64/ia32/sys_ia32.c	Tue Jul 16 16:49:35 2002
+++ 2.5.26-select/arch/ia64/ia32/sys_ia32.c	Fri Jul 19 02:17:08 2002
@@ -1058,32 +1058,32 @@ sys32_select (int n, fd_set *inp, fd_set
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp32 && !(current->personality & STICKY_TIMEOUTS)) {
 		time_t sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		if (put_user(sec, &tvp32->tv_sec) || put_user(usec, &tvp32->tv_usec)) {
 			ret = -EFAULT;
 			goto out;
 		}
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set(n, inp, fds.res_in);
 	set_fd_set(n, outp, fds.res_out);
 	set_fd_set(n, exp, fds.res_ex);
 
diff -prU6 2.5.26/arch/mips64/kernel/linux32.c 2.5.26-select/arch/mips64/kernel/linux32.c
--- 2.5.26/arch/mips64/kernel/linux32.c	Tue Jul 16 16:49:25 2002
+++ 2.5.26-select/arch/mips64/kernel/linux32.c	Fri Jul 19 02:18:19 2002
@@ -1170,30 +1170,30 @@ asmlinkage int sys32_select(int n, u32 *
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
 		time_t sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		put_user(sec, &tvp->tv_sec);
 		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set32(nn, inp, fds.res_in);
 	set_fd_set32(nn, outp, fds.res_out);
 	set_fd_set32(nn, exp, fds.res_ex);
 
diff -prU6 2.5.26/arch/ppc64/kernel/sys_ppc32.c 2.5.26-select/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.26/arch/ppc64/kernel/sys_ppc32.c	Tue Jul 16 16:49:36 2002
+++ 2.5.26-select/arch/ppc64/kernel/sys_ppc32.c	Fri Jul 19 02:17:58 2002
@@ -762,30 +762,30 @@ asmlinkage long sys32_select(int n, u32 
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+  if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
 		time_t sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		put_user(sec, &tvp->tv_sec);
 		put_user(usec, &tvp->tv_usec);
-	}
-
-  if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set32(nn, inp, fds.res_in);
 	set_fd_set32(nn, outp, fds.res_out);
 	set_fd_set32(nn, exp, fds.res_ex);
   
diff -prU6 2.5.26/arch/s390x/kernel/linux32.c 2.5.26-select/arch/s390x/kernel/linux32.c
--- 2.5.26/arch/s390x/kernel/linux32.c	Tue Jul 16 16:49:27 2002
+++ 2.5.26-select/arch/s390x/kernel/linux32.c	Fri Jul 19 02:18:27 2002
@@ -1420,30 +1420,30 @@ asmlinkage int sys32_select(int n, u32 *
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
 		int sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		put_user(sec, &tvp->tv_sec);
 		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set32(nn, inp, fds.res_in);
 	set_fd_set32(nn, outp, fds.res_out);
 	set_fd_set32(nn, exp, fds.res_ex);
 
diff -prU6 2.5.26/arch/sparc64/kernel/sys_sparc32.c 2.5.26-select/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.26/arch/sparc64/kernel/sys_sparc32.c	Tue Jul 16 16:49:35 2002
+++ 2.5.26-select/arch/sparc64/kernel/sys_sparc32.c	Fri Jul 19 02:16:59 2002
@@ -1387,30 +1387,30 @@ asmlinkage int sys32_select(int n, u32 *
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
 		time_t sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		put_user(sec, &tvp->tv_sec);
 		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set32(nn, inp, fds.res_in);
 	set_fd_set32(nn, outp, fds.res_out);
 	set_fd_set32(nn, exp, fds.res_ex);
 
diff -prU6 2.5.26/arch/x86_64/ia32/sys_ia32.c 2.5.26-select/arch/x86_64/ia32/sys_ia32.c
--- 2.5.26/arch/x86_64/ia32/sys_ia32.c	Tue Jul 16 16:49:32 2002
+++ 2.5.26-select/arch/x86_64/ia32/sys_ia32.c	Fri Jul 19 02:18:07 2002
@@ -878,30 +878,30 @@ sys32_select(int n, fd_set *inp, fd_set 
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp32 && !(current->personality & STICKY_TIMEOUTS)) {
 		time_t sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		put_user(sec, (int *)&tvp32->tv_sec);
 		put_user(usec, (int *)&tvp32->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set(n, inp, fds.res_in);
 	set_fd_set(n, outp, fds.res_out);
 	set_fd_set(n, exp, fds.res_ex);
 
diff -prU6 2.5.26/fs/select.c 2.5.26-select/fs/select.c
--- 2.5.26/fs/select.c	Tue Jul 16 16:49:24 2002
+++ 2.5.26-select/fs/select.c	Fri Jul 19 02:18:41 2002
@@ -316,30 +316,30 @@ sys_select(int n, fd_set *inp, fd_set *o
 	zero_fd_set(n, fds.res_in);
 	zero_fd_set(n, fds.res_out);
 	zero_fd_set(n, fds.res_ex);
 
 	ret = do_select(n, &fds, &timeout);
 
+	if (ret < 0)
+		goto out;
+	if (!ret) {
+		ret = -ERESTARTNOHAND;
+		if (signal_pending(current))
+			goto out;
+		ret = 0;
+	}
+
 	if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
 		time_t sec = 0, usec = 0;
 		if (timeout) {
 			sec = timeout / HZ;
 			usec = timeout % HZ;
 			usec *= (1000000/HZ);
 		}
 		put_user(sec, &tvp->tv_sec);
 		put_user(usec, &tvp->tv_usec);
-	}
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
 	}
 
 	set_fd_set(n, inp, fds.res_in);
 	set_fd_set(n, outp, fds.res_out);
 	set_fd_set(n, exp, fds.res_ex);
 
