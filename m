Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWA3NQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWA3NQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWA3NQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:16:53 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58063 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932202AbWA3NQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:16:52 -0500
Message-ID: <43DE23D6.2B9DCB5A@tv-sign.ru>
Date: Mon, 30 Jan 2006 17:33:58 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] pidhash: temporal debug checks
References: <43DDF351.2EFD1280@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Rediff after fixing a bug in [PATCH 1/3])

[PATCH 3/3] pidhash: temporal debug checks

This is for testing in -mm tree only. Ensure that we really do
not use pid == 0.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/pid.c~DBG	2006-01-30 14:21:15.000000000 +0300
+++ RC-1/kernel/pid.c	2006-01-30 20:06:35.000000000 +0300
@@ -138,6 +138,7 @@ struct pid * fastcall find_pid(enum pid_
 
 	hlist_for_each_entry_rcu(pid, elem,
 			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
+		WARN_ON(!pid->nr); /* to be removed soon */
 		if (pid->nr == nr)
 			return pid;
 	}
@@ -148,6 +149,9 @@ int fastcall attach_pid(task_t *task, en
 {
 	struct pid *pid, *task_pid;
 
+	WARN_ON(!task->pid); /* to be removed soon */
+	WARN_ON(!nr); /* to be removed soon */
+
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
 	task_pid->nr = nr;
@@ -168,9 +172,11 @@ static fastcall int __detach_pid(task_t 
 	struct pid *pid, *pid_next;
 	int nr = 0;
 
+	WARN_ON(!task->pid); /* to be removed soon */
+
 	pid = &task->pids[type];
 	if (!hlist_unhashed(&pid->pid_chain)) {
-
+		WARN_ON(!pid->nr); /* to be removed soon */
 		if (list_empty(&pid->pid_list)) {
 			nr = pid->nr;
 			hlist_del_rcu(&pid->pid_chain);
--- RC-1/kernel/fork.c~DBG	2006-01-30 19:52:59.000000000 +0300
+++ RC-1/kernel/fork.c	2006-01-30 20:06:22.000000000 +0300
@@ -1211,6 +1211,7 @@ task_t * __devinit fork_idle(int cpu)
 	if (!task)
 		return ERR_PTR(-ENOMEM);
 
+	WARN_ON(task->proc_dentry); /* to be removed soon */
 	REMOVE_LINKS(task);
 	init_idle(task, cpu);
