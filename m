Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129647AbRBPSEb>; Fri, 16 Feb 2001 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBPSEV>; Fri, 16 Feb 2001 13:04:21 -0500
Received: from colorfullife.com ([216.156.138.34]:44815 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129647AbRBPSEO>;
	Fri, 16 Feb 2001 13:04:14 -0500
Message-ID: <3A8D6BB1.342E62DB@colorfullife.com>
Date: Fri, 16 Feb 2001 19:04:33 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch> <3A8D540C.92C66398@colorfullife.com> <20010216174316.A4500@pcep-jamie.cern.ch> <3A8D5F6C.D81F2F28@colorfullife.com> <20010216183707.A4821@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> > > Ben, fancy writing a boot-time test?
> > >
> > I'd never rely on such a test - what if the cpu checks in 99% of the
> > cases, but doesn't handle some cases ('rep movd, everything unaligned,
> > ...'.
> 
> A good point.  The test results are inconclusive.
> 
> > And check the Pentium III erratas. There is one with the tlb
> > that's only triggered if 4 instruction lie in a certain window and all
> > access memory in the same way of the tlb (EFLAGS incorrect if 'andl
> > mask,<memory_addr>' causes page fault)).
> 
> Nasty, but I don't see what an obscure and impossible to work around
> processor bug has to do with this thread.  It doesn't actually change
> page fault handling, does it?
>
Page fault handling is unchanged, but perhaps there are other races. And
note that these races wouldn't be processor bugs - the spec nowhere
guarantee the behaviour you assume.

Ben tries to prove that the current cpu _never_ sets the dirty bit
without checking the present bit.

A very simple test might be

cpu 1:
	cli();
	a = 0; b = 0; m = 0;
	flush_local_tlb_page(a);
	flush_local_tlb_page(b);
	flush_local_tlb_page(a);
	while(!m);
	while (!a && !b);
	a = 1;

cpu 2:
	<wait>
	cli();
	both ptes for a and b as writable, not dirty.
	m = 1;
	udelay(100);
	change the pte of a to not present.
	wmb();
	b = 1;

Now start with variants:
change to read only instead of not present
a and b in the same way of the tlb, in a different way.
change pte with write, change with lock;
.
.
.

But you'll never prove that you tested every combination.

--
	Manfred
