Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265019AbUEYSFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbUEYSFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUEYSFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:05:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:17860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265018AbUEYSF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:05:28 -0400
Date: Tue, 25 May 2004 11:05:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: wesolows@foobazco.org, willy@debian.org, andrea@suse.de,
       benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, bcrl@kvack.org, linux-mm@kvack.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525105442.2ebdc355.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525153501.GA19465@foobazco.org>
 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org> <20040525102547.35207879.davem@redhat.com>
 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org> <20040525105442.2ebdc355.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, David S. Miller wrote:
> On Tue, 25 May 2004 10:49:21 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > So what I can tell, the fix is really something like this (this does both 
> > x86 and ppc64 just to show how two different approaches would handle it, 
> > but I have literally _tested_ neither).
> > 
> > What do people think?
> 
> So on sparc32 sun4m we'd implement ptep_update_dirty_accessed() with
> some kind of loop using the swap instruction?

Yes. Except that if everybody else uses atomic updates (including the hw 
walkers), _and_ "dirty" is true, then you can optimize that case to just 
to an atomic write (since we don't care what the previous contents were, 
and everybody else is guaranteed to honor the fact that we set all the 
bits.

(And an independent optimization is obviously to not do the store at all
if it is already has the new value, although that _should_ be the rare 
case, since if that was true I don't see why you got a page fault in the 
first place).

So _if_ such an atomic loop is fundamentally expensive for some reason, it 
should be perfectly ok to do

	if (dirty) {
		one atomic write with all the bits set;
	} else {
		cmpxchg until successful;
	}

Oh - btw - my suggested patch was totally broken for ppc64, because that 
"ptep_update_dirty_accessed()" thing obviously also needs to that damn 
hpte_update() crud etc. 

BenH - I'm leaving that ppc64 code to somebody knows what the hell he is
doing. Ie you or Anton or something. Ok? I can act as a collector the
different architecture things for that "ptep_update_dirty_accessed()"
function.

		Linus
