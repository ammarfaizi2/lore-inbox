Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVCSKLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVCSKLB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 05:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVCSKLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 05:11:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30349 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262439AbVCSKKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 05:10:51 -0500
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, riel@redhat.com,
       Ian.Pratt@cl.cam.ac.uk, kurt@garloff.de, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
References: <E1DBsgI-0001Cg-00@mta1.cl.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Mar 2005 03:07:18 -0700
In-Reply-To: <E1DBsgI-0001Cg-00@mta1.cl.cam.ac.uk>
Message-ID: <m1k6o40x0p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser <Keir.Fraser@cl.cam.ac.uk> writes:

> > > now, the patch lines that poke into the GATT I guess stay as they are. 
> > > We can maintain an out-of-tree patch for Xen, or perhaps if 
> > > virt_to_phys() is not used very much we can override its definition.
> > 
> > It sounds like xen is trying to overload the concepts of physical and
> > bus addresses to represent the mapping from "logical" addresses seen
> > by the kernel to "absolute" addresses (the "real" physical
> > addresses).  IMHO that is a mistake and will only lead to trouble.
> 
> Well, actually it has worked well for us so far. Our model of memory
> allocation amongst Xen guests is fine-grained (page granularity). The
> fact a guest can get random sparse physical pages does not fit well
> with Linux's expectation (even with discontig-mem builds) of at least
> getting fairly large contiguous physical chunks of RAM.

There is data excess data structure but it fits fine.  You simply
allocate one region and set PG_reserved on all of the pages that
the OS does not have access too.  Trivial and you don't have
to hack anything.

Larger than 4K granularity pages are important for performance reasons
in a number of contexts.  The primary reason is the large pages allow
a reduction in tlb misses.  But it is worth noting that DRAM pages
can be as large as 32KiB.  So there are other cases where there are
benefits in dealing with contiguous memory addresses besides reducing
the tlb miss count.

> For this reason, we do rather abuse the notion of 'phys'
> addresses. But we get away with it because it really doesn't matter to
> the VM system that these addresses bear no relation to reality. In
> most cases that it does matter it is because we are programming an I/O
> device, in which case we have convenient hook points (bus-address
> macros and the DMA-mapping interface). Another slightly tricky one was
> block-I/O buffer merging but, again, we found a fairly clean way of
> hooking that in an appropriate manner.

You also have broken kexec.  

And how well does hugetlbfs work under Xen?
 
> I'd be happy to cook up a patch to do this if it isn't too offensive
> for anyone.

For this specific case there may be another resolution but could
you please, please look at marking the missing pages PG_reserved
and not hacking phys_to_virt.

At this point anything short of explicitly introducing an intermediate
step say virt_to_logical() logical_to_virt() will be extremely
confusing and lead to very hard to spot bugs.  Silently changing
the semantics of functions is bad.

Eric
