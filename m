Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWCST3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWCST3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWCST3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:29:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:34763 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750708AbWCST3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:29:09 -0500
Message-ID: <441DB048.A8349576@tv-sign.ru>
Date: Sun, 19 Mar 2006 22:26:00 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup next_tid()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to make next_tid() a bit more readable
and deletes unnecessary "pid_alive(pos)" check.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/proc/base.c~	2006-03-20 00:02:08.000000000 +0300
+++ MM/fs/proc/base.c	2006-03-20 00:52:02.000000000 +0300
@@ -2215,15 +2215,15 @@ out:
  */
 static struct task_struct *next_tid(struct task_struct *start)
 {
-	struct task_struct *pos;
+	struct task_struct *pos = NULL;
 	rcu_read_lock();
-	pos = start;
-	if (pid_alive(start))
-		pos = next_thread(start);
-	if (pid_alive(pos) && (pos != start->group_leader))
-		get_task_struct(pos);
-	else
-		pos = NULL;
+	if (pid_alive(start)) {
+		pos = next_thread(start);
+		if (thread_group_leader(pos))
+			pos = NULL;
+		else
+			get_task_struct(pos);
+	}
 	rcu_read_unlock();
 	put_task_struct(start);
 	return pos;
