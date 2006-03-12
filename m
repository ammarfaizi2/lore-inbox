Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWCLQ5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWCLQ5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWCLQ5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:57:37 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2282
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751549AbWCLQ5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:57:36 -0500
Subject: [patch] hrtimer remove replace state check by BUG_ON
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1142180796.19916.497.camel@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
	 <1142169010.19916.397.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121422180.16802@scrub.home>
	 <1142170505.19916.402.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121444530.16802@scrub.home>
	 <1142172917.19916.421.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121523320.16802@scrub.home>
	 <1142175286.19916.459.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121608440.17704@scrub.home>
	 <1142178108.19916.475.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121650230.16802@scrub.home>
	 <1142180796.19916.497.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 17:57:57 +0100
Message-Id: <1142182678.19916.514.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rework of the hrtimer code showed a hard to track sporadic problem
on a testers machine. The !hrtimer_active check in the return path of
the timer callback function prevents requeueing of an enqueued timer.
Replace the check by a BUG_ON to get more info about this not yet
verified problem instead of hiding it away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -631,9 +631,10 @@ static inline void run_hrtimer_queue(str
 
 		spin_lock_irq(&base->lock);
 
-		if (restart != HRTIMER_NORESTART &&
-		    !hrtimer_active(timer))
+		if (restart != HRTIMER_NORESTART) {
+			BUG_ON(hrtimer_active(timer));
 			enqueue_hrtimer(timer, base);
+		}
 	}
 	set_curr_timer(base, NULL);
 	spin_unlock_irq(&base->lock);




