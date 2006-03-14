Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWCNAAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWCNAAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCNAAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:00:18 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:13833 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751466AbWCNAAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:00:17 -0500
Message-ID: <4416078C.4030705@vmware.com>
Date: Mon, 13 Mar 2006 16:00:12 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
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
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <20060313224902.GD12807@sorel.sous-sol.org>
In-Reply-To: <20060313224902.GD12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

Hi Chris, thank you for your comments.  I've tried to answer as much as 
I can - hopefully I found all your questions.

>> +     guest operating systems.  In the future, we envision that additional
>> +     higher level abstractions will be added as an adjunct to the
>> +     low-level API.  These higher level abstractions will target large
>> +     bulk operations such as creation, and destruction of address spaces,
>> +     context switches, thread creation and control.
>>     
>
> This is an area where in the past VMI hasn't been well-suited to support
> Xen.  It's the higher level abstractions which make the performance
> story of paravirt compelling.  I haven't made it through the whole
> patchset yet, but the bits you mention above as work to be done are
> certainly important to good performance.
>   

For example, multicalls, which we support, and batched page table 
operations, which we support, and vendor designed virtual devices, which 
we support.  What is unclear to me is why you need to keep pushing 
higher up the stack to get more performance.  If you could have any 
higher level hypercall you wanted, what would it be?  Most people say - 
fork() / exec().  But why?  You've just radically changed the way the 
guest must operate its MMU, and you've radically constrained the way 
page tables and memory management structures must be layed out by 
putting a ton of commonality in their infrastructure that is shared by 
the hypervisor and the kernel.  You've likely vastly complicated the 
design of a virtualized kernel that still runs on native hardware.  But 
what can you truly gain, that you can not gain from a simpler, less 
complicated interface that just says -

Ok, I'm about to update a whole bunch of pages tables.
Ok, I'm done and I might want to use them now.  Please make sure the 
hardware TLB will be in sync.

Pushing up the stack with a higher level API is a serious consideration, 
but only if you can show serious results from it.  I'm not convinced 
that you can actually hone in on anything /that isn't already a 
performance problem on native kernels/.  Consider, for example, that we 
don't actually support remote TLB shootdown IPIs via VMI calls.  Why is 
this a performance problem?  Well, very likely, those IPI shootdowns are 
going to be synchronous.  And if you don't co-schedule the CPUs in your 
virtual machine, you might just have issued synchronous IPIs to VCPUs 
that aren't even running.  A serious performance problem.

Is it?  Or is it really, just another case where the _native_ kernel can 
be even more clever, and avoid doing those IPI shootdowns in the 
firstplace?  I've watched IPI shootdown in Linux get drastically better 
in the 2.6 series of kernels, and see (anecdotal number quoting) maybe 4 
or 5 of them in the course of a kernel compile.  There is no longer a 
giant performance boon to be gained here.

Similarly, you can almost argue the same thing with spinlocks - if you 
really are seeing performance issues because of the wakeup of a 
descheduled remote VPU, maybe you really need to think about moving that 
lock off a hot path or using a better, lock free synchronization method.

I'm not arguing against these features - in fact, I think they can be 
done in a way that doesn't intrude too much inside of the kernel.  After 
all, locks and IPIs tend to be part of the lower layer architecture 
anyways.  And they definitely do win back some of the background noise 
introduced by virtualization.  But if you decide to make the interface 
more complicated, you really need to have an accurate measure of exactly 
what you can gain by it to justify that complexity.

Personally, I'm all for making lock primitives and shootdowns an 
_optional_ extension to the interface.  As with many other relatively 
straightforward and non-intrusive changes.  I know some of you will 
disagree with me, but I think a lot of what is being referred to as 
"higher level" paravirtualization is really an attempt to solve 
pre-existing problems in the performance of the underlying system.

There are advanced and useful things you can do with higher level 
paravirtualization, but I am not convinced at all that incredible 
performance gain is one of them.

> We do not want an interface which slows down the pace.  We work with
> source and drop cruft as quickly as possible (referring to internal
> changes, not user-visible ABI changes here).  Making changes that
> require a new guest for some significant performance gain is perfectly
> reasonable.  What we want to avoid is making changes that require a
> new guest to simply boot.  This is akin to rev'ing hardware w/out any
> backwards compatibility.  This goal doesn't require VMI and ROMs, but
> I agree it requires clear interface definitions.
>   

This is why we provide the minor / major interface numbers.  Bump the 
minor number, you get a new feature.  Bump the required minor version in 
the guest when it relies on that feature.  Bump the major number when 
you break compatibility.  More on this below.

>   
>> +    VMI_DeliverInterrupts (For future debate)
>> +
>> +       Enable and deliver any pending interrupts.  This would remove
>> +       the implicit delivery semantic from the SetInterruptMask and
>> +       EnableInterrupts calls.
>>     
>
> How do you keep forwards and backwards compat here?  Guest that's coded
> to do simple implicit version would never get interrupts delivered on
> newer ROM?
>   

This isn't part of the interface.  If it were to be included, you could 
do two things - bump the minor version, and add non-delivery semantic 
enable and restore interrupt calls, or bump the major version and drop 
the delivery semantic from the originals.

I agree this is pretty clumsy.  Expect to see more discussion about 
using annotations to expand the interface without breaking binary 
compatibility, as well as providing more advanced feature control.  I 
wanted to integrate more advanced feature control / probing into this 
version of the VMI, but there are so many possible ways to do it that it 
would be much nicer to get feedback from the community on what is the 
best interface.

>   
>> +   CPU CONTROL CALLS
>> +
>> +    These calls encapsulate the set of privileged instructions used to
>> +    manipulate the CPU control state.  These instructions are all properly
>> +    virtualizable using trap and emulate, but for performance reasons, a
>> +    direct call may be more efficient.  With hardware virtualization
>> +    capabilities, many of these calls can be left as IDENT translations, that
>> +    is, inline implementations of the native instructions, which are not
>> +    rewritten by the hypervisor.  Some of these calls are performance critical
>> +    during context switch paths, and some are not, but they are all included
>> +    for completeness, with the exceptions of the obsoleted LMSW and SMSW
>> +    instructions.
>>     
>
> Included just for completeness can be beginning of API bloat.
>   

The design impact of this bloat is zero - if you don't want to implement 
virtual methods for, say, debug register access - then you don't need to 
do anything.  You trap and emulate by default.  If on the other hand, 
you do want to hook them, you are welcome to.  The hypervisor is free to 
choose the design costs that are appropriate for their usage scenarios, 
as is the kernel - it's not in the spec, but certainly is open for 
debate that certain classes of instructions such as these need not even 
be converted to VMI calls.  We did implement all of these in Linux for 
performance and symmetry.

>   
> clts, setcr0, readcr0 are interrelated for typical use.  is it expected
> the hypervisor uses consitent regsister (either native or shadowed)
> here, or is it meant to be undefined?
>   

CLTS allows the elimination of an extra GetCR0 call, and they all 
operate on the same (shadowed) register.

> Many of these will look the same on x86-64, but the API is not
> 64-bit clean so has to be duplicated.
>   

Yes, register pressure forces the PAE API to be slightly different from 
the long mode API.  But long mode has different register calling 
conventions anyway, so it is not a big deal.   The important thing is, 
once the MMU mess is sorted out, the same interface can be used from C 
code for both platforms, and the details about which lock primitives are 
used can be hidden.  The cost of which lock primitives to use differs on 
32-bit and 64-bit platforms, across vendor, and the style of the 
hypervisor implementation (direct / writable / shadowed page tables).

>   
>   
>> +    85) VMI_SetDeferredMode
>>     
>
> Is this the batching, multi-call analog?
>   

Yes.  This interface needs to be documented in a much better fashion.  
But the idea is that VMI calls are mapped into Xen multicalls by 
allowing deferred completion of certain classes of operations.  That 
same mode of deferred operation is used to batch PTE updates in our 
implementation (although Xen uses writable page tables now, this used to 
provide the same support facility in Xen as well).  To complement this, 
there is an explicit flush - and it turns out this maps very nicely, 
getting rid of a lot of the XenoLinux changes around mmu_context.h.

>> +
>> +   VMI_CYCLES   64 bit unsigned integer
>> +   VMI_NANOSECS 64 bit unsigned integer
>>     
>
> All caps typedefs are not very popular w.r.t. CodingStyle.
>   

We know this.  This is not a Linux interface.  This is the API 
documentation, meant to be considerably different in style.  Where this 
ugliness has crept into our Linux patches, I have been steadily removing 
it and making them look nicer.  But the vast difference in the style of 
the doc is to avoid namespace collision.

>   
>> +   #define VMICALL __attribute__((regparm(3)))
>>     
>
> I understand it's for ABI documentation, but in Linux it's FASTCALL.
>   

Actually, FASTCALL is regparm(2), I think.

Cheers,

Zach
