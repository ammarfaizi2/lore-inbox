Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTJTT4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTJTT4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:56:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16271 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262762AbTJTT43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:56:29 -0400
Date: Mon, 20 Oct 2003 21:56:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031020195632.GA1128@suse.de>
References: <20031013140858.GU1107@suse.de> <200310201910.48837.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310201910.48837.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20 2003, Daniel Phillips wrote:
> Hi Jens,
> 
> On Monday 13 October 2003 16:08, Jens Axboe wrote:
> > Forward ported and tested today (with the dummy ext3 patch included),
> > works for me. Some todo's left, but I thought I'd send it out to gauge
> > interest.
> 
> This is highly interesting of course, but is it suitable for
> submission during the stability freeze?  There is no correctness issue
> so long as no filesystem in mainline sets the BIO_RW_BARRIER bit,
> which appears to be the case.  Therefore this is really a performance
> patch that introduces a new internal API.

I've said this to you 3 times now I think, I don't think you understand
what I mean with 'correctness issue'. There IS a correctness issue, in
that drives ship with write back caching enabled. The fs assumes that
once wait_on_buffer() returns, the data is on disk. Which is false, can
remain false for quite a long number of seconds.

So let me state again that this is NOT a performance patch. I've never
considered it a performance patch, there are no performance gains with
the patch I posted. It is purely a data integrity issue. I don't know
how I can state this any clearer than I already have...

There are possibilities for performance gains in the _future_, that's
just an added _future_ bonus.

> It seems to me there are a few unresolved issues with the barrier API.  It 

I agree.

> needs to be clearly stated that only write barriers are supported, not read 
> or read/write barriers, if that is in fact the intention.  Assuming it is, 
> then BIOs with read barriers need to be failed.

read barriers can be just as easily supported, I still think that the
notion of read/write barriers is something you are inventing that I
don't see any practical use for. So I wont expand on that at all. From
my point of view, a read barrier is simply an io scheduler barrier. The
drive/driver never sees that bit. But it is 100% expressable with the
current logic.

> The current BIO API provides no way to express a rw barrier, only read
> barriers and write barriers (the combination of direction bit and
> barrier bit indicates the barrier type).  This is minor but it but how
> nice it would be if the API was either orthogonal or there was a clear
> explanation of why RW barriers never make sense.  And if they don't,
> why read barriers do make sense.  Another possible wart is that the
> API doesn't allow for a read barrier carried by a write BIO or a write
> barrier carried by a read BIO.  From a practical point of view the
> only immediate use we have for barriers is to accelerate journal
> writes and everything else comes under the heading of R&D.  It would
> help if the code clearly reflected that modest goal.

Please come up with at least pseudo-rational exampes for why this would
ever be needed, I refuse to design API's based on loose whims or ideas.
The API is "designed" for the practical use of today and what I assumed
would be useful within reason, that's as far as I think it makes sense
to go. To bend the API for a doctored example such as 'rw barrier' is
stupid imho.

> The BIO barrier scheme doesn't mesh properly with your proposed
> QUEUE_ORDERED_* scheme.  It seems to me that what you want is just
> QUEUE_ORDERED_NONE and QUEUE_ORDERED_WRITE.  Is there any case where
> the distinction between a tag based implemenation versus a flush
> matters to high level code?

The difference comes from the early reiser implementation in 2.4, I'm
sure Chris can expand on that. I think it's long gone though, and it's
just an over sight on my part that the ORDERED_TAG is still there. It
will go.

> Also, the blk_queue_ordered function isn't a sufficient interface to
> enable the functionality at a high level, a filesystem also needs a
> way to know whether barriers are supported or not, short of just
> submitting a barrier request and seeing if it fails.

Why? Sometimes the only reliable way to detect whether you can support
barrier writes or not is to issue one. So I can't really help you there.

> The high level interface needs to be able to handled stacked devices,
> i.e., device mapper, but not just device mapper.  Barriers have to be
> supported by all the devices in the stack, not just the top or bottom
> one.  I don't have a concrete suggestion on what the interface should
> be just now.

I completely agree. And I'm very open to patches correcting that issue,
thanks.

> The point of this is, there still remain a number of open issues with
> this patch, no doubt more than just the ones I touched on.  Though it
> is clearly headed in the right direction, I'd suggest holding off
> during the stability freeze and taking the needed time to get it
> right.

You touched on 1 valid point, the md/dm issue. That goes doubly for the
2.4 version (that we don't need to care more about). And I agree with
you there, it needs to be done. And feel free to knock yourself out.
It's not a trivial issue.

-- 
Jens Axboe

