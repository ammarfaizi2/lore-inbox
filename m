Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272109AbRIJW4g>; Mon, 10 Sep 2001 18:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272094AbRIJW40>; Mon, 10 Sep 2001 18:56:26 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:37407 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S272101AbRIJW4L>; Mon, 10 Sep 2001 18:56:11 -0400
To: kaz@ashi.footprints.net
CC: wg@malloc.de, brianmc1@us.ibm.com, libc-alpha@sources.redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109100931190.20444-100000@ashi.FootPrints.net>
	(message from Kaz Kylheku on Mon, 10 Sep 2001 09:42:08 -0700 (PDT))
Subject: Re: SMP-ix86-threads-fork: Linux 2.4.x kernel problem identified
 [phantom read()]
From: Wolfram Gloger <wg@malloc.de>
X-URL: http://www.malloc.de/
In-Reply-To: <Pine.LNX.4.33.0109100931190.20444-100000@ashi.FootPrints.net>
Message-Id: <E15gZyh-00074n-00@mrvdom04.kundenserver.de>
Date: Tue, 11 Sep 2001 00:56:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> So it's perfectly possible to observe the behavior you are seeing
> if __libc_read() returns -1. Because then sz_read will acquire the
> value -1, and the guard expresssion sz_read < sizeof(request) will yield
> zero, terminating the loop.

Argh!  That indeed seems to be the case, _no_ apparent kernel problem
is involved, sorry for the false alarm.  read() 'just' returns -1 with
errno becoming EINTR.  One should never code up a loop like that in
the last minute (I only found the effect yesterday)..

> Could you recode the test patch to eliminate these suspicions and re-test?

The analysis was nevertheless correct, LinuxThreads gets out of synch
with disastrous effects.  I was puzzled how read() could return -1,
however it may make sense with a __pthread_sig_cancel pending in the
manager thread due to a child exiting (?).  But then, why wasn't this
possibility discovered before?

Below is a corrected patch for glibc-2.2.4.  I've run fork-malloc with
this for a couple of hours.

Thanks,
Wolfram.

2001-09-11  Wolfram Gloger  <wg@malloc.de>

	* manager.c (__pthread_manager): When reading from pipe. account
	for possible error return from read().

--- linuxthreads/manager.c.orig	Mon Jul 23 19:54:13 2001
+++ linuxthreads/manager.c	Tue Sep 11 00:47:48 2001
@@ -150,8 +150,19 @@
     }
     /* Read and execute request */
     if (n == 1 && (ufd.revents & POLLIN)) {
-      n = __libc_read(reqfd, (char *)&request, sizeof(request));
-      ASSERT(n == sizeof(request));
+      int sz_read = 0;
+
+      while (sz_read < sizeof(request)) {
+	n = __libc_read(reqfd, (char *)&request + sz_read,
+			sizeof(request) - sz_read);
+	if (n < 0) {
+#ifdef DEBUG
+	  char d[64];
+	  sprintf(d, "*** read err %d\n", errno);
+#endif
+	} else
+	  sz_read += n;
+      }
       switch(request.req_kind) {
       case REQ_CREATE:
         request.req_thread->p_retcode =

