Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277377AbRJENcW>; Fri, 5 Oct 2001 09:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277378AbRJENcM>; Fri, 5 Oct 2001 09:32:12 -0400
Received: from smtp-out.hamburg.pop.de ([195.222.210.86]:12299 "EHLO
	smtp-out.hamburg.pop.de") by vger.kernel.org with ESMTP
	id <S277377AbRJENbz>; Fri, 5 Oct 2001 09:31:55 -0400
Message-Id: <3BBDB662.CB729213@gmx.de>
Date: Fri, 05 Oct 2001 15:32:18 +0200
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: STN-Atlas Elektronik
X-Mailer: Mozilla 4.72 [en] (X11; I; OSF1 V4.0 alpha)
X-Accept-Language: German/Germany, de-DE, en
Mime-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <Pine.LNX.4.21.0110051327180.997-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:


> I don't
> know whether you're following the mmap-makes-all-pages-present
> model (using remap_page_range), or the fault-page-by-page model
> (supplying your own nopage function). 

The nopage method. In Alessandro Rubini's book (p.391) I read, that I can't use remap_page_range() on pages optained by get_free_page().

> But either way it sounds like
> you bump each page count by 1 when you map it in, and then when > it's unmapped the count goes down to 0 on all the later 
> order-0-pages,

exactly that happens in the version I use on minor 26 today.

> so they get freed before you're done with them.

Hmm, the only thing that happens to them after munmap() is 
free_pages(). I don't access the pages anymore. But maybe some code in free_pages does? Or decrements count to -1?

> Either you should force page count 1 on each of the 
> order-0-pages before you mmap them in 

Yes, I do that in the version used in minor 27 today right after the allocation.

> (and raise count to 2);

by get_page(), right?

> or you should set
> the Reserved bit on each them, and clear it before freeing 
> (see use of mem_map_reserve and mem_map_unreserve in various 
> drivers/sound
> sources using remap_page_range; there's also a couple of 
> examples of the nopage method down there too).

Ok, thanks a lot. So it's definitely insufficient how my minor 26 version handles the pages, right? If so, that's a statement I can live with.

And it was never ment that I could simply mmap the upper pages to userspace directly, without 'touching' each page, was it? 

Ciao,
-- 
Bernd Harries

bha@gmx.de            http://bharries.freeyellow.com
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40
