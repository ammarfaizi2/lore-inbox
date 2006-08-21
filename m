Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWHUMmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWHUMmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWHUMmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:42:05 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:10201 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S965074AbWHUMmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:42:03 -0400
Date: Mon, 21 Aug 2006 21:06:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060821170604.GA1640@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Compile tested).

futex_find_get_task:

	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE)
		return NULL;

I can't understand this. First, p->state can't be EXIT_ZOMBIE. The ->exit_state
check looks strange too. Sub-threads or tasks whose ->parent ignores SIGCHLD go
directly to EXIT_DEAD state (I am ignoring a ptrace case). Why EXIT_DEAD tasks
should be ok? Yes, EXIT_ZOMBIE is more important (a task may stay zombie for a
long time), but this doesn't mean we should explicitely ignore other EXIT_XXX
states.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/futex.c~1_zomb	2006-08-21 18:45:43.000000000 +0400
+++ 2.6.18-rc4/kernel/futex.c	2006-08-21 20:32:48.000000000 +0400
@@ -397,7 +397,7 @@ static struct task_struct * futex_find_g
 		p = NULL;
 		goto out_unlock;
 	}
-	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE) {
+	if (p->exit_state != 0) {
 		p = NULL;
 		goto out_unlock;
 	}

