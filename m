Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265246AbUEZEzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUEZEzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbUEZEzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:55:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:24759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265179AbUEZEzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:55:03 -0400
Date: Tue, 25 May 2004 21:54:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <1085546780.5584.19.camel@gaston>
Message-ID: <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>  <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
  <1085371988.15281.38.camel@gaston>  <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
  <1085373839.14969.42.camel@gaston>  <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
  <20040525034326.GT29378@dualathlon.random>  <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
  <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> 
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>  <20040525153501.GA19465@foobazco.org>
  <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>  <20040525102547.35207879.davem@redhat.com>
  <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>  <20040525105442.2ebdc355.davem@redhat.com>
  <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>  <1085521251.24948.127.camel@gaston>
  <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org> 
 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>  <1085522860.15315.133.camel@gaston>
  <Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>  <1085530867.14969.143.camel@gaston>
  <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>  <1085541906.14969.412.camel@gaston>
  <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org> <1085546780.5584.19.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 May 2004, Benjamin Herrenschmidt wrote:
>
> Ok, your patch just missed the do_wp_page() case which needs the same
> medication as break_cow(), which leaves us with only one caller of
> ptep_establish... the one which just sets those 2 bits and shouldn't
> be named ptep establish at all ;)

Actually, the do_wp_page() one doesn't change the page, but it potentially
changes _three_ bits: accessed, dirty _and_ writable.

But the fix on ppc64 should be to add the writable bit to the mask of 
things, and rename the function to reflect that fact.

> I'd rather have ptep_establish do the ptep_clear_flush & set_pte, and
> the later just do the bit flip, but then, the arch (and possibly
> generic) implementation of that bit flip must also do the TLB flush
> when necessary (it's not on ppc).

I agree on the renaming, but please don't use the ptep_clear_flush() in 
do_wp_page(), because it really isn't changing the virtual mapping, it's 
only a (slightly) extended case of the same old "set another bit".

		Linus
