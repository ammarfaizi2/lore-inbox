Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUKIPwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUKIPwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUKIPwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:52:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35799 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261557AbUKIPtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:49:32 -0500
Message-ID: <4190F55E.DF508D9F@tv-sign.ru>
Date: Tue, 09 Nov 2004 19:50:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] don't hide thread_group_leader() from grep
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial. replace open-coded thread_group_leader() calls.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc1/fs/binfmt_elf.c~	2004-11-08 19:43:28.000000000 +0300
+++ 2.6.10-rc1/fs/binfmt_elf.c	2004-11-09 21:32:09.331095272 +0300
@@ -1181,7 +1181,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_ppid = p->parent->pid;
 	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->signal->session;
-	if (p->pid == p->tgid) {
+	if (thread_group_leader(p)) {
 		/*
 		 * This is the record for the group leader.  Add in the
 		 * cumulative times of previous dead threads.  This total
--- 2.6.10-rc1/fs/exec.c~	2004-11-08 19:43:29.000000000 +0300
+++ 2.6.10-rc1/fs/exec.c	2004-11-09 22:10:56.767271192 +0300
@@ -605,7 +605,7 @@ static inline int de_thread(struct task_
 	 * Account for the thread group leader hanging around:
 	 */
 	count = 2;
-	if (current->pid == current->tgid)
+	if (thread_group_leader(current))
 		count = 1;
 	while (atomic_read(&sig->count) > count) {
 		sig->group_exit_task = current;
@@ -624,7 +624,7 @@ static inline int de_thread(struct task_
 	 * do is to wait for the thread group leader to become inactive,
 	 * and to assume its PID:
 	 */
-	if (current->pid != current->tgid) {
+	if (!thread_group_leader(current)) {
 		struct task_struct *leader = current->group_leader, *parent;
 		struct dentry *proc_dentry1, *proc_dentry2;
 		unsigned long exit_state, ptrace;
@@ -734,7 +734,7 @@ no_thread_group:
 
 	if (!thread_group_empty(current))
 		BUG();
-	if (current->tgid != current->pid)
+	if (!thread_group_leader(current))
 		BUG();
 	return 0;
 }
