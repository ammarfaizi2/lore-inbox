Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUEZE7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUEZE7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUEZE7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:59:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:45704 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265155AbUEZE71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:59:27 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
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
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
	 <1085522860.15315.133.camel@gaston>
	 <Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>
	 <1085530867.14969.143.camel@gaston>
	 <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
	 <1085541906.14969.412.camel@gaston>
	 <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
	 <1085546780.5584.19.camel@gaston>
	 <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085547339.5584.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 14:55:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 14:54, Linus Torvalds wrote:
> On Wed, 26 May 2004, Benjamin Herrenschmidt wrote:
> >
> > Ok, your patch just missed the do_wp_page() case which needs the same
> > medication as break_cow(), which leaves us with only one caller of
> > ptep_establish... the one which just sets those 2 bits and shouldn't
> > be named ptep establish at all ;)
> 
> Actually, the do_wp_page() one doesn't change the page, but it potentially
> changes _three_ bits: accessed, dirty _and_ writable.

Hrm... that would work if we only ever set writable, so yes.

> But the fix on ppc64 should be to add the writable bit to the mask of 
> things, and rename the function to reflect that fact.
> 
> > I'd rather have ptep_establish do the ptep_clear_flush & set_pte, and
> > the later just do the bit flip, but then, the arch (and possibly
> > generic) implementation of that bit flip must also do the TLB flush
> > when necessary (it's not on ppc).
> 
> I agree on the renaming, but please don't use the ptep_clear_flush() in 
> do_wp_page(), because it really isn't changing the virtual mapping, it's 
> only a (slightly) extended case of the same old "set another bit".

Ok, I just wasn't sure what this function was all about.

I'll cook a new patch including all the changes we discussed, may take some
time, but hopefully you'll get it today.

Ben.


