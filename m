Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289308AbSAIJeL>; Wed, 9 Jan 2002 04:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSAIJdv>; Wed, 9 Jan 2002 04:33:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62725 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289306AbSAIJdm>; Wed, 9 Jan 2002 04:33:42 -0500
Message-ID: <3C3C0CB1.16A7CC5B@zip.com.au>
Date: Wed, 09 Jan 2002 01:26:09 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16O3L5-0000B8-00@starship.berlin> <3C3B70D7.43786888@zip.com.au>,
		<3C3B70D7.43786888@zip.com.au> <E16OEr0-0000DR-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 8, 2002 11:21 pm, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > The preemptible kernel can reschedule, on average, sooner than the
> > > scheduling-point kernel, which has to wait for a scheduling point to roll
> > > around.
> >
> > Yes.  It can also fix problematic areas which my testing
> > didn't cover.
> 
> I bet, with a minor hack, it can help you *find* those problem areas too.
> You compile the two patches together and automatically log any event along
> with the execution address, where your explicit schedule points failed to
> reschedule in time.  Sort of like a profile but suited exactly to your
> problem.

Well, one of the instrumentation patches which I use detects a
scheduling overrun at interrupt time and emits an all-CPU backtrace.
You just feed the trace into ksymoops or gdb then go stare at
the offending code.  

That's the easy part - the hard part is getting sufficient coverage.
There are surprising places.  close_files(), exit_notify(), ...

> This just detects the problem areas in normal kernel execution, not
> spinlocks, but that is probably where most of the maintainance will be anyway.
> 
> By the way, did you check for latency in directory operations?

Yes.  They can be very bad for really large directories.  Scheduling
on the found-in-cache case in bread() kills that one easily for most
local filesystems.  There may still be a problem in ext2.

-
