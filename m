Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314659AbSEBRSU>; Thu, 2 May 2002 13:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314661AbSEBRSS>; Thu, 2 May 2002 13:18:18 -0400
Received: from holomorphy.com ([66.224.33.161]:2519 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314659AbSEBRSQ>;
	Thu, 2 May 2002 13:18:16 -0400
Date: Thu, 2 May 2002 10:16:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502171655.GJ32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
>> Even with 64 bit DMA, the real problem is breaking the assumption
>> that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
>> That's 90% of the difficulty of what Dan's doing anyway, as I
>> see it.

On Thu, May 02, 2002 at 06:40:37PM +0200, Andrea Arcangeli wrote:
> control on virt_to_page, pci_map_single, __va.  Actually it may be as
> well cleaner to just let the arch define page_address() when
> discontigmem is enabled (instead of hacking on top of __va), that's a
> few liner. (the only true limit you have is on the phys ram above 4G,
> that cannot definitely go into zone-normal regardless if it belongs to a
> direct mapping or not because of pci32 API)
> Andrea

Being unable to have any ZONE_NORMAL above 4GB allows no change at all.
32-bit PCI is not used on NUMA-Q AFAIK.

So long as zones are physically contiguous and __va() does what its
name implies, page_address() should operate properly aside from the
sizeof(phys_addr) > sizeof(unsigned long) overflow issue (which I
believe was recently resolved; if not I will do so myself shortly).
With SGI's discontigmem, one would need an UNMAP_NR_DENSE() as the
position in mem_map array does not describe the offset into the region
of physical memory occupied by the zone. UNMAP_NR_DENSE() may be
expensive enough architectures using MAP_NR_DENSE() may be better off
using ARCH_WANT_VIRTUAL, as page_address() is a common operation. If
space conservation is as important a consideration for stability as it
is on architectures with severely limited kernel virtual address spaces,
it may be preferable to implement such despite the computational expense.
iSeries will likely have physically discontiguous zones and so it won't
be able to use an address calculation based page_address() either.


Cheers,
Bill
