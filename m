Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269754AbUJALPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269754AbUJALPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269757AbUJALPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:15:25 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:2465 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S269754AbUJALPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:15:19 -0400
Message-ID: <415D3DD4.E440AB5B@tv-sign.ru>
Date: Fri, 01 Oct 2004 15:21:56 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/2] detach_pid(): restore optimization
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kirill's kernel/pid.c rework broke optimization logic in detach_pid().
Non zero return from __detach_pid() was used to indicate, that this pid
can probably be freed. Current version always (modulo idle threads)
return non zero value, thus resulting in unneccesary pid_hash scanning.

Also, uninlining __detach_pid() reduces pid.o text size from 2492 to 1600
bytes.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.9-rc3/kernel/pid.c~	Thu Sep 30 15:05:25 2004
+++ 2.6.9-rc3/kernel/pid.c	Fri Oct  1 11:26:11 2004
@@ -178,15 +178,18 @@ int fastcall attach_pid(task_t *task, en
 	return 0;
 }
 
-static inline int __detach_pid(task_t *task, enum pid_type type)
+static fastcall int __detach_pid(task_t *task, enum pid_type type)
 {
 	struct pid *pid, *pid_next;
-	int nr;
+	int nr = 0;
 
 	pid = &task->pids[type];
 	if (!hlist_unhashed(&pid->pid_chain)) {
 		hlist_del(&pid->pid_chain);
-		if (!list_empty(&pid->pid_list)) {
+
+		if (list_empty(&pid->pid_list))
+			nr = pid->nr;
+		else {
 			pid_next = list_entry(pid->pid_list.next,
 						struct pid, pid_list);
 			/* insert next pid from pid_list to hash */
@@ -194,8 +197,8 @@ static inline int __detach_pid(task_t *t
 				&pid_hash[type][pid_hashfn(pid_next->nr)]);
 		}
 	}
+
 	list_del(&pid->pid_list);
-	nr = pid->nr;
 	pid->nr = 0;
 
 	return nr;
