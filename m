Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUEYOvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUEYOvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEYOtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:49:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:61351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264912AbUEYOsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:48:31 -0400
Date: Tue, 25 May 2004 07:48:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Matthew Wilcox wrote:

> On Mon, May 24, 2004 at 09:00:02PM -0700, Linus Torvalds wrote:
> > I suspect we should just make a "ptep_set_bits()" inline function that 
> > _atomically_ does "set the dirty/accessed bits". On x86, it would be a 
> > simple
> > 
> > 		asm("lock ; orl %1,%0"
> > 			:"m" (*ptep)
> > 			:"r" (entry));
> > 
> > and similarly on most other architectures it should be quite easy to do 
> > the equivalent. You can always do it with a simple compare-and-exchange 
> > loop, something any SMP-capable architecture should have.
> 
> ... but PA doesn't.  Just load-and-clear-word (and its 64-bit equivalent
> in 64-bit mode).  And that word has to be 16-byte aligned.

Wow. And this architecture claims to support SMP? 

> What race are we protecting against?  If it's like xchg() and we only
> need to protect against a racing xchg() and not a reader, we can just
> reuse the global array of hashed spinlocks we have for that.

The race is:
 - one CPU sets the dirty bit (possibly with a hardware walker, but I 
   guess on PA it's probably done in sw)
 - the other CPU sets the accessed bit in sw as part of the 
   "handle_pte_fault()" processing.

Right now we set the accessed bit with a simple "ptep_establish()", which 
will use "set_pte()", which is just a regular write. So setting the 
accessed bit will basically be a nonatomic sequence of

 - read pte entry
 - entry = pte_mkyoung(entry)
 - set_pte(entry)

which is all done under the mm->page_table_lock, but which does NOT 
protect against any hardware page-table walkers or any asynchronous sw 
walkers (if anybody does them).

Basically, the suggestion is to replace the "set_pte()" with something 
that is safe against anything else that updates the page tables (whether 
software or hardware). If only core kernel code does that, then you should 
already be fine, since the page-table spinlock should already be held by 
all updaters.

NOTE! One really easy approach would be to say that we never mix software 
updates of the accessed bit with hw updates, and just have a rule that if 
the architecture does accessed-bit updates in hardware (and can thus race 
with us doing them in software _despite_ the fact that we hold the page 
table lock), then we just don't do the update at all. 

We'd just pass in a flag to "ptep_establish()" to tell it whether we
changed the dirty bit or not. It would be "write_access" in
handle_pte_fault(), and 1 in the other two cases.

> Ah, atomic writes we can do.  That's easy.  I think all Linux architectures
> support atomic writes to naturally aligned addresses, don't they?

Yes. You'd really have to work at it _not_ to support them ;)

However, the atomic write case only helps in the case when we update _all_ 
the bits that hw walkers can update, 

			Linus
