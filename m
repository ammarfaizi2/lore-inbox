Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269812AbRHDGyE>; Sat, 4 Aug 2001 02:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269813AbRHDGxz>; Sat, 4 Aug 2001 02:53:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4617 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S269812AbRHDGxo>;
	Sat, 4 Aug 2001 02:53:44 -0400
Date: Sat, 4 Aug 2001 02:50:10 -0400
From: Anton Blanchard <anton@samba.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Tridgell <tridge@valinux.com>, lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
Message-ID: <20010804025008.A30349@krispykreme>
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Marcelo,

> The problem is pretty nasty: if there is no global shortage and only a 
> given zone with shortage, we set the zone free target to freepages.min
> (basically no tasks can make progress with that amount of free memory). 

Paulus and I were seeing the same problem on a ppc with 2.4.8-pre3. We
were doing cat > /dev/null of about 5G of data, when we had close to 3G of
page cache kswapd chewed up all the cpu. Our guess was that there was a
shortage of lowmem pages (everything above 512M is highmem on the ppc32
kernel so there isnt much lowmem).

The patch below allowed us to get close to 4G of page cache before
things slowed down again and kswapd took over.

Anton

> --- linux.orig/mm/page_alloc.c	Mon Jul 30 17:06:49 2001
> +++ linux/mm/page_alloc.c	Wed Aug  1 06:21:35 2001
> @@ -630,8 +630,8 @@
>  		goto ret;
>  
>  	if (zone->inactive_clean_pages + zone->free_pages
> -			< zone->pages_min) {
> -		sum += zone->pages_min;
> +			< zone->pages_high) {
> +		sum += zone->pages_high;
>  		sum -= zone->free_pages;
>  		sum -= zone->inactive_clean_pages;
>  	}
