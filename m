Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRIJPTA>; Mon, 10 Sep 2001 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271165AbRIJPSv>; Mon, 10 Sep 2001 11:18:51 -0400
Received: from mout04.kundenserver.de ([195.20.224.89]:15482 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271226AbRIJPSh>; Mon, 10 Sep 2001 11:18:37 -0400
To: brianmc1@us.ibm.com, libc-alpha@sources.redhat.com,
        linux-kernel@vger.kernel.org
CC: wg@malloc.de
Subject: SMP-ix86-threads-fork: Linux 2.4.x kernel problem identified [phantom read()]
From: Wolfram Gloger <wg@malloc.de>
X-URL: http://www.malloc.de/
Message-Id: <E15gSpt-0008PG-00@mrvdom01.schlund.de>
Date: Mon, 10 Sep 2001 17:18:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please CC me if you reply on the kernel mailing list, thx]

Hi,

After several months of tests and debugging, I believe I've _finally_
identified the nasty problem with my fork-malloc testcase,

http://www.malloc.de/tests/fork-malloc.c

which in turn I am pretty sure is equivalent to Brian McCorkle and
others' stressKernel problem.  The combination involved is
threads/clone() (via LinuxThreads) and fork().

On a variety of dual-ix86-SMP systems running Linux-2.4.[0-10pre]
kernels (compiled with gcc-2.95.2 and gcc-2.95.4) it eventually
happens that a read(fd, buf, sz) system call returns successfully but
it _actually hasn't read any bytes into buf_ (maybe the bytes go
somewhere else but I haven't determined where).  The file involved in
this case is the manager pipe employed by LinuxThreads.

When this occurs within LinuxThreads, the buffer that is read into
('request') in the manager is then _unchanged_ from the previous
'thread create' request, and so a 'phantom thread' is created (bad),
and the creating thread is restart()ed unconditionally (much worse,
f.e. if it's waiting on a mutex).  The resulting crashes are
practically impossible to debug, hiding the problem extremely well.

I've now created a patch for glibc-2.2.4 (appended below, but should
'work' for all recent glibcs), with which applied I'm eventually
seeing "*** Bug" being printed when I run fork-malloc (see the URL
above) on Dual-ix86 systems.  You can feel free to substitute any
value for '0x123456' in the patch if you want to convince yourself of
the bug.

I tried hard to create a test case independent of LinuxThreads but
have failed so far, sorry.  If you want to reproduce, you may have to
be patient, sometimes I've seen the bug strike in a few minutes, but
occasionally it can take up to 6 hours..

Regards,
Wolfram.

--- linuxthreads/manager.c.orig	Mon Jul 23 19:54:13 2001
+++ linuxthreads/manager.c	Mon Sep 10 11:48:49 2001
@@ -150,8 +150,18 @@
     }
     /* Read and execute request */
     if (n == 1 && (ufd.revents & POLLIN)) {
-      n = __libc_read(reqfd, (char *)&request, sizeof(request));
-      ASSERT(n == sizeof(request));
+      int sz_read;
+      request.req_kind = 0x123456;
+      for (sz_read=0; sz_read<sizeof(request); sz_read+=n) {
+	n = __libc_read(reqfd, (char *)&request + sz_read,
+			sizeof(request) - sz_read);
+	if (n < 0)
+	  continue;
+      }
+      if(request.req_kind == 0x123456) {
+	write(2, "*** Bug\n", 8);
+	abort();
+      }
       switch(request.req_kind) {
       case REQ_CREATE:
         request.req_thread->p_retcode =

