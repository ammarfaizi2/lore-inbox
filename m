Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130758AbRAUA0a>; Sat, 20 Jan 2001 19:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132158AbRAUA0U>; Sat, 20 Jan 2001 19:26:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130758AbRAUA0J>; Sat, 20 Jan 2001 19:26:09 -0500
Date: Sat, 20 Jan 2001 16:25:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.10.10101202107590.12223-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10101201612240.10849-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2001, Roman Zippel wrote:
> 
> AFAIK as long as that dummy page struct is only used in the page cache,
> that should work, but you get new problems as soon as you map the page
> also into a user process (grep for CONFIG_DISCONTIGMEM under
> include/asm-mips64 to see the needed changes). In the worst case one
> might need reverse mapping to get the page back. :)

No, for the CONTIGMEM case you can just use remap_page_range() directly:
it won't actually map the "struct page*" into the user space, it will just
map a special reserved page into user space. No changes needed.

So it just so happens that the physical address of the two "pages" is the
same in this case - one reachable through the dummy "struct page *" and
one reachable through the VM layer. The VM layer will never see the dummy
"struct page", and that's ok. It doesn't need it.

Now, there are things to look out for: when you do these kinds of dummy
"struct page" tricks, some macros etc WILL NOT WORK. In particular, we do
not currently have a good "page_to_bus/phys()" function. That means that
anybody trying to do DMA to this page is currently screwed, simply because
he has no good way of getting the physical address.

This is a limitation in general: the PTE access functions would also like
to have "page_to_phys()" and "phys_to_page()" functions. It gets even
worse with IO mappings, where "CPU-physical" is NOT necessarily the same
as "bus-physical".

It shouldn't be too hard to do the phys/bus addresses in general,
something like this should actually do it

	static inline unsigned long page_to_physnr(struct page * page)
	{
		unsigned long offset;
		struct zone_struct * zone = page->zone;

		offset = zone->zone_mem_map - page;
		return zone->zone_start_paddr + offset;
	}

except right now I think "zone_start_paddr" is defined wrong (it's defined
to be the actual physical address, rather than being the "physical address
shifted right by the page-size". It needs to be the latter in order to
handle physical memory spaces that are bigger than "unsigned long" (ie
x86 PAE mode). Making the thing "unsigned long long" is _not_ an option,
considering how crappy gcc is at double integers.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
