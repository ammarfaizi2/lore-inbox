Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWCNVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWCNVXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWCNVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:23:11 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51587 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750834AbWCNVXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:23:10 -0500
Date: Tue, 14 Mar 2006 13:27:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Message-ID: <20060314212742.GL12807@sorel.sous-sol.org>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <20060313224902.GD12807@sorel.sous-sol.org> <4416078C.4030705@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4416078C.4030705@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Pushing up the stack with a higher level API is a serious consideration, 
> but only if you can show serious results from it.  I'm not convinced 
> that you can actually hone in on anything /that isn't already a 
> performance problem on native kernels/.  Consider, for example, that we 
> don't actually support remote TLB shootdown IPIs via VMI calls.  Why is 
> this a performance problem?  Well, very likely, those IPI shootdowns are 
> going to be synchronous.  And if you don't co-schedule the CPUs in your 
> virtual machine, you might just have issued synchronous IPIs to VCPUs 
> that aren't even running.  A serious performance problem.
> 
> Is it?  Or is it really, just another case where the _native_ kernel can 
> be even more clever, and avoid doing those IPI shootdowns in the 
> firstplace?  I've watched IPI shootdown in Linux get drastically better 
> in the 2.6 series of kernels, and see (anecdotal number quoting) maybe 4 
> or 5 of them in the course of a kernel compile.  There is no longer a 
> giant performance boon to be gained here.
> 
> Similarly, you can almost argue the same thing with spinlocks - if you 
> really are seeing performance issues because of the wakeup of a 
> descheduled remote VPU, maybe you really need to think about moving that 
> lock off a hot path or using a better, lock free synchronization method.
> 
> I'm not arguing against these features - in fact, I think they can be 
> done in a way that doesn't intrude too much inside of the kernel.  After 
> all, locks and IPIs tend to be part of the lower layer architecture 
> anyways.  And they definitely do win back some of the background noise 
> introduced by virtualization.  But if you decide to make the interface 
> more complicated, you really need to have an accurate measure of exactly 
> what you can gain by it to justify that complexity.

Yes, I completely agree.  Without specific performance numbers it's just
hand waving.  To make it more concrete, I'll work on a compare/contrast
of the interfaces so we have specifics to discuss.

> >Included just for completeness can be beginning of API bloat.
> 
> The design impact of this bloat is zero - if you don't want to implement 
> virtual methods for, say, debug register access - then you don't need to 
> do anything.  You trap and emulate by default.  If on the other hand, 
> you do want to hook them, you are welcome to.  The hypervisor is free to 
> choose the design costs that are appropriate for their usage scenarios, 
> as is the kernel - it's not in the spec, but certainly is open for 
> debate that certain classes of instructions such as these need not even 
> be converted to VMI calls.  We did implement all of these in Linux for 
> performance and symmetry.

Yup.  Just noting that API without clear users is the type of thing that
is regularly rejected from Linux.

> >Many of these will look the same on x86-64, but the API is not
> >64-bit clean so has to be duplicated.
> 
> Yes, register pressure forces the PAE API to be slightly different from 
> the long mode API.  But long mode has different register calling 
> conventions anyway, so it is not a big deal.   The important thing is, 
> once the MMU mess is sorted out, the same interface can be used from C 
> code for both platforms, and the details about which lock primitives are 
> used can be hidden.  The cost of which lock primitives to use differs on 
> 32-bit and 64-bit platforms, across vendor, and the style of the 
> hypervisor implementation (direct / writable / shadowed page tables).

My mistake, it makes perfect sense from ABI point of view.

> >Is this the batching, multi-call analog?
> 
> Yes.  This interface needs to be documented in a much better fashion.  
> But the idea is that VMI calls are mapped into Xen multicalls by 
> allowing deferred completion of certain classes of operations.  That 
> same mode of deferred operation is used to batch PTE updates in our 
> implementation (although Xen uses writable page tables now, this used to 
> provide the same support facility in Xen as well).  To complement this, 
> there is an explicit flush - and it turns out this maps very nicely, 
> getting rid of a lot of the XenoLinux changes around mmu_context.h.

Are these valid differences?  Or did I misunderstand the batching
mechanism?

1) can't use stack based args, so have to allocate each data structure,
which could conceivably fail unless it's some fixed buffer.

2) complicates the rom implementation slightly where implementation of
each deferrable part of the API needs to have switch (am I deferred or
not) to then build the batch, or make direct hypercall.

3) flushing in smp, have to be careful to manage simulataneous defers
and flushes from potentially multiple cpus in guest.

Doesn't seem these are showstoppers, just differences worth noting.
There aren't as many multicalls left in Xen these days anyway.

thanks,
-chris
