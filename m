Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVAOIqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVAOIqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVAOIqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:46:11 -0500
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:29850 "EHLO
	av6-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262243AbVAOIpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 03:45:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16872.55357.771948.196757@antilipe.corelatus.se>
Date: Sat, 15 Jan 2005 09:45:49 +0100
From: Matthias Lang <matthias@corelatus.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: patch to fix set_itimer() behaviour in boundary cases
X-Mailer: VM 7.17 under 21.4 (patch 16) "Corporate Culture" XEmacs Lucid
Reply-To: matthias@corelatus.se
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The linux implementation of setitimer() doesn't behave quite as
expected. I found several problems:

  1. POSIX says that negative times should cause setitimer() to 
     return -1 and set errno to EINVAL. In linux, the call succeeds.

  2. POSIX says that time values with usec >= 1000000 should
     cause the same behaviour. In linux, the call succeeds.

  3. If large time values are given, linux quietly truncates them
     to the maximum time representable in jiffies. On 2.4.4 on PPC,
     that's about 248 days. On 2.6.10 on x86, that's about 24 days.

     POSIX doesn't really say what to do in this case, but looking at
     established practice, i.e. "what BSD does", since the call comes 
     from BSD, *BSD returns -1 if the time is out of range.

References:

      kernel/itimer.c
      http://www.opengroup.org/onlinepubs/009695399/functions/getitimer.html
      http://www.delorie.com/gnu/docs/glibc/libc_444.html
      http://www.gsp.com/cgi-bin/man.cgi?section=2&topic=setitimer

I have tested on 2.4.4 and 2.6.10 as well as getting other people to
test on 2.4.28, 2.4.27 and FreeBSD.

Here's a patch against linux 2.6.10:

--- linux-2.6.10/kernel/itimer.c	2005-01-15 09:39:13.000000000 +0100
+++ linux-2.6.10.fixed/kernel/itimer.c	2005-01-13 09:56:50.000000000 +0100
@@ -84,6 +84,16 @@
 	register unsigned long i, j;
 	int k;
 
+	if (value->it_interval.tv_sec >= MAX_SEC_IN_JIFFIES
+		|| value->it_value.tv_sec >= MAX_SEC_IN_JIFFIES
+		|| value->it_interval.tv_sec < 0
+		|| value->it_value.tv_sec < 0
+		|| value->it_interval.tv_usec >= 1000000
+		|| value->it_value.tv_usec >= 1000000
+		|| value->it_interval.tv_usec < 0
+		|| value->it_value.tv_usec < 0)
+		return -EINVAL;
+
 	i = timeval_to_jiffies(&value->it_interval);
 	j = timeval_to_jiffies(&value->it_value);
 	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)

I've put it at http://www.corelatus.com/~matthias/posix_setitimer.patch
along with a test program, http://www.corelatus.com/~matthias/ti.c

Here's what the test program looks like when run on a patched 2.6.10 kernel:

    tmp >gcc -Wall ti.c
    tmp >./a.out
    value    sec=0 usec=0 result=0 expected=0
    interval sec=0 usec=0 result=0 expected=0
    value    sec=1 usec=0 result=0 expected=0
    interval sec=1 usec=0 result=0 expected=0
    value    sec=-1 usec=0 result=-1 expected=-1
    interval sec=-1 usec=0 result=-1 expected=-1
    value    sec=0 usec=-1 result=-1 expected=-1
    interval sec=0 usec=-1 result=-1 expected=-1
    value    sec=0 usec=1000000 result=-1 expected=-1
    interval sec=0 usec=1000000 result=-1 expected=-1
    value    sec=0 usec=999999 result=0 expected=0
    interval sec=0 usec=999999 result=0 expected=0
    limit is 2147156
    value    sec=2147155 usec=0 result=0 expected=0
    interval sec=2147155 usec=0 result=0 expected=0
    value    sec=2147156 usec=0 result=0 expected=0
    interval sec=2147156 usec=0 result=0 expected=0
    value    sec=2147157 usec=0 result=-1 expected=-1
    interval sec=2147157 usec=0 result=-1 expected=-1
    All tests passed

Matt
