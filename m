Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265594AbRFVX4u>; Fri, 22 Jun 2001 19:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265595AbRFVX4k>; Fri, 22 Jun 2001 19:56:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22289 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265594AbRFVX40>; Fri, 22 Jun 2001 19:56:26 -0400
Date: Fri, 22 Jun 2001 20:56:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: <andreas@conectiva.com.br>, <andreas@netbank.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix RLIMIT_NPROC accounting
Message-ID: <Pine.LNX.4.33L.0106222053170.4442-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

due to something which I consider to be a kernel bug it's
impossible for pam to do its job and set the per-user
RLIMIT_NPROC (number of processes limit) to something which
is lower than the amount of processes root is running at that
moment.

At least, it fails with all programs which set RLIMIT_NPROC
and fork()+exec() afterwards.

The attached patch should bring us back to the behaviour we
had in 2.2.  Comments?

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- kernel/fork.c.orig	Fri Jun 22 20:27:27 2001
+++ kernel/fork.c	Fri Jun 22 20:52:41 2001
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

