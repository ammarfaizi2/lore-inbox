Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUEDBQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUEDBQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUEDBQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:16:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:37289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264176AbUEDBQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:16:32 -0400
Date: Mon, 3 May 2004 18:15:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: peter@mysql.com, linuxram@us.ibm.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040503181533.59af9762.akpm@osdl.org>
In-Reply-To: <4096E1A6.2010506@yahoo.com.au>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
	<20040503110854.5abcdc7e.akpm@osdl.org>
	<1083615727.7949.40.camel@localhost.localdomain>
	<20040503135719.423ded06.akpm@osdl.org>
	<1083620245.23042.107.camel@abyss.local>
	<20040503145922.5a7dee73.akpm@osdl.org>
	<4096DC89.5020300@yahoo.com.au>
	<20040503171005.1e63a745.akpm@osdl.org>
	<4096E1A6.2010506@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
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

Sorry, I do not understand that paragraph at all.

All forms or pagecache population need to examine the pagecache to find out
if the page is already there.  This involves pagecache lookups.  We want
the read code to "learn" that the requested pages are all coming from cache
and to stop doing those lookups altogether.


