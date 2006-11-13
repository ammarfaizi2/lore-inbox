Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754096AbWKMGk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbWKMGk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 01:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbWKMGk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 01:40:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:14897 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1754096AbWKMGk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 01:40:58 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,416,1157353200"; 
   d="scan'208"; a="160427065:sNHT18017097"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, <akpm@osdl.org>,
       <mm-commits@vger.kernel.org>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Date: Sun, 12 Nov 2006 22:40:51 -0800
Message-ID: <000201c706ee$a9992e80$a081030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccG5vEjPDulipmpSCK8U0CBs3B4nQABDvdg
In-Reply-To: <Pine.LNX.4.64.0611122137190.2708@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Sunday, November 12, 2006 9:45 PM
> > (2) we should initiate load balance within a domain only from least
> >     loaded group.
> 
> This would mean we would have to determine the least loaded group first.

Well, find_busiest_group() scans every single bloody CPU in the system at
the highest sched_domain level.  In fact, this function is capable to find
busiest group within a domain, it should be capable to determine least
loaded group for free because it already scanned every groups within a domain.


> > Part of all this problem probably stemmed from "load balance" is incapable
> > of performing l-d between arbitrary pair of CPUs, and tightly tied load scan
> > and actual l-d action.  And on top of that l-d is really a pull operation
> > to current running CPU. All these limitations dictate that every CPU somehow
> > has to scan and pull.  It is extremely inefficient on large system.
> 
> Right. However, if we follow this line of thought then we will be 
> redesigning the load balancing logic.

It won't be a bad idea to redesign it ;-)

There are number of other oddity beside what was identified in it's design:

(1) several sched_groups are statically declared and they will reside in
    boot node. I would expect cross node memory access to be expansive.
    Every cpu will access these data structure repeatedly.

    static struct sched_group sched_group_cpus[NR_CPUS];
    static struct sched_group sched_group_core[NR_CPUS];
    static struct sched_group sched_group_phys[NR_CPUS];

(2) load balance staggering. Number of people pointed out that it is overly
    done.

(3) The for_each_domain() loop in rebalance_tick() looks different from
    idle_balance() where it will traverse entire sched domains even if lower
    level domain succeeded in moving some tasks.  I would expect we either
    break out of the for loop like idle_balance(), or somehow update load
    for current CPU so it gets accurate load value when doing l-d in the
    next level. Currently, It is doing neither.
