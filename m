Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031147AbWI0WY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031147AbWI0WY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031148AbWI0WY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:24:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22421 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031147AbWI0WYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:24:55 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <1159392487.23458.70.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <1159386644.4773.80.camel@linuxchandra>
	 <1159392487.23458.70.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 27 Sep 2006 15:24:52 -0700
Message-Id: <1159395892.4773.107.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 14:28 -0700, Rohit Seth wrote:

Rohit,

For 1-4, I understand the rationale. But, your implementation deviates
from the current behavior of the VM subsystem which could affect the
ability of these patches getting into mainline.

IMO, the current behavior in terms of reclamation, LRU, vm_swappiness,
and writeback logic should be maintained.

> On Wed, 2006-09-27 at 12:50 -0700, Chandra Seetharaman wrote:
> > Rohit,
> > 
> > I finally looked into your memory controller patches. Here are some of
> > the issues I see:
> > (All points below are in the context of page limit of containers being
> > hit and the new code starts freeing up pages)
> > 
> > 1. LRU is ignored totally thereby thrashing the working set (as pointed
> >    by Peter Zijlstra).
> 
> As the container goes over the limit, this algorithm deactivates some of
> the pages.  I agree that the logic to find out the correct pages to
> deactivate needs to be improved.  But the idea is that these pages go in
> front of inactive list so that if there is any memory pressure system
> wide then these pages can easily be reclaimed.
> 
> > 2. Frees up file pages first when hitting the page limit thereby making 
> >    vm_swappiness ineffective.
> 
> Not sure if I understood this part correctly.  But the choice when the
> container goes over its limit is between swap out some of the anonymous
> memory first or writeback some of the dirty file pages belonging to this
> container.
> 
> > 3. Starts writing back pages when the # of file pages is close to the 
> >    limit, thereby breaking the current writeback algorithm/logic.
> 
> That is done so as to ensure processes belonging to container (Whose
> limit is hit) are the first ones getting penalized.  For example, if you
> run a tar in a container with 100MB limit then the dirty file pages will
> be written back to disk when 100MB limit is hit).  Though I will be
> adding a HARD_LIMIT on page cache flag and the strict limit will be only
> maintained if this container flag is set.
> 
> > 4. MAPPED files are not counted against the page limit. why ?. This
> >    affects reclamation behavior and makes vm_swappiness ineffective.
> 
> num_mapped_pages only indicates how many page cache pages are mapped in
> user page tables.  More of an accounting variable.

But, # of mapped pages is used in the reclamation path logic. These set
of patches doesn't take them into account.
  
> 
> > 5. Starts freeing up pages from the first task or the first file in the
> >    linked list. This logic unfairly penalizes the early members of the 
> >    list.
> 
> This is the part that I've to fix.  Some per container variables that
> remembers the last values will help here.

Yes, that will help in fairness between the items in the list.

But, it will still suffer from (1) above, as we would have no idea of
the current working set (LRU) (within an item or among the items).

> 
> > 6. Both active and inactive pages use physical pages. But, the 
> >    controller only counts active pages and not inactive pages. why ?
> 
> The thought is, it is okay for containers to go over its limit as long

Real number of "physical pages" used by the container is the sum of
active and inactive pages.

My question is, shouldn't that be used to check against page limit
instead of active pages alone ?

How do we describe "page limit" as (to the user) ?

> as there is enough memory in the system. When there is any memory
> pressure then the inactive (+ dereferenced) pages get swapped out thus
> penalizing the container.  I'm also thinking of having hard limit for

Reclamation goes through active pages and page cache pages before it
gets into inactive pages. So, this may not work as you are explaining.
 
> anonymous pages beyond which the container will not be able to grow its
> anonymous pages.

You might break the current behavior (memory pressure must be very high
before these starts failing) if you are going to be strict about it.

> 
> > 7. Page limit is checked against the sum of (anon and file pages) in 
> >    some places and against active pages at some other places. IMO, it 
> >    should be always compared to the same value.
> > 
> It is checked against sum of anon+file pages at the time when new pages

why can't we check against active pages here ?

> is getting allocated.  But as the reclaimer activate the pages, so it is
> also important to make sure the number of active pages is not going
> above its limit.

My point is that they won't be same (ever) and hence the check is
inconsistent. 

Also, if it is this way, how do we describe the purpose of "page
limit" (for the user).

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


