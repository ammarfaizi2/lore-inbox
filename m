Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129640AbRBPP2O>; Fri, 16 Feb 2001 10:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbRBPP2E>; Fri, 16 Feb 2001 10:28:04 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:50448 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129640AbRBPP1u>;
	Fri, 16 Feb 2001 10:27:50 -0500
Date: Fri, 16 Feb 2001 16:27:41 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216162741.A4284@pcep-jamie.cern.ch>
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D4045.F8F27782@colorfullife.com>; from manfred@colorfullife.com on Fri, Feb 16, 2001 at 03:59:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> > I can think of one case where performance is considered quite important:
> > mprotect() is used by several garbage collectors, including threaded
> > ones.  Maybe mprotect() isn't the best primitive for those anyway, but
> > it's what they have to work with atm.
> 
> Does mprotect() actually care for wrong dirty bits?
> The race should be invisible to user space apps.
> 
> >>>>>>> mprotect()
> for_all_affected_ptes() {
> 	lock andl ~PERMISSION_MASK, *pte;
> 	lock orl new_permission, *pte;
> }
> < now anther cpu could still write to the write protected pages
> < and set the dirty bit, but who cares? Shouldn't be a problem.
> flush_tlb_range().
> < tlb flush before ending the syscall, user space can't notice
> < the delay.
> <<<<

The user-space app doesn't even _know_ about dirty bits.

I don't think there's even the possibility of losing dirty bits with
mprotect(), so long as pte_modify doesn't clear the dirty bit, which it
doesn't, in this code:

/* mprotect.c */
	entry = ptep_get_and_clear(pte);
	set_pte(pte, pte_modify(entry, newprot));

I.e. the only code with the race condition is code which explicitly
clears the dirty bit, in vmscan.c.

Do you see any possibility of losing a dirty bit here?

If not, there's no need for the intricate "gather" or "double scan"
schemes for mprotect() and it can stay as fast as possible.

Btw, a possible mprotect optimisation: there is no need for
flush_tlb_range() when increasing permissions.

-- Jamie
