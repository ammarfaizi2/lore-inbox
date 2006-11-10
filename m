Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946789AbWKJSue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946789AbWKJSue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946786AbWKJSue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:50:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32135 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946785AbWKJSuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:50:32 -0500
Date: Fri, 10 Nov 2006 10:50:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
References: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006, Chen, Kenneth W wrote:

> All results are within noise range.  The global tasklet does a fairly 
> good job especially on context switch intensive workload like aim7, 
> volanomark, tbench etc.  Note all machines are non-numa platform.
 
> Base on the data, I think we should make the load balance tasklet one per numa
> node instead of one per CPU.

I have done some testing on NUMA with 8p / 4n and 256 p / 128n which seems 
to indicate that this is doing very well. Having a global tasklet avoids 
concurrent load balancing from multiple nodes which smoothes out the load 
balancing load over all nodes in a NUMA system. It fixes the issues that 
we saw with contention during concurrent load balancing.

On a 8p system:

I) Percent of ticks where load balancing was found to be required

II) Percent of ticks where we attempted load balancing
   but we found that we need to try again due to load balancing
   in progress elsewhere (This increases (I) since we found that
   load balancing was required but we decided to defer. Tasklet
   was not invoked).

    	I)	II) 
Boot:	70%	~1%
AIM7:	30%	2%
Idle:	50%	 <0.5%

256p:
	I)	II)
Boot:	80%	30%
AIM7:	90%	30%
Idle: 	95%	30%

So on larger systems we have more attempts to concurrently execute the 
tasklet which also inflates I). I would expect that rate to be raised 
further on even larger systems until we likely reach a point of continuous 
load balancing somehwere in the system at 1024p (will take some time to to 
such a system). It is likely prefereable at that scale to still not have 
concurrency. Concurrency may mean that we concurrently balance huge sched 
domains which causes long delays on multiple processor and may cause 
contention between those load balancing threads that attempt to move tasks 
from the same busy processor.

Suresh noted at the Intel OS forum yesterday that we may be able to avoid 
running load balancing of the larger sched domains from all processors. 
That would reduce the overhead of scheduling and reduce the percentage of 
time that load blancing is active even on very large systems.


