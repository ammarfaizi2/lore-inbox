Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752266AbWKAS0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbWKAS0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbWKAS0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:26:55 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:21903 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1752262AbWKAS0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:26:54 -0500
Date: Wed, 1 Nov 2006 21:26:11 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Graf <tgraf@suug.ch>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] taskstats: factor out reply assembling
Message-ID: <20061101182611.GA447@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce mk_reply() helper which does all nla_put()s on reply.

Saves 453 bytes and a preparation for the next patch.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 taskstats.c |   55 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

--- STATS/kernel/taskstats.c~5_factor	2006-10-31 16:33:56.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-11-01 14:00:03.000000000 +0300
@@ -348,6 +348,25 @@ static int parse(struct nlattr *na, cpum
 	return ret;
 }
 
+static int mk_reply(struct sk_buff *skb, int type, u32 pid, struct taskstats *stats)
+{
+	struct nlattr *na;
+	int aggr;
+
+	aggr = TASKSTATS_TYPE_AGGR_TGID;
+	if (type == TASKSTATS_TYPE_PID)
+		aggr = TASKSTATS_TYPE_AGGR_PID;
+
+	na = nla_nest_start(skb, aggr);
+	NLA_PUT_U32(skb, type, pid);
+	NLA_PUT_TYPE(skb, struct taskstats, TASKSTATS_TYPE_STATS, *stats);
+	nla_nest_end(skb, na);
+
+	return 0;
+nla_put_failure:
+	return -1;
+}
+
 static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
@@ -355,7 +374,6 @@ static int taskstats_user_cmd(struct sk_
 	struct taskstats stats;
 	void *reply;
 	size_t size;
-	struct nlattr *na;
 	cpumask_t mask;
 
 	rc = parse(info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK], &mask);
@@ -387,27 +405,21 @@ static int taskstats_user_cmd(struct sk_
 		if (rc < 0)
 			goto err;
 
-		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
-		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
-		NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
-				stats);
+		if (mk_reply(rep_skb, TASKSTATS_TYPE_PID, pid, &stats))
+			goto nla_put_failure;
 	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
 		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
 		rc = fill_tgid(tgid, NULL, &stats);
 		if (rc < 0)
 			goto err;
 
-		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
-		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, tgid);
-		NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
-				stats);
+		if (mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tgid, &stats))
+			goto nla_put_failure;
 	} else {
 		rc = -EINVAL;
 		goto err;
 	}
 
-	nla_nest_end(rep_skb, na);
-
 	return send_reply(rep_skb, info->snd_pid);
 
 nla_put_failure:
@@ -451,7 +463,6 @@ void taskstats_exit(struct task_struct *
 	void *reply;
 	size_t size;
 	int is_thread_group;
-	struct nlattr *na;
 
 	if (!family_registered)
 		return;
@@ -486,27 +497,17 @@ void taskstats_exit(struct task_struct *
 	if (rc < 0)
 		goto err_skb;
 
-	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
-	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, (u32)tsk->pid);
-	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
-			*tidstats);
-	nla_nest_end(rep_skb, na);
-
-	if (!is_thread_group)
-		goto send;
+	if (mk_reply(rep_skb, TASKSTATS_TYPE_PID, tsk->pid, tidstats))
+		goto nla_put_failure;
 
 	/*
 	 * Doesn't matter if tsk is the leader or the last group member leaving
 	 */
-	if (!group_dead)
+	if (!is_thread_group || !group_dead)
 		goto send;
 
-	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
-	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
-	/* No locking needed for tsk->signal->stats since group is dead */
-	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
-			*tsk->signal->stats);
-	nla_nest_end(rep_skb, na);
+	if (mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tsk->tgid, tsk->signal->stats))
+		goto nla_put_failure;
 
 send:
 	send_cpu_listeners(rep_skb, listeners);

