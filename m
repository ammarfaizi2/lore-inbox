Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280742AbRKGCOk>; Tue, 6 Nov 2001 21:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280744AbRKGCOd>; Tue, 6 Nov 2001 21:14:33 -0500
Received: from ns0.ipal.net ([206.97.148.120]:24258 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280742AbRKGCOR>;
	Tue, 6 Nov 2001 21:14:17 -0500
Subject: [CFT][PATCH] sys_time inconsistent with sys_gettimeofday
To: linux-kernel@vger.kernel.org
Date: Tue, 6 Nov 2001 20:14:16 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011107021416.47D8C240@vega.ipal.net>
From: phil-linux-kernel@ipal.net (Phil Howard)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've occaisionally found that the result from time() is inconsistent
with the result from gettimeofday(), or the moment of alarm set by
setitimer().  This difference has occaisionally resulted in time()
returning a value of the previous second, even when called after
gettimeofday() returns the current value (plus the few microseconds).

Recently I had a script run at 00:00:00, but it called the date program
to get the current date (to build file names with), and the date it got
was the previous date one time.  This goofed up some log file archiving.
Workarounds are many, such as adding "sleep 1" or scheduling for 00:01:00
instead.  I've had this happen before, but dismissed it as a glitch.
This time I decided to investigate further.  So I ran this test program:

/* This program checks for cases of time() being called after
 * gettimeofday() but returning a time value in seconds that
 * is LOWER than the seconds portion of gettimeofday().
 */
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>
int main() {
    struct timeval tod;
    time_t tim;
    for (;;) {
	gettimeofday( & tod, NULL );
	tim = time( NULL );
	if ( tim < tod.tv_sec ) {
	    printf( "gettimeofday() = [%lu, %lu], time() = %lu\n",
		    (unsigned long) tod.tv_sec,
		    (unsigned long) tod.tv_usec,
		    (unsigned long) tim );
	}
    }
}

which produced a substantial amount of output.  I ran it via strace to
be sure, and even there I logged definite cases where time() returned
a value less than the seconds part of the previous gettimeofday().

After checking what what sys_time() was doing compare to others, I wrote
this patch for 2.4.13 (been told it's fine on 2.4.14):

diff -u --recursive --new-file linux-old/kernel/time.c linux/kernel/time.c
--- linux-old/kernel/time.c	Mon Oct 16 14:58:51 2000
+++ linux/kernel/time.c	Sat Nov  3 23:28:17 2001
@@ -70,11 +70,11 @@
  */
 asmlinkage long sys_time(int * tloc)
 {
+	struct timeval ktv;
 	int i;
 
-	/* SMP: This is fairly trivial. We grab CURRENT_TIME and 
-	   stuff it to user space. No side effects */
-	i = CURRENT_TIME;
+	do_gettimeofday(&ktv);
+	i = ktv.tv_sec;
 	if (tloc) {
 		if (put_user(i,tloc))
 			i = -EFAULT;

to make time() be consistent with gettimeofday().  It silenced the test
program above.  I'm not certain this is the best thing to do, but it did
work.  One alternative might be to make gettimeofday() update the
CURRENT_TIME variable, but my worry there was that it might upset other
code that would depend on a steady update to it.  That, and other places
like select() and poll() and setitimer() and whatever else might need
to update it to keep things in sync.  So I just decided making sys_time()
call do_gettimeofday() was the simplest solution.

Comments ahead of sys_time() do suggest calling gettimeofday() instead,
so for userspace it would seem this means the value is expected to be OK.

I am testing this on 4 machines with 2.4.13 right now.  But none are SMP,
so I'm looking for someone else who can test it on SMP.  I have some
concern regarding SMP due to the (deleted by patch) comment in sys_time().
Something previous may have been a concern for SMP and I hope that calling
do_gettimeofda() was not it.   Also, all my tests are on Intel IA32.
Other machines may not have the problem at all.  I'm trying to get a
Sparc 5 I have set up for this test, too.

MD5 of tabbed versions and URLs for direct access:
aff6f1fbf464cfef876a3b6e31e518f5  checktime.c
b7e2a07b0b351ee4dfb2fc289869a4bb  fix-time-2.4.13.patch
http://phil.ipal.org/lkml/checktime.c
http://phil.ipal.org/lkml/fix-time-2.4.13.patch

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
