Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTLEBbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTLEBbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:31:49 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2945
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263786AbTLEBbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:31:46 -0500
Date: Fri, 5 Dec 2003 02:32:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chuck Lever <cel@citi.umich.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 read ahead never reads the last page in a file
Message-ID: <20031205013205.GA1659@dualathlon.random>
References: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 06:10:31PM -0500, Chuck Lever wrote:
> hi marcelo-
> 
> i posted this a while back on fsdevel for comments, but never heard
> anything.  i'd like this patch to be included in 2.4.24, as it improves
> NFS client read performance by a significant margin, and doesn't appear to
> have any negative impact (see fsdevel archives for benchmarks).  this is
> against 2.4.23.
> 
> generic_file_readahead never reads the last page of a file.  this means
> the last page is always read synchronously by do_generic_file_read.
> normally this is not an issue, as most local disk reads are fast.

sending two sync req is quite slower than 1 sync req even with the disk,
infact in my experience the biggest issue with fast storage isn't the
seeking but the need of sending big requests down to the hardware.
Infact I think it's a _much_ bigger issue for disk than for nfs. Can you
benchmark it on a IDE with 128k long files? They should be read with a
single command, two commands are going to hurt.

> diff -X /home/cel/src/linux/dont-diff -Naurp 00-stock/mm/filemap.c 01-readahead1/mm/filemap.c
> --- 00-stock/mm/filemap.c	2003-11-28 13:26:21.000000000 -0500
> +++ 01-readahead1/mm/filemap.c	2003-12-03 16:46:11.000000000 -0500
> @@ -1299,11 +1299,14 @@ static void generic_file_readahead(int r
>   */
>  	ahead = 0;
>  	while (ahead < max_ahead) {
> -		ahead ++;
> -		if ((raend + ahead) >= end_index)
> +		unsigned long ra_index = raend + ahead + 1;
> +
> +		if (ra_index > end_index)
>  			break;
> -		if (page_cache_read(filp, raend + ahead) < 0)
> +		if (page_cache_read(filp, ra_index) < 0)
>  			break;
> +
> +		ahead++;
>  	}
>  /*
>   * If we tried to read ahead some pages,
> 

looks ok to me. I guess this could be an historic paranoid/(possibly
needed in the past) thing, to avoid reading partial pages from there,
but the pagecache layer is robust enough to handle it these days.

Thanks.
