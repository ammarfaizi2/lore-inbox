Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270077AbRHGFeu>; Tue, 7 Aug 2001 01:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270081AbRHGFek>; Tue, 7 Aug 2001 01:34:40 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:28906 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S270077AbRHGFeb>; Tue, 7 Aug 2001 01:34:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
Date: Mon, 6 Aug 2001 16:32:08 -0400
X-Mailer: KMail [version 1.2]
Cc: Mike Black <mblack@csihq.com>, Ben LaHaise <bcrl@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.33.0108051315540.7988-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108051315540.7988-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01080616320805.04153@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 August 2001 16:20, Linus Torvalds wrote:
> On 5 Aug 2001, Michael Rothwell wrote:
> > Could there be both interactive and throughput optimizations, and a
> > way to choose one or the other at run-time? Or even just at compile
> > time?
>
> Quite frankly, that's in my opinion the absolute worst approach.
>
> Yes, it's an approach many systems take - put the tuning load on the user,
> and blame the user if something doesn't work well. That way you don't have
> to bother with trying to get the code right, or make it make sense.

Good defaults make sense, of course, but a /proc entry for this might not be 
a bad idea either.  Specifically, I'm thinking write-intensive systems.

Some loads are nonstandard.  I worked on a system once trying to capture a 
raw (uncompressed) HTDV signal to a 20 disk software raid hanging off of two 
qlogic fibre channel scsi cards.  (Recorder function for a commercial video 
capture/editing system.)  Throughput was all we cared about, and it had to be 
within about 10% of the hardware's theoretical maximum to avoid dropping 
frames.

Penalizing the write queue at the expense of the read queue wouldn't have 
done us any good there.  If anything, we'd have wanted to go the other way.  
(Yeah, we were nonstandard.  Yeah, we patched our kernel.  Yeah, we were 
apparently the first people on the planet to stick 2 qlogic cards in the same 
system and try to use them both, and run into the hardwired scsi request 
queue length limit that managed to panic the kernel by spewing printks and 
making something timeout.  But darn it, somebody had to. :)

It's easier to read proc.txt than to search the kernel archive for 
discussions that might possibly relate to the problem you're seeing...

> In general, I think we can get latency to acceptable values, and latency
> is the _hard_ thing. We seem to have become a lot better already, by just
> removing the artificial ll_rw_blk code.

I'm trying to think of an optimization that DOESN'T boil down to balancing 
latency vs throughput once you've got the easy part done.  Nothing comes to 
mind, probably a lack of caffiene on my part...

> Getting throughput up to where it should be should "just" be a matter of
> making sure we get nicely overlapping IO going. We probably just have some
> silly bug tht makes us hickup every once in a while and not keep the
> queues full enough. My current suspect is the read-ahead code itself being
> a bit too inflexible, but..

Are we going to remember to update these queue sizes when Moore's Law gives 
us drives four times as fast?  Or do you think this won't be a problem?

>
> 			Linus
>

Rob
