Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266132AbUGMVr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUGMVr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266342AbUGMVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:47:12 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:17328 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S266132AbUGMVq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:46:29 -0400
Message-ID: <006901c4692b$074996f0$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       "Paul Davis" <paul@linuxaudiosystems.com>, <florin@sgi.com>,
       <linux-kernel@vger.kernel.org>, <albert@users.sourceforge.net>,
       "Bill Huey \(hui\)" <bhuey@lnxw.com>
References: <20040712172458.2659db52.akpm@osdl.org> <008501c468d2$405d8c70$161b14ac@boromir> <20040713191224.GA22237@nietzsche.lynx.com>
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought?
Date: Tue, 13 Jul 2004 23:44:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bill Huey (hui)" <bhuey@lnxw.com>
> On Tue, Jul 13, 2004 at 01:09:28PM +0100, Martijn Sipkema wrote:
> > [...]
> > > Please double-check that there are no priority inversion problems and that
> > > the application is correctly setting the scheduling policy and that it is
> > > mlocking everything appropriately.
> > 
> > I don't think it is currently possible to have cooperating threads with
> > different priorities without priority inversion when using a mutex to
> > serialize access to shared data; and using a mutex is in fact the only portable
> > way to do that...
> > 
> > Thus, the fact that Linux does not support protocols to prevent priority
> > inversion (please correct me if I am wrong) kind of suggests that supporting
> > realtime applications is not considered very important.
> 
> Any use of an explicit or implied blocking mutex across threads with differing
> priorities can results in priority inversion problems. The real problem, however,
> is contention. If you get rid of the contention in a certain critical section,
> you then also get rid of latency in the system. They are one and the same problem.

The worst case latency is the one that counts and that is the contended case. If
you could guarantee no contention then the worst case latency would be the
very fast uncontended case, but I doubt there are many (any?) examples of this in
practice. There are valid uses of mutexes with priority inheritance/ceiling protocol;
the poeple making the POSIX standard aren't stupid...

> > It is often heard in the Linux audio community that mutexes are not realtime
> > safe and a lock-free ringbuffer should be used instead. Using such a lock-free
> > ringbuffer requires non-standard atomic integer operations and does not
> > guarantee memory synchronization (and should probably not perform
> > significantly better than a decent mutex implementation) and is thus not
> > portable.
> 
> It's to decouple the system from various time related problems with jitter.
> It's critical to use this since the nature of Linus is so temporally coarse
> that these techniques must be used to "smooth" over latency problems in the
> Linux kernel.

Either use mutexes or POSIX message queues... the latter also are not
intended for realtime use under Linux (though they are meant for it in
POSIX), since they don't allocate memory on creation.

> I personally would love to see these audio applications run on a first-class
> basis under Linux. Unfortunately, that won't happen until it gets near real
> time support prevasively through the kernel just like in SGI's IRIX. Multimedia
> applications really need to be under a hard real time system with special
> scheduler support so that CPU resources, IO channels can be throttled.
> 
> The techniques Linux media folks are using now are basically a coarse hack
> to get things basically working. This won't change unless some fundamental
> concurrency issues (moving to a preemptive kernel with interrupt threads, etc..)
> change in Linux. Scattering preemption points manually over 2.6 is starting to
> look unmanable from all of the stack traces I've been reading in these latency
> related threads.

Improving the mutex and mqueue implementations to better support realtime
use would be a significant improvement I think, making Linux quite suitable
for realtime audio use.

--ms


