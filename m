Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318037AbSGMCjM>; Fri, 12 Jul 2002 22:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318072AbSGMCjL>; Fri, 12 Jul 2002 22:39:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318037AbSGMCjK>;
	Fri, 12 Jul 2002 22:39:10 -0400
Message-ID: <3D2F9521.96D7080B@zip.com.au>
Date: Fri, 12 Jul 2002 19:49:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch[ Simple Topology API
References: <3D2F75D7.3060105@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> 
> Here is a very rudimentary topology API for NUMA systems.  It uses prctl() for
> the userland calls, and exposes some useful things to userland.  It would be
> nice to expose these simple structures to both users and the kernel itself.
> Any architecture wishing to use this API simply has to write a .h file that
> defines the 5 calls defined in core_ibmnumaq.h and include it in asm/mmzone.h.

Matt,

I suspect what happens when these patches come out is that most people simply
don't have the knowledge/time/experience/context to judge them, and nothing
ends up happening.  No way would I pretend to be able to comment on the
big picture, that's for sure.

If the code is clean, the interfaces make sense, the impact on other
platforms is minimised and the stakeholders are OK with it then that
should be sufficient, yes?

AFAIK, the interested parties with this and the memory binding API are
ia32-NUMA, ia64, PPC, some MIPS and x86-64-soon.  It would be helpful
if the owners of those platforms could review this work and say "yes,
this is something we can use and build upon".  Have they done that?


I'd have a few micro-observations:

> ...
> --- linux-2.5.25-vanilla/kernel/membind.c       Wed Dec 31 16:00:00 1969
> +++ linux-2.5.25-api/kernel/membind.c   Fri Jul 12 16:13:17 2002
> ..
> +inline int memblk_to_node(int memblk)

The inlines with global scope in this file seem strange?


Matthew Dobson wrote:
> 
> Here is a Memory Binding API
> ...
> +    memblk_binding:    { MEMBLK_NO_BINDING, MPOL_STRICT },             \

> ...
> +typedef struct memblk_list {
> +       memblk_bitmask_t bitmask;
> +       int behavior;
> +       rwlock_t lock;
> +} memblk_list_t;

Is is possible to reduce this type to something smaller for
CONFIG_NUMA=n?

In the above task_struct initialiser you should initialise the
rwlock to RWLOCK_LOCK_UNLOCKED.

It's nice to use the `name:value' initialiser format in there, too.


> ...
> +int set_memblk_binding(memblk_bitmask_t memblks, int behavior)
> +{
> ...
> +       read_lock_irqsave(&current->memblk_binding.lock, flags);

Your code accesses `current' a lot.  You'll find that the code
generation is fairly poor - evaluating `current' chews 10-15
bytes of code.  You can perform a manual CSE by copying current
into a local, and save a few cycles.

> ...
> +struct page * _alloc_pages(unsigned int gfp_mask, unsigned int order)
> +{
> ...
> +       spin_lock_irqsave(&node_lock, flags);
> +       temp = pgdat_list;
> +       spin_unlock_irqrestore(&node_lock, flags);

Not sure what you're trying to lock here, but you're not locking
it ;)  This is either racy code or unneeded locking.


Thanks.
