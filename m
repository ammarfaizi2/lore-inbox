Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUBSXxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUBSXxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:53:52 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:56554 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267587AbUBSXxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:53:49 -0500
Date: Fri, 20 Feb 2004 00:53:03 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
Message-ID: <20040219235303.GI32263@drinkel.cistron.nl>
References: <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40353E30.6000105@cyberone.com.au> (from piggin@cyberone.com.au on Thu, Feb 19, 2004 at 23:52:32 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 23:52:32, Nick Piggin wrote:
> 
> 
> Miquel van Smoorenburg wrote:
> 
> >On Thu, 19 Feb 2004 11:19:15, Jens Axboe wrote:
> >
> >>On Thu, Feb 19 2004, Miquel van Smoorenburg wrote:
> >>
> >>
> >>>>Shouldn't the controller itself be performing the insertion?
> >>>>
> >>>Well, you would indeed expect the 3ware hardware to be smarter than
> >>>that, but in its defence, the driver doesn't set sdev->simple_tags or
> >>>sdev->ordered_tags at all. It just has a large queue on the host, in
> >>>hardware.
> >>>
> >>A too large queue. IMHO the simple and correct solution to your problem
> >>is to diminish the host queue (sane solution), or bump the block layer
> >>queue size (dumb solution).
> >>
> >
> >Well, I did that. Lowering the queue size of the 3ware controller to 64
> >does help a bit, but performance is still not optimal - leaving it at 254
> >and increasing the nr_requests of the queue to 512 helps the most.
> >
> >But the patch I posted does just as well, without any tuning. I changed
> >it a little though - it only has the "new" behaviour (instead of blocking
> >on allocating a request, allocate it, queue it, _then_ block) for WRITEs.
> >That results in the best performance I've seen, by far.
> >
> >
> 
> That's because you are half introducing per-process limits.
> 
> >Now the style of my patch might be ugly, but what is conceptually wrong
> >with allocating the request and queueing it, then block if the queue is
> >full, versus blocking on allocating the request and keeping a bio
> >"stuck" for quite some time, resulting in out-of-order requests to the
> >hardware ?
> >
> >
> 
> Conceptually? The concept that you have everything you need to
> continue and yet you block anyway is wrong.

For reading, I agree. For writing .. ah well, English is not my first
language, let's not argue about language semantics.

> >Note that this is not an issue of '2 processes writing to 1 file', really.
> >It's one process and pdflush writing the same dirty pages of the same file.
> 
> pdflush is a process though, that's all that matters.

I understand that when the two processes are unrelated, the patch as I
sent it will do the wrong thing.

But the thing is, you get this:

- "dd" process writes requests
- pdflush triggers to write dirty pages
- too many pages are dirty so "dd" blocks as well to write synchronously
- "dd" process triggers "queue full" but gets marked as "batching" so
  can continue (get_request)
- pdflush tries to submit one bio and gets blocked (get_request_wait)
- "dd" continues, but that one bio from pdflush remains stuck for a while

That's stupid, that one bio from pdflush should really be allowed on
the queue, since "dd" is adding requests from the same source to it
anyway.

Perhaps writes from pdflush should be handled differently to prevent
this specific case ?

Say, if pdflush adds request #128, don't mark it as batching, but
let it block. The next process will be the one marked as batching
and can continue. If pdflush tries to add a request > 128, allow it,
but _then_ block it.

Would something like that work ? Would it be a good idea to never mark
a pdflush process as batching, or would that have a negative impact
for some things ?

Mike.
