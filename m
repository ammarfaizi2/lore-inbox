Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314484AbSE0IG4>; Mon, 27 May 2002 04:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSE0IGz>; Mon, 27 May 2002 04:06:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36787 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310637AbSE0IGz>;
	Mon, 27 May 2002 04:06:55 -0400
Date: Mon, 27 May 2002 10:06:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
Message-ID: <20020527080632.GC17674@suse.de>
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au> <20020524094606.GH14918@holomorphy.com> <3CEE1035.1E67E1B8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24 2002, Andrew Morton wrote:
> > What kinds of phenomena appear to be associated with IDE's latencies?
> > I recall some comments from prior IDE maintainers on poor interactions
> > between generic disk I/O layers and IDE drivers, particularly with
> > respect to small transactions being given to the drivers to perform.
> > Are these comments still relevant, or is this of a different nature?
> 
> I assume that there's a difference in the way in which the generic layer
> treats queueing for IDE devices.  In 2.4, IDE devices are `head active',
> so the request at the head of the queue is under I/O.  But SCSI isn't
> head-active.  Requests get removed from the head of the queue prior to
> being serviced.  At least, that's how I think it goes.  I also believe that

That's correct for IDE when the queue is unplugged (if plugged, first
request is ok to touch).

> the 2.4 elevator does not look at the active request at the head when making
> merging decisions.

When unplugged, right.

> But in 2.5, head-activeness went away and as far as I know, IDE and SCSI are
> treated the same.  Odd.

It didn't really go away, it just gets handled automatically now.
elv_next_request() marks the request as started, in which case the i/o
scheduler won't consider it for merging etc. SCSI removes the request
directly after it has been marked started, while IDE leaves it on the
queue until it completes. For IDE TCQ, the behaviour is the same as with
SCSI.

-- 
Jens Axboe

