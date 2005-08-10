Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVHJCEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVHJCEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 22:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHJCEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 22:04:06 -0400
Received: from fmr22.intel.com ([143.183.121.14]:28630 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964842AbVHJCEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 22:04:05 -0400
Date: Tue, 9 Aug 2005 19:03:53 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't kick ALB in the presence of pinned task)
Message-ID: <20050809190352.D1938@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F94A00.3070504@yahoo.com.au>; from nickpiggin@yahoo.com.au on Wed, Aug 10, 2005 at 10:27:44AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:27:44AM +1000, Nick Piggin wrote:
> Yeah this makes sense. Thanks.
> 
> I think we'll only need your first line change to fix this, though.
> 
> Your second change will break situations where a single group is very
> loaded, but it is in a domain with lots of cpu_power
> (total_load <= total_power).

In that case, we will move the excess load from that group to some
other group which is below its capacity. Instead of bringing everyone
to avg load, we make sure that everyone is at or below its cpu_power.
This will minimize the movements between the nodes.

For example, Let us assume sched groups node-0, node-1 each has 
4*SCHED_LOAD_SCALE as its cpu_power.

And with 6 tasks on node-0 and 0 on node-1, current load balance 
will move 3 tasks from node-0 to 1. But with my patch, it will move only 
2 tasks to node-1. Is this what you are referring to as breakage?

Even with just the first line change, we will still allow going into
a state of 4 on node-0 and 2 on node-1.

With the second hunk of the patch we are minimizing the movement between nodes
and at the same time making sure everyone is below its cpu_power, when
the system is lightly loaded.

If the group's resources are very critical, groups cpu_power should
represent that criticality.

thanks,
suresh
