Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVKVCDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVKVCDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKVCDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:03:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:29083 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964875AbVKVCDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:03:04 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B11)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 18:03:00 -0800
Message-Id: <1132624980.31144.37.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 18:35 -0700, john stultz wrote:
> Still on the TODO list:
> o Fix Frank Sorenson's c3tsc overcompensation problem

Hmmm. It looks like this might be related to the CONFIG_SMP disabling
cpu frequency changes to the cpu_khz value. This fix might solve that
issue.

thanks
-john

diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index 91a9f7d..15f3c6b 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -255,9 +255,7 @@ static int time_cpufreq_notifier(struct 
 	if (!ref_freq) {
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
-#ifndef CONFIG_SMP
 		cpu_khz_ref = cpu_khz;
-#endif
 	}
 
 	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
@@ -267,9 +265,9 @@ static int time_cpufreq_notifier(struct 
 			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 
 		if (cpu_khz) {
-#ifndef CONFIG_SMP
-			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-#endif
+			if (num_online_cpus() == 1)
+				cpu_khz = cpufreq_scale(cpu_khz_ref, 
+						ref_freq, freq->new);
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				tsc_khz = cpu_khz;
 				set_cyc2ns_scale(cpu_khz);


