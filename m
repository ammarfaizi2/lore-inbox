Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUEJTxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUEJTxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUEJTxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:53:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34015 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261421AbUEJTwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:52:33 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Kopytov <alexeyk@mysql.com>, nickpiggin@yahoo.com.au,
       peter@mysql.com, linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040506014307.1a97d23b.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1084218659.6140.459.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2004 12:50:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-06 at 01:43, Andrew Morton wrote:

sorry, I am out for 10days and hence replies are late.

> The reason for the difference appears to be the thing which Ram added to
> readahead which causes it to usually read one page too many.  With this
> exciting patch:
> 
> --- 25/mm/readahead.c~a	2004-05-06 01:24:26.230330464 -0700
> +++ 25-akpm/mm/readahead.c	2004-05-06 01:24:26.234329856 -0700
> @@ -475,7 +475,7 @@ do_io:
>  		ra->ahead_start = 0;		/* Invalidate these */
>  		ra->ahead_size = 0;
>  		actual = do_page_cache_readahead(mapping, filp, offset,
> -						 ra->size);
> +				ra->size == 5 ? 4 : ra->size);
>  		if(!first_access) {
>  			/*
>  			 * do not adjust the readahead window size the first
> 
> _
> 
> 
> I get:
> 
> 	Time spent for test:  63.9435s
> 		0.07s user 6.69s system 5% cpu 2:11.02 total
> 
> which is a good result.
> 
> Ram, can you take a look at fixing that up please?  Something clean, not
> more hacks ;) I'd also be interested in an explanation of what the extra
> page is for.  The little comment in there doesn't really help.


The reason for the extra page read is as follows:

Consider 16k random reads i/os. Reads are generated 4pages at a time.

the readahead is triggered when the 4th page in the 'current-window' is
touched. However the data which is read-in through the 'readahead
window' gets thrown away because the next 16k read-io will not access
anything read in the readahead window. As a result I put in that
optimization which handles this wasted readahead-pages. 

The idea is, when we miss the current-window, read one more page than
the number of pages accessed in the current-window. 

Here is a example scenario of random 16k i/os and with Andrew's code
		actual = do_page_cache_readahead(mapping, filp, offset,
-						 ra->size);
+				ra->size == 5 ? 4 : ra->size);


Consider that the application access  page {1,2,3,4}  
{100,101,102,103}  {200,201,202,203}

Consider that the current-window holds 4 pages. i.e page 1,2,3,4

when the application asks for {1,2,3,4} we happily satisfy them through
the current-window. However when the application touches page 4, the
lazy-readahead triggers in and brings in pages {5,6,7,8,9,10,11,12} but
now the application wants to access {100,101,102,103}. This waste of
effort is probably bearable as long as we dont commit the same mistake
in the future. When the application tries to access {100,101,102,103}
the code then scraps both the current-window and the readahead-window
and reads in a new current-window of size 4 i.e {100,101,102,103}.
However when
the application touches page 103, the lazy-readahead gets triggered and
brings in 8 more pages {104,105,106,107,108,109,110,111} and as always
all these pages go wasted. This wastage continues for ever.

My Optimization [ I mean hack ;) ] was meant to avoid this bad behavior.
Instead of reading in 'number of pages accessed in the current-window',
I read in 'one more page than the number of pages accessed in the
current-window'. With this optimization the behavior changes to as
follows:

when the application asks for {1,2,3,4} we happily satisfy them through
the current-window. However when the application touches page 4, the
lazy-readahead triggers and brings in pages {5,6,7,8,9,10,11,12} but now
the application wants to access {100,101,102,103}. This bad behavior is
probably ok since the optimization ensures that it does not commit the
same mistake in the future. When the application tries to access
{100,101,102,103} the code then scraps both the current window and the
readahead window and reads in a new current window of size 4+1 i.e
{100,101,102,103,104}. 
However since the application does not touch page 104 and hence
lazy-readahead does not get triggered we do not waste effort
bringing in pages. And this nice behavior continues for ever.


Probably we may see marginal degradation of this optimization with 16k
i/o but the amount of wastage avoided by this optimization (hack) 
is great when random i/o is of larger size. I think it was 4% better
performance on DSS workload with 64k random reads.

Do you still think its a hack?

Also I think  with sysbench workload and Andrew's ra-copy patch, we
might be loosing some benefits of some of the optimization because 
if two threads simulteously work with copies of the same ra structure
and update it, the optimization effect reflected in one of the
ra-structure is lost depending on which ra structure gets copied back
last.

RP

