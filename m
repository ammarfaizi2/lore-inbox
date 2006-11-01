Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946556AbWKAFqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946556AbWKAFqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946551AbWKAFqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:47 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6365 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946523AbWKAFqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:46:13 -0500
Message-Id: <20061101054535.696669000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Oleg Nesterov <oleg@tv-sign.ru>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>
Subject: [PATCH 56/61] fill_tgid: fix task_struct leak and possible oops
Content-Disposition: inline; filename=fill_tgid-fix-task_struct-leak-and-possible-oops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Oleg Nesterov <oleg@tv-sign.ru>

1. fill_tgid() forgets to do put_task_struct(first).

2. release_task(first) can happen after fill_tgid() drops tasklist_lock,
   it is unsafe to dereference first->signal.

This is a temporary fix, imho the locking should be reworked.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Jay Lan <jlan@sgi.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 kernel/taskstats.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.18.1.orig/kernel/taskstats.c
+++ linux-2.6.18.1/kernel/taskstats.c
@@ -229,14 +229,17 @@ static int fill_tgid(pid_t tgid, struct 
 	} else
 		get_task_struct(first);
 
-	/* Start with stats from dead tasks */
-	spin_lock_irqsave(&first->signal->stats_lock, flags);
-	if (first->signal->stats)
-		memcpy(stats, first->signal->stats, sizeof(*stats));
-	spin_unlock_irqrestore(&first->signal->stats_lock, flags);
 
 	tsk = first;
 	read_lock(&tasklist_lock);
+	/* Start with stats from dead tasks */
+	if (first->signal) {
+		spin_lock_irqsave(&first->signal->stats_lock, flags);
+		if (first->signal->stats)
+			memcpy(stats, first->signal->stats, sizeof(*stats));
+		spin_unlock_irqrestore(&first->signal->stats_lock, flags);
+	}
+
 	do {
 		if (tsk->exit_state == EXIT_ZOMBIE && thread_group_leader(tsk))
 			continue;
@@ -256,7 +259,7 @@ static int fill_tgid(pid_t tgid, struct 
 	 * Accounting subsytems can also add calls here to modify
 	 * fields of taskstats.
 	 */
-
+	put_task_struct(first);
 	return 0;
 }
 

--
