Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133056AbRDZCXp>; Wed, 25 Apr 2001 22:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133061AbRDZCXg>; Wed, 25 Apr 2001 22:23:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25220 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133056AbRDZCXS>;
	Wed, 25 Apr 2001 22:23:18 -0400
Date: Wed, 25 Apr 2001 22:23:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] handling of failed copy_thread() in do_fork()
Message-ID: <Pine.GSO.4.21.0104252214380.13090-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If copy_thread() fails (it can't happen on x86, but on other
architectures, e.g. on sparc, it's possible) do_fork() doesn't do
full cleanup - it forgets to do exit_mm(). Obvious fix follows.
Please, apply.
								Al

diff -urN S4-pre7/kernel/fork.c S4-pre7-fork/kernel/fork.c
--- S4-pre7/kernel/fork.c	Wed Apr 25 20:43:12 2001
+++ S4-pre7-fork/kernel/fork.c	Wed Apr 25 22:12:39 2001
@@ -652,7 +652,7 @@
 		goto bad_fork_cleanup_sighand;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
-		goto bad_fork_cleanup_sighand;
+		goto bad_fork_cleanup_mm;
 	p->semundo = NULL;
 	
 	/* Our parent execution domain becomes current domain
@@ -708,6 +708,8 @@
 		down(&sem);
 	return retval;
 
+bad_fork_cleanup_mm:
+	exit_mm(p);
 bad_fork_cleanup_sighand:
 	exit_sighand(p);
 bad_fork_cleanup_fs:

