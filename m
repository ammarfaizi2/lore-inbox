Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUHSUxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUHSUxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUHSUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:53:44 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:59320 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S267376AbUHSUxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:53:23 -0400
Date: Thu, 19 Aug 2004 13:53:14 -0700
Message-Id: <200408192053.i7JKrE9g024895@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: [PATCH] waitid system call
In-Reply-To: Michael Kerrisk's message of  Thursday, 19 August 2004 19:20:16 +0200 <19958.1092936016@www27.gmx.net>
X-Zippy-Says: I want to dress you up as TALLULAH BANKHEAD and cover you with
   VASELINE and WHEAT THINS..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've tested out various things (see below for a summary), and 

Thanks for testing out the code.  I had meant to mention that there is a
test program for waitid in the glibc test suite, which is what I used to
test the code before submitting it.  It's in posix/tst-waitid.c in the
glibc CVS sources.  You can tweak that program slightly to build it
independent of glibc.  For anyone who wants to try it out using glibc, I'll
attach below the patches that enable use of the system call (if you build
glibc against kernel headers including the waitid patch). 

> all seems well, with one possible doubt.  How can one 
> distinguish "no children to wait for case" and the "child 
> successfully waited for case" when using WNOHANG?

This is something I did consider in detail, though I overlooked commenting
on it.  The POSIX wording on this is not entirely unambiguous.  What it
does say is, "If waitid() returns because a child process was found [...],
then the structure pointed to by infop shall be filled in by the system
[...]"  It does not say that *infop is written in any other case.  So, I
think a POSIX-compliant application must not assume that it will be.  

Given that specification, I made the system call do just what it says and
no more.  For a WNOHANG return without a child, it doesn't touch the structure.

The tst-waitid program intends to be POSIX-compliant (in its use of
waitid), and so I wrote it to zero the si_signo field before the call and
check whether it got set to SIGCHLD or not.  The POSIX specification for
waitid specifically requires that si_signo be set to SIGCHLD when the
siginfo_t is filled in.  Taking the standard as a whole, you can also
conclude that it requires that si_pid be filled in and not zero.  So that
is also a reasonable test--if you zeroed the structure (or at least the
field you want to test) before the waitid call.

I think one could even construe the POSIX wording to mean that a WNOHANG
return-without-child should not touch the structure at all.  However, I
would not argue for that and say Solaris should not zero si_pid here.


Thanks,
Roland



glibc patch follows:


2004-08-04  Roland McGrath  <roland@redhat.com>

	* sysdeps/unix/sysv/linux/bits/waitflags.h
	(WSTOPPED, WEXITED, WCONTINUED, WNOWAIT): New macros.
	* sysdeps/unix/sysv/linux/waitid.c: New file.  Use new syscall when
	available, or fall back to the waitpid-based generic code.

Index: sysdeps/unix/sysv/linux/bits/waitflags.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/bits/waitflags.h,v
retrieving revision 1.5
diff -p -u -r1.5 waitflags.h
--- sysdeps/unix/sysv/linux/bits/waitflags.h	6 Jul 2001 04:56:14 -0000	1.5
+++ sysdeps/unix/sysv/linux/bits/waitflags.h	19 Aug 2004 20:51:17 -0000
@@ -1,5 +1,5 @@
 /* Definitions of flag bits for `waitpid' et al.
-   Copyright (C) 1992, 1996, 1997, 2000 Free Software Foundation, Inc.
+   Copyright (C) 1992, 1996, 1997, 2000, 2004 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
 
    The GNU C Library is free software; you can redistribute it and/or
@@ -26,5 +26,11 @@
 #define	WNOHANG		1	/* Don't block waiting.  */
 #define	WUNTRACED	2	/* Report status of stopped children.  */
 
+/* Bits in the fourth argument to `waitid'.  */
+#define WSTOPPED	2	/* Report stopped child (same as WUNTRACED). */
+#define WEXITED		4	/* Report dead child.  */
+#define WCONTINUED	8	/* Report continued child.  */
+#define WNOWAIT		0x01000000 /* Don't reap, just poll status.  */
+
 #define __WALL		0x40000000 /* Wait for any child.  */
 #define __WCLONE	0x80000000 /* Wait for cloned process.  */
Index: sysdeps/unix/sysv/linux/waitid.c
===================================================================
RCS file: sysdeps/unix/sysv/linux/waitid.c
diff -N sysdeps/unix/sysv/linux/waitid.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ sysdeps/unix/sysv/linux/waitid.c	19 Aug 2004 20:51:17 -0000
@@ -0,0 +1,67 @@
+/* Linux implementation of waitid.
+   Copyright (C) 2004 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <errno.h>
+#include <sys/wait.h>
+#include <kernel-features.h>
+
+/**** kernel-features.h ****/
+/* Starting with version 2.6.??? the getdents syscall returns d_type
+   information as well.  */
+#if __LINUX_KERNEL_VERSION >= 132615999
+# define __ASSUME_WAITID_SYSCALL	1
+#endif
+
+#if __ASSUME_WAITID_SYSCALL > 0
+
+static inline int
+do_waitid (idtype_t idtype, id_t id, siginfo_t *infop, int options)
+{
+  return INLINE_SYSCALL (waitid, 4, idtype, id, infop, options);
+}
+# define NO_DO_WAITID
+
+#elif defined __NR_waitid
+
+static int do_compat_waitid (idtype_t idtype, id_t id,
+			     siginfo_t *infop, int options);
+# define DO_WAITID do_compat_waitid
+
+static int
+do_waitid (idtype_t idtype, id_t id, siginfo_t *infop, int options)
+{
+  static int waitid_works;
+  if (waitid_works > 0)
+    return INLINE_SYSCALL (waitid, 4, idtype, id, infop, options);
+  if (waitid_works == 0)
+    {
+      int result = INLINE_SYSCALL (waitid, 4, idtype, id, infop, options);
+      if (result < 0 && errno == ENOSYS)
+	waitid_works = -1;
+      else
+	{
+	  waitid_works = 1;
+	  return result;
+	}
+    }
+  return do_compat_waitid (idtype, id, infop, options);
+}
+#endif
+
+#include "sysdeps/posix/waitid.c"
