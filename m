Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWFFRQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWFFRQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFFRQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:16:23 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:51375 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750942AbWFFRQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:16:22 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com>
	 <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org>
	 <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org>
	 <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org>
	 <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
	 <44848DD2.7010506@shadowen.org>
	 <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
	 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
	 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
	 <20060605135812.30138205.akpm@osdl.org>
	 <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 06 Jun 2006 19:16:23 +0200
Message-Id: <1149614184.29059.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 09:32 -0700, Christoph Lameter wrote: 
> > Whether it's correct depends on what Martin was trying to achieve
> > with his test.  I'm surprised to find a very ordinary
> > #define __swp_type(entry)	(((entry).val >> 2) & 0x1f)
> > in include/asm-s390/pgtable.h, and no architecture with a more
> > limiting mask.
> 
> Yes we need to hear from Martin.

s390 supports up to 32 swap devices. At the same time on 31 bit systems
only up to 4GB of swap is supported per device. That is because there
are three reserved bits in the 31 bit pte, (pte & 0x80000900) must be
zero. Bit 2^10 is the invalid bit, bit 2^9 the read-only bit. Two more
bits are needed to distinguish between the different pte types. That
makes 32-7 = 25 bits in total for offset and swap device. 5 bits are
used for the swap device number, and 20 for the offset.
I have chosen this split because for 31 the bit systems in 1999 the
standard dasd device has been a model 3 with a capacity of 2.6 GB.

So much for the history lesson.

> > Not really (though the clarity and reassurance of the additional
> > MAX_SWAPFILES test is good).  We went over it a year or two back,
> > and the macro contortions do involve MAX_SWAPFILES_SHIFT: which
> > up to and including 2.6.17 has enforced the MAX_SWAPFILES limit.
> 
> It looks though as if the testers were able to define more than 32 swap 
> devices. So there is the danger of overwriting the memory 
> following the swap info if we do not fix this.
> 
> Where are the macro contortions? No arch uses MAX_SWAPFILES_SHIFT for its 
> definitions and the only other significant use is in swapops.h to 
> determine the shift.

swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))
evaluates to 31 for s390. The idea has been that the creation of a swap
entry with ~0UL as the type should mask off all bits that can not be
represented in a swap entry. Convert it back and you have the maximum
number of swap devices. That should be true for all architectures.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


