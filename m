Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSIEPBz>; Thu, 5 Sep 2002 11:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSIEPBz>; Thu, 5 Sep 2002 11:01:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316544AbSIEPBy>; Thu, 5 Sep 2002 11:01:54 -0400
Date: Thu, 5 Sep 2002 08:06:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <20020905123331.A1984@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0209050744520.14066-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Suparna, I'll only react to one thing in your email right now, I'll try 
  to take the time to look at your _real_ questions later after I've had
  my coffee and woken up.. ]

On Thu, 5 Sep 2002, Suparna Bhattacharya wrote:
> 
> Barthlomeij actually raised another point about the situation when the
> partial completion happens with an error (i.e. not uptodate case), a situation
> which doesn't automatically get handled correctly. Something to think
> about ?

Good point. Yes. However, it's hard to pass the errors down, since we've 
largely lost the individual parts of the bio (ie people don't even use the 
buffer_heads any more.

There's a somewhat related issue with bio's, namely that partial
_successful_ completion also doesn't notify anybody, which can suck from a
latency standpoint if there are big delays in the partial IO (even if it
is all successful). That's certainly true of the floppy driver, for
example, where we can build up a 64kB bio due to read-ahead and then it
takes many milliseconds between partial completions (which are done one
track at a time in the absolute best case).

Note that this actually makes read-ahead much less effective, because it 
means that we're not doing work while the read-ahead is happening: the 
read-ahead improves throughput by doing big blocks at a time, but it does 
_not_ get the improvement that it used to get of having asynchronous IO 
going on. 

We should wake up the person that maybe only needed the first page.

But right now, we've kind of lost that ability, because the bio itself 
does not contain any such information. We used to have a list of buffer 
heads in the request, and could wake them up one by one, but..

I would suggest:

 - add a "nr of sectors completed" argument to the "bi_end_io()" function, 
   so that it looks like

	void xxx_bio_end_io(struct bio *bio, unsigned long completed)
	{
		/*
		 * Old completion handlers that don't understand it
		 * should just return immediately for partial bio
		 * completion notifiers
		 */
		if (bio->b_size)
			return;
		...
	}

   which would allow things like mpage_end_io_read() to unlock pages as 
   they complete, instead of unlocking them all in one go.

Comments? It looks trivial to do this from a bio level, and it would not 
be hard to update the existing end_io functions (because you can always 
just update them with the one-liner "if not totally done, return" to get 
the old behaviour).

Andrew? I really dislike the lack of concurrency in our current mpage 
read-ahead thing. Whaddayathink?

		Linus

