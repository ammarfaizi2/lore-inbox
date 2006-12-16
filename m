Return-Path: <linux-kernel-owner+w=401wt.eu-S932630AbWLPUkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWLPUkf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWLPUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:40:35 -0500
Received: from mail.screens.ru ([213.234.233.54]:60297 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932630AbWLPUke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:40:34 -0500
Date: Sat, 16 Dec 2006 23:06:02 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-lkml@gmx.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kill_something_info: really ignore -EPERM
Message-ID: <20061216200602.GA5538@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kill(-1, sig) returns 0 if it has found some processes but there
is no one for which we have permission to send the signal.

Doesn't it make more sense to return -ESRCH in this case?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- eric-mm1/kernel/signal.c~2_perm	2006-12-16 22:17:52.000000000 +0300
+++ eric-mm1/kernel/signal.c	2006-12-16 22:22:48.000000000 +0300
@@ -1326,20 +1326,16 @@ static int kill_something_info(int sig, 
 		ret = kill_pid_info(sig, info, find_pid(pid));
 	} else if (pid == -1) {
 		struct task_struct *p;
-		int found = 0;
 
-		ret = 0;
+		ret = -ESRCH;
 		read_lock(&tasklist_lock);
 		for_each_process(p)
 			if (!is_init(p) && p != current->group_leader) {
 				int err = group_send_sig_info(sig, info, p);
 				if (err != -EPERM)
 					ret = err;
-				found = 1;
 			}
 		read_unlock(&tasklist_lock);
-		if (!found)
-			ret = -ESRCH;
 	} else {
 		struct pid *grp = task_pgrp(current);
 		if (pid != 0)

