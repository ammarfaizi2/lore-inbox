Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTGXMNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTGXMNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:13:21 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:21517 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263407AbTGXMNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:13:15 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22pre6aa1
Date: Thu, 24 Jul 2003 14:27:27 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20030717102857.GA1855@dualathlon.random> <200307221427.01519.m.c.p@wolk-project.de> <20030722135957.GA1961@x30.linuxsymposium.org>
In-Reply-To: <20030722135957.GA1961@x30.linuxsymposium.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307241356.57793.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 July 2003 15:59, Andrea Arcangeli wrote:

Hi Andrea,

> performance degradation when? note that we're only talking about
> contigous I/O here, not contest. I can't measure any performance
> degradation during contigous I/O and if something it could be explained
> by the now shorter queue, but you tried enlarging it and it went even
> slower (this was good btw, confirming a larger queue was completely
> worthless and it only hurts the VM without providing any I/O bandwidth
> pipelining benefit). The elevator-lowlatency should have no other effect
> other than a shorter queue during pure contigous I/O.
Well, contigous I/O isn't a big problem, though I saw performance degradation 
in contigous I/O. The problem is, that I still see mouse stops while heavy 
I/O, that I still see keyboard stops while heavy I/O, X is dog slow while 
heavy I/O (renicing X to -20 doesn't really help). I really miss the 2.4.18 
time where this wasn't a problem at all!
Contest was not the reason. An easy reproducable scenario is:

 dd if=/dev/zero of=/home/largefile bs=16384 count=131072

This will kill your mouse, keyboard and X. The only "workaround" not to see 
mouse stops, keyboard stops and X dogstyle was decreasing nr_requests from 
128 to 4. Anything higher resulted in pauses (e.g. 8 for nr_requests).
Maybe SCSI behaves totally different, dunno. ATM I don't have SCSI around to 
test it, only IDE (ATA100/ATA133).

I've tested this too for .22-pre7, changing "MAX_NR_REQUESTS 1024" to "4". And 
now the big surprise: Still mouse stops, keyboard stops while, e.g. the above 
dd command, but with, for sure, very low throughput. So throughput dropping 
is not the problem here at all. I have very very low throughput but still 
pauses/stops. How is this possible? I am very confused about the code :-(

> > > can you try with data=writeback (or ext2) or hdparm -W1 and see if you
> > > can still see the same delta between the two kernels? (careful with -W1
> > > as it invalidates journaling)
> > Yes, I'll do it later this day.
> please try plain ext2, this sounds like some fs effect of some sort. The
> fs must throttle on the shorter queue or seek differently somehow.
well, ext2 does not make any difference :-(

I thought trying out q->full from Chris would make any difference. I am quite 
sure that it must be a merge error by me, otherwise I cannot explain why 
q->full kills my X-windows for tons of seconds during a "make -j16 bzImage 
modules" I get stops of the whole system too for some seconds every 30 
seconds or so. Ripped out q->full (not just disabling via elvtune -b 0) fixed 
at least that behaviour.

Another funny thing, not dependant on q->full, is, that VMware needs over 1 
Minute to start up with a Windows 2000 in it where w/o the lowlat elevator it 
needs ~30 seconds or less to start up completely. VMware has reads/writes 
during the startup about _max_ of 500kb/s. Before it went up to 10mb/s.
Now we should decide if it's either a bug in the kernel or a bug in VMware ;))

> > Sorry for my late reply. I've been very busy.
> No problem ;)
ok :) thnx. Sorry again for the delay, but I wanted to be sure about the 
reports so I had to test many things out first.

Hmm, I am a bit afraid that no one else noticed this yet. This reminds be back 
to over a year ago where I reported I/O stalls/pauses/stops with 2.4.19-pre's 
and no one noticed that but you after some time. A 'real' fix for that came up
over one year later and some days before we had a big discussion about it with 
many people involved noticing it too.

Don't get me wrong Andrea and Chris :) .. but I am quite disappointed about 
current Linux for the Desktop. 2.4 has I/O problems, 2.6 has Scheduler 
problems, 2 things I cannot live with for my Desktop. Maybe Linus is right 
when he said, Linux may be Desktop ready in 2006.

Any suggestions what I can do to help to fix that silly behaviour? I really 
really want a usable 2.4 tree again (read: 2.4.22 final) :)

P.S.: I've CC'ed Nick.

ciao, Marc

