Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNMlj>; Wed, 14 Feb 2001 07:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBNMl3>; Wed, 14 Feb 2001 07:41:29 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:35740 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129051AbRBNMlO>; Wed, 14 Feb 2001 07:41:14 -0500
Date: Wed, 14 Feb 2001 13:29:16 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Ingo Molnar <mingo@chiara.elte.hu>,
        Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
In-Reply-To: <3A8A6E31.ED24B54F@uow.edu.au>
Message-ID: <Pine.GSO.3.96.1010214124336.21491C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Andrew Morton wrote:

> Tell me, please: what tradeoffs are involved in this patch?
> Obviously it works around a pretty fatal problem, but
> what are we giving away?

 The change decreases performance a bit.  For well-behaved systems the
loss is fifteen instructions: a local APIC read (uncached but supposedly
cheap), a global memory read (a cache line invalidation and fetch), seven
stack accesses (cached for sure), a taken branch and five ALU.  With the
version you have I see gcc is actually doing an extra memory read due to
the volatile APIC access presumably -- this is now fixed.

 For misdelivered interrupts the overhead is much, much bigger, involving
acquiring a spinlock and multiple (uncached and possibly slow) I/O APIC
accesses.  We may lower the overhead by undefining APIC_LOCKUP_DEBUG,
which we should do after a bit of testing.  I think we might leave
APIC_MISMATCH_DEBUG intact -- its cost is a single locked instruction
which is negligible IMO.

 Note the original version consisted of two instructions only -- a local
APIC write and "ret", sigh...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

