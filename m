Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUEYUuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUEYUuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUEYUuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:50:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:32969 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265206AbUEYUuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:50:15 -0400
Date: Tue, 25 May 2004 13:49:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: wesolows@foobazco.org, willy@debian.org, andrea@suse.de,
       benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, bcrl@kvack.org, linux-mm@kvack.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525133543.753fc5a5.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0405251340160.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525153501.GA19465@foobazco.org>
 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org> <20040525102547.35207879.davem@redhat.com>
 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org> <20040525105442.2ebdc355.davem@redhat.com>
 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org> <20040525133543.753fc5a5.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, David S. Miller wrote:
> 
> Hmmm, do you understand how broken the sparc hardware is? :-)

I seem to always repress that part.

> Seriously, the issue is that the MMU writes back access/dirty bits
> asynchronously, does not do a relookup when it writes these bits back
> into the PTE (like x86 and others do) it actually stores away the PTE
> physical address and writes into the PTE using that, and finally as
> previously mentioned we lack a cmpxchg we only have raw SWAP.

Ok. Still, that doesn't sound too bad. I assume that the pte write has to 
be atomic anyway (ie it doesn't walk the page tables, but it clearly _has_ 
to do an atomic "read-modify-update" or just the _hardware_ updates might 
race against each other and one CPU loses the dirty bit when another CPU 
writes back the accessed bit).

So I really think it should be safe to just do a regular write when you 
update both bits, because you know that no other CPU will at least _clear_ 
any bits. Hmm?

So it sounds like the SWAP loop basically ends up being just something 
like

	val = pte_value(entry);
	for (;;) {
		oldval = SWAP(ptep, val);
		/*
		 * If we wrote a value that had the same or more bits set 
		 * than the old value, we're ok...
		 */
		if (!(oldval & ~val))
			break;
		/*
		 * ..otherwise we need to write the "or" of all bits and
		 * try again.
		 */
		val |= oldval;
	}

Right? Note that the reason we can do the "dirty and accessed bit both 
set" case with a simple write is exactly because that's already the 
"maximal" bits anybody can write to the thing, so we don't need to loop, 
we can just write it directly.

I realize that this isn't as simple as the x86 solution (or most
everything else, for that matter ;), but it's by no means totally
unreasonable. Or are there even _more_ gotchas that I've missed?

		Linus
