Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUEJWpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUEJWpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUEJWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:43:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53485 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262382AbUEJWlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:41:09 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: alexeyk@mysql.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040510132151.238b8d0c.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
	 <1084218659.6140.459.camel@localhost.localdomain>
	 <20040510132151.238b8d0c.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1084228767.6140.832.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2004 15:39:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 13:21, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> >
> > > Ram, can you take a look at fixing that up please?  Something clean, not
> > > more hacks ;) I'd also be interested in an explanation of what the extra
> > > page is for.  The little comment in there doesn't really help.
> > 
> > 
> > The reason for the extra page read is as follows:
> > 
> > Consider 16k random reads i/os. Reads are generated 4pages at a time.
> > 
> > the readahead is triggered when the 4th page in the 'current-window' is
> > touched.
> 
> Right.  We've added two whole unsigned longs to the file_struct to track
> the access patterns.  That should be sufficient for us to detect when the
> access pattern is random, and to then not perform readahead due to a
> current-window miss *at all*.
> 
> So that extra page can go away, and:
> 
> --- 25/mm/readahead.c~a	Mon May 10 13:16:59 2004
> +++ 25-akpm/mm/readahead.c	Mon May 10 13:17:22 2004
> @@ -492,21 +492,17 @@ do_io:
>  		 */
>  		if (ra->ahead_start == 0) {
>  			/*
> -			 * if the average io-size is less than maximum
> +			 * If the average io-size is less than maximum
>  			 * readahead size of the file the io pattern is
>  			 * sequential. Hence  bring in the readahead window
>  			 * immediately.
> -			 * Else the i/o pattern is random. Bring
> -			 * in the readahead window only if the last page of
> -			 * the current window is accessed (lazy readahead).
>  			 */
>  			unsigned long average = ra->average;
>  
>  			if (ra->serial_cnt > average)
>  				average = (ra->serial_cnt + ra->average) / 2;
>  
> -			if ((average >= max) || (offset == (ra->start +
> -							ra->size - 1))) {
> +			if (average >= max) {
>  				ra->ahead_start = ra->start + ra->size;
>  				ra->ahead_size = ra->next_size;
>  				actual = do_page_cache_readahead(mapping, filp,
> 
> _
> 
> 
> That way, we read the correct amount of data, and we only start I/O when we
> know the application is going to actually use the data.
> 
> This may cause problems when the application transitions from seeky-access
> to linear-access.
> 
> Does it sound feasible?
I am nervous about this change. You are totally getting rid of
lazy-readahead and that was the optimization which gave the best
possible boost in performance. 
Let me see how this patch does with a DSS benchmark.

> 
> >
> > Probably we may see marginal degradation of this optimization with 16k
> > i/o but the amount of wastage avoided by this optimization (hack) 
> > is great when random i/o is of larger size. I think it was 4% better
> > performance on DSS workload with 64k random reads.
> 
> 64k sounds unusually large.  We need top performance at 8k too.
> 
> > Do you still think its a hack?
> 
> yup ;)
> 

:-(


> > Also I think  with sysbench workload and Andrew's ra-copy patch, we
> > might be loosing some benefits of some of the optimization because 
> > if two threads simulteously work with copies of the same ra structure
> > and update it, the optimization effect reflected in one of the
> > ra-structure is lost depending on which ra structure gets copied back
> > last.
> 
> hm, maybe.  That only makes a difference if two threads are accessing the
> same fd at the same time, and it was really bad before the patch.  The IO
> patterns seemed OK to me with the patch.  Except it's reading one page too
> many.

In the normal large random workload this extra page would have
compesated for all the wasted readaheads.  However in the case of
sysbench with Andrew's ra-copy patch the readahead calculation is not
happening quiet right. Is it worth trying to get a marginal gain 
with sysbench at the cost of getting a big hit on DSS benchmarks,
aio-tests,iozone and probably others. Or am I making an unsubstantiated
claim? I will get back with results.


RP

