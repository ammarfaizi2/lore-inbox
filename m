Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274517AbRIXTJE>; Mon, 24 Sep 2001 15:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274505AbRIXTIu>; Mon, 24 Sep 2001 15:08:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4356 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274412AbRIXTIf>; Mon, 24 Sep 2001 15:08:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jonathan Morton <chromi@cyberspace.org>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: Linux VM design
Date: Mon, 24 Sep 2001 21:16:21 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com> <20010924182948Z16175-2757+1593@humbolt.nl.linux.org> <a05100301b7d52f49f7b6@[192.168.239.101]>
In-Reply-To: <a05100301b7d52f49f7b6@[192.168.239.101]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924190853Z16175-2757+1600@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 24, 2001 08:46 pm, Jonathan Morton wrote:
> >  > DP> The arguments in support of aging over LRU that I'm aware of are:
> >>
> >>  DP>   - incrementing an age is more efficient than resetting several LRU
> >>  DP>     list links
> >>  DP>   - also captures some frequency-of-use information
> >>
> >>  Of what use this info can be? If one page is accessed 100 times/second
> >>  and other one once in 10 seconds, they both have to stay in RAM.
> >>  VM should take 'time since last access' into account whan deciding
> >>  which page to swap out, not how often it was referenced.
> >
> >You might want to have a look at this:
> >
> >    http://archi.snu.ac.kr/jhkim/seminar/96-004.ps
> >    (lrfu algorithm)
> >
> >To tell the truth, I don't really see why the frequency information is all
> >that useful either.  Rik suggested it's good for streaming IO but we 
already
> >have effective means of dealing with that that don't rely on any frequency
> >information.
> >
> >So the list of reasons why aging is good is looking really short.
> 
> It's not really frequency information.  If a page is accessed 1000 
> times during a single schedule cycle, that will count as a single 
> increment in the age come the time.  However, *macro* frequency 
> information of this type *is* useful in the case where thrashing is 
> taking place.  You want to swap out the page that is accessed only 
> once every other schedule cycle, before the one accessed every cycle. 

But this happens naturally with LRU.  Think how it works: to get evicted a 
page has to progress all the way from the head to the tail of the LRU list.  
Any page that's accessed frequently is going to keep being put back at the 
head of the list, and only infrequently accessed pages will drop off the tail.

> This is of course moot if one process is being suspended (as it 
> probably should), but the criteria for suspension might include this 
> access information.

OK, that does get at something you can do with aging that you can't do with 
an LRU list: look at the weightings of random pages.  You can't do that with 
the LRU list because there's no efficient way to determine which position a 
page holds in the list.

One application where you would want to know the weightings of random pages 
is defragmentation.  That might become important in the future but we're not 
doing it now.

A little contemplation will probably turn up other uses for this special 
property.

--
Daniel
