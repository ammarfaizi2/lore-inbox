Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSIARdq>; Sun, 1 Sep 2002 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSIARdq>; Sun, 1 Sep 2002 13:33:46 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:28177 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317298AbSIARdp>; Sun, 1 Sep 2002 13:33:45 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove BUG_ON(p->ptrace) in release_task()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 02 Sep 2002 02:38:03 +0900
Message-ID: <87fzwthapw.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think, BUG_ON(p->ptrace) will be called if the CLONE_DETACH process
is traced.  This patch removes BUG_ON(p->ptrace), and also removes
BUG_ON(p->ptrace) workaround in sys_wait4().

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-2.5.33/kernel/exit.c~	2002-09-02 01:02:07.000000000 +0900
+++ linux-2.5.33/kernel/exit.c	2002-09-02 00:54:47.000000000 +0900
@@ -66,8 +66,7 @@
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
-	BUG_ON(p->ptrace || !list_empty(&p->ptrace_list) ||
-					!list_empty(&p->ptrace_children));
+	BUG_ON(!list_empty(&p->ptrace_list)||!list_empty(&p->ptrace_children));
 	unhash_process(p);
 
 	release_thread(p);
@@ -717,14 +716,8 @@
 					ptrace_unlink(p);
 					do_notify_parent(p, SIGCHLD);
 					write_unlock_irq(&tasklist_lock);
-				} else {
-					if (p->ptrace) {
-						write_lock_irq(&tasklist_lock);
-						ptrace_unlink(p);
-						write_unlock_irq(&tasklist_lock);
-					}
+				} else
 					release_task(p);
-				}
 				goto end_wait4;
 			default:
 				continue;
