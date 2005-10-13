Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVJMUBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVJMUBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVJMUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:01:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29890 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751110AbVJMUBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:01:36 -0400
Subject: sched_clock -> check_tsc_unstable -> tsc_read_c3_time ?!?
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 16:01:27 -0400
Message-Id: <1129233687.16243.52.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the latency traces it appears that sched_clock could be
optimized a bit:

evolutio-16296 0D.h4   32us : activate_task (try_to_wake_up)
evolutio-16296 0D.h4   33us : sched_clock (activate_task)
evolutio-16296 0D.h4   33us : check_tsc_unstable (sched_clock)
evolutio-16296 0D.h4   34us : tsc_read_c3_time (sched_clock)
evolutio-16296 0D.h4   35us : recalc_task_prio (activate_task)

check_tsc_unstable and tsc_read_c3_time appear to be new.  Here they
are:

     49 /* Code to mark and check if the TSC is unstable
     50  * due to cpufreq or due to unsynced TSCs
     51  */
     52 static int tsc_unstable;
     53 int check_tsc_unstable(void)
     54 {
     55         return tsc_unstable;
     56 }

     73 u64 tsc_read_c3_time(void)
     74 {
     75         return tsc_c3_offset;
     76 }

Shouldn't these be inlined or something?  I know it's only a few
microseconds, but it seems like excessive function call overhead to me.
I don't use power management and the TSC is stable on this machine.  Why
do we have to call these simple accessor functions over and over?

Lee

