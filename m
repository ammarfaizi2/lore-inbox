Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932788AbWF1Loa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbWF1Loa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWF1Lo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:44:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18064 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932788AbWF1Lo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:44:28 -0400
Date: Wed, 28 Jun 2006 13:44:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <Pine.LNX.4.64.0606281218130.12900@scrub.home>
Message-ID: <Pine.LNX.4.64.0606281335380.17704@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org> 
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> 
 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271903320.12900@scrub.home>  <Pine.LNX.4.64.0606271919450.17704@scrub.home>
  <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
 <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Jun 2006, Roman Zippel wrote:

> Frequency changes are IMO currently the most likely reason for this 
> behaviour. If the cpu speeds down too much, the adjustment code might 
> actually attempt to go backwards in time, the old adjustment code might 
> have survived that, because it reacts slower to changes.
> The patch below should prevent this.

Hmm, I've run some simulations and I found that it actually needed some 
extreme frequency differences to trigger a negative multiplier, but even 
then it recovered very quickly from it.
Valdis, could you please add a call to the function below in 
__get_realtime_clock_ts() when the problem triggers to print the complete 
internal clock state.
Thanks.

bye, Roman

---
 kernel/timer.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-06-28 13:30:30.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-06-28 13:34:43.000000000 +0200
@@ -789,6 +789,13 @@ u64 current_tick_length(void)
 #include <linux/clocksource.h>
 static struct clocksource *clock; /* pointer to current clocksource */
 
+void printk_clock_info(void)
+{
+	printk("clock %s: m:%u,s:%u,cl:%Lu,ci:%Lu,xn:%Lu,xi:%Lu,e:%Ld\n",
+		clock->name, clock->mult, clock->shift, clock->cycle_last, clock->cycle_interval,
+		clock->xtime_nsec, clock->xtime_interval, clock->error);
+}
+
 #ifdef CONFIG_GENERIC_TIME
 /**
  * __get_nsec_offset - Returns nanoseconds since last call to periodic_hook
