Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265603AbUEZPWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUEZPWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265601AbUEZPWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:22:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:26518 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265595AbUEZPWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:22:42 -0400
Date: Wed, 26 May 2004 08:22:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 implementation of ptep_set_access_flags
In-Reply-To: <1085555491.7835.61.camel@gaston>
Message-ID: <Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
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
  <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>  <1085546780.5584.19.camel@gaston>
  <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>  <1085551152.6320.38.camel@gaston>
  <1085554527.7835.59.camel@gaston> <1085555491.7835.61.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 May 2004, Benjamin Herrenschmidt wrote:
>
> Here's the ppc32 implementation of ptep_set_access_flags:

Ok. I modified the way things are done a bit, to make it easier
to keep architectures that haven't been updated yet in working order.

What I did was to basically split up the old "ptep_establish()" into a new 
"ptep_establish()" that is only used for COW, and your 
"ptep_update_accessed_bits()", which is used for the other cases.

I also left the default implementations in <asm-generic/pgtable.h> as 
exactly the same as the default implementation used to be for the old 
"ptep_establish()", so architectures that have not been updated to
take advantage of the split should work the way they always did. Except 
s390, which now gets the default function for the accessed bits update 
(which should be at least pretty close to correct for s390 too, I think 
the problem for s390 was the COW-case).

The "new" rules (well, they aren't new, but now they are explicitly
spelled out) for this thing are:

 - ptep_establish(__vma, __address, __ptep, __entry)

	Establish a new mapping:
	 - flush the old one
	 - update the page tables
	 - inform the TLB about the new one

	We hold the mm semaphore for reading and vma->vm_mm->page_table_lock.

	Note: the old pte is known to not be writable, so we don't need to
	worry about dirty bits etc getting lost.

 - ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty)

	Largely same as above, but only sets the access flags (dirty,
	accessed, and writable). Furthermore, we know it always gets set
	to a "more permissive" setting, which allows most architectures
	to optimize this.

and right now they both just default to

	set_pte(__ptep, __entry);
	flush_tlb_page(__vma, __address);

unless overridden by the architecture. 

			Linus
