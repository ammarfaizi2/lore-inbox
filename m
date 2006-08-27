Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWH0PAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWH0PAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWH0PAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 11:00:05 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:21732 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932128AbWH0PAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 11:00:01 -0400
Date: Sun, 27 Aug 2006 23:24:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] oom_kill_task: cleanup ->mm checks
Message-ID: <20060827192417.GA2615@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- It is not possible to have task->mm == &init_mm.

- task_lock() buys nothing for 'if (!p->mm)' check.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/mm/oom_kill.c~	2006-08-27 22:28:42.000000000 +0400
+++ 2.6.18-rc4/mm/oom_kill.c	2006-08-27 23:09:09.000000000 +0400
@@ -262,14 +262,11 @@ static void __oom_kill_task(struct task_
 		return;
 	}
 
-	task_lock(p);
-	if (!p->mm || p->mm == &init_mm) {
+	if (!p->mm) {
 		WARN_ON(1);
 		printk(KERN_WARNING "tried to kill an mm-less task!\n");
-		task_unlock(p);
 		return;
 	}
-	task_unlock(p);
 
 	if (message) {
 		printk(KERN_ERR "%s: Killed process %d (%s).\n",
@@ -303,7 +300,7 @@ static int oom_kill_task(struct task_str
 	 * However, this is of no concern to us.
 	 */
 
-	if (mm == NULL || mm == &init_mm)
+	if (mm == NULL)
 		return 1;
 
 	__oom_kill_task(p, message);

