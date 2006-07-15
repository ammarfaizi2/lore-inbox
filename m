Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWGOHF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWGOHF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbWGOHF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:05:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:41886 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161208AbWGOHFz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:05:55 -0400
X-IronPort-AV: i="4.06,245,1149490800"; 
   d="scan'208"; a="98412489:sNHT17078033"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq_ondemand governor - problem
Date: Sat, 15 Jul 2006 11:05:49 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC0D6914@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq_ondemand governor - problem
thread-index: AcanmOaAmuMxzvu3RUCKkDXRqjZORgAQ0ZwQ
From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
To: "art" <art@usfltd.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Jul 2006 07:05:54.0584 (UTC) FILETIME=[1D2E9180:01C6A7DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beside ondemand governor there is processor driver who should do
synchronization of frequencies over dependent CPUs (cores in your case).
If policy->cpus mask is set, then ondemand governor will choose minimum
idle time over dependent cores, and calculate load from it. If driver
does set policy-cpus mask, it's his job, or job of the processor itself
to do synchronization.

Hope that helps,
Alex

>-----Original Message-----
>From: art [mailto:art@usfltd.com] 
>Sent: Saturday, July 15, 2006 2:42 AM
>To: linux-kernel@vger.kernel.org
>Cc: Pallipadi, Venkatesh; Starikovskiy, Alexey Y; 
>torvalds@osdl.org; akpm@osdl.org; mingo@elte.hu
>Subject: cpufreq_ondemand governor - problem
>
>problem:
>on dualcore AMD - if you use cpufreq_ondemand governor and 
>your program is 
>one_process/one_thread intensive one core is busy and second is doing 
>nothing - governor is droping speed on both cores to lowest 
>speed - slowing 
>down busy core process - my dualcore-AMD do this i'm not shure 
>if it is only 
>AMD or INTEL problem too 
>
>to test this set ondemand governor 
>
># echo "ondemand" > 
>/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
>
>now
>start in terminal-1 
>
>#awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<100000;j++);}' 
>
>observe cpu speed and utilization
>core1 - utilization 100% speed lowest possible
>core2 - utilization 0% speed lowest possible 
>
>now
>start in terminal-2 
>
>#awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<100000;j++);}' 
>
>observe cpu speed and utilization
>core1 - utilization 100% speed max possible
>core2 - utilization 100% speed max possible 
>
>now kill one awk 
>
>observe cpu speed and utilization
>core1 - utilization 100% speed lowest possible
>core2 - utilization 0% speed lowest possible 
>
>looks like cpufreq ondemand governor sets two frequency 
>dependent cores to 
>speed level ok for that one with lowest utilization slowing down 
>process/thread working on other core. For now it is ok for independent 
>multiprocessor bad for multicore-freq-dependent. 
>
>
>temporary dirty patch works for me - your result my vary (for 
>shure it will 
>not work for multi-processor/dualcore - we need identify and 
>pair cores to 
>do same thing) 
>
>
> --- cpufreq_ondemand.c-org	2006-07-05 23:09:49.000000000 -0500
>+++ cpufreq_ondemand.c	2006-07-14 15:50:56.000000000 -0500
>@@ -39,6 +39,7 @@
>  * All times here are in uS.
>  */
> static unsigned int def_sampling_rate;
>+static unsigned int load_max_core=0;
> #define MIN_SAMPLING_RATE_RATIO			(2)
> /* for correct statistics, we need at least 10 ticks between 
>each measure 
>*/
> #define MIN_STAT_SAMPLING_RATE			
>(MIN_SAMPLING_RATE_RATIO * 
>jiffies_to_usecs(10))
>@@ -268,6 +269,8 @@ static void dbs_check_cpu(struct cpu_dbs
> 			idle_ticks = tmp_idle_ticks;
> 	}
> 	load = (100 * (total_ticks - idle_ticks)) / total_ticks;
>+	if (load_max_core > load)
>+		load = load_max_core;
>
> 	/* Check for frequency increase */
> 	if (load > dbs_tuners_ins.up_threshold) {
>@@ -297,6 +300,7 @@ static void dbs_check_cpu(struct cpu_dbs
>
> 		__cpufreq_driver_target(policy, freq_next, 
>CPUFREQ_RELATION_L);
> 	}
>+load_max_core = 0;
> }
>
> static void do_dbs_timer(void *data) 
>
>
> --------------------------------------------------- 
>
>after this patch dualcore-AMD is working OK max speed for 100% 
>utilization 
>on core1 and 0% utilization on core2 
>
>
>xboom
>art@usfltd.com
>
