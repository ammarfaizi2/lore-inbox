Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSAHUTp>; Tue, 8 Jan 2002 15:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288279AbSAHUTg>; Tue, 8 Jan 2002 15:19:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1036 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287798AbSAHUTU>; Tue, 8 Jan 2002 15:19:20 -0500
Message-ID: <3C3B5305.267EFC14@zip.com.au>
Date: Tue, 08 Jan 2002 12:13:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br> <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> > Andrew Morten`s read-latency.patch is a clear winner for me, too.
> 
> AFAIK Andrew's code simply adds schedule points around the kernel, right?
> 
> If so, nope, I do not plan to integrate it.

I haven't sent it to you yet :)  It improves the kernel.  That's
good, isn't it?  (There are already forty or fifty open-coded
rescheduling points in the kernel.  That patch just adds the
missing (and most important) ten).  

BTW, with regard to the "preempt and low-lat improve disk throughput"
argument.  I have occasionally seen small throughput improvements,
but I think these may be just request-merging flukes.  Certainly
they were very small.

The one area where it sometimes makes a huuuuuge throughput
improvement is software RAID.

Much of the VM and dirty buffer writeout code assumes that
submit_bh() starts I/O.  Guess what?  RAID's submit_bh()
sometimes *doesn't* start I/O.  Because the IO is started
by a different thread.

With the Riel VM I had a test case in which software RAID
completely and utterly collapsed because of this.  The machine
was spending huge amounts of time spinning in page_launder(), madly
submitting I/O, but never yielding, so the I/O wasn't being started.

-aa VM has an open-coded yield in shrink_cahce() which prevents
that particular collapse.  But I had a report yesterday that
the mini-ll patch triples throughput on a complex RAID stack in
2.4.17.  Same reason.

Arguably, this is a RAID problem - raidN_make_request() should
be yielding.  But it's better to do this in one nice, single,
reviewable place - submit_bh().  However that won't prevent
wait_for_buffers() from starving the raid thread.

RAID is not alone.  ksoftirqd, keventd and loop_thread() also
need reasonably good response times.

But given the number of people who have been providing feedback
on this patch, and on the disk-read-latency patch, none of this
is going anywhere, and mine will be the only Linux machines which
don't suck.  (Takes ball, goes home).

-
