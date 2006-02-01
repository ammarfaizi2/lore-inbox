Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422860AbWBASaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422860AbWBASaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWBASaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:30:52 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:4273 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1422860AbWBASav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:30:51 -0500
Message-ID: <43E1106B.E1D73FE6@tv-sign.ru>
Date: Wed, 01 Feb 2006 22:47:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] choose_new_parent: remove unused arg, sanitize exit_state check
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'child_reaper' arg is not used in choose_new_parent().

"->exit_state >= EXIT_ZOMBIE" check is a leftover, was
valid when EXIT_ZOMBIE lived in ->state var.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/exit.c~	2006-02-02 01:18:56.000000000 +0300
+++ RC-1/kernel/exit.c	2006-02-02 01:22:09.000000000 +0300
@@ -517,13 +517,13 @@ static void exit_mm(struct task_struct *
 	mmput(mm);
 }
 
-static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
+static inline void choose_new_parent(task_t *p, task_t *reaper)
 {
 	/*
 	 * Make sure we're not reparenting to ourselves and that
 	 * the parent is not a zombie.
 	 */
-	BUG_ON(p == reaper || reaper->exit_state >= EXIT_ZOMBIE);
+	BUG_ON(p == reaper || reaper->exit_state);
 	p->real_parent = reaper;
 }
 
@@ -624,7 +624,7 @@ static void forget_original_parent(struc
 
 		if (father == p->real_parent) {
 			/* reparent with a reaper, real father it's us */
-			choose_new_parent(p, reaper, child_reaper);
+			choose_new_parent(p, reaper);
 			reparent_thread(p, father, 0);
 		} else {
 			/* reparent ptraced task to its real parent */
@@ -645,7 +645,7 @@ static void forget_original_parent(struc
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
-		choose_new_parent(p, reaper, child_reaper);
+		choose_new_parent(p, reaper);
 		reparent_thread(p, father, 1);
 	}
 }
