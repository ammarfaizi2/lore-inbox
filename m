Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUKOUtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUKOUtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUKOUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:48:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13899 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261693AbUKOUqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:46:33 -0500
Date: Mon, 15 Nov 2004 20:45:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm check_rlimit oops on p->signal
Message-ID: <Pine.LNX.4.44.0411152043250.4131-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The p->signal check in account_system_time is insufficient.  If the
timer interrupt hits near the end of exit_notify, after EXIT_ZOMBIE has
been set, another cpu may release_task (NULLifying p->signal) in between
account_system_time's check and check_rlimit's dereference.  Nor should
account_it_prof risk send_sig.  But surely account_user_time is safe?

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc1-mm5/kernel/sched.c	2004-11-11 12:40:12.000000000 +0000
+++ linux/kernel/sched.c	2004-11-14 20:41:26.851384984 +0000
@@ -2333,8 +2333,7 @@ void account_user_time(struct task_struc
 	p->utime = cputime_add(p->utime, cputime);
 
 	/* Check for signals (SIGVTALRM, SIGPROF, SIGXCPU & SIGKILL). */
-	if (likely(p->signal))
-		check_rlimit(p, cputime);
+	check_rlimit(p, cputime);
 	account_it_virt(p, cputime);
 	account_it_prof(p, cputime);
 
@@ -2362,9 +2361,10 @@ void account_system_time(struct task_str
 	p->stime = cputime_add(p->stime, cputime);
 
 	/* Check for signals (SIGPROF, SIGXCPU & SIGKILL). */
-	if (likely(p->signal))
+	if (likely(p->signal && p->exit_state < EXIT_ZOMBIE)) {
 		check_rlimit(p, cputime);
-	account_it_prof(p, cputime);
+		account_it_prof(p, cputime);
+	}
 
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);

