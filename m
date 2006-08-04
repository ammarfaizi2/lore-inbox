Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161406AbWHDUlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161406AbWHDUlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161408AbWHDUlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:41:23 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:14525 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161406AbWHDUlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:41:21 -0400
Message-ID: <44D3B0F0.2010409@vmware.com>
Date: Fri, 04 Aug 2006 13:41:20 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru, Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <20060804183448.GE11244@sequoia.sous-sol.org>
In-Reply-To: <20060804183448.GE11244@sequoia.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
>   
>>> Who said that?  Please smack them on the head with a broom.  We are all 
>>> actively working on implementing Rusty's paravirt-ops proposal.  It 
>>> makes the API vs ABI discussion moot, as it allow for both.
>>>       
>> So everyone is still skirting the issue, oh great :)
>>     
>
> No, we are working closely together on Rusty's paravirt ops proposal.
> Given the number of questions I've fielded in the last 24 hrs, I really
> don't think people understand this.
>
> We are actively developing paravirt ops, we have a patch series that
> begins to implement it (although it's still in it's nascent stage).  If
> anybody is interested in our work it is done in public.  The working
> tree is here: http://ozlabs.org/~rusty/paravirt/ (mercurial patchqueue,
> just be forewarned that it's still quite early to be playing with it,
> doesn't do much yet).  We are using the virtualization mailing list for
> discussions https://lists.osdl.org/mailman/listinfo/virtualization if
> you are interested.
>
> Zach (please correct me if I'm wrong here), is working on plugging the
> VMI into the paravirt_ops interface.  So his discussion of binary
> interface issues is as a consumer of the paravirt_ops interface.
>   

To be completely clear, I am creating a set of paravirt_ops for ESX.  
This set of paravirt ops will still go through a binary indirection 
layer.  Hence, it is important for me to educate everyone on that layer 
and find out the opinions people have on what an acceptable license / 
source policy is for that layer.  We need the layer for exactly the same 
reason the vsyscall page is important.  We use it  to indirect 
hypervisor calls so that they can be future compatible, instead of 
forcing a particular hypervisor interface.  When running on Intel vs. 
AMD hardware, that interface may be different.  When running inside HVM 
hardware, VT or Pacifica, that interface _will_ be different.  We must 
allow for the possibility of alternative implementations.  This layer is 
very much like a PAL code layer that allows system level instructions to 
have alternative implementations, and also, most importantly, means we 
are free to change the structural layout of information which is shared 
between the hypervisor and the kernel.  This shared information will 
grow and need to change as it evolves over time.  But we can't break 
compatibility with precompiled Linux kernels.  So the layer needs to be 
there and needs to be separate from the kernel, and I need to do that in 
such a way that doesn't violate the licensing model of Linux or any 
other operating system, while making sure that also doesn't conflict 
with our corporate licensing policies.  This is not a trivial problem.

> So, in case it's not clear, we are all working together to get
> paravirt_ops upstream.  My personal intention is to do everything I can
> to help get things in shape to queue for 2.6.19 inclusion, and having
> confusion over our direction does not help with that agressive timeline.
>   
Paravirt_ops has long term benefits for the i386 (and x86_64) 
architectures.  This is independent in fact of whether Xen and VMware 
want to use the same ABI to talk to the hypervisor or not.  From my 
point of view, it is a cleaner way to implement the kernel backend to 
both VMI and Xen, since it removes the requirement that we create an 
entirely new sub-architecture for each hypervisor.  In the Xen case, 
they may want to run a dom-0 hypervisor which is compiled for an actual 
hardware sub-arch, such as Summit or ES7000.  Using a sub-arch for the 
hypervisor means you would need some kind of nested sub-architecture 
support.  This is ludicrous.  Instead, what paravirt-ops promises long 
term is a way to get rid of the sub-architecture layer altogether.  
Sub-arches like Voyager and Visual workstation have some strange 
initialization requirements, interrupt controllers, and SMP handling.  
Exactly the kind of thing which paravirt_ops is being designed to 
indirect for hypervisors.  In the end, there is no reason it can't be 
expanded to a more general purpose interface that removes the 
requirement to build separate kernels and maintain separate 
sub-architectures for each weird new tweak of i386.  As i386 moves into 
more embedded systems, I would expect to see these new sub-architectures 
begin to grow like a rash.  It's ugly, and hard to maintain.  I've 
broken SGI Visual workstation and Voyager support more than I'd care to 
admit because it is really hard to compile and test all of these 
different variations of i386.  In the end, it will finally be possible 
to compile and run a single i386 kernel binary that is actually capable 
of running on the full set of supported hardware.  This makes every 
distro and maintainers life a lot simpler.

The same approach can be used on x86_64 for paravirtualization, but also 
to abstract out vendor differences between platforms.  Opteron and EMT64 
hardware are quite different, and the plethora of non-standard 
motherboards and uses have already intruded into the kernel.  Having a 
clean interface to encapsulate these changes is also desirable here, and 
once we've nailed down a final approach to achieving this for i386, it 
makes sense to do x86_64 as well.

I'm now talking lightyears into the future, but when the i386 and x86_64 
trees merge together, this layer will be almost identical for the two, 
allowing sharing of tricky pieces of code, like the APIC and IO-APIC, 
NMI handling, system profiling, and power management.  It the interface 
evolves in a nicely packaged and compartmentalized way from that, then 
perhaps someday it can grow to become a true cross-architecture way to 
handle machine abstraction and virtualization.  Then you can compile a 
single kernel which gets assembled to code proto-fragments that are 
dynamically linked together during the boot sequence, using a 
cross-machine translation unit that allows a single kernel to run on 
every current and future processor architecture that mimics some 
combined set of machine characteristics (N-tiered cache coloring, 
multiway hardware page tables, hypercubic interrupt routing, dynamically 
morphed GPUs, quantum hypervisor isolation).  Of course, it will still 
require a PCI bus.

So absolutely we should go in that direction now, and I'm fully 
committed to working on it.  Which is why I wanted feedback on what we 
have to do to make sure our ESX implementation is done in a way that is 
acceptable to the community.  I too would like to push for an interface 
in 2.6.19, and we can't have confusion on this issue be a last minute 
stopper.

Maybe someday Xen and VMware can share the same ABI interface and both 
use a VMI like layer.  But that really is a separate and completely 
orthogonal question.  Paravirt-ops makes any approach to integrating 
hypervisor awareness into the kernel cleaner by providing an appropriate 
abstract interface for it.

Zach
