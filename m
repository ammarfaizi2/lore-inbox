Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVC3O0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVC3O0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVC3O0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:26:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:29616 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261912AbVC3O0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:26:19 -0500
Subject: Re: NFS client latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112138283.11346.2.camel@lade.trondhjem.org>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Mar 2005 09:26:18 -0500
Message-Id: <1112192778.17365.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 18:18 -0500, Trond Myklebust wrote:
> ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> > I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> > ms latency trace.
> 
> What kind of workload are you using to produce these numbers?
> 

Here is the other long latency I am seeing in the NFS client.  I posted
this before, but did not cc: the correct people.

It looks like nfs_wait_on_requests is doing thousands of
radix_tree_gang_lookups while holding some lock.

Lee

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.41-00
--------------------------------------------------------------------
 latency: 3178 �s, #4095/14224, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1
#P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
(T1/#0)            <...> 32105 0 3 00000004 00000000 [0011939614227867]
0.000ms (+4137027.445ms): <6500646c> (<61000000>)
(T1/#2)            <...> 32105 0 3 00000004 00000002 [0011939614228097]
0.000ms (+0.000ms): __trace_start_sched_wakeup+0x9a/0xd0 <c013150a>
(try_to_wake_up+0x94/0x140 <c0110474>)
(T1/#3)            <...> 32105 0 3 00000003 00000003 [0011939614228436]
0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1>
(try_to_wake_up+0x94/0x140 <c0110474>)
(T3/#4)    <...>-32105 0dn.3    0�s : try_to_wake_up+0x11e/0x140
<c01104fe> <<...>-2> (69 76): 
(T1/#5)            <...> 32105 0 3 00000002 00000005 [0011939614228942]
0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1>
(try_to_wake_up+0xf8/0x140 <c01104d8>)
(T1/#6)            <...> 32105 0 3 00000002 00000006 [0011939614229130]
0.000ms (+0.000ms): wake_up_process+0x35/0x40 <c0110555> (do_softirq
+0x3f/0x50 <c011b05f>)
(T6/#7)    <...>-32105 0dn.1    1�s < (1)
(T1/#8)            <...> 32105 0 2 00000001 00000008 [0011939614229782]
0.001ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee>
(nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
(T1/#9)            <...> 32105 0 2 00000001 00000009 [0011939614229985]
0.001ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup
+0x52/0x70 <c01e0632>)
(T1/#10)            <...> 32105 0 2 00000001 0000000a [0011939614230480]
0.001ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee>
(nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
(T1/#11)            <...> 32105 0 2 00000001 0000000b [0011939614230634]
0.002ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup
+0x52/0x70 <c01e0632>)
(T1/#12)            <...> 32105 0 2 00000001 0000000c [0011939614230889]
0.002ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee>
(nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
(T1/#13)            <...> 32105 0 2 00000001 0000000d [0011939614231034]
0.002ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup
+0x52/0x70 <c01e0632>)
(T1/#14)            <...> 32105 0 2 00000001 0000000e [0011939614231302]
0.002ms (+0.000ms): radix_tree_gang_lookup+0xe/0x70 <c01e05ee>
(nfs_wait_on_requests+0x6d/0x110 <c01c744d>)
(T1/#15)            <...> 32105 0 2 00000001 0000000f [0011939614231419]
0.002ms (+0.000ms): __lookup+0xe/0xd0 <c01e051e> (radix_tree_gang_lookup
+0x52/0x70 <c01e0632>)

(last two lines just repeat)


> Cheers,
>   Trond

