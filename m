Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315364AbSEBTUW>; Thu, 2 May 2002 15:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315368AbSEBTUV>; Thu, 2 May 2002 15:20:21 -0400
Received: from holomorphy.com ([66.224.33.161]:34775 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315364AbSEBTUU>;
	Thu, 2 May 2002 15:20:20 -0400
Date: Thu, 2 May 2002 12:19:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502191903.GL32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
>> Being unable to have any ZONE_NORMAL above 4GB allows no change at all.

On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> No change if your first node maps the whole first 4G of physical address
> space, but in such case nonlinear cannot help you in any way anyways.
> The fact you can make no change at all has only to do with the fact
> GFP_KERNEL must return memory accessible from a pci32 device.

Without relaxing this invariant for this architecture there is no hope
that NUMA-Q can ever be efficiently operated by this kernel.


On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> I think most configurations have more than one node mapped into the
> first 4G, and so in those configurations you can do changes and spread
> the direct mapping across all the nodes mapped in the first 4G phys.

These would be partially-populated nodes. There may be up to 16 nodes.
Some unusual management of the interrupt controllers is required to get
the last 4 cpus. Those who know how tend to disavow the knowledge. =)


On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> the fact you can or you can't have something to change with discontigmem
> or nonlinear, it's all about pci32.

Artificially tying together the device-addressibility of memory and
virtual addressibility of memory is a fundamental design decision which
seems to behave poorly for NUMA-Q, though general it seems to work okay.


On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
>> 32-bit PCI is not used on NUMA-Q AFAIK.

On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> but can you plugin 32bit pci hardware into your 64bit-pci slots, right?
> If not, and if you're also sure the linux drivers for your hardware are all
> 64bit-pci capable then you can do the changes regardless of the 4G
> limit, in such case you can spread the direct mapping all over the whole
> 64G physical ram, whereever you want, no 4G constraint anymore.

I believe 64-bit PCI is pretty much taken to be a requirement; if it
weren't the 4GB limit would once again apply and we'd be in much
trouble, or we'd have to implement a different method of accommodating
limited device addressing capabilities and would be in trouble again.


On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
>> So long as zones are physically contiguous and __va() does what its

On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> zones remains physically contigous, it's the virtual address returned by
> page_address that changes. Also the kmap header will need some
> modification, you should always check for PageHIGHMEM in all places to
> know if you must kmap or not, that's a few liner.

I've not been using the generic page_address() in conjunction with
highmem, but this sounds like a very natural thing to do when the need
to do so arises; arranging for storage of the virtual address sounds
trickier, though doable. I'm not sure if mainline would want it, and
I don't feel a pressing need to implement it yet, but then again, I've
not yet been parked in front of a 64GB x86 machine yet...


On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> BTW, about the pgdat loops optimizations, you misunderstood what I meant
> in some previous email, with "removing them" I didn't meant to remove
> them in the discontigmem case, that would had to be done case by case,
> with removing them I meant to remove them only for mainline 2.4.19-pre7
> when kernel is compiled for x86 target like 99% of userbase uses it. A
> discontigmem using nonlinear also doesn't need to loop. It's a 1 branch
> removal optimization (doesn't decrease the complexity of the algorithm
> for discontigmem enabled). It's all in function of
> #ifndef CONFIG_DISCONTIGMEM.

>From my point of view this would be totally uncontroversial. Some arch
maintainers might want a different #ifdef condition but it's fairly
trivial to adjust that to their needs when they speak up.


On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> Dropping the loop when discontigmem is enabled is much more interesting
> optimization of course.
> Andrea

Absolutely; I'd be very supportive of improvements for this case as well.
Many of the systems with the need for discontiguous memory support will
also benefit from parallelizations or other methods of avoiding references
to remote nodes/zones or iterations over all nodes/zones.


Cheers,
Bill
