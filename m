Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLEQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTLEQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:33:59 -0500
Received: from intra.cyclades.com ([64.186.161.6]:16097 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264147AbTLEQd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:33:57 -0500
Date: Fri, 5 Dec 2003 13:51:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 read ahead never reads the last page in a file
In-Reply-To: <20031205013205.GA1659@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0312051140220.1782-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Andrea Arcangeli wrote:

> On Wed, Dec 03, 2003 at 06:10:31PM -0500, Chuck Lever wrote:
> > hi marcelo-
> > 
> > i posted this a while back on fsdevel for comments, but never heard
> > anything.  i'd like this patch to be included in 2.4.24, as it improves
> > NFS client read performance by a significant margin, and doesn't appear to
> > have any negative impact (see fsdevel archives for benchmarks).  this is
> > against 2.4.23.
> > 
> > generic_file_readahead never reads the last page of a file.  this means
> > the last page is always read synchronously by do_generic_file_read.
> > normally this is not an issue, as most local disk reads are fast.
> 
> sending two sync req is quite slower than 1 sync req even with the disk,
> infact in my experience the biggest issue with fast storage isn't the
> seeking but the need of sending big requests down to the hardware.
> Infact I think it's a _much_ bigger issue for disk than for nfs. Can you
> benchmark it on a IDE with 128k long files? They should be read with a
> single command, two commands are going to hurt.
> 
> > diff -X /home/cel/src/linux/dont-diff -Naurp 00-stock/mm/filemap.c 01-readahead1/mm/filemap.c
> > --- 00-stock/mm/filemap.c	2003-11-28 13:26:21.000000000 -0500
> > +++ 01-readahead1/mm/filemap.c	2003-12-03 16:46:11.000000000 -0500
> > @@ -1299,11 +1299,14 @@ static void generic_file_readahead(int r
> >   */
> >  	ahead = 0;
> >  	while (ahead < max_ahead) {
> > -		ahead ++;
> > -		if ((raend + ahead) >= end_index)
> > +		unsigned long ra_index = raend + ahead + 1;
> > +
> > +		if (ra_index > end_index)
> >  			break;
> > -		if (page_cache_read(filp, raend + ahead) < 0)
> > +		if (page_cache_read(filp, ra_index) < 0)
> >  			break;
> > +
> > +		ahead++;
> >  	}
> >  /*
> >   * If we tried to read ahead some pages,
> > 
> 
> looks ok to me. I guess this could be an historic paranoid/(possibly
> needed in the past) thing, to avoid reading partial pages from there,
> but the pagecache layer is robust enough to handle it these days.

Patch applied. 



