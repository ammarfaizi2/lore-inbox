Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUECUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUECUzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263991AbUECUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:55:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:26847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263972AbUECUzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:55:16 -0400
Date: Mon, 3 May 2004 13:57:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: nickpiggin@yahoo.com.au, alexeyk@mysql.com, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040503135719.423ded06.akpm@osdl.org>
In-Reply-To: <1083615727.7949.40.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
	<20040503110854.5abcdc7e.akpm@osdl.org>
	<1083615727.7949.40.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> > The place which needs attention is handle_ra_miss().  But first I'd like to
> > reacquaint myself with the intent behind the lazy-readahead patch.  Was
> > never happy with the complexity and special-cases which that introduced.
> 
> lazy-readahead has no role to play here.

Sure.  But lazy-readahead is bolted on the side and is generally not to my
liking.  I'd like to find a solution to the sysbench problem which also
solves the thing which lazy-readahead addressed.

> The readahead window got closed
> because the i/o pattern was totally random. My guess is multiple threads
> are generating 16k i/o on the same fd. In such a case the i/os can  get
> interleaved and the readahead window size goes for a toss(which is
> expected  behavior)

I don't think it's that.  The app is doing well-aligned 16k reads and
writes.  If we get enough pagecache hits on the reads, readahead turns
itself off (fair enough) but fails to turn itself on again.

The readahead logic _should_ be able to adapt to the fixed-sized I/Os and
issue correct-sized reads immediately after each seek.  I _think_ this will
fix the problem which lazy-readahead addressed, but as usual we don't have
a rigorous description of that problem :(

> Well if this is infact the case: the question is
> 	1. does the i/o pattern really has some sequentiality to 
> 		deserve a readahead?
> 	2. or should we ensure that the interleaved case be somehow
> 		 handled, by including the size parameter?
> 
> I know Nick has implied option (2) but I think from the readahead's
> point of view it is (1),

Readahead has got too complex and is getting band-aidy.  I'd prefer to tear
it down and rethink things.
