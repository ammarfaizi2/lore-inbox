Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289783AbSAWKin>; Wed, 23 Jan 2002 05:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSAWKie>; Wed, 23 Jan 2002 05:38:34 -0500
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:25086 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S289685AbSAWKiZ>; Wed, 23 Jan 2002 05:38:25 -0500
Message-ID: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
Date: Wed, 23 Jan 2002 10:38:09 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-saarland.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: Daniel Robbins <drobbins@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The effect of the store is to write-allocate a cache line in the data
> cache and fill that cache line with data from the underlying physical
> memory. Because the line was write-allocated it is subsequently written
> back to physical memory even though the bits have not been changed by
> the processor. 

I'm not sure if I understand you correctly:

speculative write operations always set the cache line dirty bit, even
if the write operations is not executed (e.g. discarded due to a
mispredicted jump)

memory mapped by GART is not cache coherent, and the write-back of the
cache causes data corruptions.

Result: data corruption.

Is that correct?

Then "nopentium" only works by chance: I assume that speculative
operations do not walk the page tables, thus the probability that a
valid TLB entry is found for the GART mapped page is slim. But if there
is an entry, then the corruption would still occur.

How could we work around it?
a) At GART mapping time, we'd have to
- flush the cache
- unmap the pte entries that point to the pages that will be mapped by
GART
- create a new, uncached, ioremap mapping to the pages.

Obviously that won't work with 4 MB pages.

b) abuse highmem.
highmem memory is not mapped. If we only use highmem pages for GART, and
ensure that page->virtual is 0, then we know that no valid pte points
into the GART pages.
