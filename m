Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCNOLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCNOLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCNOLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:11:06 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40588 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261506AbVCNOKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:10:50 -0500
Date: Mon, 14 Mar 2005 14:10:48 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Paul Jackson <pj@engr.sgi.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9)
 + prezeroing (Version 4)
In-Reply-To: <1110478613.16432.36.camel@localhost>
Message-ID: <Pine.LNX.4.58.0503141157330.12793@skynet>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>  <1110239966.6446.66.camel@localhost>
  <Pine.LNX.4.58.0503101421260.2105@skynet>  <20050310092201.37bae9ba.pj@engr.sgi.com>
 <1110478613.16432.36.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Dave Hansen wrote:

> On Thu, 2005-03-10 at 09:22 -0800, Paul Jackson wrote:
> > In particular, I am working on preparing a patch proposal for a policy
> > that would kill a task rather than invoke the swapper.  In
> > mm/page_alloc.c __alloc_pages(), if one gets down to the point of being
> > about to kick the swapper, if this policy is enabled (and you're not
> > in_interrupt() and don't have flag PF_MEMALLOC set), then ask
> > oom_kill_task() to shoot us instead.  For some big HPC jobs that are
> > carefully sized to fit on the allowed memory nodes, swapping is a fate
> > worse than death.
> >
> > The natural place (for me, anyway) to hang such policies is off the
> > cpuset.
> >

I have not read up on cpuset before so I am assuming you are talking about
http://www.bullopensource.org/cpuset/ so correct me if I am wrong.

> > I am hopeful that cpusets will soon hit Linus's tree.
> >
> > Would it make sense to specify these buddy allocator fallback policies
> > per cpuset as well?
>
> That seems reasonable, but I don't think there necessarily be enough
> cpuset users to make this reasonable as the only interface.
>
> Seems like something VMA-based along the lines of madvise() or the NUMA
> binding API would be more appropriate.  Perhaps default policies
> inherited from a cpuset, but overridden by other APIs would be a good
> compromise.
>

I would think that VMA is too fine-grained and there is not a really clean
way of specifying what fallback policy to use with madvise() unless we
hard-code a fixed number of policies.  I agree that if cpuset is not
widely used, it should not be the only way of setting policy. However, the
NUMA binding API deals with memory ranges, not PIDs. Implementing the
fallbacks for memory ranges would be at the node or zone level, not PID
which could be a conflict with cpuset (for example, which takes priority
when both cpuset and node policies are set?). So, I don't think the numa
binding as it is today is exactly the way to go either.

First though, we have to define how a fallback policy would be implemented
and applied.  Right now, there is one hard-coded policy (assuming that the
placement policy gets merged at some point in the future) that is
implemented in __rmqueue() and is applied at the zone level. It is
implemented as a while loop and the information it uses is;

Input: int[] Integer array of fallback allocation types
       struct zone * zone is the zone being allocated from
       int order being the required order

Output: struct free_area *area is the area we are going to allocate from
        int current_order is the order of the free pages in area

So, a very rough fallback policy setup might look something like;

/*
 * Fallback function fills this struct telling the allocator where to get
 * free pages from
 */
struct fallback {
	struct free_area        *area;
	unsigned long           current_order;
};

/* struct that describes a fallback policy */
struct fallback_policy {
	void (*fallback)(int *fallback_list, struct zone* zone, int order);
	char name[10];
	int id; /* set on register */
}

/* List of all available fallback policies */
struct list_head *fallback_policies;

/* Default policy to use */
struct fallback_policy default_policy = {
	.fallback = fallback_lowfrag,
	.name = "default",
	.id = 0
};

/*
 * Register a new fallback policy. Throws a wobbly if the name is already
 * registered
 */
void register_fallback(struct fallback_policy *policy);

/* Unregister a fallback, calls BUG if policy == default_policy */
void unregister_fallback(struct fallback_policy *policy);

the fallback_lowfrag() function would just implement the current fallback
approach. Other users like hotplug or cpuset would create their own
fallback policy, populate a fallback_policy and register it. I think this
is similar to how IO schedulers are registered.

Next... How do we apply it.

I think the sensible level to have a fallback policy as at the mm_struct
level.  If the mm does not have a pointer to a fallback_policy, it uses
the default. This would be inherited from either a cpuset or explicitly
set via a specific API (should it inherit across exec()?  Initially, I
would think no)

Case 1: The cpuset case

cpuset has a pseudo filesystem called cfs that looks very like /sys
mounted on /dev/cpuset. Each directory under /dev/cpuset is a cpuset and
there are a number of files there. For fallbacks, a new file would be
there called fallback. Catting it would print something like

[default] hotplug noswapper

where the name between [] is what is currently set. To set a new fallback
policy, echo the new string name to fallback like

echo noswapper > fallback

Any process created with pexec() or is otherwise part of a cpuset will get
it's policy from here.

Case 2: Specific API

The NUMA binding API has a method that looks like this;

#include <linux/mempolicy.h>
int set_mempolicy(int policy, unsigned long *nodemask, unsigned long
maxnode)

We could have something like

int set_mempolicy_fallback(int pid, char *policy_name);

Straight off, I don't like that policy_name is a string. Maybe, we would
export a mapping of ID to string names via /sys although it means users of
the API would have to parse /sys first which is undesirable.

Case 3: Dirty hack via /proc

We could have a proc entry like /proc/pid/fallback which behaves the same
as the cfs entry. I have a funny feeling that no one will go for this for
anything other than a proof of concept.


> I have the feeling that applications will want to give the same kind of
> notifications for swapping as they would for memory hotplug operations
> as well.  In decreasing order of pickiness:
>
> 1. Don't touch me at all
> 2. It's OK to migrate these pages elsewhere on this node
> 3. It's OK to migrate these pages anywhere
> 4. It's OK to swap these pages out
>

I think this is a separate issue because it affects page replacement both
locally and globally as well as allocation fallback policy.

-- 
Mel Gorman
Part-time Phd Student				Java Applications Developer
University of Limerick				    IBM Dublin Software Lab
