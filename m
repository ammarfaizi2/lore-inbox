Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753866AbWKMED5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbWKMED5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 23:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbWKMED5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 23:03:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:40346 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1753863AbWKMED4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 23:03:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,415,1157353200"; 
   d="scan'208"; a="160382498:sNHT18253823"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, <akpm@osdl.org>,
       <mm-commits@vger.kernel.org>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Date: Sun, 12 Nov 2006 20:03:51 -0800
Message-ID: <000001c706d8$bcce0770$a081030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccFPEOY2TTbWVfjS6qnutD7v4n35ABlLzIA
In-Reply-To: <Pine.LNX.4.64.0611101847050.28621@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Friday, November 10, 2006 6:51 PM
> On Fri, 10 Nov 2006, Chen, Kenneth W wrote:
> 
> > So designate only one CPU within a domain to do load balance between groups
> > for that specific sched domain should in theory fix the 2nd problem you
> > identified.  Did you get a chance to look at the patch Suresh posted?
> 
> Yes, I am still thinking about how this would work. This would mean that 
> the first cpu on a system would move busy processes to itself from all 
> 1023 other processes? That does not sound appealing.
> 
> Processes in the allnodes domain would move to processor #0. The next 
> lower layer are the nodes groups. Not all of the groups at that layer 
> contain processor #0. So we would never move processes into those sched 
> domains?

Not really, someone needs to put a bloody comments in that patch ;-)

The key is that load balance scans from lowest SMT domain and traverse
upwards to numa allnodes domain.  The CPU check and break is placed at
the end of the for loop so it is effectively shorting out i+1 iteration.
And given the fact that sd->span in iteration(i) is the same as sd->groups
in iteration(i+1).  The patch is effectively designate first CPU (hard-coded)
in a group within a domain to perform load balance in that domain.  All
other groups within a domain will still have at least one CPU assigned to
perform load balance.

Though the original patch is not perfect:

(1) we should extend the logic to all rebalance tick, not just busy tick.
(2) we should initiate load balance within a domain only from least
    loaded group.
(3) the load scanning should be done only once per interval per domain.
    Currently, it is scanning load for each CPU within a domain.  Even with
    the patch, the scanning is cut down to one per group. That is still
    too much.  Large system that has hundreds of groups in numa allnodes
    will end up scanning / calculate load over and over again. That should
    be cut down as well.

Part of all this problem probably stemmed from "load balance" is incapable
of performing l-d between arbitrary pair of CPUs, and tightly tied load scan
and actual l-d action.  And on top of that l-d is really a pull operation
to current running CPU. All these limitations dictate that every CPU somehow
has to scan and pull.  It is extremely inefficient on large system.

IMO, we should decouple load scan from actual l-d action and if possible,
make l-d capable of performing on arbitrary pair of CPUs.

