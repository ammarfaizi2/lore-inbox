Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSECAHi>; Thu, 2 May 2002 20:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315484AbSECAHh>; Thu, 2 May 2002 20:07:37 -0400
Received: from holomorphy.com ([66.224.33.161]:47320 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315480AbSECAGT>;
	Thu, 2 May 2002 20:06:19 -0400
Date: Thu, 2 May 2002 17:05:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503000500.GP32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anton Blanchard <anton@samba.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <E173Pe0-0002Bw-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 02:20, Anton Blanchard wrote:
>> From arch/ppc64/kernel/iSeries_setup.c:
>>  * The iSeries may have very large memories ( > 128 GB ) and a partition
>>  * may get memory in "chunks" that may be anywhere in the 2**52 real
>>  * address space.  The chunks are 256K in size.
>> Also check out CONFIG_MSCHUNKS code and see why I'd love to see a generic
>> solution to this problem.

On Fri, May 03, 2002 at 01:05:45AM +0200, Daniel Phillips wrote:
> Hmm, I just re-read your numbers above.  Supposing you have 256 GB of
> 'installed' memory, divided into 256K chunks at random places in the 52
> bit address space, a hash table with 1M entries could map all that
> physical memory.  You'd need 16 bytes or so per hash table entry, making
> the table 16MB in size.  This would be about .0006% of memory.

Doh! I made all that noise about "contiguously allocated" and the
relaxation of the contiguous allocation requirement on the aggregate
was the whole reason I liked trees so much! Regardless, if there's
virtual contiguity the table can work, and what can I say, it's not my
patch, and there probably isn't a real difference given that your
ratio to memory size is probably small enough to cope.


On Fri, May 03, 2002 at 01:05:45AM +0200, Daniel Phillips wrote:
> More-or-less equivalently, a tree could be used, with the tradeoff being
> a little better locality of reference vs more search steps.  The hash
> structure can also be tweaked to improve locality by making each hash
> entry map several adjacent memory chunks, and hoping that the chunks tend
> to occur in groups, which they most probably do.
> I'm offering the hash table, combined with config_nonlinear as a generic
> solution.

Is the virtual remapping for virtual contiguity available at the time
this remapping table is set up? A 1M-entry table is larger than the
largest available fragment of physically contiguous memory even at
1B/entry. If it's used to direct the virtual remapping you might need
to perform some arch-specific bootstrapping phases. Also, what is the
recourse of a boot-time allocated table when it overflows due to the
onlining of sufficient physical memory? Or are there pointer links
within the table entries so as to provide collision chains? If so,
then the memory requirements are even larger... If you limit the size
of the table to consume an entire hypervisor-allocated memory fragment
would that not require boot-time allocation of a fresh chunk from the
hypervisor and virtually mapping the new chunk? How do you know what
the size of the table should be if the number of chunks varies dramatically?


Cheers,
Bill
