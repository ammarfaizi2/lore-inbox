Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266339AbRGYBV2>; Tue, 24 Jul 2001 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbRGYBVS>; Tue, 24 Jul 2001 21:21:18 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34316 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266353AbRGYBVA>; Tue, 24 Jul 2001 21:21:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Patrick Dreker <patrick@dreker.de>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 03:25:37 +0200
X-Mailer: KMail [version 1.2]
Cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107241328020.29611-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107241328020.29611-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <0107250325370C.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 22:33, Linus Torvalds wrote:
> On Tue, 24 Jul 2001, Patrick Dreker wrote:
> > I just decided to give this patch a try, as I have written a little
> > application which does some statistics over traces dumped by
> > another program by mmap()ing a large file and reading it
> > sequentially. The trace file to be analyzed is about 240 megs in
> > size and consists of records each 249 bytes long. The analysis
> > program opens and the mmap()s the trace file doing some small
> > calculations on the data (basically it adds up fields from the
> > records to get overall values).
>
> Note that the patch won't do much anything for the mmap() case - the
> VM doesn't consider that "use once" anyway, and trying to make it do
> so would be hard, I suspect. It's just very nasty to try to figure
> out whether the user has touched the page a single time or millions
> of times...
>
> We do have the "accessed" bit, but in order to get any access
> patterns we'd have to scan the page tables a _lot_ more than we do
> now. Right now we do it only under memory pressure, and only about
> once per memory cycle, which is not really even remotely enough to
> get anything more than "yes, the user did touch the page"..
>
> In order for mmap() to make a difference with the new code, we could
> do something like look at the adjacent VM pages on page-in. That,
> together with VM hints, might well be able to do similar things for
> mmap. But at a noticeably higher cost than what the current code has.

OK, the truth is, I decided to punt that problem on the assumption I'd 
be able to come up with something workable when the time came.  Now 
having thought about it a little longer I see it's not so easy.  It's 
time for some free-form thinking.

Maybe there's a relatively simple way.  We'll see for either memory 
read or write we'll see the fault.  At that point the page starts its 
death march down the inactive queue and shortly after that the actual 
memory operation takes place.  Another short time later we clear the 
hardware referenced bit by some as-yet-undetermined means.  At the 
south end of the queue we check the hardware referenced bit and 
reactivate or continue with the eviction process as with the current 
patch.

Now I sense there are gotchas here that I'm not entirely on top of - 
the swap side of the memory manager being a little less than crystal 
clear to me at this point.  Let me start by guessing that it's not so 
easy to know which pte to look in for the referenced bit.  However, we 
could cheat and store the pte address in the struct page, or perhaps in 
the buffers, which happen to be still attached at the time.

Hmm, just a first idea, and admittedly ugly.  I think what I really 
have to do is some more code study.

--
Daniel
