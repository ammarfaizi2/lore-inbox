Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVHVW2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVHVW2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVHVW2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:28:10 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751434AbVHVWZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:30 -0400
Date: Mon, 22 Aug 2005 10:49:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [swsusp] Fix process freezing
Message-ID: <20050822084909.GA7411@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix process freezer: thaw processes if something goes wrong and do not
spin in schedule().

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 5d655d6e10c2a7ab291ee24b467fb167828f508a
tree 8dfa9668e66e7006de7f0107698356718beb1e37
parent 847ddd5de8a88b2d47e759bc94186a77140bc673
author <pavel@amd.(none)> Mon, 22 Aug 2005 10:48:24 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 10:48:24 +0200

 kernel/power/process.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -38,7 +38,6 @@ void refrigerator(void)
 	   processes around? */
 	long save;
 	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 
@@ -47,8 +46,10 @@ void refrigerator(void)
 	recalc_sigpending(); /* We sent fake signal, clean it up */
 	spin_unlock_irq(&current->sighand->siglock);
 
-	while (frozen(current))
+	while (frozen(current)) {
+		current->state = TASK_UNINTERRUPTIBLE;
 		schedule();
+	}
 	pr_debug("%s left refrigerator\n", current->comm);
 	current->state = save;
 }
@@ -80,13 +81,28 @@ int freeze_processes(void)
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
-		if (time_after(jiffies, start_time + TIMEOUT)) {
+		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
-			return todo;
+			break;
 		}
 	} while(todo);
 
+	if (todo) {
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p)
+			if (freezing(p)) {
+				pr_debug("  clean up: %s\n", p->comm);
+				p->flags &= ~PF_FREEZE;
+				spin_lock_irqsave(&p->sighand->siglock, flags);
+				recalc_sigpending_tsk(p);
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			}
+		while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+		return todo;
+	}
+
 	printk( "|\n" );
 	BUG_ON(in_atomic());
 	return 0;

-- 
if you have sharp zaurus hardware you don't need... you know my address
