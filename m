Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbRGFMna>; Fri, 6 Jul 2001 08:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266679AbRGFMnU>; Fri, 6 Jul 2001 08:43:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:43882 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266678AbRGFMnJ>; Fri, 6 Jul 2001 08:43:09 -0400
Date: Fri, 6 Jul 2001 14:43:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thibaut Laurent <thibaut@celestix.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010706144311.J2425@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random> <3B447B6D.C83E5FB9@redhat.com> <20010705164046.S17051@athlon.random> <20010705233200.7ead91d5.thibaut@celestix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010705233200.7ead91d5.thibaut@celestix.com>; from thibaut@celestix.com on Thu, Jul 05, 2001 at 11:32:00PM +0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> And the winner is... Andrea. Kudos to you, I've just applied these patches,
> recompiled and it seems to work fine.

can you apply this patch on top of the ksoftirqd patch and see if you
can trigger the BUG() again when based on pre2? (I want to make sure to
be as strict as mainline) Then if you apply the same patches on top of
pre3 the BUG() should go away.

--- 2.4.7pre2aa1/kernel/softirq.c.~1~	Thu Jul  5 17:13:47 2001
+++ 2.4.7pre2aa1/kernel/softirq.c	Fri Jul  6 14:39:49 2001
@@ -173,7 +173,8 @@
 		if (!tasklet_trylock(t))
 			BUG();
 		if (!atomic_read(&t->count)) {
-			clear_bit(TASKLET_STATE_SCHED, &t->state);
+			if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				BUG();
 			t->func(t->data);
 			tasklet_unlock(t);
 			continue;
@@ -210,7 +211,8 @@
 		if (!tasklet_trylock(t))
 			BUG();
 		if (!atomic_read(&t->count)) {
-			clear_bit(TASKLET_STATE_SCHED, &t->state);
+			if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				BUG();
 			t->func(t->data);
 			tasklet_unlock(t);
 			continue;


Thanks!

Andrea
