Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVLSHnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVLSHnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 02:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLSHnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 02:43:17 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:58255 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030269AbVLSHnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 02:43:17 -0500
Date: Mon, 19 Dec 2005 09:43:05 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Luuk van der Duim <luukvanderduim@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] micro optimization of cache_estimate in slab.c
In-Reply-To: <1134931062.13138.214.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0512190941480.23535@sbz-30.cs.Helsinki.FI>
References: <1134894189.13138.208.camel@localhost.localdomain> 
 <84144f020512180927lc6492abpb28c047f9e0c535c@mail.gmail.com>
 <1134931062.13138.214.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2005, Steven Rostedt wrote:
> Index: linux-2.6.15-rc5/mm/slab.c
> ===================================================================
> --- linux-2.6.15-rc5.orig/mm/slab.c	2005-12-16 16:24:09.000000000 -0500
> +++ linux-2.6.15-rc5/mm/slab.c	2005-12-18 13:30:13.000000000 -0500
> @@ -708,7 +708,14 @@
>  		base = sizeof(struct slab);
>  		extra = sizeof(kmem_bufctl_t);
>  	}
> -	i = 0;
> +	/*
> +	 * Divide the amount we have, by the amount we need for
> +	 * each object.  Since the size is already calculated
> +	 * to be no less than the alignment, this result will
> +	 * not be any greater than 1 that we need, and this will
> +	 * be subtracted after the while loop.
> +	 */
> +	i = (wastage - base)/(size + extra);
>  	while (i*size + ALIGN(base+i*extra, align) <= wastage)
>  		i++;
>  	if (i > 0)

Thanks. Looks much better but I am still wondering if we could get rid of 
the loop altogether. Hmm.

			Pekka
