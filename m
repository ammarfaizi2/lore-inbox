Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUJ3AWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUJ3AWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbUJ3AVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:21:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1257 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263738AbUJ3AQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:16:29 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Buffered I/O slowness
Date: Fri, 29 Oct 2004 17:16:25 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jeremy@sgi.com
References: <200410251814.23273.jbarnes@engr.sgi.com> <200410291046.48469.jbarnes@engr.sgi.com> <20041029160827.4dc29c3f.akpm@osdl.org>
In-Reply-To: <20041029160827.4dc29c3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291716.25277.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 29, 2004 4:08 pm, Andrew Morton wrote:
> > I'm intentionally issuing very large reads and writes here to take
> > advantage of the striping, but it looks like both the readahead and
> > regular buffered I/O code will split the I/O into page sized chunks?
>
> No, the readahead code will assemble single BIOs up to the size of the
> readahead window.  So the single-page-reads in do_generic_mapping_read()
> should never happen, because the pages are in cache from the readahead.

Yeah, I realized that after I sent the message.  The readahead looks like it 
might be ok.

> > So maybe a few things need to be done:
> >   o set readahead to larger values by default for dm volumes at setup
> > time (the default was very small)
>
> Well possibly.  dm has control of queue->backing_dev_info and is free to
> tune the queue's default readahead.

Yep, I'll give that a try and see if I can come up with a reasonable default 
(something more the stripe unit seems like a start).

> >   o maybe bypass readahead for very large requests?
> >     if the process is doing a huge request, chances are that readahead
> > won't benefit it as much as a process doing small requests
>
> Maybe - but bear in mind that this is all pinned memory when the I/O is in
> flight, so some upper bound has to remain.

Right, for the direct I/O case, it looks like things are limited to 64 pages 
at a time.

>
> >   o not sure about writes yet, I haven't looked at that call chain much
> > yet
> >
> > Does any of this sound reasonable at all?  What else could be done to
> > make the buffered I/O layer friendlier to large requests?
>
> I'm not sure that we know what's going on yet.  I certainly don't.  The
> above numbers look good, so what's the problem???

The numbers are ~1/3 of what the machine is capable of with direct I/O.  That 
seems like it's much lower than it should be to me.  Cache cold reads into 
the page cache seem like they should be nearly as fast as direct reads (at 
least on a CPU where the extra data copying overhead isn't getting in the 
way).

> Suggest you get geared up to monitor the BIOs going into submit_bio().
> Look at their bi_sector and bi_size.  Make sure that buffered I/O is doing
> the right thing.

Ok, I'll give that a try.

Thanks,
Jesse
