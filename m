Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRH0Tmr>; Mon, 27 Aug 2001 15:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRH0Tmh>; Mon, 27 Aug 2001 15:42:37 -0400
Received: from ns.cablesurf.de ([195.206.131.193]:35579 "EHLO ns.cablesurf.de")
	by vger.kernel.org with ESMTP id <S266977AbRH0Tmd>;
	Mon, 27 Aug 2001 15:42:33 -0400
Message-Id: <200108271953.VAA20749@ns.cablesurf.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 21:43:11 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <200108271848.UAA20391@ns.cablesurf.de> <20010827185803Z16034-32384+632@humbolt.nl.linux.org>
In-Reply-To: <20010827185803Z16034-32384+632@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. August 2001 21:04 schrieb Daniel Phillips:
> On August 27, 2001 08:37 pm, Oliver Neukum wrote:
> > Hi,
> >
> > >   - Readahead cache is naturally a fifo - new chunks of readahead
> > >     are added at the head and unused readahead is (eventually)
> > >     culled from the tail.
> >
> > do you really want to do this based on pages ? Should you not drop all
> > pages associated with the inode that wasn't touched for the longest
> > time ?
>
> Isn't that very much the same as dropping pages from the end of the
> readahead queue?

No, the end of the readahead queue will usually have pages from many 
inodes(or perhaps it should be attached to open files as two tasks may read 
different parts of one file).

If we are optimising for streaming (which readahead is made for) dropping 
only one page will buy you almost nothing in seek time. You might just as 
well drop them all and correct your error in one larger read if necessary.
Dropping the oldest page is possibly the worst you can do, as you will need 
it soonest.

> > If you are streaming dropping all should be no great loss.
>
> The quesion is, how do you know you're streaming?  Some files are
> read/written many times and some files are accessed randomly.  I'm trying
> to avoid penalizing these admittedly rarer, but still important cases.

For those other case we have pages on the active list which are properly 
aged, haven't we ?
And readahead won't help you for random access unless you can cache it all.
You might throw in a few extra blocks if you have free memory, but then you 
have free memory anyway.
