Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSKLTjU>; Tue, 12 Nov 2002 14:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSKLTjU>; Tue, 12 Nov 2002 14:39:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:23184 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261545AbSKLTjT>;
	Tue, 12 Nov 2002 14:39:19 -0500
Message-ID: <3DD15A79.768C1066@digeo.com>
Date: Tue, 12 Nov 2002 11:46:01 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.[45] fixes for design locking bug in 
 wait_on_page/wait_on_buffer/get_request_wait
References: <20021112035723.GA17642@dualathlon.random> <3DD0C0E6.4A8035A4@digeo.com> <20021112181532.GA6133@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 19:46:01.0845 (UTC) FILETIME=[21479250:01C28A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> 
> no, you forgot readahead, that's buggy and needs fixing in readpage too
> (same in 2.4 and 2.5).

readahead in 2.5 unplugs.  Which is quite wrong for AIO, but is unavoidable
given the current situation...
 
> ...
> 
> > I dunno.  I bet there are still more holes, and I for one am heartily sick
> > of unplug bugs.  Why not make the damn queue unplug itself after ten
> > milliseconds or 16 requests?  I bet that would actually increase throughput,
> > especially in the presence of kernel preemption and scheduling points.
> 
> This doesn't remove the need to avoid the mean 5 msec delay before the
> queue unplug (I know the race triggers rarely though, but if we left all the
> places broken the number of 5msec mean waits will increase bug by bug
> over time). I'm not very excited by the idea (in particular for 2.4), if
> it performs so much better I would say it's a broken length of the queue
> that is way too oversized and that leads to other problems with fariness
> of task against task etc... We need the big number of requests with
> small requests only, with big requests we should allow only very few
> requests to be returned.

No, no, no.  Step back, miles back.  Forget the current implementation
and ask yourself "what is a good design for plugging?".  Because I can
assure you that if someone came out and proposed the current design for
inclusion in today's kernel, they would be pulverised.

Plugging is an optimisation which is specific to, and internal to the
request layer.  It should not require that every client of that layer
know about it, and be careful to unplug (with bizarrely complex locking
and ordering rules) simply because the request layer is too lame to look
after its own stuff.

Particularly because the clients of the request layer do not have enough
information to make a good decision about when to unplug.  Only the
request layer knows that.

And particularly because we've been hitting the same darn bug for years.
And we've been blaming the poor old callers!

The request layer should perform its own unplug "when the time is right",
and the external unplug should be viewed as an optimisation hint.

It all becomes rather obvious when you try to answer the question "when
should the kernel unplug for AIO reads"?

And yes, the fact that the time-based component of the unplug decision
would obscure failure by callers to make use of the optimisation hint
is unfortunate.  But it's only a few callsites, and 99.9999% coverage
there is good enough.
