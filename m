Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUKVCpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUKVCpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 21:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUKVCpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 21:45:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:63140 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261900AbUKVCpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 21:45:07 -0500
Subject: [PATCH] del_timer() vs. mod_timer() SMP race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 13:44:05 +1100
Message-Id: <1101091445.13612.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

We just spent some days fighting a rare race in one of the distro's who backported
some of timer.c from 2.6 to 2.4 (though they missed a bit).

The actual race we found didn't happen in 2.6 _but_ code inspection showed that a
similar race is still present in 2.6, explanation below:

Code removing a timer from a list (run_timers or del_timer) takes that CPU list
lock, does list_del, then timer->base = NULL.

It is mandatory that this timer->base = NULL is visible to other CPUs only after
the list_del() is complete. If not, then mod timer could see it NULL, thus take it's
own CPU list lock and not the one for the CPU the timer was beeing removed from the
list, and thus the list_add in mod_timer() could race with the list_del() from
run_timers() or del_timer().

Our race happened with run_timers(), which _DOES_ contain a proper smp_wmb() in the
right spot in 2.6, but didn't in the "backport" we were fighting with.

However, del_timer() doesn't have such a barrier, and thus is subject to this race in
2.6 as well. This patch fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/timer.c
===================================================================
--- linux-work.orig/kernel/timer.c	2004-11-22 11:50:59.000000000 +1100
+++ linux-work/kernel/timer.c	2004-11-22 13:35:38.928448032 +1100
@@ -308,6 +308,7 @@
 		goto repeat;
 	}
 	list_del(&timer->entry);
+	smp_wmb();
 	timer->base = NULL;
 	spin_unlock_irqrestore(&base->lock, flags);
 


