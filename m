Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRH0Ubk>; Mon, 27 Aug 2001 16:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRH0Uba>; Mon, 27 Aug 2001 16:31:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21513 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268856AbRH0UbQ>; Mon, 27 Aug 2001 16:31:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 22:37:57 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <20010827185803Z16034-32384+632@humbolt.nl.linux.org> <200108271953.VAA20749@ns.cablesurf.de>
In-Reply-To: <200108271953.VAA20749@ns.cablesurf.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827203125Z16070-32383+1731@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 09:43 pm, Oliver Neukum wrote:
> Am Montag, 27. August 2001 21:04 schrieb Daniel Phillips:
> > On August 27, 2001 08:37 pm, Oliver Neukum wrote:
> > > Hi,
> > >
> > > >   - Readahead cache is naturally a fifo - new chunks of readahead
> > > >     are added at the head and unused readahead is (eventually)
> > > >     culled from the tail.
> > >
> > > do you really want to do this based on pages ? Should you not drop all
> > > pages associated with the inode that wasn't touched for the longest
> > > time ?
> >
> > Isn't that very much the same as dropping pages from the end of the
> > readahead queue?
> 
> No, the end of the readahead queue will usually have pages from many 
> inodes(or perhaps it should be attached to open files as two tasks may read 
> different parts of one file).
> 
> If we are optimising for streaming (which readahead is made for) dropping 
> only one page will buy you almost nothing in seek time. You might just as 
> well drop them all and correct your error in one larger read if necessary.
> Dropping the oldest page is possibly the worst you can do, as you will need 
> it soonest.

Yes, good point.  OK, I'll re-examine the dropping logic.  Bear in mind, 
dropping readahead pages is not supposed to happen frequently under 
steady-state operation, so it's not that critical what we do here, it's going 
to be hard to create a load that shows the impact.  The really big benefit 
comes from not overdoing the readahead in the first place, and not underdoing 
it either.

> > > If you are streaming dropping all should be no great loss.
> >
> > The quesion is, how do you know you're streaming?  Some files are
> > read/written many times and some files are accessed randomly.  I'm trying
> > to avoid penalizing these admittedly rarer, but still important cases.
> 
> For those other case we have pages on the active list which are properly 
> aged, haven't we ?

Not if they never get a change to be moved to the active list.  We have to be 
careful to provide that opportunity.

> And readahead won't help you for random access unless you can cache it all.
> You might throw in a few extra blocks if you have free memory, but then you 
> have free memory anyway.

Readahead definitely can help in some types of random access loads, e.g., 
when access size is larger than a page, or when the majority of pages of a 
file are eventually accessed, but in random order.  On the other hand, it 
will only hurt for short, sparse, random reads.  Such a pattern needs to be 
detected in generic_file_readahead.

--
Daniel
