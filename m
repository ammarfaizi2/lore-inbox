Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbRFUPjO>; Thu, 21 Jun 2001 11:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265011AbRFUPjE>; Thu, 21 Jun 2001 11:39:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265010AbRFUPiw>; Thu, 21 Jun 2001 11:38:52 -0400
Date: Thu, 21 Jun 2001 17:38:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stefan.Bader@de.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <20010621173833.L29084@athlon.random>
In-Reply-To: <C1256A72.00507ECF.00@d12mta05.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1256A72.00507ECF.00@d12mta05.de.ibm.com>; from Stefan.Bader@de.ibm.com on Thu, Jun 21, 2001 at 04:39:11PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 04:39:11PM +0200, Stefan.Bader@de.ibm.com wrote:
> diff -ruN old/fs/buffer.c new/fs/buffer.c
> --- old/fs/buffer.c     Thu Jun 21 09:47:20 2001
> +++ new/fs/buffer.c     Thu Jun 21 10:44:01 2001
> @@ -798,11 +798,12 @@
>          * that unlock the page..
>          */
>         spin_lock_irqsave(&page_uptodate_lock, flags);
> +       clear_bit(BH_Async, &bh->b_state);
>         unlock_buffer(bh);
>         atomic_dec(&bh->b_count);
>         tmp = bh->b_this_page;
>         while (tmp != bh) {
> -               if (tmp->b_end_io == end_buffer_io_async &&
> buffer_locked(tmp))
> +               if (test_bit(BH_Async, &tmp->b_state) &&
> buffer_locked(tmp))
>                         goto still_busy;
>                 tmp = tmp->b_this_page;
>         }
> @@ -834,6 +835,7 @@
> 
>  void set_buffer_async_io(struct buffer_head *bh) {
>      bh->b_end_io = end_buffer_io_async ;
> +               set_bit(BH_Async, &bh->b_state);
>  }
> 
>  /*
> @@ -1535,6 +1537,7 @@
>         do {
>                 lock_buffer(bh);
>                 bh->b_end_io = end_buffer_io_async;
> +               set_bit(BH_Async, &bh->b_state);
>                 atomic_inc(&bh->b_count);
>                 set_bit(BH_Uptodate, &bh->b_state);
>                 clear_bit(BH_Dirty, &bh->b_state);
> @@ -1736,6 +1739,7 @@
>                 struct buffer_head * bh = arr[i];
>                 lock_buffer(bh);
>                 bh->b_end_io = end_buffer_io_async;
> +               set_bit(BH_Async, &bh->b_state);
>                 atomic_inc(&bh->b_count);
>         }
> 
> @@ -2182,6 +2186,7 @@
>                 bh->b_blocknr = *(b++);
>                 set_bit(BH_Mapped, &bh->b_state);
>                 bh->b_end_io = end_buffer_io_async;
> +               set_bit(BH_Async, &bh->b_state);
>                 atomic_inc(&bh->b_count);
>                 bh = bh->b_this_page;
>         } while (bh != head);
> diff -ruN old/include/linux/fs.h new/include/linux/fs.h
> --- old/include/linux/fs.h      Thu Jun 21 09:47:51 2001
> +++ new/include/linux/fs.h      Thu Jun 21 09:48:20 2001
> @@ -207,6 +207,7 @@
>  #define BH_Mapped      4       /* 1 if the buffer has a disk mapping */
>  #define BH_New         5       /* 1 if the buffer is new and not yet
> written out */
>  #define BH_Protected   6       /* 1 if the buffer is protected */
> +#define BH_Async 7 /* 1 if the buffer is used for asyncronous io */
> 
>  /*
>   * Try to keep the most commonly used fields in single cache lines (16

I think the patch is ok. We must have a way to track down which bh are
actually getting read, the others could be just uptodate and dirty and
waiting kupdate to flush them under us (and we cannot defer the unlock
of the page due those locked buffers under flush write-I/O or we
deadlock).

Andrea
