Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUEYEvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUEYEvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUEYEvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:51:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52097
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264662AbUEYEvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:51:07 -0400
Date: Tue, 25 May 2004 06:50:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525045059.GW29378@dualathlon.random>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525042054.GU29378@dualathlon.random> <Pine.LNX.4.58.0405242137210.32189@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405242137210.32189@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 09:39:05PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 25 May 2004, Andrea Arcangeli wrote:
> 
> > On Mon, May 24, 2004 at 09:00:02PM -0700, Linus Torvalds wrote:
> > > 
> > > 
> > > On Tue, 25 May 2004, Andrea Arcangeli wrote:
> > > > 
> > > > The below patch should fix it, the only problem is that it can screwup
> > > > some arch that might use page-faults to keep track of the accessed bit,
> > > 
> > > Indeed. At least alpha does this - that's where this code came from. SO 
> > > this will cause infinite page faults on alpha and any other "accessed bit 
> > > in software" architectures.
> > 
> > as you say the alpha has no accessed bit at all in hardware, so
> > it cannot generate page faults. 
> 
> It _does_ generate page faults.
> 
> We do the accessed bit by clearing the "user readable" thing (or
> something. I forget the exact details, and I'm too lazy to check it out).  
> And a page won't be _really_ readable until it has been marked young.
> 
> If you don't mark it young, you'll get infinite page faults.
> 
> That's how we do the accessed bit.

no, that's not what I remeber from alpha, alpha always sets the young
bit as soon as it sets the pte from non-null to something. No matter
what kind of pte is that (readonly/writeonly/whatever). Then this bit is
cleared by the VM but nothing ever happens again. The accessed bit is
quite useless infact.

> > "accessed bit in software" is fine with my fix.
> 
> NO IT IS NOT.

It definitely is, there's no way the architecture can loop on a bit that
doesn't exist as far as the hardware is concerned.

see the code:

/* .. and these are ours ... */
#define _PAGE_DIRTY	0x20000
#define _PAGE_ACCESSED	0x40000
#define _PAGE_FILE	0x80000	/* set:pagecache, unset:swap */

extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }

So alpha will work fine, there's absolutely no way pte_mkyoung can avoid
the next page fault, period.

furthermore there is no way to keep the accessed bit coherent without
hardware support, I tried that while I was working on the alpha some
year ago but there's no way. The accessed bit in software is only useful
to give a second chance to pages paged in recently (if useful at all).

There are two ways to do the hardware support, one is what x86 does,
that is to set the bit without a page fault that enters kernel. The
other way is an option that ia64 has to generate even the page fault.

My fix works fine for x86* and alpha. It may not work for ia64 if it's
using hardware page faults to set the young bit. comments on this detail
from the ia64 developers would be welcome.
