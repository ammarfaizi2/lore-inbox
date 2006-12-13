Return-Path: <linux-kernel-owner+w=401wt.eu-S964874AbWLMLUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWLMLUI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWLMLTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57332 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848AbWLMLTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:35 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/12] signal: Rewrite kill_something_info so it uses newer helpers.
Date: Wed, 13 Dec 2006 04:07:49 -0700
Message-Id: <11660080772552-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The goal is to remove users of the old signal helper functions
so they can be removed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/signal.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 1921ffd..1e34d32 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1192,8 +1192,10 @@ EXPORT_SYMBOL_GPL(kill_pid_info_as_uid);
 
 static int kill_something_info(int sig, struct siginfo *info, int pid)
 {
+	int ret;
+	rcu_read_lock();
 	if (!pid) {
-		return kill_pg_info(sig, info, process_group(current));
+		ret = kill_pgrp_info(sig, info, task_pgrp(current));
 	} else if (pid == -1) {
 		int retval = 0, count = 0;
 		struct task_struct * p;
@@ -1208,12 +1210,14 @@ static int kill_something_info(int sig, struct siginfo *info, int pid)
 			}
 		}
 		read_unlock(&tasklist_lock);
-		return count ? retval : -ESRCH;
+		ret = count ? retval : -ESRCH;
 	} else if (pid < 0) {
-		return kill_pg_info(sig, info, -pid);
+		ret = kill_pgrp_info(sig, info, find_pid(-pid));
 	} else {
-		return kill_proc_info(sig, info, pid);
+		ret = kill_pid_info(sig, info, find_pid(pid));
 	}
+	rcu_read_unlock();
+	return ret;
 }
 
 /*
-- 
1.4.4.1.g278f

