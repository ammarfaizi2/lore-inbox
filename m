Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUJHVOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUJHVOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJHVOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:14:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44760 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265093AbUJHVOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:14:44 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041007105230.GA17411@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
Content-Type: text/plain
Message-Id: <1097270080.1442.61.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 17:14:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
> i've released the -T3 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> 

[adding Andrew Morton to the cc: list as these issues are increasingly
relevant to -mm and not VP specific] 

I am seeing the same prune_icache latency that Mark reported.  I have
never seen this one at all before T3.  This one seem very frequent,
enough so to overtake the netif_skb single-packet processing latency
that seems to be our lower bound. 

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 242 us, entries: 178 (178)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: kswapd0/54, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: prune_icache+0x52/0x460
 => ended at:   prune_icache+0x162/0x460
=======>
00000001 0.000ms (+0.001ms): prune_icache (shrink_icache_memory)
00000001 0.001ms (+0.002ms): inode_has_buffers (prune_icache)
00000001 0.004ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.005ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.007ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.008ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.010ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.011ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.012ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.014ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.015ms (+0.001ms): inode_has_buffers (prune_icache)

[more of same interrupted by the timer a few times]

Workload is just a kernel compile and an RT task (jackd). 
Interestingly, kswapd seems to have triggered the above, but I should
not be hitting swap!  I have swappiness set to 0, and here is what
vmstat showed:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      4  30608  54476 221680    0    0     9    12  310   600 36  8 56  0
 1  0      4  41424  54476 221796    0    0     0     0 1109  2577 88 12  0  0
 1  0      4  41168  54484 221808    0    0    24     0 1005  2158 83 17  0  0
 1  0      4  34704  54496 221808    0    0     0   192 1015  2063 92  8  0  0
 1  0      4  32208  54496 221808    0    0     0     0 1003  2045 96  4  0  0
 1  0      4  30928  54496 221808    0    0     0     0 1004  2090 98  2  0  0

Lee

