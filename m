Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWBNKK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWBNKK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWBNKK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:10:57 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:31210 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030272AbWBNKK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:10:56 -0500
Date: Tue, 14 Feb 2006 11:10:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 01/12] hrtimer: round up relative start time
Message-ID: <Pine.LNX.4.61.0602141056490.2674@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When starting a relative timer we have to round it up the next clock
tick to avoid an early expiry. The problem is that we don't know the
real clock resolution, so we have to assume the worst case, but it's
basically the same as the old code did, so it won't be worse than 2.6.15
and with a better clock interface we can improve this.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/hrtimer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-13 22:29:45.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-13 22:29:51.000000000 +0100
@@ -419,7 +419,8 @@ hrtimer_start(struct hrtimer *timer, kti
 	new_base = switch_hrtimer_base(timer, base);
 
 	if (mode == HRTIMER_REL)
-		tim = ktime_add(tim, new_base->get_time());
+		tim = ktime_add(ktime_add(tim, new_base->get_time()),
+				base->resolution);
 	timer->expires = tim;
 
 	enqueue_hrtimer(timer, new_base);
