Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUIXGoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUIXGoy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUIXGmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:42:35 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63626 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268526AbUIXGjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:39:00 -0400
Message-ID: <4153C1FA.3070508@sgi.com>
Date: Fri, 24 Sep 2004 01:43:06 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ray Bryant <raybry@austin.rr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 2/2] mm: eliminate node 0 bias in MPOL_INTERLEAVE
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net> <20040923043256.2132.93167.33080@raybryhome.rayhome.net> <20040923092954.GA4836@wotan.suse.de>
In-Reply-To: <20040923092954.GA4836@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending to removing annoying long lines....)

Andi Kleen wrote:
> On Wed, Sep 22, 2004 at 11:32:45PM -0500, Ray Bryant wrote:
> 
>>Each of these cases potentially breaks the (assumed) invariant of
> 
> 
> I would prefer to keep the invariant.
> 

I understand, but read on.

> 
>>+++ linux-2.6.9-rc2-mm1/mm/mempolicy.c	2004-09-21 17:44:58.000000000 -0700
>>@@ -435,7 +435,7 @@ asmlinkage long sys_set_mempolicy(int re
>> 		default_policy[policy] = new;
>> 	}
>> 	if (new && new->policy == MPOL_INTERLEAVE)
>>-		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
>>+		current->il_next = current->pid % MAX_NUMNODES;
> 
> 
> Please do the find_next/find_first bit here in the slow path. 
> 
> Another useful change may be to check if il_next points to a node
> that is in the current interleaving mask. If yes don't change it.
> This way skew when interleaving policy is set often could be avoided.
> 
> 
>> 	return 0;
>> }
>> 
>>@@ -714,6 +714,11 @@ static unsigned interleave_nodes(struct 
>> 
>> 	nid = me->il_next;
>> 	BUG_ON(nid >= MAX_NUMNODES);
>>+	if (!test_bit(nid, policy->v.nodes)) {
>>+		nid = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
>>+		if (nid >= MAX_NUMNODES)
>>+			nid = find_first_bit(policy->v.nodes, MAX_NUMNODES);
>>+	}
> 
> 
> And remove it here.
> 
> 
Regardless of whether we remove this or not, then we have a potential problem,
I think.  The reason is that there is a single il_next for all policies.  So
we get into trouble if the current process's page allocation policy and
its page cache allocation policy are MPOL_INTERLEAVE, but the node masks for
the two policies are significantly different. Just to be specific, suppose
there are 64 nodes, and the page allocation policy selects nodes 0-53 and
the page cache allocation policy chooses nodes 54-63.  Further suppose that
allocation requests are page, page cache, page, page cache, etc....

Then if il_next starts out at zero, here are the nodes that will be selected:
(I'm assuming here that the code I inserted above is not present.)

request a page, get 0 and using the page allocation mask, next is set to 1

request page cache, get 1 and using the page cache allocation mask, next is 
set to 54

request a page, get 54 and using the page allocation mask, next is set to 0

request page cache, get 0  and using the page cache allocation mask, next is 
set to 54

request a page, get 54 and using the page allocation mask, next is set to 0
etc...

This is not good.  Generally speaking, all of the pages are allocated from the
1st page cache node and all of the page cache pages are allocated from the 1st
page allocation node.

I guess I am back to passing an offset etc in via page cache alloc.  Or we
have to have a second il_next for the page cache policy, and that is more
cruft than we are willing to live with, I expect.

I'll look at Steve's patch and see how he handles this.

>> 	next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
>> 	if (next >= MAX_NUMNODES)
>> 		next = find_first_bit(policy->v.nodes, MAX_NUMNODES);
>>Index: linux-2.6.9-rc2-mm1/kernel/fork.c
>>===================================================================
>>--- linux-2.6.9-rc2-mm1.orig/kernel/fork.c	2004-09-21 16:24:49.000000000 -0700
>>+++ linux-2.6.9-rc2-mm1/kernel/fork.c	2004-09-21 17:41:12.000000000 -0700
>>@@ -873,6 +873,8 @@ static task_t *copy_process(unsigned lon
>> 			goto bad_fork_cleanup;
>> 		}
>> 	}
>>+	/* randomize placement of first page across nodes */
>>+	p->il_next = p->pid % MAX_NUMNODES;
> 
> 
> Same here.
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

