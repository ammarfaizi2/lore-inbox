Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUECV46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUECV46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUECV46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:56:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:52887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264054AbUECV4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:56:54 -0400
Date: Mon, 3 May 2004 14:59:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040503145922.5a7dee73.akpm@osdl.org>
In-Reply-To: <1083620245.23042.107.camel@abyss.local>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
	<20040503110854.5abcdc7e.akpm@osdl.org>
	<1083615727.7949.40.camel@localhost.localdomain>
	<20040503135719.423ded06.akpm@osdl.org>
	<1083620245.23042.107.camel@abyss.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> wrote:
>
> On Mon, 2004-05-03 at 13:57, Andrew Morton wrote:
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > >
> > > > The place which needs attention is handle_ra_miss().  But first I'd like to
> > > > reacquaint myself with the intent behind the lazy-readahead patch.  Was
> > > > never happy with the complexity and special-cases which that introduced.
> > > 
> > > lazy-readahead has no role to play here.
> > 
> 
> Andrew,
> 
> Could you please clarify how this things become to be dependent on
> read-ahead at all.

readahead is currently the only means by which we build up nice large
multi-page BIOs.

> At my understanding read-ahead it to catch sequential (or other) access
> pattern and do some advance reading, so instead of 16K request we do
> 128K request, or something similar.

That's one of its usage patterns.  It's also supposed to detect the
fixed-sized-reads-seeking-all-over-the-place situation.  In which case it's
supposed to submit correctly-sized multi-page BIOs.  But it's not working
right for this workload.

A naive solution would be to add special-case code which always does the
fixed-size readahead after a seek.  Basically that's

	if (ra->next_size == -1UL)
		force_page_cache_readahead(...)

in filemap.c.  But this means that the kernel does lots of pointless
pagecache lookups when everything is in pagecache.  We should detect this
situation and stop doing readahead completely, until we start getting
pagecache lookup misses again.

> But how could read-ahead disabled end up in 16K request converted to
> several sequential synchronous 4K requests ? 

Readahead got itself turned off because of pagecache hits and didn't turn
itself on again.

