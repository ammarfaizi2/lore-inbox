Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135853AbREDEKk>; Fri, 4 May 2001 00:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135855AbREDEKa>; Fri, 4 May 2001 00:10:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54945 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135853AbREDEKT>;
	Fri, 4 May 2001 00:10:19 -0400
Date: Fri, 4 May 2001 00:10:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] max_fds race in select().
In-Reply-To: <m14vWv7-001QLxC@mozart>
Message-ID: <Pine.GSO.4.21.0105040007310.17788-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Rusty Russell wrote:

> We can end up with the user getting more fds tban they asked for...
> 
> Unlikely, but possible,

True. If n is originally greater than ->max_fdset and ->max_fdset
grows between the comparison and assignment. Yuck.

Linus, please apply it - race is narrow, but...
								Al

> --- linux-2.4.4-official/fs/select.c	Thu Feb 22 14:25:36 2001
> +++ working-2.4.4-rcu/fs/select.c	Fri May  4 14:06:39 2001
> @@ -260,7 +260,7 @@
>  	fd_set_bits fds;
>  	char *bits;
>  	long timeout;
> -	int ret, size;
> +	int ret, size, max_fdset;
>  
>  	timeout = MAX_SCHEDULE_TIMEOUT;
>  	if (tvp) {
> @@ -285,8 +285,10 @@
>  	if (n < 0)
>  		goto out_nofds;
>  
> -	if (n > current->files->max_fdset)
> -		n = current->files->max_fdset;
> +	/* max_fdset can increase, so grab it once to avoid race */
> +	max_fdset = current->files->max_fdset;
> +	if (n > max_fdset)
> +		n = max_fdset;
>  
>  	/*
>  	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
> 
> --
> Premature optmztion is rt of all evl. --DK
> 

