Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSANUKF>; Mon, 14 Jan 2002 15:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSANUIr>; Mon, 14 Jan 2002 15:08:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19728 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289011AbSANUIO>; Mon, 14 Jan 2002 15:08:14 -0500
Message-ID: <3C43394D.412C7ECC@zip.com.au>
Date: Mon, 14 Jan 2002 12:02:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roman Zippel <zippel@linux-m68k.org>, yodaiken@fsmlabs.com,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201141248220.29048-100000@serv> from "Roman Zippel" at Jan 14, 2002 01:00:53 PM <E16Q6D2-0001aZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm really trying to avoid this, I'm more than happy to discuss
> > theoretical or practical problems _if_ they are backed by arguments,
> > latter are very thin with Victor. Making pointless claims only triggers
> > above reaction. If I did really miss a major argument so far, I will
> > publicly apologize.
> 
> You seem to be missing the fact that latency guarantees only work if you
> can make progress. If a low priority process is pre-empted owning a
> resource (quite likely) then you won't get your good latency. To
> handle those cases you get into priority boosting, and all sorts of lock
> complexity - so that the task that owns the resource temporarily can borrow
> your priority in order that you can make progress at your needed speed.
> That gets horrendously complex, and you get huge chains of priority
> dependancies including hardware level ones.
> 

It would be useful to define the scope and design guidelines of a "real
time task".   Obviously, if it tries to perform filesystem or network
I/O it can block for a long time.  If it acquires VFS locks it can suffer
bad priority inversion.

I have all along assumed that a well-designed RT application would delegate
all these operations to SCHED_OTHER worker processes, probably via shared
memory/shared mappings.  So in the simplest case, you'd have a SCHED_FIFO
task which talks to the hardware, and which has a helper task which reads
and writes stuff from and to disk.  With sufficient buffering and readahead
to cover the worst case IO latencies.

If this is generally workable, then it means that the areas of possible
priority inversion are quite small - basically device driver read/write
functions.  The main remaining area where priority inversion can 
happen is in the page allocator.  I'm experimenting/thinking about giving
non-SCHED_OTHER tasks a modified form of atomic allocation to defeat this.

-
