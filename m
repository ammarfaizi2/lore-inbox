Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRI3H3v>; Sun, 30 Sep 2001 03:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRI3H3l>; Sun, 30 Sep 2001 03:29:41 -0400
Received: from chiara.elte.hu ([157.181.150.200]:41489 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S272818AbRI3H3d>;
	Sun, 30 Sep 2001 03:29:33 -0400
Date: Sun, 30 Sep 2001 09:27:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Bernd Harries <bha@gmx.de>
Cc: Bernd Harries <mlbha@gmx.de>, <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <3BB601AD.8890EA1D@gmx.de>
Message-ID: <Pine.LNX.4.33.0109300914490.1665-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Sep 2001, Bernd Harries wrote:

> Roman Zippel looked at my driver and added code to print the usage
> counter for each page after a 9-order __get_free_pages().
>
> We found that only the first (!) page has a count of 1, the others
> have 0!

This is a property of Linux's buddy allocator. If you allocate a 9th order
'big page', that does not mean you can free the pages one by one. Higher
order pages are 'one unit' and are typically handled as such. Eg. the
kernel stack is allocated and freed as order 1 pages.

>           struct page * page = virt_to_page(card_ptr->dma_blk1[n]);
>           int i;
>           for(i = 0; i < (1 << max_order); i++, page++)
>           {
>             atomic_set(&page->count, 1);
>           }
>
> And the freeing of the pages is now done page by page in the _vma_close()
> function.

while unconventional, doing this is safe. There is nothing in the page
structure that says that the page was allocated as a higher order page. So
if you fix up the page counts, freeing them as separate entities is safe.
(in fact it's even safe to split it up into 8k or 16k pages - not that
this would be useful for you.) But the above is an 'internal' property of
the Linux page allocator, so it's not guaranteed to stay so forever.

(the Linux kernel does not do the above for understandable reasons: it
takes a loop of 512 iterations to fix up the page counts in the above way,
which is noticeable runtime overhead.)

is it a fundamental property of the hardware that it needs a continuous
physical memory buffer? If not then i'd strongly suggest updating the
driver to do scatter-gather instead of trying to allocate a 2 MB page.
Being able to allocate a 2 MB page is only guaranteed during bootup. There
is just no mechanizm in Linux that guarantees it for you to be able to
allocate a 2 MB page (let alone two adjacent 2 MB pages), in even a
moderately utilized system. Scatter-gather avoids all these problems.

	Ingo

