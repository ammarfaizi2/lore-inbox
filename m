Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288484AbSAUVkd>; Mon, 21 Jan 2002 16:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288485AbSAUVkX>; Mon, 21 Jan 2002 16:40:23 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26629 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288484AbSAUVkK>; Mon, 21 Jan 2002 16:40:10 -0500
Message-ID: <3C4C8927.DB977949@zip.com.au>
Date: Mon, 21 Jan 2002 13:33:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020121090602.A13715@hq.fsmlabs.com>,
		<E16PZbb-0003i6-00@the-village.bc.nu>
		<E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com>
		<E16SgwP-0001iN-00@starship.berlin>  <20020121090602.A13715@hq.fsmlabs.com> <1011647882.8596.466.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Mon, 2002-01-21 at 11:06, yodaiken@fsmlabs.com wrote:
> 
> > I have not seen a single well structured benchmark that shows a significant
> > difference. I've seen lots of benchmarks with odd mixes of different patches
> > showing something unknown. How about a simple clear dbench?
> 
> I and many others have been posting benchmarks for months.
> 
> Here:
> 
> (average of 4 runs of `dbench 16')
> 2.5.3-pre1:             25.7608 MB/s
> 2.5.3-pre1-preempt:     32.341 MB/s
> 

Well I spent several hours last week trying to reproduce and
account for these observations and basically came up with
nothing.  The patch-induced variation was of the same order
as the inter-run variation.

You should publish the dbench dots.  They're most informative.
Look at these two:

16 clients started
..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..............................................................................................+++++++++++++++****************
Throughput 6.48209 MB/sec (NB=8.10261 MB/sec  64.8209 MBit/sec)

16 clients started
.................................................................................................................................................................................................................................+...................................................................................................................................................................................................................................................................+................................................................................+............................+++++++++++++****************
Throughput 7.76901 MB/sec (NB=9.71126 MB/sec  77.6901 MBit/sec)

These are identical runs.  Empty filesystem, 64 megs of memory.

Note how in the second run, a few clients terminated early,
and the throughput numbers increased quite markedly.

I don't know what causes this, and frankly I'm not really
interested.  It's some bizarre freaky dbench instability.

Similar effects occur with the `make -j12 bzImage' swapstorm
test.  After a while, all the `cc' instances start to
get synchronised at the onset of their peak memory demand.
The earlier and longer this happens, the worse the runtime.
It's an unstable system and tiny input perturbations create
large effects on the output.

Sorry, but these are not interesting, repeatable or stable workloads,
and I remain unconvinced about claims that low-latency or preempt
aid I/O throughput.  And even if a statistically significant
benefit _can_ be empirically demonstrated, it would be incautious
to claim a general benefit without a solid explanation of what
is causing it.  (Apart from the RAID5 kernel thread starvation
effect, which _is_ explained).

If someone can show me a sensible and repeatable I/O gain then
great, I can go in and work out exactly where it's coming from
and then we finally have a real, tangible, non-hand-wavy
explanation.  It may be there, but I just don't see it yet.

-
