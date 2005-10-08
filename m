Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVJHKEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVJHKEp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVJHKEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:04:45 -0400
Received: from cncln.online.ln.cn ([218.25.172.144]:34829 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750841AbVJHKEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:04:44 -0400
Date: Sat, 8 Oct 2005 18:04:37 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [patch] PF_DEAD cleanup
Message-ID: <20051008100437.GA2799@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The PF_DEAD setting doesn't belong to exit_notify(), move it to a proper place.

		Coywolf


Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

 exit.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- 2.6.14-rc3-cy/kernel/exit.c~orig	2005-10-08 17:03:39.000000000 +0800
+++ 2.6.14-rc3-cy/kernel/exit.c	2005-10-08 17:18:03.000000000 +0800
@@ -783,10 +783,6 @@ static void exit_notify(struct task_stru
 	/* If the process is dead, release it - nobody will wait for it */
 	if (state == EXIT_DEAD)
 		release_task(tsk);
-
-	/* PF_DEAD causes final put_task_struct after we schedule. */
-	preempt_disable();
-	tsk->flags |= PF_DEAD;
 }
 
 fastcall NORET_TYPE void do_exit(long code)
@@ -869,7 +865,10 @@ fastcall NORET_TYPE void do_exit(long co
 	tsk->mempolicy = NULL;
 #endif
 
-	BUG_ON(!(current->flags & PF_DEAD));
+	/* PF_DEAD causes final put_task_struct after we schedule. */
+	preempt_disable();
+	current->flags |= PF_DEAD;
+
 	schedule();
 	BUG();
 	/* Avoid "noreturn function does return".  */
