Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVAEMc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVAEMc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVAEMc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:32:58 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:54182 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262335AbVAEMcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:32:54 -0500
Message-ID: <41DBDE6F.9060700@yahoo.com.au>
Date: Wed, 05 Jan 2005 23:32:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FRV: Change PML4 -> PUD
References: <41DB4EC7.9070608@yahoo.com.au>  <18003.1104868971@redhat.com> <8551.1104927403@redhat.com>
In-Reply-To: <8551.1104927403@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>David Howells wrote:
>>
>>>The attached patch changes the PML4 bits of the FRV arch to the new PUD way.
>>>
>>
>>Looks OK... any reason you aren't using the asm-generic folding headers?
>>(asm-generic/pgtable-nopmd.h or asm-generic/pgtable-nopud.h).
> 
> 
> The PMEs aren't that trivial. Technically, I think I should have one PGE
> containing 64 PMEs, each of which points to one chunk of a common page table,
> but I'm not sure the allocation assumptions will work right for that.
> 
> The way the page table tree structure is defined on this arch is interesting:
> 16KB PGD, 256B PTs and 16KB pages. I glue several PTs together into one page,
> which means that each PME actually contains 64 pointers and is 256B in size.
> 

OK, I sort-of understand. I see you've just got frv merged now, so I'll
have a better look soon.

> Trying to use the trivial PUD/PMD support buys me compilation errors about
> being unable to represent objects. It would be easier if the support wasn't
> inside out: pmd_t contains a pud_t which contains a pgd_t. This perhaps should
> be the other way around.
> 

That kind of is inside out. But it is the easiest way to get the sizes
right and have a unique type at the same time AFAIKS.

> The problems seem to revolve around this:
> 
> 	#define set_pgd(pgdptr, pgdval) \
> 		set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })
> 
> It's probably possible to rewrite the thing so that the pgd_t contains the 64
> pointers, but then set_pmd() ends up setting the pgd_t which seems wrong
> somehow. Not only that, but the code looks wrong: pmd->pud->pgd?????
> 

This kind of stems from the way page tables get folded... basically I just
pulled out the common stuff into a single header file. I'd like to look at
making everything nicer, but I think this system might just turn out to be
as good as it gets.

But anyway, further changes would require big sweeps of arch code, so may
be best left to 2.7, if ever.

> It would seem better to me to start from the assumption that PMEs will always
> contain "pointers" to page tables. What the current method seems to do is that
> pointers to page tables are installed as high up the tree as possible, and the
> unnecessary dangly bits (PUDs/PMDs) are looped back on themselves.
> 
> Both methods work, I suppose, but it's not well documented; and because it's
> inside out, it's not immediately obvious. Whoever designed this system should
> write it up and stick a file in Documentation/ about it.
> 
> 
>>I sent some notes to the arch list about getting those working, but
>>apparently it hasn't come though yet.
> 
> 
> Sounds like there's a mailing list I should be on, but don't know about.
> 

It is very exclusive. Not even a great hacker like myself is allowed there ;)
Ask David Miller, I think.

> 
>>Of course I do think it is sensible that you just get it working first,
>>before getting too fancy.
> 
> 
> Definitely. The arch makes "fancy" tricky anyway.
> 
> David
> 

