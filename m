Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUFWM1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUFWM1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUFWM1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:27:48 -0400
Received: from gprs214-143.eurotel.cz ([160.218.214.143]:50571 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262418AbUFWM1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:27:46 -0400
Date: Wed, 23 Jun 2004 14:27:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Prepare for SMP suspend
Message-ID: <20040623122733.GA31091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Its very bad idea to freeze migration threads, as it crashes machine
upon next call to "schedule()". In refrigerator, I had one
"wake_up_process()" too many. This fixes it. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- clean/kernel/sched.c	2004-06-22 12:36:47.000000000 +0200
+++ linux/kernel/sched.c	2004-06-22 12:39:00.000000000 +0200
@@ -3558,6 +3558,7 @@
 		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
+		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
 
--- linux.orig/kernel/power/process.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/process.c	2004-06-03 00:27:56.000000000 +0200
@@ -109,7 +109,6 @@
 			wake_up_process(p);
 		} else
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
