Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVAEMRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVAEMRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVAEMRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:17:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262357AbVAEMQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:16:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <41DB4EC7.9070608@yahoo.com.au> 
References: <41DB4EC7.9070608@yahoo.com.au>  <18003.1104868971@redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FRV: Change PML4 -> PUD 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 12:16:43 +0000
Message-ID: <8551.1104927403@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> David Howells wrote:
> > The attached patch changes the PML4 bits of the FRV arch to the new PUD way.
> > 
> 
> Looks OK... any reason you aren't using the asm-generic folding headers?
> (asm-generic/pgtable-nopmd.h or asm-generic/pgtable-nopud.h).

The PMEs aren't that trivial. Technically, I think I should have one PGE
containing 64 PMEs, each of which points to one chunk of a common page table,
but I'm not sure the allocation assumptions will work right for that.

The way the page table tree structure is defined on this arch is interesting:
16KB PGD, 256B PTs and 16KB pages. I glue several PTs together into one page,
which means that each PME actually contains 64 pointers and is 256B in size.

Trying to use the trivial PUD/PMD support buys me compilation errors about
being unable to represent objects. It would be easier if the support wasn't
inside out: pmd_t contains a pud_t which contains a pgd_t. This perhaps should
be the other way around.

The problems seem to revolve around this:

	#define set_pgd(pgdptr, pgdval) \
		set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })

It's probably possible to rewrite the thing so that the pgd_t contains the 64
pointers, but then set_pmd() ends up setting the pgd_t which seems wrong
somehow. Not only that, but the code looks wrong: pmd->pud->pgd?????

It would seem better to me to start from the assumption that PMEs will always
contain "pointers" to page tables. What the current method seems to do is that
pointers to page tables are installed as high up the tree as possible, and the
unnecessary dangly bits (PUDs/PMDs) are looped back on themselves.

Both methods work, I suppose, but it's not well documented; and because it's
inside out, it's not immediately obvious. Whoever designed this system should
write it up and stick a file in Documentation/ about it.

> I sent some notes to the arch list about getting those working, but
> apparently it hasn't come though yet.

Sounds like there's a mailing list I should be on, but don't know about.

> Of course I do think it is sensible that you just get it working first,
> before getting too fancy.

Definitely. The arch makes "fancy" tricky anyway.

David
