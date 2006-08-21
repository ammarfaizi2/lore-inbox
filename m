Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWHUMma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWHUMma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWHUMma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:42:30 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:16089 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S965083AbWHUMmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:42:19 -0400
Date: Mon, 21 Aug 2006 21:06:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] futex_find_get_task: don't take tasklist_lock
Message-ID: <20060821170621.GA1643@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is ok to do find_task_by_pid() + get_task_struct() under rcu_read_lock(),
we cand drop tasklist_lock.

Note that testing of ->exit_state is racy with or without tasklist anyway.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/futex.c~2_ffgt	2006-08-21 20:32:48.000000000 +0400
+++ 2.6.18-rc4/kernel/futex.c	2006-08-21 20:41:15.000000000 +0400
@@ -389,7 +389,7 @@ static struct task_struct * futex_find_g
 {
 	struct task_struct *p;
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	p = find_task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
@@ -403,7 +403,7 @@ static struct task_struct * futex_find_g
 	}
 	get_task_struct(p);
 out_unlock:
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 
 	return p;
 }

