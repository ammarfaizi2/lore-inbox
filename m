Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRH0WK4>; Mon, 27 Aug 2001 18:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRH0WKt>; Mon, 27 Aug 2001 18:10:49 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:28844 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S269417AbRH0WKb>; Mon, 27 Aug 2001 18:10:31 -0400
Date: Tue, 28 Aug 2001 00:10:45 +0200 (MET DST)
From: <Oliver.Neukum@lrz.uni-muenchen.de>
X-X-Sender: <ui222bq@sun2.lrz-muenchen.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010827203125Z16070-32383+1731@humbolt.nl.linux.org>
Message-Id: <Pine.SOL.4.33.0108272348170.1537-100000@sun2.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > If we are optimising for streaming (which readahead is made for) dropping
> > only one page will buy you almost nothing in seek time. You might just as
> > well drop them all and correct your error in one larger read if necessary.
> > Dropping the oldest page is possibly the worst you can do, as you will need
> > it soonest.
>
> Yes, good point.  OK, I'll re-examine the dropping logic.  Bear in mind,
> dropping readahead pages is not supposed to happen frequently under
> steady-state operation, so it's not that critical what we do here, it's going
> to be hard to create a load that shows the impact.  The really big benefit
> comes from not overdoing the readahead in the first place, and not underdoing
> it either.

OK, so you have four reasons for dropping a readahead page

1) File was closed - trivial I'd say
2) Memory needed for other readahead
3) Memory needed for anything but readahead
4) The page won't be needed - some kind of timeout ?

Cases 3 and 2 are hard. Should replacement policy vary ?

> > > > If you are streaming dropping all should be no great loss.
> > >
> > > The quesion is, how do you know you're streaming?  Some files are
> > > read/written many times and some files are accessed randomly.  I'm trying
> > > to avoid penalizing these admittedly rarer, but still important cases.
> >
> > For those other case we have pages on the active list which are properly
> > aged, haven't we ?
>
> Not if they never get a change to be moved to the active list.  We have to be
> careful to provide that opportunity.

I see no reason a change to readahead would affect that. Maybe I am dense.
Relevant seems to be rather whether you use read-once or put them on the
active list right away.

Could information on the use pattern be stored in the dentry ?
E.g. If we opened it twice in the last 30 seconds we put all referenced
pages into the active list unaged to ensure that they'll stay in core.

> > And readahead won't help you for random access unless you can cache it all.
> > You might throw in a few extra blocks if you have free memory, but then you
> > have free memory anyway.
>
> Readahead definitely can help in some types of random access loads, e.g.,
> when access size is larger than a page, or when the majority of pages of a
> file are eventually accessed, but in random order.  On the other hand, it

Only if they fit into ram. There's nothing wrong with reading the whole
accessed file if it's small enough and you have a low memory pressure.
It might cut down on netscape launch times drastically on large machines.
But if there's memory pressure you can hardly evict pages on the active
list for readahead, can you ?

> will only hurt for short, sparse, random reads.  Such a pattern needs to be
> detected in generic_file_readahead.

Interresting, how do you do that, keep a list of recent reads ?

	Regards
		Oliver


