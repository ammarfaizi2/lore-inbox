Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263866AbRFNSWr>; Thu, 14 Jun 2001 14:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbRFNSWh>; Thu, 14 Jun 2001 14:22:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:51216 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263887AbRFNSW2>; Thu, 14 Jun 2001 14:22:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: John Stoffel <stoffel@casc.com>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
Date: Thu, 14 Jun 2001 20:25:09 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Tom Sightler <ttsig@tuxyturvy.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva> <01061410474103.00879@starship> <15144.54236.903016.433760@gargle.gargle.HOWL>
In-Reply-To: <15144.54236.903016.433760@gargle.gargle.HOWL>
MIME-Version: 1.0
Message-Id: <01061420250909.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 17:10, John Stoffel wrote:
> >> The file _could_ be a temporary file, which gets removed before
> >> we'd get around to writing it to disk. Sure, the chances of this
> >> happening with a single file are close to zero, but having 100MB
> >> from 200 different temp files on a shell server isn't unreasonable
> >> to expect.
>
> Daniel> This still doesn't make sense if the disk bandwidth isn't
> Daniel> being used.
>
> And can't you tell that a certain percentage of buffers are owned by a
> single file/process?  It would seem that a simple metric of
>
>        if ##% of the buffer/cache is used by 1 process/file, start
>        writing the file out to disk, even if there is no pressure.
>
> might do the trick to handle this case.

Buffers and file pages are owned by the vfs, not processes pre se, so it 
makes accounting harder.  In this case you don't care: it's a file, so in the 
absence of memory pressure and with disk bandwidth available it's better to 
get the data onto disk sooner rather than later.  (This glosses over the 
question of mmap's, by the way.)  It's pretty hard to see why there is any 
benefit at all in delaying, but it's clear there's a benefit in terms of data 
safety and a further benefit in terms of doing what the user expects.

> >> Maybe we should just see if anything in the first few MB of
> >> inactive pages was freeable, limiting the first scan to something
> >> like 1 or maybe even 5 MB maximum (freepages.min?  freepages.high?)
> >> and flushing as soon as we find more unfreeable pages than that ?
>
> Daniel> For file-backed pages what we want is pretty simple: when 1)
> Daniel> disk bandwidth is less than xx% used 2) memory pressure is
> Daniel> moderate, just submit whatever's dirty.  As pressure increases
> Daniel> and bandwidth gets loaded up (including read traffic) leave
> Daniel> things on the inactive list longer to allow more chances for
> Daniel> combining and better clustering decisions.
>
> Would it also be good to say that pressure should increase as the
> buffer.free percentage goes down?

Maybe - right now getblk waits until it runs completely out of buffers of a 
given size before trying to allocate more, which means that sometimes an io 
will be delayed by the time it takes to complete a page_launder cycle.  Two 
reasons why it may not be worth doing anything about this: 1) we will move 
most of the buffer users into the page cache in due course 2) the frequency 
of this kind of io delay is *probably* pretty low.

> It won't stop you from filling the
> buffer, but it should at least start pushing out pages to disk
> earlier.

--
Daniel
