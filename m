Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266130AbRGYAAN>; Tue, 24 Jul 2001 20:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266138AbRGXX7x>; Tue, 24 Jul 2001 19:59:53 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:52233 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266130AbRGXX7s>; Tue, 24 Jul 2001 19:59:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, <jlnance@intrex.net>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 02:04:30 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241355090.20326-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107241355090.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01072502043009.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 18:56, Rik van Riel wrote:
> On Tue, 24 Jul 2001 jlnance@intrex.net wrote:
> > On Tue, Jul 24, 2001 at 05:47:30AM +0200, Daniel Phillips wrote:
> > > So I decided to look for a new way of approaching the use-once
> > > problem that would easily integrated with our current approach.  
> > > What I came up with is pretty simple: instead of starting a newly
> > > allocated page on the active ring, I start it on the inactive
> > > queue with an age of zero. Then, any time generic_file_read or
> > > write references a page, if its age is zero, set its age to
> > > START_AGE and mark it as unreferenced.
> >
> > This is wonderfully simple and ellegant.
>
> It's a tad incorrect, though.
>
> If a page gets 2 1-byte reads in a microsecond, with this
> patch it would get promoted to the active list, even though
> it's really only used once.

Yes, I expected that to be a relatively rare case however - block 
aligned transfers are much more common, and when we have multiple 
blocks per page we may well want the page to go onto the active list 
because there may be quite a delay between successive block accesses.  
>From there it will be aged normally, not such a horrible thing.

To fix this properly I suspect that just a few microseconds is enough 
delay to pick up the temporal groupings you're talking about.  That's 
not hard to achieve.

> Preferably we'd want to have a "new" list of, say, 5% maximum
> of RAM size, where all references to a page are ignored. Any
> references made after the page falls off that list would be
> counted for page replacement purposes.

At that size you'd run a real risk of missing the tell-tale multiple 
references that mark a page as frequently used.  Think about metadata 
here (right now, that usually just means directory pages, but later... 
who knows).  Once somebody has looked at two files in a directory - 
while the page sits on the "ignore" list - chances are very good 
they'll look at a third, but perhaps not before it drops off the south 
end of the inactive queue.

Well, theorizing can only get us so far before we need to take actual 
measurements.

--
Daniel
