Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRBPQBD>; Fri, 16 Feb 2001 11:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRBPQAy>; Fri, 16 Feb 2001 11:00:54 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:31500 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129259AbRBPQAi>;
	Fri, 16 Feb 2001 11:00:38 -0500
Date: Fri, 16 Feb 2001 17:00:29 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216170029.A4450@pcep-jamie.cern.ch>
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D4D43.CF589FA0@colorfullife.com>; from manfred@colorfullife.com on Fri, Feb 16, 2001 at 04:54:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> >         entry = ptep_get_and_clear(pte);
> >         set_pte(pte, pte_modify(entry, newprot));
> > 
> > I.e. the only code with the race condition is code which explicitly
> > clears the dirty bit, in vmscan.c.
> > 
> > Do you see any possibility of losing a dirty bit here?
> >
> Of course.
> Just check the output after preprocessing.
> It's 
> 	int entry;
> 	entry = *pte;
> 	entry &= ~_PAGE_CHG_MASK;
> 	entry |= pgprot_val(newprot)
> 	*pte = entry;

And how does that lose a dirty bit?

For the other processor to not write a dirty bit, it must have a dirty
TLB entry already which, along with the locked cycle in
ptep_get_and_clear, means that `entry' will have _PAGE_DIRTY set.  The
dirty bit is not lost.

> We need
> 	atomic_clear_mask (_PAGE_CHG_MASK, pte);
> 	atomic_set_mask (pgprot_val(newprot), *pte);
> 
> for multi threaded apps.

cmpxchg is probably faster.

-- Jamie
