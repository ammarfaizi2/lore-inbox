Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSLWLV2>; Mon, 23 Dec 2002 06:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSLWLV2>; Mon, 23 Dec 2002 06:21:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:10226 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261600AbSLWLV1>;
	Mon, 23 Dec 2002 06:21:27 -0500
Message-ID: <3E06F399.655E0005@digeo.com>
Date: Mon, 23 Dec 2002 03:29:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Poor performance with 2.5.52, load and process in D state
References: <20021222113754.15064.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Dec 2002 11:29:29.0639 (UTC) FILETIME=[8EAD7370:01C2AA76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> From: Andrew Morton <akpm@digeo.com>
> > Paolo Ciarrocchi wrote:
> > >
> > > Hi all,
> > > I booted 2.5.52 with the following parmater:
> > > apm=off mem=32M (not sure about the amount, anyway I can reproduce
> > > the problem for sure with 32M and 40M)
> > >
> > > Then I tried the osdb (www.osdb.org) benchmark with
> > > 40M of data.
> > >
> > > $./bin/osdb-pg --nomulti
> > >
> > > the result is that aftwer a few second running top I see the postmaster
> > > process in D state and a lot if iowait.
> >
> > What exactly _is_ the issue?  The machine is achieving 25% CPU utilisation
> > in user code, 6-9% in system code.  It is doing a lot of I/O, and is
> > getting work done.
> 
> Ok, I'm back with the results of the osdb test against 2.4.19 and 2.5.52
> Both the kernel booted with apm=off mem=40M
> osdb ran with 40M of data.
> To summarize the results:
> 2.4.19 "Single User Test"       806.78 seconds  (0:13:26.78)
> 2.5.52 "Single User Test"       3771.85 seconds (1:02:51.85)
> 

I could reproduce this.

What's happening is that when the test starts up it does a lot of writing
which causes 2.4 to do a bunch of swapout.  So for the rest of the test
2.4 has an additional 8MB of cache available.

The problem of write activity causing swapout was fixed in 2.5.  It
does not swap out at all in this test.  But this time, we want it to.

End result: 2.4 has ~20 megabytes of cache for the test and 2.5 has ~12
megabytes.   The working pagecache set is around 16 MB, so we're right on
the edge - it makes 2.5 run 10x slower.  You can get most of this back by
boosting /proc/sys/vm/swappiness.  I think the default of 60 is too unswappy
really.  I run my machines at 80.

Tuning swappiness doesn't get all the performance back.  2.5's memory
footprint is generally larger - we still need to work that down.

If this was a real database server I'd expect that memory would end
up getting swapped out anyway.  But it doesn't happen in this test,
which is actually quite light in its I/O demands.

With mem=128m, 2.5 is 10% faster than 2.4.  Some of this is due to
the enhancements to copy_*_user() for poorly-aligned copies on Intel
CPUs.
