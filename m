Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUDIFjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 01:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDIFjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 01:39:46 -0400
Received: from zero.aec.at ([193.170.194.10]:50698 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261779AbUDIFjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 01:39:43 -0400
To: colpatch@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
References: <1IsMQ-3vi-35@gated-at.bofh.it> <1IsMS-3vi-45@gated-at.bofh.it>
	<1It5U-3J1-21@gated-at.bofh.it> <1ItfE-3PL-3@gated-at.bofh.it>
	<1ISQC-7Cv-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 09 Apr 2004 07:39:37 +0200
In-Reply-To: <1ISQC-7Cv-5@gated-at.bofh.it> (Matthew Dobson's message of
 "Fri, 09 Apr 2004 03:20:06 +0200")
Message-ID: <m3d66hwvza.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> writes:
>
> Instead of looking up a page's node number by
> page_zone(p)->zone_pgdat->node_id, you can get the same information much
> more efficiently by doing some bit-twidling on page->flags.  Use
> page_nodenum(struct page *) from include/linux/mm.h.

That wasn't there when I wrote the code. I will do that change, thanks.

> So it looks like you *are* sharing policies, at least for VMA's in the
> range of a single mbind() call?  This is a good start! ;)  Looking
> further ahead, I'm a bit confused.  It seems despite *sharing* VMA's
> belonging to a single mbind() call, you *copy* VMA's during dup_mmap(),
> copy_process(), split_vma(), and move_vma().  So in the majority of
> cases you duplicate policies instead of sharing them, but you *do* share
> them in some instances?  Why the inconsistency?

Locking. policies get locked by their VM.

(the sharing you're advocating would require adding a new lock to 
mempolicy) 

>> +/* Change policy for a memory range */
>> +asmlinkage long sys_mbind(unsigned long start, unsigned long len,
>> +			  unsigned long mode,
>> +			  unsigned long *nmask, unsigned long maxnode,
>> +			  unsigned flags)
>
> What would you think about giving sys_mbind() a pid argument, like
> sys_sched_setaffinity()?  It would make it much easier for sysadmins to
> use the API if they didn't have to rewrite applications to make these
> calls on their own.  There's already a plethora of arguments, so one
> more might be overkill....  Just a thought.

It already has 6 arguments - 7 are not allowed. Also playing with a different
process' VM remotely is just a recipe for disaster IMHO (remember
all the security holes that used to be in /proc/pid/mem)

> Why not condense both the sys_mbind() & sys_set_mempolicy() into a
> single call?  The functionality of these calls (and even their code) is
> very similar.  The main difference is there is no need for looking up
> VMA's and doing locking in the sys_set_mempolicy() case.  You overload
> the output side (sys_get_mempolicy()) to handle both whole process and
> memory range options, but you don't do the same on the input
> (sys_mbind() and sys_set_mempolicy()).  Saving one syscall and having
> them behave more symmetrically would be a nice addition...

I think it's cleaner to have them separated. 

>> +/* Retrieve NUMA policy */
>> +asmlinkage long sys_get_mempolicy(int *policy,
>> +				  unsigned long *nmask, unsigned long maxnode,
>> +				  unsigned long addr, unsigned long flags)	
>
> I had a thought...  Shouldn't all your user pointers be marked as such
> with __user?  Ie:

I figure that the people who use the tools who need such ugly annotations
will add them themselves.

>
>> +{
>> +	int err, pval;
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma = NULL; 	
>> +	struct mempolicy *pol = current->mempolicy;
>> +
>> +	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
>> +		return -EINVAL;
>> +	if (nmask != NULL && maxnode < numnodes)
>> +		return -EINVAL;
>
> Did you mean: if (nmask == NULL || maxnode < numnodes) ?

No, the original test is correct.

> I think that BUG_ON should be BUG_ON(nid < 0), since it *shouldn't* be
> possible to get through that loop with nid >= MAX_NUMNODES.  The only
> line that could set nid >= MAX_NUMNODES is nid = find_next_bit(...); and
> the very next line ensures that if nid is in fact >= MAX_NUMNODES it
> will be set to -1.  It actually looks pretty redundant altogether,
> but...

Yes, it could be removed.

-Andi

