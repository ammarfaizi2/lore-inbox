Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWGCBN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWGCBN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWGCBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:13:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50360 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750797AbWGCBNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:13:55 -0400
Date: Mon, 3 Jul 2006 03:13:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Valdis.Kletnieks@vt.edu
cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0607030256581.17704@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
 <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home>
 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
 <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home>
 <Pine.LNX.4.64.0606281335380.17704@scrub.home> <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
            <1151695569.5375.22.camel@localhost.localdomain>
 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 30 Jun 2006, Valdis.Kletnieks@vt.edu wrote:

> *AHA* I *found* the bugger, I think.
> 
> In kernel/timer.c, we have:
> 
> static void clocksource_adjust(struct clocksource *clock, s64 offset)
> (s64 used for offset in multiple places).
> 
> However, in other places, offset is a 'cycle_t', which is:
> 
> include/linux/clocksource.h:typedef u64 cycle_t;
> 
> So it looks like a signed/unsigned screwage.

It's a possibility, but the signed/unsigned usage is pretty much 
intentional. The assumptation is that time only goes forward so nothing 
there should become negative, only adjustments happen in both directions.
It's really weird why it's getting completely so out of control early 
during boot. It would be great if you could also test the patch below, it 
should trigger closer to when it goes wrong and help to analyze the 
problem (or at least rule out a number of possibilities).

bye, Roman

---
 kernel/timer.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c
+++ linux-2.6-mm/kernel/timer.c
@@ -1078,6 +1078,7 @@ static __always_inline int clocksource_b
  */
 static void clocksource_adjust(struct clocksource *clock, s64 offset)
 {
+	static int cnt = 16;
 	s64 error, interval = clock->cycle_interval;
 	int adj;
 
@@ -1091,6 +1092,13 @@ static void clocksource_adjust(struct cl
 	} else
 		return;
 
+	if ((adj > 10 || adj < -10 || (s32)clock->mult <= -adj) && cnt > 0) {
+		cnt--;
+		printk("big adj at %ld (%Lu,%d,%Ld,%Ld)\n", jiffies, current_tick_length(),
+			adj, interval, offset);
+		printk_clock_info();
+	}
+
 	clock->mult += adj;
 	clock->xtime_interval += interval;
 	clock->xtime_nsec -= offset;
@@ -1149,9 +1157,15 @@ static void update_wall_time(void)
 
 	/* check to see if there is a new clocksource to use */
 	if (change_clocksource()) {
+		static int cnt = 16;
 		clock->error = 0;
 		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
+		if (cnt > 0) {
+			cnt--;
+			printk("clock changed at %ld (%Lu)\n", jiffies, current_tick_length());
+			printk_clock_info();
+		}
 	}
 }
 
