Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUEYUhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUEYUhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUEYUhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:37:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265206AbUEYUgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:36:51 -0400
Date: Tue, 25 May 2004 13:35:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, wesolows@foobazco.org
Cc: wesolows@foobazco.org, willy@debian.org, andrea@suse.de,
       benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, bcrl@kvack.org, linux-mm@kvack.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-Id: <20040525133543.753fc5a5.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	<Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	<1085371988.15281.38.camel@gaston>
	<Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	<1085373839.14969.42.camel@gaston>
	<Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	<20040525034326.GT29378@dualathlon.random>
	<Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	<20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	<20040525153501.GA19465@foobazco.org>
	<Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	<20040525102547.35207879.davem@redhat.com>
	<Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	<20040525105442.2ebdc355.davem@redhat.com>
	<Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 11:05:09 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 25 May 2004, David S. Miller wrote:
> > So on sparc32 sun4m we'd implement ptep_update_dirty_accessed() with
> > some kind of loop using the swap instruction?
> 
> Yes. Except that if everybody else uses atomic updates (including the hw 
> walkers), _and_ "dirty" is true, then you can optimize that case to just 
> to an atomic write (since we don't care what the previous contents were, 
> and everybody else is guaranteed to honor the fact that we set all the 
> bits.
> 
> (And an independent optimization is obviously to not do the store at all
> if it is already has the new value, although that _should_ be the rare 
> case, since if that was true I don't see why you got a page fault in the 
> first place).
> 
> So _if_ such an atomic loop is fundamentally expensive for some reason, it 
> should be perfectly ok to do
> 
> 	if (dirty) {
> 		one atomic write with all the bits set;
> 	} else {
> 		cmpxchg until successful;
> 	}

Hmmm, do you understand how broken the sparc hardware is? :-)

Seriously, the issue is that the MMU writes back access/dirty bits
asynchronously, does not do a relookup when it writes these bits back
into the PTE (like x86 and others do) it actually stores away the PTE
physical address and writes into the PTE using that, and finally as
previously mentioned we lack a cmpxchg we only have raw SWAP.

Keith W. can verify this, he has my old SuperSPARC manual which explains
all of this stuff.  Keith you might want to quote that little "atomic PTE
update sequence" piece of code that's in the manual for Linus.

