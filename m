Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272552AbRIWBmL>; Sat, 22 Sep 2001 21:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273054AbRIWBmA>; Sat, 22 Sep 2001 21:42:00 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:9232 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S272552AbRIWBly>; Sat, 22 Sep 2001 21:41:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Roger Larsson <roger.larsson@norran.net>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sat, 22 Sep 2001 21:42:02 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <200109222340.BAA37547@blipp.internet5.net> <200109230042.f8N0gw129012@mailf.telia.com>
In-Reply-To: <200109230042.f8N0gw129012@mailf.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010923014156Z272552-760+15680@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 September 2001 20:38, Roger Larsson wrote:
> On Sunday 23 September 2001 01.40, safemode wrote:
> > ok. The preemption patch helps realtime applications in linux be a little
> > more close to realtime.  I understand that.  But your mp3 player
> > shouldn't need root permission or renicing or realtime priority flags to
> > play mp3s. To test how well the latency patches are working you should be
> > running things all at the same priority.  The main issue people are
> > having with skipping mp3s is not in the decoding of the mp3 or in the
> > retrieving of the file, it's in the playing in the soundcard.  That's
> > being affected by dbench flooding the system with irq requests.  I'm
> > inclined to believe it's irq requests because the _only_ time i have
> > problems with mp3s (and i dont change priority levels) is when A. i do a
> > cdparanoia -Z -B "1-"    or dbench 32.   I bet if someone did these tests
> > on scsi hardware with the latency patch, they'd find much better results
> > than us users of ide devices.
>
> No, irq might have something to do with it but it is unlikely since the
> stops are too long.
>
> Much more likely is:
> a) when running without priority altered:
> MP3 playing requires processing, this will lower the process priority
> relative processes that does little processing - like dbench processes.
> Running with negative nice will help this, but is no guarantee. Running
> with RT priority is.
> [this is where the various low latency patches helps]

I dont think mp3 playing should require realtime priority.  if the problem is 
not getting enough cpu time or attention from the kernel then it's a kernel 
scheduling problem.  You shouldn't have to "cheat" and bypass all that.  in 
an ideal situation the kernel should be able to see that the mp3 proccess is 
running and is thus more important than stuff like dbench proccesses.  
Although this problem we're having with mp3 skippage is not a cpu bound 
problem.  We're dealing with another resource here that's not so predictable 
because the kernel scheduling handles cpu time slices very nicely.  


> b) several processes are doing disk operations simultaneously.
> This will put preassure on the VM to free pages fast enough. It will
> also put preassure on the disk IO to read from disk fast enough -
> these requests are not prioritized with the process priority in mind.
> If there are no pages free we have to wait...
> [if you run the latencytest program with no audiofile, to use a sine,
>  you will not hear dropouts... it runs with RT prio with resident memory]

this may be the reason.  Although i dont think RT prio has anything to do 
with it.  If RT prio doesn't effect this VM portion of the kernel then wether 
we use RT or not for something as tiny as mp3 playing would hardly matter.  
Our sound drivers may not be able to play nicely with the VM under heavy disk 
access like cdparanoia -Z or dbench 32 and above.  


> This second problem is MUCH harder to solve.
> Multimedia applications could reserve memory - for their critical code
> including buffers... (but this will require suid helpers...)
> SGIs filesystem XFS is said to be able to guarantee bandwith to an
> application.
>
> Riels schedule in __alloc_pages probably helps the case with competing
> regular processes a lot. Not allowing memory allocators to run their
> whole time slot. The result should be a way to prioritize memory allocs
> relative your priority. (yield part might be possible/good to remove)

Sounds interesting. 
> /RogerL

Setting to RT should guarantee that your process gets executed when it wants 
to and processed by the kernel, which should help when dealing with something 
that holds on to a part of the kernel for an unpredictable amount of time or 
perhaps just a length of time that's too long.  But this vm scheduling thing 
that can break up those requests should allow the kernel to organize more of 
it's processes to be able to run smoothly at the same time without the need 
to give one higher priority than the other. Perhaps making a default alloc 
time slot that's small so no processes get accidentally starved and if you 
want a program that hogs memory time to run at full performance and not be 
hampered by multitasking, running at a higher priority would increase it's 
mem alloc time.   mp3 playing requires a very minimal amount of resources 
from anything.  it should be made that these minimal programs can run 
smoothly without resource hogging programs starving them unless you 
specificaly want them to (ie. increase priority).  
