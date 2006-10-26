Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945988AbWJZXVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945988AbWJZXVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945989AbWJZXVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:21:08 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:60805 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1945984AbWJZXVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:21:04 -0400
Date: Fri, 27 Oct 2006 03:20:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] fill_tgid: fix task_struct leak and possible oops
Message-ID: <20061026232052.GA520@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. fill_tgid() forgets to do put_task_struct(first).

2. release_task(first) can happen after fill_tgid() drops tasklist_lock,
   it is unsafe to dereference first->signal.

This is a temporary fix, imho the locking should be reworked.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~1_fix_sig	2006-10-22 18:24:03.000000000 +0400
+++ STATS/kernel/taskstats.c	2006-10-26 23:44:32.000000000 +0400
@@ -237,14 +237,17 @@ static int fill_tgid(pid_t tgid, struct 
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
@@ -264,7 +267,7 @@ static int fill_tgid(pid_t tgid, struct 
 	 * Accounting subsytems can also add calls here to modify
 	 * fields of taskstats.
 	 */
-
+	put_task_struct(first);
 	return 0;
 }
 

