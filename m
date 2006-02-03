Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWBCSQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWBCSQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBCSQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:16:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38095 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751307AbWBCSQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:16:30 -0500
Message-ID: <43E3B01A.FCAADD0@tv-sign.ru>
Date: Fri, 03 Feb 2006 22:33:46 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] don't use REMOVE_LINKS/SET_LINKS for reparenting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are places where kernel uses REMOVE_LINKS/SET_LINKS while
changing process's ->parent. Use add_parent/remove_parent instead,
they don't abuse of global process list.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/exit.c~2_LINKS	2006-02-04 00:28:49.000000000 +0300
+++ RC-1/kernel/exit.c	2006-02-04 00:53:54.000000000 +0300
@@ -220,10 +220,10 @@ static void reparent_to_init(void)
 
 	ptrace_unlink(current);
 	/* Reparent to init */
-	REMOVE_LINKS(current);
+	remove_parent(current);
 	current->parent = child_reaper;
 	current->real_parent = child_reaper;
-	SET_LINKS(current);
+	add_parent(current);
 
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
--- RC-1/kernel/ptrace.c~2_LINKS	2006-02-04 00:23:41.000000000 +0300
+++ RC-1/kernel/ptrace.c	2006-02-04 00:53:54.000000000 +0300
@@ -35,9 +35,9 @@ void __ptrace_link(task_t *child, task_t
 	if (child->parent == new_parent)
 		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
-	REMOVE_LINKS(child);
+	remove_parent(child);
 	child->parent = new_parent;
-	SET_LINKS(child);
+	add_parent(child);
 }
  
 /*
@@ -77,9 +77,9 @@ void __ptrace_unlink(task_t *child)
 	child->ptrace = 0;
 	if (!list_empty(&child->ptrace_list)) {
 		list_del_init(&child->ptrace_list);
-		REMOVE_LINKS(child);
+		remove_parent(child);
 		child->parent = child->real_parent;
-		SET_LINKS(child);
+		add_parent(child);
 	}
 
 	ptrace_untrace(child);
