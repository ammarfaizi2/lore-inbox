Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVASUzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVASUzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVASUzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:55:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33463 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261892AbVASUy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:54:57 -0500
Date: Wed, 19 Jan 2005 12:54:44 -0800
Message-Id: <200501192054.j0JKsiFw002526@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cputime_t patches broke RLIMIT_CPU
Emacs: no job too big... no job.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RLIMIT_CPU limit is in seconds, not in jiffies.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2301,14 +2327,14 @@ static void check_rlimit(struct task_str
 	cputime_t total, tmp;
 
 	total = cputime_add(p->utime, p->stime);
-	tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_cur);
+	tmp = secs_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_cur);
 	if (unlikely(cputime_gt(total, tmp))) {
 		/* Send SIGXCPU every second. */
 		tmp = cputime_sub(total, cputime);
 		if (cputime_to_secs(tmp) < cputime_to_secs(total))
 			send_sig(SIGXCPU, p, 1);
 		/* and SIGKILL when we go over max.. */
-		tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_max);
+		tmp = secs_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_max);
 		if (cputime_gt(total, tmp))
 			send_sig(SIGKILL, p, 1);
 	}
