Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWF1KjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWF1KjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWF1KjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:39:03 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52623 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932176AbWF1KjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:39:02 -0400
Date: Wed, 28 Jun 2006 12:35:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <1151453231.24656.49.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606281218130.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org> 
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> 
 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271903320.12900@scrub.home>  <Pine.LNX.4.64.0606271919450.17704@scrub.home>
  <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Jun 2006, john stultz wrote:

> > [   92.087113] ACPI: CPU0 (power states: C1[C1] C2[C2])
> > [   92.087122] ACPI: Processor [CPU0] (supports 8 throttling states)
> > [   92.120270] ACPI: Thermal Zone [THM] (70 C)
> > [   72.242000] Time: acpi_pm clocksource has been installed.
> > 
> > and the timestamps steps back about 20 seconds.... 
> 
> Yea, that bit is expected. Basically the cpufreq driver is loading, and
> when we detect cpufreq changes we mark the TSC as unstable and we fall
> back to an alternative clocksource (acpi_pm in your case). At the same
> time, sched_clock sees that the TSC is unstable and it falls back to
> using jiffies, which causes the small jump in the printk timestamps.

Frequency changes are IMO currently the most likely reason for this 
behaviour. If the cpu speeds down too much, the adjustment code might 
actually attempt to go backwards in time, the old adjustment code might 
have survived that, because it reacts slower to changes.
The patch below should prevent this.

Looking through the log file, I noticed other things:

[   17.942330] speedstep: frequency transition measured seems out of range (0 nSec), falling back to a safe one of 500000 nSec.
...
[   21.869356] Time: tsc clocksource has been installed.

The speedstep code uses do_gettimeofday() but there is no real clock 
source installed, so it gets confused.
IMO it would be better to install the PIT timer very early and later avoid 
switching to tsc at all, if there is any possibility of speed changes.

bye, Roman



---
 include/linux/clocksource.h |    4 +++-
 kernel/timer.c              |    6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/include/linux/clocksource.h
===================================================================
--- linux-2.6-mm.orig/include/linux/clocksource.h	2006-06-28 11:53:01.000000000 +0200
+++ linux-2.6-mm/include/linux/clocksource.h	2006-06-28 12:14:30.000000000 +0200
@@ -55,7 +55,7 @@ struct clocksource {
 	int rating;
 	cycle_t (*read)(void);
 	cycle_t mask;
-	u32 mult;
+	u32 mult, mult_min;
 	u32 shift;
 	int (*update_callback)(void);
 	int is_continuous;
@@ -169,6 +169,8 @@ static inline void clocksource_calculate
 	tmp += c->mult/2;
 	do_div(tmp, c->mult);
 
+	c->mult_min = max(c->mult >> 2, 1u);
+
 	c->cycle_interval = (cycle_t)tmp;
 	if (c->cycle_interval == 0)
 		c->cycle_interval = 1;
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-06-28 11:55:12.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-06-28 12:13:50.000000000 +0200
@@ -1053,6 +1053,12 @@ static __always_inline int clocksource_b
 	if (sign > 0 ? error > *interval : error < *interval)
 		adj++;
 
+	if (sign < 0 && unlikely(clock->mult < clock->mult_min + (1 << adj))) {
+		if (clock->mult <= clock->mult_min)
+			return 0;
+		adj = fls(clock->mult - clock->mult_min) - 1;
+	}
+
 	*interval <<= adj;
 	*offset <<= adj;
 	return sign << adj;
