Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132271AbRAYRr6>; Thu, 25 Jan 2001 12:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRAYRri>; Thu, 25 Jan 2001 12:47:38 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:18507 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S132588AbRAYRr3>;
	Thu, 25 Jan 2001 12:47:29 -0500
Message-ID: <3A7066A1.5030608@valinux.com>
Date: Thu, 25 Jan 2001 10:47:13 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
		<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org> 
		<20010125165001Z132264-460+11@vger.kernel.org> <E14LpvQ-0008Pw-00@mail.valinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> ** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Thu, 25 Jan
> 2001 10:04:47 -0700
> 
> 
> 
>>> The problem with this is that between the ioremap and iounmap, the page is
>>> reserved.  What happens if that page belongs to some disk buffer or user
>>> process, and some other process tries to free it.  Won't that cause a problem?
>> 
>> 	The page can't belong to some other process/kernel component.  You own 
>> the page if you allocated it.  
> 
> 
> Ok, my mistake.  I wasn't paying attention to the "get_free_pages" call.  My
> problem is that I'm ioremap'ing someone else's page, but my hardware sits on the
> memory bus disguised as real memory, and so I need to poke around the 4GB space
> trying to find it.

As in an MMIO aperture?  If its MMIO on the bus you should be able to 
just call ioremap with the bus address.  By nature of it being outside 
of real ram, it should automatically be uncached (unless you've set an 
MTRR over that region saying otherwise).

> 
> 
> 
>> (I was the one who added support to 
>> the kernel to ioremap real ram, trust me.)
> 
> 
> I really appreciate that feature, because it helps me a lot.  Any
> recommendations on how I can do what I do without causing any problems?  Right
> now, my driver never calls iounmap on memory that's in real RAM, even when it
> exits.  Fortunately, the driver isn't supposed to exit, so all it does is waste
> a few KB of virtual memory.

Look at the functions agp_generic_free_gatt_table and 
agp_generic_create_gatt_table in agpgart_be.c (drivers/char/agp).  They 
do the ioremap_nocache on real ram for the GATT/GART table.  Heres some 
quick pseudo code as well.

I_want_a_no_cached_page() {
alloc a page
reserve the page
flush every cpu's cache
ioremap_nocache the page
}

I_want_to_free_a_no_cached_page() {
iounmap the page
unreserve the page
free the page
}

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
