Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265971AbRF1Og5>; Thu, 28 Jun 2001 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265972AbRF1Ogr>; Thu, 28 Jun 2001 10:36:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:26636 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265971AbRF1Og1>; Thu, 28 Jun 2001 10:36:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: mike_phillips@urscorp.com, <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
Date: Thu, 28 Jun 2001 16:39:35 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <OF95A43E53.39291B42-ON84256A79.003D421D@urscorp.com>
In-Reply-To: <OF95A43E53.39291B42-ON84256A79.003D421D@urscorp.com>
MIME-Version: 1.0
Message-Id: <01062816393503.00419@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 14:20, mike_phillips@urscorp.com wrote:
> > If individual pages could be classified as code (text segments),
> > data, file cache, and so on, I would specify costs to the paging
> > of such pages in or out.  This way I can make the system perfer
> > to drop a file cache page that has not been accessed for five
> > minutes, over a program text page that has not been acccessed
> > for one hour (or much more).
>
> This would be extremely useful. My laptop has 256mb of ram, but every day
> it runs the updatedb for locate. This fills the memory with the file
> cache. Interactivity is then terrible, and swap is unnecessarily used. On
> the laptop all this hard drive thrashing is bad news for battery life
> (plus the fact that laptop hard drives are not the fastest around). I
> purposely do not run more applications than can comfortably fit in the
> 256mb of memory.
>
> If fact, to get interactivity back, I've got a small 10 liner that mallocs
> memory to *force* stuff into swap purely so I can have a large block of
> memory back for interactivity.
>
> Something simple that did "you haven't used this file for 30mins, flush it
> out of the cache would be sufficient"

Updatedb fills memory full of clean file pages so there's nothing to flush.  
Did you mean "evict"?

Roughly speaking we treat clean pages as "instantly relaimable".  Eviction 
and reclaiming are done in the same step (look at reclaim_page).  The key to 
efficient mm is nothing more or less than choosing the best victim for 
reclaiming and we aren't doing a spectacularly good job of that right now.

There is a simple change in strategy that will fix up the updatedb case quite 
nicely, it goes something like this: a single access to a page (e.g., reading 
it) isn't enough to bring it to the front of the LRU queue, but accessing it 
twice or more is.  This is being looked at.

Note that we don't actually use a LRU queue, we use a more efficient 
approximation called aging, so the above is not a recipe for implementation.

--
Daniel
