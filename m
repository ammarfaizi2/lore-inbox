Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUKPAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUKPAXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKPAXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:23:05 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:14520 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261724AbUKPAXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:23:01 -0500
Date: Mon, 15 Nov 2004 16:23:00 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] prefer TSC over PM Timer
Message-ID: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've heard other folks have independently run into this problem -- in fact 
i see the most recent fc2 kernels already do this.  i'd like this to be 
accepted into the main kernel though.

the x86 PM Timer is an order of magnitude slower than the TSC for 
gettimeofday calls.  i'm seeing 8%+ of the time spent doing gettimeofday 
in someworkloads... and apparently kernel.org was seeing 80% of its time 
go to gettimeofday during the fc3-release overload.  PM timer is also less 
accurate than TSC.

i can see a vague argument around cpufreq / tsc troubles, but i'm having a 
hell of a time getting a centrino box to show any TSC troubles even while 
i induce workloads that cause cpufreq to bounce the frequency around.  
maybe someone could give an example of it failing...

note:  when timer_tsc discovers inaccuracy after boot it falls back to 
timer_pit ... timer_pit is twice as expensive as timer_pm, and it'd be 
cool if timer_tsc could fall back to timer_pm... but by that point in time 
all the __init stuff is gone, so i can't see how to init timer_pm.  this 
would be a more ideal solution.

thanks
-dean

Signed-off-by: dean gaudet <dean@arctic.org>

--- linux-2.6.10-rc2/arch/i386/kernel/timers/timer.c.orig	2004-11-15 23:28:30.000000000 -0800
+++ linux-2.6.10-rc2/arch/i386/kernel/timers/timer.c	2004-11-15 23:29:07.000000000 -0800
@@ -19,10 +19,10 @@
 #ifdef CONFIG_HPET_TIMER
 	&timer_hpet_init,
 #endif
+	&timer_tsc_init,
 #ifdef CONFIG_X86_PM_TIMER
 	&timer_pmtmr_init,
 #endif
-	&timer_tsc_init,
 	&timer_pit_init,
 	NULL,
 };
