Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269732AbRHIIUi>; Thu, 9 Aug 2001 04:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269734AbRHIIU2>; Thu, 9 Aug 2001 04:20:28 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:1005 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S269732AbRHIIUL>; Thu, 9 Aug 2001 04:20:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Larry McVoy <lm@bitmover.com>
Subject: Re: SIS 630E perf problems?
Date: Thu, 9 Aug 2001 04:19:30 -0400
X-Mailer: KMail [version 1.2]
Cc: Paul Flinders <ptf@ftel.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200108061713.f76HDaj16575@work.bitmover.com> <01080618523906.04153@localhost.localdomain> <20010807081652.A11619@work.bitmover.com>
In-Reply-To: <20010807081652.A11619@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01080904193002.15175@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 11:16, Larry McVoy wrote:
> > I've used a few funky SIS chipsets, on and off, for a long time now, and
> > they always have one leeeetle problem...
> >
> > Try benchmarking it with a lower screen resolution (like 640x480x256
> > colors). If the video is sharing main memory, it's sharing the memory
> > bandwidth as well.  So you've basically got a constant
> > ultra-high-priority DMA going to the screen, sucking up bandwidth and
> > fighting with everything else. (Everything else MUST lose or the display
> > would sparkle.
> > 1280x1024x32bitsx70hz is HOW much bandwidth we're talking here?)
>
> OK, a copuple of updates on this:
>
> I wasn't running X when I ran the benchmarks.
>
> I played around with the bios settings enough to make the machine not
> pass POST anymore so I reset the CMOS.  Doing that, plus telling the
> system to autodetect DRAM clocks dropped the latencies down to 260ns
> outside of X and 281ns with X running.  Still not fantastic but good
> enough I suppose.

Text mode still comes out of main memory, and is still a fairly consistent 
DMA out of it.  I suspect that for every pixel displayed, text mode or not, 
it still has to hit main memory.  Text mode goes through a lookup table 
thingy to max the character against the pixel grid for that character, but I 
suspect it still re-reads the value from main memory each time.

Even if it doesn't and instead caches the value (which, this being SIS, is 
probably wishful thinking: if that was the case they'd just devote 16k or so 
to the text mode circuitry and not have text mode share main memory at ALL, 
which I'm almost certain is NOT the case.  Again, optimizing for text mode 
ain't what a "for windows" hardware company thinks about, even when it's 
easy...)

Anyway, it's still doing nasty things with opening/closing memory banks 
(fighting with what would otherwise be linear burst transfers: we interrupt 
this DMA to seek to somewhere else in memory.  Yes, SIMMS have something like 
a hard drive seek, sending new addresses and opening/closing banks.  Ars 
technica had a nice article on this a while back I could dig up a link to if 
anybody's bored.  It's 1000 times faster than a hard drive seek, but it's 
still there.  The old latency vs throughput issue. Locality of reference is a 
good thing no matter what's going on.  And yes, making this go away and doing 
prefetch (and branch predictions, etc) are half of what the L1 and L2 caches 
do.  And the bus interface units did at least a few bytes read ahead all the 
way back to the 8086, actually.  (6 bytes for the 8086, 4 bytes for the 
8088.  Yes, I'm still writing a book on computer history.  Research 
crystalizing into chapters Real Soon Now (tm).  If I could just stop finding 
MORE info leading to fresh tangents to go down for a bit...  Or if the UT 
library didn't close between midnight and 8 am over the summer session...)

Rob
