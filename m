Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRB1DhX>; Tue, 27 Feb 2001 22:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130053AbRB1DhO>; Tue, 27 Feb 2001 22:37:14 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:53004 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129632AbRB1DhF>; Tue, 27 Feb 2001 22:37:05 -0500
Date: Tue, 27 Feb 2001 22:50:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Robert Read <rread@datarithm.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] set kiobuf io_count once, instead of increment
In-Reply-To: <20010227162222.A6389@tenchi.datarithm.net>
Message-ID: <Pine.LNX.4.21.0102272234380.7124-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Feb 2001, Robert Read wrote:

> Currently in brw_kiovec, iobuf->io_count is being incremented as each
> bh is submitted, and decremented in the bh->b_end_io().  This means
> io_count can go to zero before all the bhs have been submitted,
> especially during a large request. This causes the end_kio_request()
> to be called before all of the io is complete.  
> 
> This suggested patch against 2.4.2 sets io_count to the total amount
> before the bhs are submitted, although there is probably a better way
> to determine the io_count than this.
> 
> robert
> 
> diff -ru linux/fs/buffer.c linux-rm/fs/buffer.c
> --- linux/fs/buffer.c	Mon Jan 15 12:42:32 2001
> +++ linux-rm/fs/buffer.c	Tue Jan 30 11:41:57 2001
> @@ -2085,6 +2085,7 @@
>  		offset = iobuf->offset;
>  		length = iobuf->length;
>  		iobuf->errno = 0;
> +		atomic_set(&iobuf->io_count, length/size);
>  		
>  		for (pageind = 0; pageind < iobuf->nr_pages; pageind++) {
>  			map  = iobuf->maplist[pageind];
> @@ -2119,8 +2120,6 @@
>  				bh[bhind++] = tmp;
>  				length -= size;
>  				offset += size;
> -
> -				atomic_inc(&iobuf->io_count);
>  
>  				submit_bh(rw, tmp);
>  				/* 
> -

It seems your patch breaks bh allocation failure handling. If
get_unused_buffer_head() fails, iobuf->io_count never reaches 0, so
processes waiting on kiobuf_wait_for_io() will block forever.


