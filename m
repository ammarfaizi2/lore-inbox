Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286606AbRL0USh>; Thu, 27 Dec 2001 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286609AbRL0US0>; Thu, 27 Dec 2001 15:18:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9482 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286606AbRL0USM>; Thu, 27 Dec 2001 15:18:12 -0500
Date: Thu, 27 Dec 2001 18:18:08 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] rlimit_nproc
Message-ID: <Pine.LNX.4.33L.0112271816380.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(not yet automated, scripts need to be written ... but the patch
below would be a typical candidate ... are you happy with the way
the description and patch are combined ?)

When a user has a low RLIMIT_NPROC set in limits.conf, the user fails
to log in.  This is because the programs using pam basically do the
following:
  1) apply rlimits, setting RLIMIT_NPROC to eg. 10
  2) fork() to spawn the shell, which fails if root has
     more processes running than the per-user limit
  3) change to the user's UID
  4) exec() the shell

This patch ignores the limit for root so it's possible to use limit
on the amount of processes per user again. This is also a good thing
because the processes it ignores change UID again. Server processes
running as root need to do their own limiting anyway, otherwise they'd
just starve out the proverbial root shell.


--- linux/kernel/fork.c.orig	Fri Jun 22 20:27:27 2001
+++ linux/kernel/fork.c	Fri Jun 22 20:52:41 2001
@@ -576,7 +576,14 @@
 	*p = *current;

 	retval = -EAGAIN;
-	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
+	/*
+	 * Check if we are over our maximum process limit, but be sure to
+	 * exclude root. This is needed to make it possible for login and
+	 * friends to set the per-user process limit to something lower
+	 * than the amount of processes root is running. -- Rik
+	 */
+	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur
+	              && !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
 		goto bad_fork_free;
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);

