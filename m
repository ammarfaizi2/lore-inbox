Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288755AbSADUdc>; Fri, 4 Jan 2002 15:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSADUd1>; Fri, 4 Jan 2002 15:33:27 -0500
Received: from elin.scali.no ([62.70.89.10]:64518 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S288754AbSADUdC>;
	Fri, 4 Jan 2002 15:33:02 -0500
Message-ID: <3C360FD5.91285F5D@scali.no>
Date: Fri, 04 Jan 2002 21:25:57 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Short question about the mmap method
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkml readers,

I have a question regarding drivers implementing the mmap and nopage methods. In some references
I've read that pages in kernel allocated memory (either allocated with kmalloc, vmalloc or
__get_free_pages) should be set to reserved (mem_map_reserve or set_bit(PG_reserved, page->flags)
before they can be mmap'ed to guarantee that they can't be swapped out. Is this true ?

The reason I ask is that I have a test driver that allocates some pages with vmalloc(), reserves
them with mem_map_reserve(), and uses the "nopage" method to give a userspace app access to them.
When the userpace app accesses the page, the "nopage" function is invoked as expected and the
page->count is incremented (by the nopage function). When this application exits the page->count
should have been decremented by the kernel, but it seems like it doesn't since the page is reserved
and this causes a giant memleak when the driver is unloaded since the pages are not put back to the
free list unless page->count is zero (I do mem_map_unreserve before vfree). If I avoid using
mem_map_reserve (and _unreserve) the page count is 1 at the time I unload the driver and everything
goes fine.

The kernel I'm using is RedHat 7.2 2.4.9-12

One more question:

When getting the "struct page" for pages allocated with vmalloc() I use the same method as
drivers/media/video/bttv-driver.c (checking the page table). Somewhere (I think Rubini) I read that
the init_mm.page_table_lock should be held before checking the page table. Is this true, or can it
safely be done without doing that (the bttv-driver.c doesn't) ?

Any ideas & comments are appreciated.

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
