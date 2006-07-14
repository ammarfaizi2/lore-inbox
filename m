Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWGNW5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWGNW5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWGNW5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:57:30 -0400
Received: from www.webhostingstar.com ([69.222.0.225]:7404 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1030368AbWGNW53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:57:29 -0400
Message-ID: <20060714224204.31311.qmail@mail.webhostingstar.com>
From: "art" <art@usfltd.com>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, alexey.y.starikovskiy@intel.com,
       torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu
Subject: cpufreq_ondemand governor - problem
Date: Fri, 14 Jul 2006 17:42:04 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

problem:
on dualcore AMD - if you use cpufreq_ondemand governor and your program is 
one_process/one_thread intensive one core is busy and second is doing 
nothing - governor is droping speed on both cores to lowest speed - slowing 
down busy core process - my dualcore-AMD do this i'm not shure if it is only 
AMD or INTEL problem too 

to test this set ondemand governor 

# echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 

now
start in terminal-1 

#awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<100000;j++);}' 

observe cpu speed and utilization
core1 - utilization 100% speed lowest possible
core2 - utilization 0% speed lowest possible 

now
start in terminal-2 

#awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<100000;j++);}' 

observe cpu speed and utilization
core1 - utilization 100% speed max possible
core2 - utilization 100% speed max possible 

now kill one awk 

observe cpu speed and utilization
core1 - utilization 100% speed lowest possible
core2 - utilization 0% speed lowest possible 

looks like cpufreq ondemand governor sets two frequency dependent cores to 
speed level ok for that one with lowest utilization slowing down 
process/thread working on other core. For now it is ok for independent 
multiprocessor bad for multicore-freq-dependent. 


temporary dirty patch works for me - your result my vary (for shure it will 
not work for multi-processor/dualcore - we need identify and pair cores to 
do same thing) 


 --- cpufreq_ondemand.c-org	2006-07-05 23:09:49.000000000 -0500
+++ cpufreq_ondemand.c	2006-07-14 15:50:56.000000000 -0500
@@ -39,6 +39,7 @@
  * All times here are in uS.
  */
 static unsigned int def_sampling_rate;
+static unsigned int load_max_core=0;
 #define MIN_SAMPLING_RATE_RATIO			(2)
 /* for correct statistics, we need at least 10 ticks between each measure 
*/
 #define MIN_STAT_SAMPLING_RATE			(MIN_SAMPLING_RATE_RATIO * 
jiffies_to_usecs(10))
@@ -268,6 +269,8 @@ static void dbs_check_cpu(struct cpu_dbs
 			idle_ticks = tmp_idle_ticks;
 	}
 	load = (100 * (total_ticks - idle_ticks)) / total_ticks;
+	if (load_max_core > load)
+		load = load_max_core;

 	/* Check for frequency increase */
 	if (load > dbs_tuners_ins.up_threshold) {
@@ -297,6 +300,7 @@ static void dbs_check_cpu(struct cpu_dbs

 		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_L);
 	}
+load_max_core = 0;
 }

 static void do_dbs_timer(void *data) 


 --------------------------------------------------- 

after this patch dualcore-AMD is working OK max speed for 100% utilization 
on core1 and 0% utilization on core2 


xboom
art@usfltd.com
