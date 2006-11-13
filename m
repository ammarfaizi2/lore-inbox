Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753976AbWKMFpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbWKMFpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbWKMFpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:45:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15512 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753976AbWKMFpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:45:30 -0500
Date: Sun, 12 Nov 2006 21:44:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <000001c706d8$bcce0770$a081030a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0611122137190.2708@schroedinger.engr.sgi.com>
References: <000001c706d8$bcce0770$a081030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006, Chen, Kenneth W wrote:

> The key is that load balance scans from lowest SMT domain and traverse
> upwards to numa allnodes domain.  The CPU check and break is placed at
> the end of the for loop so it is effectively shorting out i+1 iteration.

It shortens out if the current cpu is not the first cpu of the span. But 
at that point it has already done load balancing for the cpu that is not 
the first cpu of the span!

> (1) we should extend the logic to all rebalance tick, not just busy tick.

Ok.

> (2) we should initiate load balance within a domain only from least
>     loaded group.

This would mean we would have to determine the least loaded group first.

> (3) the load scanning should be done only once per interval per domain.
>     Currently, it is scanning load for each CPU within a domain.  Even with
>     the patch, the scanning is cut down to one per group. That is still
>     too much.  Large system that has hundreds of groups in numa allnodes
>     will end up scanning / calculate load over and over again. That should
>     be cut down as well.

Yes we want that. Maybe we could remember the load calculated in 
sched_group and use that for a certain time period? Load would only be 
calculated once and then all other processors make their decisions based 
on the cached load?

> Part of all this problem probably stemmed from "load balance" is incapable
> of performing l-d between arbitrary pair of CPUs, and tightly tied load scan
> and actual l-d action.  And on top of that l-d is really a pull operation
> to current running CPU. All these limitations dictate that every CPU somehow
> has to scan and pull.  It is extremely inefficient on large system.

Right. However, if we follow this line of thought then we will be 
redesigning the load balancing logic.

