Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284536AbRLUKBt>; Fri, 21 Dec 2001 05:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286532AbRLUKBj>; Fri, 21 Dec 2001 05:01:39 -0500
Received: from holomorphy.com ([216.36.33.161]:37504 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S284536AbRLUKB1>;
	Fri, 21 Dec 2001 05:01:27 -0500
Date: Fri, 21 Dec 2001 02:01:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: aspects of bootmem design (was: Re: [PATCH] MAX_MP_BUSSES increase)
Message-ID: <20011221020110.B766@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200112210419.fBL4Jfq08533@butler1.beaverton.ibm.com> <Pine.LNX.4.33.0112211131130.2269-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0112211131130.2269-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Dec 21, 2001 at 11:42:40AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 11:42:40AM +0100, Ingo Molnar wrote:
> no, it does not happen. Eg. on x86, we first set up bootmem, then we
> allocate multiple times, then we free all the remaining areas. Not a
> single place for fragmentation to happen, apart from the skipping issue i
> mentioned in the previous mail (and which isnt solved by the tree
> structure either). A complex pattern of bootmem-alloc/bootmem-free is just
> not the common thing to do - we usually dont do anything complex before
> initializating the real allocators.

As someone who has literally tracked every bootmem operation and the
effects on the state of the bootmem allocator that happens during the
entire lifetime of the bootmem allocator on a few different machines,
I will say that fewer than 10 calls to alloc_bootmem_core() occur on
the i386 PC's I've seen on kernels from 2.4.15-pre5 to 2.4.17-pre1.

On Fri, Dec 21, 2001 at 11:42:40AM +0100, Ingo Molnar wrote:
> William, could you please give us the amount of RAM saved on your box,
> with and without your tree-structure patch applied?

I will do so in short order, but I will first say a few things:

	(1) I am not using a true allocation algorithm.
		I am using essentially devices I contrived myself to
		respect the semantics of the existing bootmem interfaces.

	(2) The complex allocation and freeing pattern is neither the
		problem this tries to solve, nor is it except by perhaps
		some side-effects something that happens to benefit.
		The in-line documentation (if you would like more, I
		will write more with both haste and precision) attempts
		to present the issues it was designed to address.
		I will also answer not only specific questions, but
		also present descriptions of the motivations, the
		mechanisms, the results, the testing, and the algorithms
		in whatever level of detail the questioner would like,
		with the small proviso that the more detailed the
		response requested, the larger the time I will need
		to prepare the response.

	(3) Yes, I presented results regarding memory savings, and
		they are factual. I stated, if I recall properly,
		that they are minor on i386 and reported them as they
		were reported to me by independent testers. I also
		reported results that came back to me from independent
		testing that were larger than those I had seen myself.

	(4) The tree structure is not the essential aspect. The tree
		structure is to eliminate exhaustive search, and the
		particular tree (treaps) were chosen on the basis of
		a recommendation in Knuth vol 3 regarding support for
		searches on dynamic sets of intervals. Some have objected
		to the complexity of the structure. Other feedback
		came back as well that said the tree structures were
		good and efficient, which counterbalanced that.

	(5) The essential aspect is an extent-based representation of
		available physical memory. The existing bootmem uses
		a direct-mapped tabulation of available physical pages,
		which requires foreknowledge by arch/*/kernel/setup.c
		of all the available ranges of physical memory, including
		(you guessed it) building up a different extent-based
		representation for just about every architecture.

		The caller's task is simplified when the layout of the
		data structures used to track the memory are not dependent
		upon the layout of the memory itself, and a small
		demonstration of this can be arranged.


Cheers,
Bill
