Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWBPRcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWBPRcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWBPRcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:32:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26324 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932310AbWBPRca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:32:30 -0500
Message-ID: <43F4C951.D3724CF4@tv-sign.ru>
Date: Thu, 16 Feb 2006 21:49:53 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] release_task: replace open-coded ptrace_unlink()
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use ptrace_unlink() instead of open-coding.
No changes in kernel/exit.o

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/exit.c~	2006-02-17 00:03:30.000000000 +0300
+++ 2.6.16-rc3/kernel/exit.c	2006-02-17 00:05:25.000000000 +0300
@@ -66,13 +66,12 @@ void release_task(struct task_struct * p
 	task_t *leader;
 	struct dentry *proc_dentry;
 
-repeat: 
+repeat:
 	atomic_dec(&p->user->processes);
 	spin_lock(&p->proc_lock);
 	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
-	if (unlikely(p->ptrace))
-		__ptrace_unlink(p);
+	ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
 	/*
