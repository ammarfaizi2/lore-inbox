Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbWLPUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWLPUXW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWLPUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:23:22 -0500
Received: from mail.screens.ru ([213.234.233.54]:41270 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbWLPUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:23:21 -0500
X-Greylist: delayed 1060 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 15:23:21 EST
Date: Sat, 16 Dec 2006 23:23:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kill_pid_info: kill acquired_tasklist_lock
Message-ID: <20061216202308.GA6125@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill acquired_tasklist_lock, sig_needs_tasklist() is very cheap nowadays.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- eric-mm1/kernel/signal.c~3_kpi	2006-12-16 22:22:48.000000000 +0300
+++ eric-mm1/kernel/signal.c	2006-12-16 23:14:05.000000000 +0300
@@ -1247,19 +1247,18 @@ int kill_pgrp_info(int sig, struct sigin
 int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
 {
 	int error;
-	int acquired_tasklist_lock = 0;
 	struct task_struct *p;
 
 	rcu_read_lock();
-	if (unlikely(sig_needs_tasklist(sig))) {
+	if (unlikely(sig_needs_tasklist(sig)))
 		read_lock(&tasklist_lock);
-		acquired_tasklist_lock = 1;
-	}
+
 	p = pid_task(pid, PIDTYPE_PID);
 	error = -ESRCH;
 	if (p)
 		error = group_send_sig_info(sig, info, p);
-	if (unlikely(acquired_tasklist_lock))
+
+	if (unlikely(sig_needs_tasklist(sig)))
 		read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 	return error;

