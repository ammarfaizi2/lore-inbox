Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264736AbUEYFAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbUEYFAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUEYFAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:00:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16771
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264727AbUEYFAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:00:03 -0400
Date: Tue, 25 May 2004 06:59:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525045958.GY29378@dualathlon.random>
References: <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525042054.GU29378@dualathlon.random> <Pine.LNX.4.58.0405242137210.32189@ppc970.osdl.org> <Pine.LNX.4.58.0405242141150.32189@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405242141150.32189@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 09:44:08PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 24 May 2004, Linus Torvalds wrote:
> >
> > We do the accessed bit by clearing the "user readable" thing (or
> > something. I forget the exact details, and I'm too lazy to check it out).  
> 
> Yup. Lookie here:
> 
> 	#define __ACCESS_BITS   (_PAGE_ACCESSED | _PAGE_KRE | _PAGE_URE)
> 	extern inline pte_t pte_mkold(pte_t pte)        { pte_val(pte) &= ~(__ACCESS_BITS); return pte; }
> 
> Notice how an "old" pte won't be readable. Then, when we take the page 
> fault, we'll do
> 
> 	extern inline pte_t pte_mkyoung(pte_t pte)      { pte_val(pte) |= __ACCESS_BITS; return pte; }
> 
> and now the pte is readable again.
> 
> In other words, we absolutely _have_ to do the "pte_mkyoung()" part in the
> page fault, or an "old" pte will never become readable again (unless it's
> accessed with a write rather than a read, which will then happen to make
> it young again).
> 
> I'm not quite senile yet.

I see, sorry I was wrong. I misread this code a long time ago and I
noticed how the young bit works only now. Infact I always wondered if
the young bit was useful at all. So it was possible to emulate it after
all. However I wonder what happens for PROT_WRITE? How can you make a
mapping only writeable if the mk_young marks it readable? That's why I
misread it without even imagining it was setting the readable bit at the
same time of the young bit.

so while ia64 may not even need to set the young bit, alpha needs it.
