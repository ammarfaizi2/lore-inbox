Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVAUNtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVAUNtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 08:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVAUNtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 08:49:49 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:59101 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262364AbVAUNtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 08:49:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Fri, 21 Jan 2005 14:42:54 +0100
User-Agent: KMail/1.7.1
Cc: hugang@soulinfo.com, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200501202032.31481.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com> <20050121103028.GF18373@elf.ucw.cz>
In-Reply-To: <20050121103028.GF18373@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211442.55274.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 21 of January 2005 11:30, Pavel Machek wrote:
> Hi!
> 
> > Full patch still can get from
> >  http://soulinfo.com/~hugang/swsusp/2005-1-21/
> 
> From a short look:
> 
> core.eatmem.diff of course helps, but is wrong. You should talk to
> akpm to find out why shrink_all_memory is not doing its job.
> 
> i386: +       repz movsl %ds:(%esi),%es:(%edi)
> I do not think movsl has any parameters. What is repz? Repeat as long
> as it is non-zero?

No, it's "repeat until %ecx is zero or ZF is cleared", but the latter never happens
with movsl.  It's intended for cmpsl, scasl and friends (the assembler should
complain about using it here).

> I think this should be "rep movsl".

Yes, it should.


> core:
> @@ -576,92 +989,31 @@ static void copy_data_pages(void)
>                 for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
>                         if (saveable(zone, &zone_pfn)) {
>                                 struct page * page;
> +                               pbe = find_pbe_by_index(pagedir_nosave, nr_copy_pages-to_copy);
> +                               BUG_ON(pbe == NULL);
>                                 page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
> 
> Don't you introduce O(n^2) behaviour here? Should not it be something
> like pbe_next? And it is the only user of find_pbe_by_index().
> 
> I think that read_one_pbe() is too short to be uninlined... Same for
> read_one_pagedir and write_one_pbe().
> 
> alloc_one_pagedir: why not just alloc page as zeroed?
> 
> Okay, it is still too big to merge directly. Would it be possible to
> get mod_printk_progress(), introduce *_for_each (but leave there old
> implementations), introduce pagedir_free() (but leave old
> implementation). Better collision code should already be there, that
> should make patch smaller, too. Try not to move code around.

I have a suggestion.

hugang, you are currently replacing an array of pbes with a list of arrays
of pbes contained within individual pages.

I would go further and replace it with a single one-directional list
of pbes.  Namely, I would modify "struct pbe" in the following way:

struct pbe {
	unsigned long address;
	unsigned long orig_address;
	swp_entry_t swap_address;	
	struct pbe *next;
};

(AFAICT, the "dummy" field is only used by hugang - as a pointer)
and I would define "for_each_pbe()" as:

#define for_each_pbe(pbe, pblist) \
	for (pbe = pblist;  pbe;  pbe = pbe->next)

Then, the only non-trivial changes would be in alloc_pagedir() and
in swsusp_pagedir_relocate(), where I would need to link pbes to
each other.

This also would make the assembly parts independent of the
sizeof(struct pbe), which is currently hardcoded there.

What do you think?

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
