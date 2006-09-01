Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWIAR0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWIAR0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWIAR0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:26:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751204AbWIAR0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:26:01 -0400
Subject: [PATCH 2.6.18-rc5] enforce RLIMIT_NOFILE in poll()
From: Chris Snook <csnook@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Vadim Lobanov <vlobanov@speakeasy.net>,
       Ulrich Drepper <drepper@redhat.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 13:25:56 -0400
Message-Id: <1157131556.12933.6.camel@newton.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Snook <csnook@redhat.com>

POSIX states that poll() shall fail with EINVAL if nfds > OPEN_MAX.  In
this context, POSIX is referring to sysconf(OPEN_MAX), which is the
value of current->signal->rlim[RLIMIT_NOFILE].rlim_cur in the linux
kernel, not the compile-time constant which happens to also be named
OPEN_MAX.  In the current code, an application may poll up to max_fdset
file descriptors, even if this exceeds RLIMIT_NOFILE.  The current code
also breaks applications which poll more than max_fdset descriptors,
which worked circa 2.4.18 when the check was against NR_OPEN, which is
1024*1024.  This patch enforces the limit precisely as POSIX defines,
even if RLIMIT_NOFILE has been changed at run time with ulimit -n.
Tested on 2.6.18-rc5.

Signed-off-by: Chris Snook <csnook@redhat.com>
---

To elaborate on the rationale for this, there are three cases:

1) RLIMIT_NOFILE is at the default value of 1024

In this (default) case, the patch changes nothing.  Calls with nfds >
1024 fail with EINVAL both before and after the patch, and calls with
nfds <= 1024 pass the check both before and after the patch, since 1024
is the initial value of max_fdset.

2) RLIMIT_NOFILE has been raised above the default

In this case, poll() becomes more permissive, allowing polling up to
RLIMIT_NOFILE file descriptors even if less than 1024 have been opened.
The patch won't introduce new errors here.  If an application somehow
depends on poll() failing when it polls with duplicate or invalid file
descriptors, it's already broken, since this is already allowed below
1024, and will also work above 1024 if enough file descriptors have been
open at some point to cause max_fdset to have been increased above nfds.

3) RLIMIT_NOFILE has been lowered below the default

In this case, the system administrator or the user has gone out of their
way to protect the system from inefficient (or malicious) applications
wasting kernel memory.  The current code allows polling up to 1024 file
descriptors even if RLIMIT_NOFILE is much lower, which is not what the
user or administrator intended.  Well-written applications which only
poll valid, unique file descriptors will never notice the difference,
because they'll hit the limit on open() first.  If an application gets
broken because of the patch in this case, then it was already
poorly/maliciously designed, and allowing it to work in the past was a
violation of POSIX and a DoS risk on low-resource systems.

This patch would replace remove-open_max-check-from-poll-syscall.patch
which is currently in -mm.  With this patch, poll() will permit exactly
what POSIX suggests, no more, no less, and for any run-time value set
with ulimit -n, not just 256 or 1024.  There are existing apps which
which poll a large number of file descriptors, some of which may be
invalid, and if those numbers stradle 1024, they currently fail with or
without the patch in -mm, though they worked fine under 2.4.18.
---

diff -urNp linux-2.6.18-rc5-orig/fs/select.c linux-2.6.18-rc5-
patch/fs/select.c
--- linux-2.6.18-rc5-orig/fs/select.c	2006-08-31 21:30:19.000000000
-0400
+++ linux-2.6.18-rc5-patch/fs/select.c	2006-08-31 21:45:05.000000000
-0400
@@ -658,8 +658,6 @@ int do_sys_poll(struct pollfd __user *uf
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
-	struct fdtable *fdt;
-	int max_fdset;
 	/* Allocate small arguments on the stack to save memory and be
 	   faster - use long to make sure the buffer is aligned properly
 	   on 64 bit archs to avoid unaligned access */
@@ -667,11 +665,7 @@ int do_sys_poll(struct pollfd __user *uf
 	struct poll_list *stack_pp = NULL;
 
 	/* Do a sanity check on nfds ... */
-	rcu_read_lock();
-	fdt = files_fdtable(current->files);
-	max_fdset = fdt->max_fdset;
-	rcu_read_unlock();
-	if (nfds > max_fdset && nfds > OPEN_MAX)
+	if (nfds > current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		return -EINVAL;
 
 	poll_initwait(&table);


