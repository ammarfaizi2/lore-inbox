Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSEXKAS>; Fri, 24 May 2002 06:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317118AbSEXKAR>; Fri, 24 May 2002 06:00:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314290AbSEXKAQ>;
	Fri, 24 May 2002 06:00:16 -0400
Message-ID: <3CEE1035.1E67E1B8@zip.com.au>
Date: Fri, 24 May 2002 03:04:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au> <20020524094606.GH14918@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Fri, May 24, 2002 at 02:26:48AM -0700, Andrew Morton wrote:
> > Oh absolutely.   That's the reason why 2.4 is beating 2.5 at tiobench with
> > more than one thread.  2.5 is alternating fairly between threads and 2.4
> > is not.  So 2.4 seeks less.
> 
> In one sense or another some sort of graceful transition to unfair
> behavior could be considered a kind of thrashing control; how meaningful
> that is in the context of disk I/O is a question I can't answer directly,
> though. Do you have any comments on this potential strategic unfairness?

Well we already have controls for strategic unfairness: the "read passovers"
thing.  It sets a finite limit on the number of times which a request can
be walked past by the merging algorithm.   Once that counter has
expired, the request becomes effectively a merging barrier and it will
propagate to the head of the queue as fast as the disk can retire the
reads.

I don't have a problem if the `read latency' tunable (and this
algorithm) cause a single thread to hog the disk head across
multiple successive readahead windows.  That's probably a good thing,
and it's tunable.

But it seems to not be working right.

And there's no userspace tunable at this time.

> On Fri, May 24, 2002 at 02:26:48AM -0700, Andrew Morton wrote:
> > I've been testing this extensively on 2.5 + multipage BIO I/O and when you
> > increase readahead from 32 pages (two BIOs) to 64 pages (4 BIOs), 2.5 goes
> > from perfect to horrid - each threads grabs the disk head and performs many,
> > many megabytes of read before any other thread gets a share.  Net effect is
> > that the tiobench numbers are great, but any operation which involves
> > reading disk has 30 or 60 second latencies.
> > Interestingly, it seems specific to IDE.  SCSI behaves well.
> > I have tons of traces and debug code - I'll bug Jens about this in a week or
> > so.
> 
> What kinds of phenomena appear to be associated with IDE's latencies?
> I recall some comments from prior IDE maintainers on poor interactions
> between generic disk I/O layers and IDE drivers, particularly with
> respect to small transactions being given to the drivers to perform.
> Are these comments still relevant, or is this of a different nature?

I assume that there's a difference in the way in which the generic layer
treats queueing for IDE devices.  In 2.4, IDE devices are `head active',
so the request at the head of the queue is under I/O.  But SCSI isn't
head-active.  Requests get removed from the head of the queue prior to
being serviced.  At least, that's how I think it goes.  I also believe that
the 2.4 elevator does not look at the active request at the head when making
merging decisions.

But in 2.5, head-activeness went away and as far as I know, IDE and SCSI are
treated the same.  Odd.

-
