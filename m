Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUEDAvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUEDAvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbUEDAvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:51:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30449 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264134AbUEDAvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:51:37 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <4096E1A6.2010506@yahoo.com.au>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au>	<20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org>	<4096DC89.5020300@yahoo.com.au>
	 <20040503171005.1e63a745.akpm@osdl.org>  <4096E1A6.2010506@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1083631804.4544.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2004 17:50:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 17:19, Nick Piggin wrote:
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> >>>That's one of its usage patterns.  It's also supposed to detect the
> >>>fixed-sized-reads-seeking-all-over-the-place situation.  In which case it's
> >>>supposed to submit correctly-sized multi-page BIOs.  But it's not working
> >>>right for this workload.
> >>>
> >>>A naive solution would be to add special-case code which always does the
> >>>fixed-size readahead after a seek.  Basically that's
> >>>
> >>>	if (ra->next_size == -1UL)
> >>>		force_page_cache_readahead(...)
> >>>
> >>
> >>I think a better solution to this case would be to ensure the
> >>readahead window is always min(size of read, some large number);
> >>
> > 
> > 
> > That would cause the kernel to perform lots of pointless pagecache lookups
> > when the file is already 100% cached.
> > 
> 
> 
> That's pretty sad. You need a "preread" or something which
> sends the pages back... or uses the actor itself. readahead
> would then have to be reworked to only run off the end of
> the read window, but that is what it should be doing anyway.

Sorry, If I am saying this again. I have checked the behaviour of the
readahead code using my user level simulator as well as running some
DSS benchmark and iozone benchmark. It generates a steady stream of
large i/o for large-random-reads and should not exhibit the bad behavior
that we are seeing.  I feel this bad behavior is because of interleaved
access by multiple thread. 

To illustrate with an example:

t1 request reads from page 100 to 104
simultaneously t2 requests reads on the same fd from 200 to 204

So  do_page_cache_readahead() can be called in the following pattern.
100,200,101,201,102,202,103,203,104,204. 
Because of this pattern the readahaed code assumes that the read pattern
is absolutely random and hence closes the readahead window.

I think I should generate a patch to validate this behavior, I will.
How about having some /proc counters that keep track of number of
window-closes because of cache-hits and because of cache-misses?

RP

