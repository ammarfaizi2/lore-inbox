Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVDUQMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVDUQMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDUQMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:12:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:40405 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261497AbVDUQKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:10:03 -0400
Date: Thu, 21 Apr 2005 21:57:38 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050421162738.GA4200@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com> <20050419093438.GB3963@in.ibm.com> <20050419102348.118005c1.pj@sgi.com> <20050420071606.GA3931@in.ibm.com> <20050420120946.145a5973.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420120946.145a5973.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 12:09:46PM -0700, Paul Jackson wrote:
> Earlier, I wrote to Dinakar:
> > What are your invariants, and how can you assure yourself and us
> > that your code preserves these invariants?

Ok, Let me begin at the beginning and attempt to define what I am 
doing here

1. I need a method to isolate a random set of cpus in such a way that
   only the set of processes that are specifically assigned can
   make use of these CPUs
2. I need to ensure that the sched load balance code does not pull
   any tasks other than the assigned ones onto these cpus
3. I need to be able to create multiple such groupings of cpus
   that are disjoint from the rest and run only specified tasks
4. I need a user interface to specify which random set of cpus
   form such a grouping of disjoint cpus
5. I need to be able to dynamically create and destroy these
   grouping of disjoint cpus
6. I need to be able to add/remove cpus to/from this grouping


Now if you try to fit these requirements onto cpusets, keeping in mind
that it already has an user interface and some of the frame work
required to create disjoint groupings of cpus

1. An exclusive cpuset ensures that the cpus it has are disjoint from
   all other cpusets except its parent and children
2. So now I need a way to disassociate the cpus of an exclusive
   cpuset from its parent, so that this set of cpus are truly
   disjoint from the rest of the system.
3. After I have done (2) above, I now need to build two set of sched 
   domains corresponding to the cpus of this exclusive cpuset and the 
   remaining cpus of its parent
4. Ensure that the current rules of non-isolated cpusets are all
   preserved such that if this feature is not used, all other features
   work as before

This is exactly what I have tried to do.

1. Maintain a flag to indicate whether a cpuset is isolated
2. Maintain an isolated_map for every cpuset. This contains a cache of 
   all cpus associated with isolated children
3. To isolate a cpuset x, x has to be an exclusive cpuset and its
   parent has to be an isolated cpuset
4. On isolating a cpuset by issuing
   /bin/echo 1 > cpu_isolated
   
   It ensures that conditions in (3) are satisfied and then removes the 
   cpus of the current cpuset from the parent cpus_allowed mask. (It also
   puts the cpus of the current cpuset into the isolated_map of its parent)
   This ensures that only the current cpuset and its children will have
   access to the now isolated cpus.
   It also rebuilds the sched domains into two new domains consisting of
   a. All cpus in the parent->cpus_allowed
   b. All cpus in current->cpus_allowed
5. Similarly on setting isolated off on a isolated cpuset, (or on doing
   an rmdir on an isolated cpuset) It adds all of the cpus of the current 
   cpuset into its parent cpuset's cpus_allowed mask and removes them from 
   it's parent's isolated_map

   This ensures that all of the cpus in the current cpuset are now
   visible to the parent cpuset.

   It now rebuilds only one sched domain consisting of all of the cpus
   in its parent's cpus_allowed mask.
6. You can also modify the cpus present in an isolated cpuset x provided
   that x does not have any children that are also isolated.
7. On adding or removing cpus from an isolated cpuset that does not
   have any isolated children, it reworks the parent cpuset's
   cpus_allowed and isolated_map masks and rebuilds the sched domains
   appropriately
8. Since the function update_cpu_domains, which does all of the
   above updations to the parent cpuset's masks, is always called with
   cpuset_sem held, it ensures that all these changes are atomic.


> > He removes cpus 4-5 from batch and adds them to cint
> 
> Could you spell out the exact steps the user would take, for this part
> of your example?  What does the user do, what does the kernel do in
> response, and what state the cpusets end up in, after each action of the
> user?


   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1           0             0-7
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            1          4-7            2-3
 top/others/cint           2-3         1          2-3             0
 top/others/batch          4-7         0          4-7             0

At this point to remove cpus 4-5 from batch and add them to cint, the admin
would do the following steps

	# Remove cpus 4-5 from batch
 	# batch is not a isolated cpuset and hence this step 
        # has no other implications
	/bin/echo 6-7 > /top/others/batch/cpus 

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1           0             0-7
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            1          4-7            2-3
 top/others/cint           2-3         1          2-3             0
 top/others/batch          6-7         0          6-7             0

	# Add cpus 4-5 to cint alongwith existing cpus 2-3
	/bin/echo 2-5 > /top/others/cint/cpus

   cpuset               cpus       isolated   cpus_allowed   isolated_map
 top                 0-7               1           0             0-7
 top/lowlat             0-1            1          0-1             0
 top/others             2-7            1          6-7            2-5
 top/others/cint           2-5         1          2-5             0
 top/others/batch          6-7         0          6-7             0

As you can see there are no "side effects" here. All of these are legitimate
operations and work the same even in the current cpusets code as in mainline.
(Except ofcourse the isolation part)

Hope this helps in clarifying all your questions

However, after taking into account all of your comments so far, I have
reworked my patch and reduced and simplified it quite a bit. I have
maintained all of the functionality that I have described so far.
(Adding one restriction viz 
   You can also modify the cpus present in an isolated cpuset x provided
   that x does not have any children that are also isolated.)
I'll send that in a new mail. 

Thanks for all your comments and review so far

	-Dinakar
