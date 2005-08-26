Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbVHZJkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbVHZJkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 05:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVHZJkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 05:40:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55500 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751514AbVHZJkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 05:40:00 -0400
Date: Fri, 26 Aug 2005 11:39:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Fix process freezing
Message-ID: <20050826093948.GA1887@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If process freezing fails, some processes are frozen, and rest are
left in "were asked to be frozen" state. Thats wrong, we should leave
it in some consistent state.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux-mm/kernel/power/process.c	2005-08-24 20:25:11.000000000 +0200
+++ linux/kernel/power/process.c	2005-08-26 11:30:40.000000000 +0200
@@ -81,13 +81,33 @@
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
 
+	/* This does not unfreeze processes that are already frozen
+	 * (we have slightly ugly calling convention in that respect,
+	 * and caller must call thaw_processes() if something fails),
+	 * but it cleans up leftover PF_FREEZE requests.
+	 */
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
