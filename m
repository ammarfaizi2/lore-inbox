Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbREOOtf>; Tue, 15 May 2001 10:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262772AbREOOt0>; Tue, 15 May 2001 10:49:26 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:44298 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262769AbREOOtO>; Tue, 15 May 2001 10:49:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Getting FS access events
Date: Tue, 15 May 2001 16:42:56 +0200
X-Mailer: KMail [version 1.2]
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0105150637070.21081-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105150637070.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01051516425608.24410@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 12:44, Alexander Viro wrote:
> On Tue, 15 May 2001, Daniel Phillips wrote:
> > That's because you left out his invalidate:
> >
> >  	* create an instance in pagecache
> >  	* start reading into buffer cache (doesn't invalidate, right?)
> >  	* start writing using pagecache (invalidate buffer copy)
>
> Bzzert. You have a race here. Let's make it explicit:
>
> start writing
> put write request in queue
> block on that
> 					start reading into buffer cache
> 					put read request into queue
> 					read from media
> write to media
>
> And no, we can't invalidate from IO completion hook.
>
> >  	* lose the page
> >  	* try to read it (via pagecache)
> >
> > Everthing ok.
>
> Nope.

The problem is that we have two IO operations on the same physical 
block in the queue at the same time, and we don't know it.  Maybe we 
should know it.

For your specific example we are ok if we do:

         * create an instance in pagecache
         * start reading into buffer cache (doesn't invalidate, right?)
         * start writing using pagecache (invalidate buffer copy)
         * lose the page (invalidate buffer copy)
         * try to read it (via pagecache)

We are also ok if we follow my suggested optimization and move the page 
to the buffer cache instead of just losing it.

We are not ok if we do:

         * try to read it (via buffercache)

because its copy is out of date, but this can be fixed by enforcing 
coherency in the request queue. 

1) Why should the request queue not be coherent?

2) Can we stop talking about buffer cache here and start talking about 
blocks mapped into a separate address space in the page cache?  From 
Linus's previous comments in this thread we are going to have that 
anyway, and your race also applies there.

I'd like to call that separate address space a 'block cache'.

--
Daniel
