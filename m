Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289862AbSA2UKJ>; Tue, 29 Jan 2002 15:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289863AbSA2UKA>; Tue, 29 Jan 2002 15:10:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50440 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289862AbSA2UJt>; Tue, 29 Jan 2002 15:09:49 -0500
Date: Tue, 29 Jan 2002 12:08:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <20020129115548.J899@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0201291200530.966-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, William Lee Irwin III wrote:
>
> On Tue, Jan 29, 2002 at 12:18:42PM +0200, Momchil Velikov wrote:
> > COW at pgd/pmd level is ia32-ism, unlike COW at pte level.
>
> Pain! Well, at least the pte markings dodge the page_add_rmap() bullet.

You can portably mark then non-present, at some higher cost. That choice
would have to be left to the architecture configuration (the same way the
dirty and accessed bits are left to the architecture - some hardware
supports them directly, others have to trap and emulate them)

So if would not be out of the question to have a

	pmd_mkrdonly()

function that would (on architectures that do not support it) just remove
the present bit instead of removing the WR bit.

> On Tue, Jan 29, 2002 at 12:18:42PM +0200, Momchil Velikov wrote:
> > PS. Well, the whole pgd/pmd/ptb stuff is ia32-ism, but that's another
> > story.
>
> Perhaps something can be done about that.

The pgd/pmd/pte thing is _not_ a ia32-ism.

A tree-based data structure is very much a generic portable construct, and
is, in fact, the only sane way to maintain VM mappings.

The fact that Linux tries very hard to allow the portable data structure
to be _represented_ using the same data structures that the hardware uses
for the TLB lookup is a separate issue, and mainly helps performance and
TLB coherency. And even then it's not a ia32-ism: every single sane
architecture out there is either soft-fill TLB (in which case a tree is
fine), or already is a tree (ia32, x86-64, alpha, m68k etc).

The others are just stupid aberrations (ie the ppc hash-tables), and can
portably be considered nothing but in-memory TLB's.

However, in order to allow other architectures to share their hardware
page tables with the Linux software VM mappings, we _should_ take their
page walkers into account. It would be a pity if the Linux page table
abstraction was too removed from some machines reality.

		Linus

