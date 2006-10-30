Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161519AbWJ3ViJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519AbWJ3ViJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161520AbWJ3ViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:38:09 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:38346 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1161519AbWJ3ViG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:38:06 -0500
Date: Tue, 31 Oct 2006 00:37:49 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] taskstats: fix sub-threads accounting
Message-ID: <20061030213749.GA3035@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there are no listeners, taskstats_exit_send() just returns because
taskstats_exit_alloc() didn't allocate *tidstats. This is wrong, each
sub-thread should do fill_tgid_exit() on exit, otherwise its ->delays
is not recorded in ->signal->stats and lost.

Q: We don't send TASKSTATS_TYPE_AGGR_TGID when single-threaded process
exits. Is it good? How can the listener figure out that it was actually
a process exit, not sub-thread?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~2_send	2006-10-30 23:47:46.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-10-31 00:14:42.000000000 +0300
@@ -446,10 +446,9 @@ void taskstats_exit_send(struct task_str
 	int is_thread_group;
 	struct nlattr *na;
 
-	if (!family_registered || !tidstats)
+	if (!family_registered)
 		return;
 
-	rc = 0;
 	/*
 	 * Size includes space for nested attributes
 	 */
@@ -457,8 +456,15 @@ void taskstats_exit_send(struct task_str
 		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
 
 	is_thread_group = (tsk->signal->stats != NULL);
-	if (is_thread_group)
-		size = 2 * size;	/* PID + STATS + TGID + STATS */
+	if (is_thread_group) {
+		/* PID + STATS + TGID + STATS */
+		size = 2 * size;
+		/* fill the tsk->signal->stats structure */
+		fill_tgid_exit(tsk);
+	}
+
+	if (!tidstats)
+		return;
 
 	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
 	if (rc < 0)
@@ -478,11 +484,8 @@ void taskstats_exit_send(struct task_str
 		goto send;
 
 	/*
-	 * tsk has/had a thread group so fill the tsk->signal->stats structure
 	 * Doesn't matter if tsk is the leader or the last group member leaving
 	 */
-
-	fill_tgid_exit(tsk);
 	if (!group_dead)
 		goto send;
 

