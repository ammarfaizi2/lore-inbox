Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSGOStG>; Mon, 15 Jul 2002 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGOStF>; Mon, 15 Jul 2002 14:49:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54148 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317592AbSGOStD>;
	Mon, 15 Jul 2002 14:49:03 -0400
Message-ID: <3D331956.1070603@us.ibm.com>
Date: Mon, 15 Jul 2002 11:49:58 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch[ Simple Topology API
References: <3D2F75D7.3060105@us.ibm.com> <3D2F9521.96D7080B@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 > Matt,
 >
 > I suspect what happens when these patches come out is that most people simply
 > don't have the knowledge/time/experience/context to judge them, and nothing
 > ends up happening.  No way would I pretend to be able to comment on the
 > big picture, that's for sure.
Absolutely correct.  I know that most people here on LKML don't have 8, 16, 32, 
or more CPU systems to test this code on, or for that matter, even care about 
code designed for said systems.  I'm lucky enough to get to work on such 
machines, and I'm sure there are others out there (as evidenced by some of the 
replies I've gotten) that do care.  Also, there are publicly available NUMA 
machines in the OSDL that people can use to "play" on large systems.  I hope 
that by seeing code and using these systems, some more people might get 
interested in some of the interesting scalability issues that crop up with 
these machines.

 > If the code is clean, the interfaces make sense, the impact on other
 > platforms is minimised and the stakeholders are OK with it then that
 > should be sufficient, yes?
I would hope so.  That's what I'm trying to establish! ;)

 > AFAIK, the interested parties with this and the memory binding API are
 > ia32-NUMA, ia64, PPC, some MIPS and x86-64-soon.  It would be helpful
 > if the owners of those platforms could review this work and say "yes,
 > this is something we can use and build upon".  Have they done that?
I've gotten some feedback from large systems people.  I hope to get feedback 
from anyone with large systems that could potentially use this kind of API, and 
get a "this is great" or a "this sucks".  I believe that bigger systems need 
new ways to improve efficiency and scalability than what the kernel offers now. 
  I know I do...

 > I'd have a few micro-observations:
 >
 >>...
 >>--- linux-2.5.25-vanilla/kernel/membind.c       Wed Dec 31 16:00:00 1969
 >>+++ linux-2.5.25-api/kernel/membind.c   Fri Jul 12 16:13:17 2002
 >>..
 >>+inline int memblk_to_node(int memblk)
 >
 >
 > The inlines with global scope in this file seem strange?
 >
 >
 > Matthew Dobson wrote:
 >
 >>Here is a Memory Binding API
 >>...
 >>+    memblk_binding:    { MEMBLK_NO_BINDING, MPOL_STRICT },             \
 >
 >
 >>...
 >>+typedef struct memblk_list {
 >>+       memblk_bitmask_t bitmask;
 >>+       int behavior;
 >>+       rwlock_t lock;
 >>+} memblk_list_t;
 >
 >
 > Is is possible to reduce this type to something smaller for
 > CONFIG_NUMA=n?
Probably...  I'll look at that today...

 > In the above task_struct initialiser you should initialise the
 > rwlock to RWLOCK_LOCK_UNLOCKED.
Yep..  Totally forgot about that! :(

 > It's nice to use the `name:value' initialiser format in there, too.
Sure, enhanced readability is always a good thing!

 >>...
 >>+int set_memblk_binding(memblk_bitmask_t memblks, int behavior)
 >>+{
 >>...
 >>+       read_lock_irqsave(&current->memblk_binding.lock, flags);
 >
 >
 > Your code accesses `current' a lot.  You'll find that the code
 > generation is fairly poor - evaluating `current' chews 10-15
 > bytes of code.  You can perform a manual CSE by copying current
 > into a local, and save a few cycles.
Sure..  I've actually gotten a couple different ideas about improving the 
efficiency of that function, and will also be rewriting that today..

 >>...
 >>+struct page * _alloc_pages(unsigned int gfp_mask, unsigned int order)
 >>+{
 >>...
 >>+       spin_lock_irqsave(&node_lock, flags);
 >>+       temp = pgdat_list;
 >>+       spin_unlock_irqrestore(&node_lock, flags);
 >
 >
 > Not sure what you're trying to lock here, but you're not locking
 > it ;)  This is either racy code or unneeded locking.
To be honest, I'm not entirely sure what that's locking either.  That is the 
non-NUMA path of that function, and the locking was in the original code, so I 
just moved it along.  After doing a bit of searching, that lock seems 
COMPLETELY useless there.  Especially since in the original function, a few 
lines further down pgdat_list is read again, without the lock!  I guess, unless 
someone here says otherwise, I'll pull that locking out of the next rev.

Thanks for all the feedback.  I'll incorporate most of it into the next rev of 
the patch!

Cheers!

-Matt


 >
 >
 > Thanks.
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 >

