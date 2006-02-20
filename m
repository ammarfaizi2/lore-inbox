Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWBTUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWBTUaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWBTUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:30:52 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:63716 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161169AbWBTUav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:30:51 -0500
Date: Mon, 20 Feb 2006 21:30:50 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove child_reaper arg from choose_new_parent()
Message-ID: <20060220203050.GA5926@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Folks!

unless there is a masterplan behind that, the 
child_reaper argument to choose_new_parent()
is not used but shadows a global value ...

best,
Herbert

------------------

remove the gratuitous child_reaper argument
from choose_new_parent() and adjust the callers

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
---

diff -NurpP linux-2.6.16-rc4/kernel/exit.c linux-2.6.16-rc4-chr/kernel/exit.c
--- linux-2.6.16-rc4/kernel/exit.c	2006-02-18 14:40:37 +0100
+++ linux-2.6.16-rc4-chr/kernel/exit.c	2006-02-20 20:40:05 +0100
@@ -533,7 +533,7 @@ static void exit_mm(struct task_struct *
 	mmput(mm);
 }
 
-static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
+static inline void choose_new_parent(task_t *p, task_t *reaper)
 {
 	/*
 	 * Make sure we're not reparenting to ourselves and that
@@ -640,7 +640,7 @@ static void forget_original_parent(struc
 
 		if (father == p->real_parent) {
 			/* reparent with a reaper, real father it's us */
-			choose_new_parent(p, reaper, child_reaper);
+			choose_new_parent(p, reaper);
 			reparent_thread(p, father, 0);
 		} else {
 			/* reparent ptraced task to its real parent */
@@ -661,7 +661,7 @@ static void forget_original_parent(struc
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
-		choose_new_parent(p, reaper, child_reaper);
+		choose_new_parent(p, reaper);
 		reparent_thread(p, father, 1);
 	}
 }

