Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262318AbSJKI0r>; Fri, 11 Oct 2002 04:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJKI0q>; Fri, 11 Oct 2002 04:26:46 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5905 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262318AbSJKI0p>; Fri, 11 Oct 2002 04:26:45 -0400
Message-ID: <3DA68CAF.8F4EC88C@aitel.hist.no>
Date: Fri, 11 Oct 2002 10:32:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org, pochini@shiny.it,
       Robert Love <rml@tech9.net>, Mark Mielke <mark@mark.mielke.cc>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>, andersen@codepoet.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <1034221067.794.505.camel@phantasy> <XFMail.20021010153919.pochini@shiny.it> <20021010225050.GC2673@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Thu, Oct 10, 2002 at 03:39:19PM +0200, Giuliano Pochini wrote:
[...]
> > When a process opens a file with O_STREAMING, it tells the kernel
> > it will use the data only once, but it tells nothing about other
> > tasks. If that process reads something which is already cached,
> > then it must not drop it because someone other used it recently
> > and IMHO pagecache only should be allowed to drop it.
> >
> 
> You are missing the point.  If the app thinks that might happen, it
> shouldn't use O_STREAMING.

The app _can't_ know, so nothing should use O_STREAMING?

I think the idea seems good - if a page requested for streaming
happens to be in cache already, don't mark it for early eviction.

This approach ensures that streaming apps don't affect the caches
of other apps at all.  There are way too many cases where
streaming is useful but we don't know if others might be using
the pages - perhaps in other ways.

Consider searching _all_ files on disk for some string.  Clearly
a cache-killer that would benefit from streaming, without
streaming this pushes everything else from cache except
for the last files searched.
But streaming that unconditionally marks pages for eviction
will also kill all cache in this case.  Both data and binaries.

Streaming that only evicts pages it _brought in_ can 
search the entire disk (or some reasonable but large subset)
leaving almost all other cache intact.

Now, if we could make updatedb use this kind of streaming
for its directory traversals... :-)

Helge Hafting
