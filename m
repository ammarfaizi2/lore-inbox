Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVB1E0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVB1E0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 23:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVB1E0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 23:26:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43818
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261551AbVB1EZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 23:25:46 -0500
Date: Mon, 28 Feb 2005 05:25:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: two pipe bugfixes
Message-ID: <20050228042544.GA8742@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This testcase from Thomas Crhak:

#include <unistd.h>
#include <sys/select.h>

int
main(int argv, char **argc) {
  int inout[2];
  fd_set readfds, writefds, exceptfds;
  struct timeval timeout;

  timeout.tv_sec = 0;
  timeout.tv_usec = 0;

  FD_ZERO(&readfds);
  FD_ZERO(&writefds);
  FD_ZERO(&exceptfds);

  pipe(inout);
  write(inout[1], "qqqqqqqq", 5);

  FD_SET(inout[1], &readfds);
  FD_SET(inout[1], &writefds);
  FD_SET(inout[1], &exceptfds);

  select(inout[1] + 1, &readfds, &writefds, &exceptfds, &timeout);

  close(inout[0]);

  write(inout[1], "qqqqqqqq", 5);
  return 0;
}

was returning this in 2.6.9:

pipe([3, 4])                            = 0
write(4, "qqqqq", 5)                    = 5
select(5, [4], [4], [4], {0, 0})        = 1 (in [4], left {0, 0})
close(3)                                = 0
write(4, "qqqqq", 5)                    = -1 EPIPE (Broken pipe)

and it started to return this since 2.6.11-rc:

pipe([3, 4])                            = 0
write(4, "qqqqq", 5)                    = 5
select(5, [4], [4], [4], {0, 0})        = 2 (in [4], out [4], left {0,
0})
close(3)                                = 0
write(4, "qqqqq", 5)                    = 5

There are two separate bugs: the first is that it doesn't return
-EPIPE because the input side has been closed already, the second is
that it returns POLLIN|POLLOUT. I heard POLLIN|POLLOUT is sometime
detected as a special case that means the input side has disconnected.
But anyway POLLIN|POLLOUT at the same time seems wrong to me (at least I
didn't find anything in SUS specs mentioning this magic for pipes) and
2.6.11-rc definitely breaks python-twisted (which apparently understand
the magic I've heard). But clearly the change in 2.6.11-rc that sets
POLLOUT if not all buffers are full makes plenty of sense for
performance reasons.

IMHO the really wrong thing is that we always set POLLIN (even for
output filedescriptors that will never allow any data to be read).

So now I check if the file is open in read or write mode, and I return
POLLIN or POLLOUT and never both of them at the same time. I've no idea
if this is the correct semantics that all applications expects, but
since we use the same pipe_poll callback for all read/write/rdwr cases,
I believe this is the most correct one and it certainly looks better
than the 2.6.11-rc code that breaks twisted, and this new logic still
allows the optimizations in the 2.6.11-rc to work.

Current output of strace with this patch applied is this:

pipe([3, 4])                            = 0
write(4, "qqqqq", 5)                    = 5
select(5, [4], [4], [4], {0, 0})        = 1 (out [4], left {0, 0})
close(3)                                = 0
write(4, "qqqqq", 5)                    = -1 EPIPE (Broken pipe)
--- SIGPIPE (Broken pipe) @ 0 (0) ---
+++ killed by SIGPIPE +++

which is different from 2.6.9 but it makes a lot more sense to me for a
"write-only" fd IMHO, and I had no pratical problems with this patch
yet (not that I've run any big stress test though, just normal misc
usage with all sort of desktop apps and twisted). Comments welcome thanks!

Patch is against 2.6.11-rc5.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- xx/fs/pipe.c.~1~	2005-02-28 00:43:42.000000000 +0100
+++ xx/fs/pipe.c	2005-02-28 04:47:26.000000000 +0100
@@ -235,6 +235,12 @@ pipe_writev(struct file *filp, const str
 	down(PIPE_SEM(*inode));
 	info = inode->i_pipe;
 
+	if (!PIPE_READERS(*inode)) {
+		send_sig(SIGPIPE, current, 0);
+		ret = -EPIPE;
+		goto out;
+	}
+
 	/* We try to merge small writes */
 	if (info->nrbufs && total_len < PAGE_SIZE) {
 		int lastbuf = (info->curbuf + info->nrbufs - 1) & (PIPE_BUFFERS-1);
@@ -398,8 +404,15 @@ pipe_poll(struct file *filp, poll_table 
 
 	/* Reading only -- no need for acquiring the semaphore.  */
 	nrbufs = info->nrbufs;
-	mask = (nrbufs > 0) ? POLLIN | POLLRDNORM : 0;
-	mask |= (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
+	mask = 0;
+	/*
+	 * Returning POLLIN|POLLOUT for a output channel has special semantics 
+	 * and it's used by some app to detect when the input has been closed.
+	 */
+	if (filp->f_mode & FMODE_READ && nrbufs > 0)
+		mask |= POLLIN | POLLRDNORM;
+	if (filp->f_mode & FMODE_WRITE && nrbufs < PIPE_BUFFERS)
+		mask |= POLLOUT | POLLWRNORM;
 
 	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
 		mask |= POLLHUP;

PS. this still can return POLLIN|POLLOUT if somebody opens a fifo in RDWRITE
mode, but I guess that's ok and the above beahviour still should make sense
for such a corner case usage too.
