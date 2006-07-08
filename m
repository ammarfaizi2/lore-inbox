Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWGHPh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWGHPh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 11:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWGHPhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 11:37:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5813 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964871AbWGHPhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 11:37:55 -0400
Date: Sat, 8 Jul 2006 17:37:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: stable@kernel.org, kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, rml@novell.com
Subject: [patch-stable 2.6.16] pdflush: handle resume wakeups
Message-ID: <20060708153731.GB1723@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.16 needs this. It was merged into 2.6.18-rc1 in
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d616e09ab33aa4d013a93c9b393efd5cebf78521 .

pdflush is carefully designed to ensure that all wakeups have some
corresponding work to do - if a woken-up pdflush thread discovers that
it hasn't been given any work to do then this is considered an error.

That all broke when swsusp came along - because a timer-delivered
wakeup to a frozen pdflush thread will just get lost.  This causes the
pdflush thread to get lost as well: the writeback timer is supposed to
be re-armed by pdflush in process context, but pdflush doesn't execute
the callout which does this.

Fix that up by ignoring the return value from try_to_freeze(): jsut
proceed, see if we have any work pending and only go back to sleep if
that is not the case.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Pavel Machek <pavel@suse.cz>

diff -urN linux-suse/mm/pdflush.c linux/mm/pdflush.c
--- linux-suse/mm/pdflush.c	2006-07-06 11:51:11.000000000 -0400
+++ linux/mm/pdflush.c	2006-07-06 11:51:57.000000000 -0400
@@ -104,21 +104,20 @@
 		list_move(&my_work->list, &pdflush_list);
 		my_work->when_i_went_to_sleep = jiffies;
 		spin_unlock_irq(&pdflush_lock);
-
 		schedule();
-		if (try_to_freeze()) {
-			spin_lock_irq(&pdflush_lock);
-			continue;
-		}
-
+		try_to_freeze();
 		spin_lock_irq(&pdflush_lock);
 		if (!list_empty(&my_work->list)) {
-			printk("pdflush: bogus wakeup!\n");
+			/*
+			 * Someone woke us up, but without removing our control
+			 * structure from the global list.  swsusp will do this
+			 * in try_to_freeze()->refrigerator().  Handle it.
+			 */
 			my_work->fn = NULL;
 			continue;
 		}
 		if (my_work->fn == NULL) {
-			printk("pdflush: NULL work function\n");
+			printk("pdflush: bogus wakeup\n");
 			continue;
 		}
 		spin_unlock_irq(&pdflush_lock);


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
