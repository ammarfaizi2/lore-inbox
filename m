Return-Path: <linux-kernel-owner+w=401wt.eu-S1750875AbXATXHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbXATXHb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXATXHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:07:30 -0500
Received: from hu-out-0506.google.com ([72.14.214.238]:18047 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXATXH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:07:27 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WzbXZLCUCwcvUnL7kTZoPn8QKDSL++XqwKilaWR94sosl+tWFb6gNVkq/NFCVvKE4pUaGWImhqmPVHAL9N0g6KpSTOwRC3dHXO4ZADDJCa5DSISrYRs968WsD7J3di7unjX5OlgzD7W0Oqp30F13puah95i/ZhRsyZ36so0rFbo=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: O_DIRECT question
Date: Sun, 21 Jan 2007 00:05:36 +0100
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <200701201736.22553.vda.linux@googlemail.com> <45B281BB.50607@tls.msk.ru>
In-Reply-To: <45B281BB.50607@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701210005.36274.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2007 21:55, Michael Tokarev wrote:
> Denis Vlasenko wrote:
> > On Thursday 11 January 2007 18:13, Michael Tokarev wrote:
> >> example, which isn't quite possible now from userspace.  But as long as
> >> O_DIRECT actually writes data before returning from write() call (as it
> >> seems to be the case at least with a normal filesystem on a real block
> >> device - I don't touch corner cases like nfs here), it's pretty much
> >> THE ideal solution, at least from the application (developer) standpoint.
> > 
> > Why do you want to wait while 100 megs of data are being written?
> > You _have to_ have threaded db code in order to not waste
> > gobs of CPU time on UP + even with that you eat context switch
> > penalty anyway.
> 
> Usually it's done using aio ;)
> 
> It's not that simple really.
> 
> For reads, you have to wait for the data anyway before doing something
> with it.  Omiting reads for now.

Really? All 100 megs _at once_? Linus described fairly simple (conceptually)
idea here: http://lkml.org/lkml/2002/5/11/58
In short, page-aligned read buffer can be just unmapped,
with page fault handler catching accesses to yet-unread data.
As data comes from disk, it gets mapped back in process'
address space.

This way read() returns almost immediately and CPU is free to do
something useful.

> For writes, it's not that problematic - even 10-15 threads is nothing
> compared with the I/O (O in this case) itself -- that context switch
> penalty.

Well, if you have some CPU intensive thing to do (e.g. sort),
why not benefit from lack of extra context switch?
Assume that we have "clever writes" like Linus described.

/* something like "caching i/o over this fd is mostly useless" */
/* (looks like this API is easier to transition to
 * than fadvise etc. - it's "looks like" O_DIRECT) */
	fd = open(..., flags|O_STREAM);
        ...
/* Starts writeout immediately due to O_STREAM,
 * marks buf100meg's pages R/O to catch modifications,
 * but doesn't block! */
	write(fd, buf100meg, 100*1024*1024);
/* We are free to do something useful in parallel */
	sort();

> > I hope you agree that threaded code is not ideal performance-wise
> > - async IO is better. O_DIRECT is strictly sync IO.
> 
> Hmm.. Now I'm confused.
> 
> For example, oracle uses aio + O_DIRECT.  It seems to be working... ;)
> As an alternative, there are multiple single-threaded db_writer processes.
> Why do you say O_DIRECT is strictly sync?

I mean that O_DIRECT write() blocks until I/O really is done.
Normal write can block for much less, or not at all.

> In either case - I provided some real numbers in this thread before.
> Yes, O_DIRECT has its problems, even security problems.  But the thing
> is - it is working, and working WAY better - from the performance point
> of view - than "indirect" I/O, and currently there's no alternative that
> works as good as O_DIRECT.

Why we bothered to write Linux at all?
There were other Unixes which worked ok.
--
vda
