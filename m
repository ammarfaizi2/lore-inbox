Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUDOTos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUDOTos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:44:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:32484 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262802AbUDOToj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:44:39 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040415123915.016523df.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081989517.1206.206.camel@arrakis>
	 <20040415123915.016523df.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1082058260.3111.73.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Apr 2004 12:44:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 03:39, Andi Kleen wrote:
> On Wed, 14 Apr 2004 17:38:37 -0700
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
> 
> 
> > 1) Redefine the value of some of the MPOL_* flags
> 
> I don't want to merge the flags the and the mode argument. It's ugly.

Well, if you're against adding a pid argument, this change is useless
anyway.


> > 2) Rename check_* to mpol_check_*
> 
> I really don't understand why you insist on renaming all my functions? 
> I like the current naming, thank you.

I don't want to rename them *all*! ;)  There's a million functions named
check_foo(), so why not a few more?  :)


> > 3) Remove get_nodes().  This should be done in the same manner as
> > sys_sched_setaffinity().  We shouldn't care about unused high bits.
> 
> I disagree on that. This would break programs that are first tested
> on a small machine and then later run on a big machine (common case)

I don't follow this argument...  How does this code work on a small
machine, but break on a big one:

DECLARE_BITMAP(nodes, MAX_NUMNODES);
BITMAP_CLEAR(nodes, MAX_NUMNODES);
set_bit(4, nodes);
mbind(startaddr, 8 * PAGE_SIZE, MPOL_PREFERRED, nodes, MAX_NUMNODES,
flags);

??

Userspace should be declaring an array of unsigned longs based on the
size of the machine they're running on.  If userspace programs are just
declaring arbitrary sized array and hoping that they'll work, they're
being stupid.  If they're declaring oversized arrays and not zeroing the
array before passing it in, then they're being lazy.  Either way, we're
going to throw the bits away, so do we care if they're being lazy or
stupid?  If the bits we care about are sane, then we do what userspace
tells us.  If the bits we care about aren't, we throw an error. 
Besides, we don't return an error when they pass us too little data, why
do we return an error when they pass too much?

I remember one of your concerns was checking that all the nodes with set
bits need to be online.  I think this is wrong.  We need to be checking
node_online_map at fault time, not at binding time.  Sooner or later
memory hotplug will go into the kernel, and then you're (or someone) is
going to have to rewrite how this is handled.  I'd rather do it right
the first time.


> > 4) Create mpol_check_flags() to, well, check the flags.  As the number
> > of flags and modes grows, it will be easier to do this check in its own
> > function.
> > 5) In the syscalls (sys_mbind() & sys_set_mempolicy()), change 'len' to
> > a size_t, add __user to the declaration of 'nmask', change 'maxnode' to
> 
> unsigned long is the standard for system calls.  Check some others. 

Ok.  I see this set of system calls as sort of the illegitimate
love-child of mlock()/mprotect() and sched_set/getaffinity(). 
sys_mlock() was using a size_t, so I copied that...


> > 'nmask_len', and condense 'flags' and 'mode' into 'flags'.  The
> > motivation here is to make this syscall similar to
> > sys_sched_setaffinity().  These calls are basically the memory
> > equivalent of set/getaffinity, and should look & behave that way.  Also,
> > dropping an argument leaves an opening for a pid argument, which I
> > believe would be good.  We should allow processes (with appropriate
> > permissions, of course) to mbind other processes.
> 
> Messing with other process' VM is a recipe for disaster. There 
> used to be tons of exploitable races in /proc/pid/mem, I don't want to repeat that.
> Adding pid to set_mem_policy would be a bit easier, but it would require
> to add a lock to the task struct for this. Currently it is nice and lockless
> because it relies on the fact that only the current process can change 
> its own policy. I prefer to keep it lockless, because that keeps the memory 
> allocation fast paths faster.

We're already grabbing the mmap_sem for writing when we modify the vma's
in sys_mbind.  I haven't looked at what kind of locking would be
necessary if we were modifying a *different* processes vma's, but I
figured that would at least be a good start.  If it's significantly more
complicated than that, you're probably right that it's not worth the
effort.


> > 6) Change how end is calculated as follows:
> > 	end = PAGE_ALIGN(start+len);
> > 	start &= PAGE_MASK;
> > Basically, this allows users to pass in a non-page aligned 'start', and
> > makes sure we mbind all pages from the page containing 'start' to the
> > page containing 'start'+'len'.
> 
> mprotect() does the EINVAL check on unalignment. I think it's better
> to follow mprotect here.

Ok.  I'm usually a fan of not failing if we don't *have* to, and an
unaligned start address is easily fixable.  On the other hand, if other
syscalls throw errors for it, then it's fine with me.


BTW, any response to the idea of combining sys_mbind() &
sys_set_mempolicy()?

-Matt

