Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSIEP0Y>; Thu, 5 Sep 2002 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSIEP0X>; Thu, 5 Sep 2002 11:26:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13278 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317619AbSIEP0X>;
	Thu, 5 Sep 2002 11:26:23 -0400
Date: Thu, 5 Sep 2002 17:35:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Daniel Jacobowitz <dan@debian.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [patch] ptrace-fix-2.5.33-A1
Message-ID: <Pine.LNX.4.44.0209051728490.18985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

the attached patch (against BK-curr) collects two ptrace related fixes:  
first it undoes Ogawa's change (so various uses of ptrace works again),
plus it adds Daniel's suggested fix that allows a parent to PTRACE_ATTACH
to a child it forked. (this also fixes the incorrect BUG_ON() assert
Ogawa's patch was intended to fix in the first place.)

i've tested various ptrace uses and they appear to work just fine.

(Daniel, let us know if you can still see anything questionable in this
area - or if the ptrace list could be managed in a cleaner way.)

please apply,

	Ingo

--- linux/kernel/exit.c.orig	Thu Sep  5 17:25:47 2002
+++ linux/kernel/exit.c	Thu Sep  5 17:27:06 2002
@@ -66,7 +66,8 @@
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
-	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
+	BUG_ON(p->ptrace || !list_empty(&p->ptrace_list) ||
+					!list_empty(&p->ptrace_children));
 	unhash_process(p);
 
 	release_thread(p);
@@ -718,8 +719,14 @@
 					ptrace_unlink(p);
 					do_notify_parent(p, SIGCHLD);
 					write_unlock_irq(&tasklist_lock);
-				} else
+				} else {
+					if (p->ptrace) {
+						write_lock_irq(&tasklist_lock);
+						ptrace_unlink(p);
+						write_unlock_irq(&tasklist_lock);
+					}
 					release_task(p);
+				}
 				goto end_wait4;
 			default:
 				continue;
--- linux/kernel/ptrace.c.orig	Thu Sep  5 17:28:40 2002
+++ linux/kernel/ptrace.c	Thu Sep  5 17:28:47 2002
@@ -29,7 +29,7 @@
 	if (!list_empty(&child->ptrace_list))
 		BUG();
 	if (child->parent == new_parent)
-		BUG();
+		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
 	REMOVE_LINKS(child);
 	child->parent = new_parent;

