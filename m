Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUI3Jsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUI3Jsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 05:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUI3Jsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 05:48:42 -0400
Received: from calsoftinc.com ([64.62.215.98]:33412 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S269096AbUI3Jsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 05:48:38 -0400
Subject: Re: Performance of del_timer_sync
From: shobhit dayal <shobhit@calsoftinc.com>
To: linux-kernel@vger.kernel.org
Cc: geoff@linux.intel.com, akpm@osdl.org
In-Reply-To: <1096110445.12409.86.camel@kuber>
References: <1096110445.12409.86.camel@kuber>
Content-Type: text/plain
Organization: calsoft
Message-Id: <1096538830.12409.281.camel@kuber>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 30 Sep 2004 15:37:10 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I profiled the 2.6.7 kernel, running a postgres load, on a 8p 4 node
NUMA machine, logging occurances of timer deletions before they expired
and timer deletions after they expired.
The results show that the ratio of timers being deleted after expiry to
timers being deleted before expiry was 10:1.
This profiling was only done for schedule_timeout since it is the most
frequent caller to del_timer_singleshot_sync.

There were 10000 occurance of timers being deleted after expiry from
schedule_timeout and 997 occurances of timers being deleted before
expiry from schedule_timout while the postgress workload ran.
The ratio was always 10:1 from the start of the workload to end as the
number of deletions climbed.

The del_timer_singleshot_sync improves performance for the case where
timers are deleted before expiry but not for the case of timers being
deleted after expiry.

The profiling data shows that the most frequesnt occurance, is that of
timers being deleted after expiry, to the ratio of 10:1. In such a case
del_timer_singleshot_sync may not provide the needed performance gain.


regards
shobhit



On Sat, 2004-09-25 at 16:37, shobhit dayal wrote:
> This is with reference to the del_timer_sync patch submitted by Geoff
> Gustafson http://lwn.net/Articles/84839/.
> 
> I profiled a postgress load on a 8p( 4 nodes) NUMA machine. This
> profiler logs functions that access memory on remote nodes, and
> del_timer_sync was one of the top few functions doing this. The culprit
> is the for loop in del_timer_sync that reads the running_timer field of
> the per cpu tvec_bases_t structure on all nodes in the system. It gets
> invoked most times from del_singleshot_timer_sync.
> 
> Andrew Morton had suggested a patch for this, when the top callers to
> del_timer sync were schedule_timeout and clear_timeout, the fix being
> the  del_single_shot_timer_sync patch,  with the knowledge that
> schedule_timeout and clear_timeout do not create timers that re-add
> themselves.
> 
> This may not be enough, the problem is that schedule_timeout at most
> times will call del_single_shot_timer_sync after the timer has expired.
> This will cause del_timer to asume that the handler is running on some
> cpu and del_timer_sync will still get invoked.
> 
> Ofcourse, it also means that del_timer_sync will continue to be a
> hotspot as far as taking up cpu time is concerned.
> 
> I tried Geoff's patch and it does seem to improve performance.
> 
> Has anyone else seen del_timer_sync as a hotspot after the
> del_singleshot_timer_sync patch?
> 
> regards
> Shobhit
> 
> 
> 
> 				
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

