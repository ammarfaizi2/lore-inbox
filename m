Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWDZUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWDZUxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWDZUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:53:10 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:14551 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932421AbWDZUxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:53:09 -0400
Date: Wed, 26 Apr 2006 15:53:07 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] x86_64: fix die_lock nesting
Message-ID: <20060426205307.GA7505@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this when poking around in this area.

BTW, the comments in oops_begin say the operation is racy, and the only
way I can think of that is races is if you get a non-NMI oops then
get an NMI oops within the oops_begin or oops_end functions.
That can actually be fixed using compare-and-swap, but, to tell you
the truth, it just doesn't seem worth it to me.  If you like, though,
I can attempt a fix at that, too.  Anyway, the patch...


The oops_begin() function in x86_64 would only conditionally claim
the die_lock if the call is nested, but oops_end() would always
release the spinlock. This patch adds a nest count for the die lock
so that the release of the lock is only done on the final oops_end().

Signed-off-by: Corey Minyard <minyard@acm.org>

diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 6bda322..debd834 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -384,6 +384,7 @@ void out_of_line_bug(void)
 
 static DEFINE_SPINLOCK(die_lock);
 static int die_owner = -1;
+static unsigned int die_nest_count;
 
 unsigned __kprobes long oops_begin(void)
 {
@@ -398,6 +399,7 @@ unsigned __kprobes long oops_begin(void)
 		else
 			spin_lock(&die_lock);
 	}
+	die_nest_count++;
 	die_owner = cpu;
 	console_verbose();
 	bust_spinlocks(1);
@@ -408,7 +410,13 @@ void __kprobes oops_end(unsigned long fl
 { 
 	die_owner = -1;
 	bust_spinlocks(0);
-	spin_unlock_irqrestore(&die_lock, flags);
+	die_nest_count--;
+	if (die_nest_count)
+		/* We still own the lock */
+		local_irq_restore(flags);
+	else
+		/* Nest count reaches zero, release the lock. */
+		spin_unlock_irqrestore(&die_lock, flags);
 	if (panic_on_oops)
 		panic("Oops");
 }
