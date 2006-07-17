Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWGQQcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWGQQcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWGQQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:9915 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750961AbWGQQcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:36 -0400
Date: Mon, 17 Jul 2006 09:28:11 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, rml@novell.com,
       Pavel Machek <pavel@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 28/45] pdflush: handle resume wakeups
Message-ID: <20060717162811.GC4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pdflush-handle-resume-wakeups.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 mm/pdflush.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.17.6.orig/mm/pdflush.c
+++ linux-2.6.17.6/mm/pdflush.c
@@ -104,21 +104,20 @@ static int __pdflush(struct pdflush_work
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
