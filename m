Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289865AbSA2UiX>; Tue, 29 Jan 2002 15:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSA2UiO>; Tue, 29 Jan 2002 15:38:14 -0500
Received: from holomorphy.com ([216.36.33.161]:51102 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289865AbSA2UiF>;
	Tue, 29 Jan 2002 15:38:05 -0500
Date: Tue, 29 Jan 2002 12:39:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129123932.K899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Momchil Velikov <velco@fadata.bg>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Oliver Xymoron <oxymoron@waste.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <20020129115548.J899@holomorphy.com> <Pine.LNX.4.33.0201291200530.966-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0201291200530.966-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 12:08:20PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 12:18:42PM +0200, Momchil Velikov wrote:
>>> PS. Well, the whole pgd/pmd/ptb stuff is ia32-ism, but that's another
>>> story.

On Tue, 29 Jan 2002, William Lee Irwin III wrote:
>> Perhaps something can be done about that.

On Tue, Jan 29, 2002 at 12:08:20PM -0800, Linus Torvalds wrote:
> The pgd/pmd/pte thing is _not_ a ia32-ism.
> A tree-based data structure is very much a generic portable construct, and
> is, in fact, the only sane way to maintain VM mappings.

In my mind it's not about the form but about how much of it is exposed.
For instance, exposing the number of levels seems to require emulating
an extra level for machines with 2-level pagetables. There is also a
(perhaps minor) issue with this exposure creating some extra codework
in mm/*.c -- here most of what's needed is largely a for_each_pte()
that can pick a range to walk over.

On Tue, Jan 29, 2002 at 12:08:20PM -0800, Linus Torvalds wrote:
> The fact that Linux tries very hard to allow the portable data structure
> to be _represented_ using the same data structures that the hardware uses
> for the TLB lookup is a separate issue, and mainly helps performance and
> TLB coherency. And even then it's not a ia32-ism: every single sane
> architecture out there is either soft-fill TLB (in which case a tree is
> fine), or already is a tree (ia32, x86-64, alpha, m68k etc).

It's quite a happy coincidence when this happens, and in my mind making
it happen more often would be quite nice.

On Tue, Jan 29, 2002 at 12:08:20PM -0800, Linus Torvalds wrote:
> The others are just stupid aberrations (ie the ppc hash-tables), and can
> portably be considered nothing but in-memory TLB's.

Ouch! Well, you have spoken.

On Tue, Jan 29, 2002 at 12:08:20PM -0800, Linus Torvalds wrote:
> However, in order to allow other architectures to share their hardware
> page tables with the Linux software VM mappings, we _should_ take their
> page walkers into account. It would be a pity if the Linux page table
> abstraction was too removed from some machines reality.

This is definitely one of the directions in which I intended to move.
If I can't bring the software pagetables closer to the hardware ones,
then it's not worthwhile.


Thanks,
Bill
