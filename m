Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271741AbTHMK3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271742AbTHMK3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:29:48 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:32915 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271741AbTHMK3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:29:47 -0400
Date: Wed, 13 Aug 2003 12:29:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] unused label (was: Re: If xdr_kmap() fails, we need to ensure
 that it unmaps all the pages, and returns)
In-Reply-To: <200307311703.h6VH3i0f027629@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0308131226370.11378-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1019.1.22, 2003/07/30 01:54:20+02:00, trond.myklebust@fys.uio.no
> 
> 	If xdr_kmap() fails, we need to ensure that it unmaps all the pages, and returns
> 	0. We don't want to be sending partial RPC requests to the server.

> diff -Nru a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> --- a/net/sunrpc/xdr.c	Thu Jul 31 10:03:47 2003
> +++ b/net/sunrpc/xdr.c	Thu Jul 31 10:03:47 2003

> @@ -203,16 +204,15 @@
>  		ppage += base >> PAGE_CACHE_SHIFT;
>  		base &= ~PAGE_CACHE_MASK;
>  	}
> -	first_kmap = 1;
>  	do {
>  		len = PAGE_CACHE_SIZE;
> -		if (first_kmap) {
> -			first_kmap = 0;
> +		if (!first_kmap) {
> +			first_kmap = ppage;
>  			iov->iov_base = kmap(*ppage);
>  		} else {
>  			iov->iov_base = kmap_nonblock(*ppage);
>  			if (!iov->iov_base)
> -				goto out;
> +				goto out_err;
>  		}
>  		if (base) {
>  			iov->iov_base += base;

After this change the label `out' becomes unused, causing a compile warning.
Here's a fix:

--- linux-2.4.22-rc2/net/sunrpc/xdr.c.orig	Wed Aug 13 12:03:03 2003
+++ linux-2.4.22-rc2/net/sunrpc/xdr.c	Wed Aug 13 12:21:11 2003
@@ -231,7 +231,6 @@
 		iov->iov_base = (char *)xdr->tail[0].iov_base + base;
 		iov++;
 	}
- out:
 	return (iov - iov_base);
 out_err:
 	for (; first_kmap != ppage; first_kmap++)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

