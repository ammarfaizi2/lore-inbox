Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSAFKlt>; Sun, 6 Jan 2002 05:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287802AbSAFKlj>; Sun, 6 Jan 2002 05:41:39 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:61965 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287794AbSAFKla>; Sun, 6 Jan 2002 05:41:30 -0500
Message-ID: <3C370AFF.9385091A@linux-m68k.org>
Date: Sat, 05 Jan 2002 15:17:35 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steffen Persvold <sp@scali.no>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question about the mmap method
In-Reply-To: <3C360FD5.91285F5D@scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Steffen Persvold wrote:

> I have a question regarding drivers implementing the mmap and nopage methods. In some references
> I've read that pages in kernel allocated memory (either allocated with kmalloc, vmalloc or
> __get_free_pages) should be set to reserved (mem_map_reserve or set_bit(PG_reserved, page->flags)
> before they can be mmap'ed to guarantee that they can't be swapped out. Is this true ?
> 
> The reason I ask is that I have a test driver that allocates some pages with vmalloc(), reserves
> them with mem_map_reserve(), and uses the "nopage" method to give a userspace app access to them.
> When the userpace app accesses the page, the "nopage" function is invoked as expected and the
> page->count is incremented (by the nopage function).

You must only set PG_reserved or only increment the page count. If you
increment the page count, the kernel will try to free memory by removing
the page from the process and reread the page later by calling the
nopage function again.
If you have the pages allocated all the time anyway, it's better to set
PG_reserved, but these pages can only be freed again when all files are
closed. You probably also want to set VM_RESERVED in vma->vm_flags, so
the kernel won't even look at these pages, while scanning the process
for freeable memory.

> When getting the "struct page" for pages allocated with vmalloc() I use the same method as
> drivers/media/video/bttv-driver.c (checking the page table). Somewhere (I think Rubini) I read that
> the init_mm.page_table_lock should be held before checking the page table. Is this true, or can it
> safely be done without doing that (the bttv-driver.c doesn't) ?

Currently this lock isn't needed, since noone will remove or change this
mapping until you call vfree().

bye, Roman

