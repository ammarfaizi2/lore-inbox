Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752531AbWKBNEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWKBNEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbWKBNEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:04:20 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:24984 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1752531AbWKBNET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:04:19 -0500
Date: Thu, 2 Nov 2006 16:03:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Graf <tgraf@suug.ch>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] taskstats: cleanup reply assembling
Message-ID: <20061102130338.GA3381@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:
>
> nla_nest_start() may return NULL, either rely on prepare_reply() to be
> correct and BUG() on failure or do proper error handling for all
> functions.

nla_put() in taskstat.c can fail only if the 'size' argument of alloc_skb()
was not right. This is a kernel bug, we should not hide it. So add 'BUG()'
on error path and check for 'na == NULL'.

> genlmsg_cancel() is only required in error paths for dumping
> procedures.

So we can remove 'genlmsg_cancel()' calls and 'void *reply' (saves 227 bytes).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~1_nla_bug	2006-11-01 21:14:39.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-11-02 15:46:44.000000000 +0300
@@ -69,7 +69,7 @@ enum actions {
 };
 
 static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
-			void **replyp, size_t size)
+				size_t size)
 {
 	struct sk_buff *skb;
 	void *reply;
@@ -99,7 +99,6 @@ static int prepare_reply(struct genl_inf
 	}
 
 	*skbp = skb;
-	*replyp = reply;
 	return 0;
 }
 
@@ -361,6 +360,8 @@ static struct taskstats *mk_reply(struct
 		aggr = TASKSTATS_TYPE_AGGR_PID;
 
 	na = nla_nest_start(skb, aggr);
+	if (!na)
+		goto err;
 	if (nla_put(skb, type, sizeof(pid), &pid) < 0)
 		goto err;
 	ret = nla_reserve(skb, TASKSTATS_TYPE_STATS, sizeof(struct taskstats));
@@ -370,6 +371,7 @@ static struct taskstats *mk_reply(struct
 
 	return nla_data(ret);
 err:
+	BUG();
 	return NULL;
 }
 
@@ -378,7 +380,6 @@ static int taskstats_user_cmd(struct sk_
 	int rc = 0;
 	struct sk_buff *rep_skb;
 	struct taskstats *stats;
-	void *reply;
 	size_t size;
 	cpumask_t mask;
 
@@ -400,7 +401,7 @@ static int taskstats_user_cmd(struct sk_
 	size = nla_total_size(sizeof(u32)) +
 		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
 
-	rc = prepare_reply(info, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
+	rc = prepare_reply(info, TASKSTATS_CMD_NEW, &rep_skb, size);
 	if (rc < 0)
 		return rc;
 
@@ -409,27 +410,24 @@ static int taskstats_user_cmd(struct sk_
 		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
 		stats = mk_reply(rep_skb, TASKSTATS_TYPE_PID, pid);
 		if (!stats)
-			goto nla_err;
+			goto err;
 
 		rc = fill_pid(pid, NULL, stats);
 		if (rc < 0)
-			goto nla_err;
+			goto err;
 	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
 		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
 		stats = mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tgid);
 		if (!stats)
-			goto nla_err;
+			goto err;
 
 		rc = fill_tgid(tgid, NULL, stats);
 		if (rc < 0)
-			goto nla_err;
+			goto err;
 	} else
 		goto err;
 
 	return send_reply(rep_skb, info->snd_pid);
-
-nla_err:
-	genlmsg_cancel(rep_skb, reply);
 err:
 	nlmsg_free(rep_skb);
 	return rc;
@@ -466,7 +464,6 @@ void taskstats_exit(struct task_struct *
 	struct listener_list *listeners;
 	struct taskstats *stats;
 	struct sk_buff *rep_skb;
-	void *reply;
 	size_t size;
 	int is_thread_group;
 
@@ -491,17 +488,17 @@ void taskstats_exit(struct task_struct *
 	if (list_empty(&listeners->list))
 		return;
 
-	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, size);
 	if (rc < 0)
 		return;
 
 	stats = mk_reply(rep_skb, TASKSTATS_TYPE_PID, tsk->pid);
 	if (!stats)
-		goto nla_err;
+		goto err;
 
 	rc = fill_pid(tsk->pid, tsk, stats);
 	if (rc < 0)
-		goto nla_err;
+		goto err;
 
 	/*
 	 * Doesn't matter if tsk is the leader or the last group member leaving
@@ -511,16 +508,14 @@ void taskstats_exit(struct task_struct *
 
 	stats = mk_reply(rep_skb, TASKSTATS_TYPE_TGID, tsk->tgid);
 	if (!stats)
-		goto nla_err;
+		goto err;
 
 	memcpy(stats, tsk->signal->stats, sizeof(*stats));
 
 send:
 	send_cpu_listeners(rep_skb, listeners);
 	return;
-
-nla_err:
-	genlmsg_cancel(rep_skb, reply);
+err:
 	nlmsg_free(rep_skb);
 }
 

