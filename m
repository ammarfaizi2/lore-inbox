Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311242AbSCQB2D>; Sat, 16 Mar 2002 20:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311241AbSCQB1x>; Sat, 16 Mar 2002 20:27:53 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:62222 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311242AbSCQB1m>;
	Sat, 16 Mar 2002 20:27:42 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.60617.911732.176262@argo.ozlabs.ibm.com>
Date: Sun, 17 Mar 2002 12:09:29 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161238510.32013-100000@penguin.transmeta.com>
In-Reply-To: <15507.44228.577059.711997@napali.hpl.hp.com>
	<Pine.LNX.4.33.0203161238510.32013-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Which brings us back to the whole reason for the discussion: this is not a 
> theoretical argument. Look at the POWER4 numbers, and _shudder_ at the 
> expense of cache invalidation.

Go a little easy, the ppc64 port is still young and there are still
lots of places where it can use some serious optimization.  This is
one of them.

In principle the expense of invalidating the hash-table entries should
be able to be reduced to at most one store for every time we write to
a PTE in the linux page tables.  We currently don't have quite enough
information made available to the architecture code to achieve that.
In particular I think it would help if set_pte could be given the
mm_struct and the virtual address, then set_pte could fairly easily
invalidate the hash-table entry (if any) corresponding to the PTE
being changed.  Would you consider a patch along these lines?

Another alternative would be to make flush_tlb_mm doing the
change-the-VSIDs trick and then get the idle task to flush the stale
hash table entries.  We would need something like a bitmap showing
which PTEs had corresponding hash-table entries so that we didn't
waste time searching for hash-table entries that weren't there.

Paul.
