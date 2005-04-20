Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVDTG6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVDTG6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVDTG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 02:58:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54204 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261386AbVDTG6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 02:58:03 -0400
Date: Wed, 20 Apr 2005 12:46:06 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050420071606.GA3931@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com> <20050419093438.GB3963@in.ibm.com> <20050419102348.118005c1.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419102348.118005c1.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:23:48AM -0700, Paul Jackson wrote:
> 
> How does this play out in your interface?  Are you convinced that
> your invariants are preserved at all times, to all users?  Can
> you present a convincing argument to others that this is so?


Let me give an example of how the current version of isolated cpusets can
be used and hopefully clarify my approach.


Consider a system with 8 cpus that needs to run a mix of workloads.
One set of applications have low latency requirements and another
set have a mixed workload. The administrator decides to allot
2 cpus to the low latency application and the rest to other apps.
To do this, he creates two cpusets
(All cpusets are considered to be exclusive for this discussion)

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1          0-7             0
 top/lowlat             0-1            0          0-1             0
 top/others             2-7            0          2-7             0

He now wants to partition the system along these lines as he wants
to isolate lowlat from the rest of the system to ensure that
a. No tasks from the parent cpuset (top_cpuset in this case)
   use these cpus
b. load balance does not run across all cpus 0-7

He does this by

        cd /mount-point/lowlat
        /bin/echo 1 > cpu_isolated

Internally it takes the cpuset_sem, does some sanity checks and ensures
that these cpus are not visible to any other cpuset including its parent
(by removing these cpus from its parent's cpus_allowed mask and adding
them to its parent's isolated_map) and then calls sched code to partition
the system as

                [0-1] [2-7]

   The internal state of data structures are as follows

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1          2-7            0-1
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            0          2-7             0

        -------------------------------------------------------


The administrator now wants to further partition the "others" cpuset into
a cpu intensive application and a batch one

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1          2-7            0-1
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            0          2-7             0
 top/others/cint           2-3         0          2-3             0
 top/others/batch          4-7         0          4-7             0


If now the administrator wants to isolate the cint cpuset...

        cd /mount-point/others
        /bin/echo 1 > cpu_isolated

        (At this point no new sched domains are built
         as there exists a sched domain which exactly
         matches the cpus in the "others" cpuset.)

        cd /mount-point/others/cint
        /bin/echo 1 > cpu_isolated

At this point cpus from the "others" cpuset are also taken away from its
parent cpus_allowed mask and put into the parent's isolated_map. This means
that the parent cpus_allowed mask is empty.  This would now result in
partitioning the "others" cpuset and builds two new sched domains as follows

                [2-3] [4-7]

Notice that the cpus 0-1 having already been isolated are not affected
in this operation

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1           0             0-7
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            1          4-7            2-3
 top/others/cint           2-3         1          2-3             0
 top/others/batch          4-7         0          4-7             0

        -------------------------------------------------------

The admin now wants to run more applications in the cint cpuset
and decides to borrow a couple of cpus from the batch cpuset
He removes cpus 4-5 from batch and adds them to cint

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1           0             0-7
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            1          6-7            2-5
 top/others/cint           2-5         1          2-5             0
 top/others/batch          6-7         0          6-7             0

As cint is already isolated, adding cpus causes it to rebuild all cpus
covered by its cpus_allowed and its parent's cpus_allowed, so the new
sched domains will look as follows

                [2-5] [6-7]

cpus 0-1 are ofcourse still not affected

Similarly the admin can remove cpus from cint, which will
result in the domains being rebuilt to what was before

                [2-3] [4-7]

        -------------------------------------------------------


Hope this clears up my approach. Also note that we still need to take care
of the cpu hotplug case, where any random cpu can be removed and added back
and this code needs to take care of rebuilding the appropriate sched domains


        -Dinakar

