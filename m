Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbRF0LpE>; Wed, 27 Jun 2001 07:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbRF0Loy>; Wed, 27 Jun 2001 07:44:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62221 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265066AbRF0Loq>; Wed, 27 Jun 2001 07:44:46 -0400
Date: Wed, 27 Jun 2001 07:11:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>, NIIBE Yutaka <gniibe@m17n.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
Message-ID: <Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 

I think Stephen C. Tweedie has some considerations about the cache
flushing calls on do_swap_page().

Stephen? 


On Wed, 27 Jun 2001, NIIBE Yutaka wrote:

> Hello Marcelo, 
> 
> This is follow-up to the mail in February.  You may perhaps forget the
> context, it's the bug of MM about cache flushing for swapped-in-pages.
> I see this bug on SuperH port (SH-4).
> 
> I think that we have this issue on the machine whose flush_dcache_page()
> is defined.  In current code, the cache aren't flushed for 
> the asynchronously-swapped-in pages which is cached in swap cache.
> This is the problem.
> 
> Marcelo Tosatti writes:
>  > Yet another thing (1) on end_buffer_io_async() to handle a case which is
>  > only true for a specific user of it. Since the other special case handling
>  > is for swap IO too, I think a separate IO end operation for swap would be
>  > interesting.
>  > 
>  > (1) The current one is SetPageDecrAfter handling.
> 
> How about this?  I've updated MM bugzilla already.
> 
> 2001-06-26  NIIBE Yutaka  <gniibe@m17n.org>
> 
> 	* include/linux/mm.h (PG_flush_after, PageFlushAfter,
> 	SetPageFlushAfter, PageTestandClearFlushAfter): New bit.
> 	* mm/page_io.c (rw_swap_page_base): Set flush-after bit.
> 	* fs/buffer.c (end_buffer_io_async): Implement flush-ing
> 	with PG_flush_after.
> 
> 	* mm/memory.c (do_swap_page): Remove flush-ing the page.
> 
> diff -ruNp --exclude=CVS --exclude=.cvsignore v2.4.6-pre5/fs/buffer.c kernel/fs/buffer.c
> --- v2.4.6-pre5/fs/buffer.c	Mon Jun 25 18:48:07 2001
> +++ kernel/fs/buffer.c	Tue Jun 26 15:11:17 2001
> @@ -831,6 +831,9 @@ static void end_buffer_io_async(struct b
>  	if (PageTestandClearDecrAfter(page))
>  		atomic_dec(&nr_async_pages);
>  
> +	if (PageTestandClearFlushAfter(page))
> +		flush_dcache_page(page);
> +
>  	UnlockPage(page);
>  
>  	return;
> diff -ruNp --exclude=CVS --exclude=.cvsignore v2.4.6-pre5/include/linux/mm.h kernel/include/linux/mm.h
> --- v2.4.6-pre5/include/linux/mm.h	Mon Jun 25 18:48:09 2001
> +++ kernel/include/linux/mm.h	Tue Jun 26 14:58:56 2001
> @@ -282,6 +282,7 @@ typedef struct page {
>  #define PG_inactive_clean	11
>  #define PG_highmem		12
>  #define PG_checked		13	/* kill me in 2.5.<early>. */
> +#define PG_flush_after		14
>  				/* bits 21-29 unused */
>  #define PG_arch_1		30
>  #define PG_reserved		31
> @@ -364,6 +365,10 @@ static inline void set_page_dirty(struct
>  
>  #define SetPageReserved(page)		set_bit(PG_reserved, &(page)->flags)
>  #define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
> +
> +#define PageFlushAfter(page)	test_bit(PG_flush_after, &(page)->flags)
> +#define SetPageFlushAfter(page)	set_bit(PG_flush_after, &(page)->flags)
> +#define PageTestandClearFlushAfter(page)	test_and_clear_bit(PG_flush_after, &(page)->flags)
>  
>  /*
>   * Error return values for the *_nopage functions
> diff -ruNp --exclude=CVS --exclude=.cvsignore v2.4.6-pre5/mm/memory.c kernel/mm/memory.c
> --- v2.4.6-pre5/mm/memory.c	Mon Jun 25 18:48:10 2001
> +++ kernel/mm/memory.c	Tue Jun 26 14:48:15 2001
> @@ -1109,8 +1109,6 @@ static int do_swap_page(struct mm_struct
>  			return -1;
>  		}
>  		wait_on_page(page);
> -		flush_page_to_ram(page);
> -		flush_icache_page(vma, page);
>  	}
>  
>  	/*
> diff -ruNp --exclude=CVS --exclude=.cvsignore v2.4.6-pre5/mm/page_io.c kernel/mm/page_io.c
> --- v2.4.6-pre5/mm/page_io.c	Mon Apr 30 16:15:32 2001
> +++ kernel/mm/page_io.c	Tue Jun 26 15:01:00 2001
> @@ -50,6 +50,7 @@ static int rw_swap_page_base(int rw, swp
>  
>  	if (rw == READ) {
>  		ClearPageUptodate(page);
> +		SetPageFlushAfter(page);
>  		kstat.pswpin++;
>  	} else
>  		kstat.pswpout++;
> -- 
> 

