Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272326AbRHXVFh>; Fri, 24 Aug 2001 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272327AbRHXVF1>; Fri, 24 Aug 2001 17:05:27 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:36101 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272326AbRHXVFM>; Fri, 24 Aug 2001 17:05:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Fri, 24 Aug 2001 23:11:58 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824210523Z16096-32383+1216@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2001 10:19 pm, Rik van Riel wrote:
> On Fri, 24 Aug 2001, Daniel Phillips wrote:
> > On August 24, 2001 07:43 pm, Rik van Riel wrote:
> 
> > > 1) under memory pressure, the inactive_dirty list is
> > >    only as large as 1 second of pageout IO, meaning
> > 		      ^^^^^^^^
> > This is the problem.  In the absense of competition and truly
> > active pages, the inactive queue should just grow until it is
> > much larger than the active ring.  Then the replacement policy
> > will naturally become fifo, which is exactly what you want in
> > your example.
> 
> Actually, no.  FIFO would be ok if you had ONE readahead
> stream going on, but when you have multiple readahead
> streams going on you want to evict the data each of the
> streams has already used, and not all the readahead data
> which happened to be read in first.

We will be fine up until the point that the set of all readahead fills the 
entire cache, then we will start dropping *some* of the readahead.  This will 
degrade gracefully: if the set of readahead is twice as large as cache then 
half the readahead will be dropped.  We will drop the readahead in coherent 
chunks so that it can be re-read in one disk seek.  This is not such bad 
behaviour.

All this assuming you don't enforce the 1 second size limit on the inactive 
queue, of course.

We probably could squeeze a little better performance out of this case by 
magically knowing that no input page will ever be reused, as you suggest.  
We risk getting such an improvement at the expensive of other, more typical 
loads.

That said, I think I might be able to come up with something that uses 
specific knowledge about readahead to squeeze a little better performance out 
of your example case without breaking loads that are already working pretty 
well.  It will require another lru list - this is not something we want to do 
right now, don't you agree?

--
Daniel
