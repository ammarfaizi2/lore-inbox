Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWC2WKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWC2WKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWC2WKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:10:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63390 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751026AbWC2WKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:10:13 -0500
Date: Thu, 30 Mar 2006 00:09:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, seife@suse.de
Subject: [patch] Fix suspend with traced tasks
Message-ID: <20060329220936.GB1716@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

strace /bin/bash misbehaves after resume; this fixes it.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 8ac7c35..b2a5f67 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -26,8 +26,7 @@ static inline int freezeable(struct task
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
-	    (p->state == TASK_STOPPED) ||
-	    (p->state == TASK_TRACED))
+	    (p->state == TASK_STOPPED))
 		return 0;
 	return 1;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 6b5037a..185b13e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1689,6 +1689,7 @@ static void ptrace_stop(int exit_code, i
 	/* Let the debugger run.  */
 	set_current_state(TASK_TRACED);
 	spin_unlock_irq(&current->sighand->siglock);
+	try_to_freeze();
 	read_lock(&tasklist_lock);
 	if (likely(current->ptrace & PT_PTRACED) &&
 	    likely(current->parent != current->real_parent ||

-- 
Picture of sleeping (Linux) penguin wanted...
