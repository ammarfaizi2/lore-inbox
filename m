Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVKJQba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVKJQba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVKJQba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:31:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750935AbVKJQba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:31:30 -0500
Message-ID: <437375DE.1070603@redhat.com>
Date: Thu, 10 Nov 2005 11:31:26 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] poll(2) timeout values
Content-Type: multipart/mixed;
 boundary="------------090604060309020902070007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604060309020902070007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

On 32 bit platforms, the poll(2) system call support can not correctly
handle the range of timeout values which are possible to call it with.
This is due to some limitations based on the clock speed, but also due
to concerns about integer arithmetic overflow.  The former is due to,
the number of jiffies which correspond to the number of milliseconds in
the timeout value, being larger than allowed.  Clock speeds of 1000 HZ
or less do not have this problem, so this is not a very common situation
to find.  The latter is due to problems in the ordering of the arithmetic
operations used to convert milliseconds to jiffies.

The problem being reported is that despite the man page descriptions, on
a typical 32 bit system with the clock rate set at 1000 HZ, the poll system
call can not handle timeout values larger than about 2,147 seconds.  On
such a system, the limit should be about 2,147,483 seconds.

Another problem was also discovered in the definition of the arguments to
the kernel poll implementation.  The poll(2) system takes an int as its
third argument.  The kernel implementation was using a long.

Once this problem is corrected, then the first problem can also be
corrected because the length of the timeout value from the user level
is limited to 31 bits.  64 bit arithmetic can be used to correctly do
the conversion between milliseconds and clock jiffies without loss of
precision.

These changes were tested by running a program which issues a poll(2)
call with a timeout value of 2,200 seconds.  Without these changes, the
poll call in this program hangs forever.  With the changes, the poll
call times out after approximately 2,200 seconds, matching the semantics
as described in the man page.

Concerns have been expressed regarding the change in the arguments to
the sys_poll() routine.  This is not an exported symbol, so there should
be compatibility issues with existing callers.  The routine implements
the system call interface underneath the glibc poll(2) call, so, if there
are architectures for which this would be a problem, then these changes
are not good enough.

Clearly, the timeout calculations problem can be fixed without changing
the arguments to the sys_poll() routine.  However, it is cleaner to fix
it this way by ensuring the sizes and types of arguments match.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------090604060309020902070007
Content-Type: text/plain;
 name="poll.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="poll.devel"

--- linux-2.6.14/fs/select.c.org
+++ linux-2.6.14/fs/select.c
@@ -25,6 +25,7 @@
 #include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
@@ -464,7 +465,7 @@ static int do_poll(unsigned int nfds,  s
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, int timeout_msecs)
 {
 	struct poll_wqueues table;
  	int fdcount, err;
@@ -473,6 +474,8 @@ asmlinkage long sys_poll(struct pollfd _
  	struct poll_list *walk;
 	struct fdtable *fdt;
 	int max_fdset;
+	long timeout;
+	int64_t lltimeout;
 
 	/* Do a sanity check on nfds ... */
 	rcu_read_lock();
@@ -482,13 +485,20 @@ asmlinkage long sys_poll(struct pollfd _
 	if (nfds > max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
-	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
+	if (timeout_msecs) {
+		if (timeout_msecs < 0)
 			timeout = MAX_SCHEDULE_TIMEOUT;
-	}
+		else {
+			lltimeout = (int64_t)timeout_msecs * HZ + 999;
+			do_div(lltimeout, 1000);
+			lltimeout++;
+			if (lltimeout > MAX_SCHEDULE_TIMEOUT)
+				timeout = MAX_SCHEDULE_TIMEOUT;
+			else
+				timeout = (long)lltimeout;
+		}
+	} else
+		timeout = 0;
 
 	poll_initwait(&table);
 
--- linux-2.6.14/include/linux/syscalls.h.org
+++ linux-2.6.14/include/linux/syscalls.h
@@ -420,7 +420,7 @@ asmlinkage long sys_socketpair(int, int,
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 asmlinkage long sys_listen(int, int);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-				long timeout);
+				int timeout_msecs);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_epoll_create(int size);

--------------090604060309020902070007--
