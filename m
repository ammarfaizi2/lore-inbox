Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSFIBac>; Sat, 8 Jun 2002 21:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317502AbSFIBab>; Sat, 8 Jun 2002 21:30:31 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2052 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317498AbSFIBaa>;
	Sat, 8 Jun 2002 21:30:30 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206090130.g591UVR434040@saturn.cs.uml.edu>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: davem@redhat.com (David S. Miller)
Date: Sat, 8 Jun 2002 21:30:31 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020608.160300.37239939.davem@redhat.com> from "David S. Miller" at Jun 08, 2002 04:03:00 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> From: Roland Dreier <roland@topspin.com>

>> which causes stack corruption: on the PPC
>> 440GP, pci_map_single() with PCI_DMA_FROMDEVICE just invalidates the
>> cache for the region being mapped.  However, if a buffer is smaller
>> than a cache line, then two bad things can happen.
>
> There is no allocation scheme legal for PCI DMA which gives you
> smaller than a cacheline of data, this includes SLAB.  This is why
> stack buffers and the like are illegal for PCI DMA.
>
>> The solution to this was simply to use kmalloc() to allocate buffers
>> instead of using automatic variables.
>
> Right.
>
>> However, this leads to my first question: is this safe on all
>> architectures?
>
> It must be.  If the architecture allows SLAB to give smaller than
> cacheline sized data, it must handle PCI DMA map/unmap flushing
> in an appropriate fashion (ie. handle sub-cacheline buffers).
>>
>> DMA-mapping.txt says kmalloc()'ed memory is OK for DMAs and does not
>> mention cache alignment.
>
> It doesn't mention cache alignment because that is an implementation
> specific issue.  The user of the interfaces need not be concerned
> about any of this.
>
> There need be no changes to the documentation.  If you do as the
> documentation states (use kmalloc or get_free_page to get your
> buffers) then it will just work.

On a non-SMP system, would it be OK to map all the memory
without memory coherency enabled? You seem to be implying that
one only needs to implement some mechanism in pci_map_single()
to handle flushing cache lines (write back, then invalidate).

This would be useful for Macs.


