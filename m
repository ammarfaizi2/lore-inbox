Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317332AbSFIGdj>; Sun, 9 Jun 2002 02:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317567AbSFIGdi>; Sun, 9 Jun 2002 02:33:38 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:48390 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317332AbSFIGdf>;
	Sun, 9 Jun 2002 02:33:35 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206090633.g596XZI472183@saturn.cs.uml.edu>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: davem@redhat.com (David S. Miller)
Date: Sun, 9 Jun 2002 02:33:35 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020608.222942.111546622.davem@redhat.com> from "David S. Miller" at Jun 08, 2002 10:29:42 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> From: "Albert D. Cahalan" <acahalan@cs.uml.edu>

>> On a non-SMP system, would it be OK to map all the memory
>> without memory coherency enabled? You seem to be implying that
>> one only needs to implement some mechanism in pci_map_single()
>> to handle flushing cache lines (write back, then invalidate).
>>
>> This would be useful for Macs.
>
> It's just avoiding flushing by effecting flushing the cache after
> every load/store the cpu does, so of course it would work.
>
> It would be slow as hell, but it would work.

I don't see why it would have to be slow. Mapping the memory
with coherency disabled will reduce bus traffic for all the
regular kernel code doing non-DMA stuff. (coherency requires
that the CPU generate address-only bus operations)

The obvious concern is that some kernel code might touch
a cache line after the invalidate but before the DMA is
done. If that could be considered a bug, then every non-SMP
Mac could gain some speed by turning off coherency.
Maybe the x86 MTRRs allow for something similar.

For device --> memory DMA:

1. write back cache lines that cross unaligned boundries
2. start the DMA
3. invalidate the above cache lines
4. invalidate cache lines that are fully inside the DMA

For memory --> device DMA:

1. write back all cache lines affected by the DMA
2. start the DMA
3. invalidate the above cache lines

