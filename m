Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbRFNIpd>; Thu, 14 Jun 2001 04:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbRFNIpX>; Thu, 14 Jun 2001 04:45:23 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:16402 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261700AbRFNIpO>; Thu, 14 Jun 2001 04:45:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
Date: Thu, 14 Jun 2001 10:47:41 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01061410474103.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 05:16, Rik van Riel wrote:
> On Wed, 13 Jun 2001, Tom Sightler wrote:
> > Quoting Rik van Riel <riel@conectiva.com.br>:
> > > After the initial burst, the system should stabilise,
> > > starting the writeout of pages before we run low on
> > > memory. How to handle the initial burst is something
> > > I haven't figured out yet ... ;)
> >
> > Well, at least I know that this is expected with the VM, although I do
> > still think this is bad behavior.  If my disk is idle why would I wait
> > until I have greater than 100MB of data to write before I finally
> > start actually moving some data to disk?
>
> The file _could_ be a temporary file, which gets removed
> before we'd get around to writing it to disk. Sure, the
> chances of this happening with a single file are close to
> zero, but having 100MB from 200 different temp files on a
> shell server isn't unreasonable to expect.

This still doesn't make sense if the disk bandwidth isn't being used.

> Maybe we should just see if anything in the first few MB
> of inactive pages was freeable, limiting the first scan to
> something like 1 or maybe even 5 MB maximum (freepages.min?
> freepages.high?) and flushing as soon as we find more unfreeable
> pages than that ?

There are two cases, file-backed and swap-backed pages.

For file-backed pages what we want is pretty simple: when 1) disk bandwidth 
is less than xx% used 2) memory pressure is moderate, just submit whatever's 
dirty.  As pressure increases and bandwidth gets loaded up (including read 
traffic) leave things on the inactive list longer to allow more chances for 
combining and better clustering decisions.

There is no such obvious answer for swap-backed pages; the main difference is 
what should happen under low-to-moderate pressure.  On a server we probably 
want to pre-write as many inactive/dirty pages to swap as possible in order 
to respond better to surges, even when pressure is low.  We don't want this 
behaviour on a laptop, otherwise the disk would never spin down.  There's a 
configuration parameter in there somewhere.

--
Daniel
