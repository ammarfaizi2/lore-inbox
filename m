Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSHBUzf>; Fri, 2 Aug 2002 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSHBUzf>; Fri, 2 Aug 2002 16:55:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24310 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317312AbSHBUze>;
	Fri, 2 Aug 2002 16:55:34 -0400
Message-ID: <3D4AF27F.48DB7FF0@mvista.com>
Date: Fri, 02 Aug 2002 13:58:39 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: some questions using rdtsc in user space
References: <Pine.LNX.4.33.0208021430590.2710-100000@coffee.psychology.mcmaster.ca> <3D4ADDA5.9080900@PolesApart.wox.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexandre P. Nunes" wrote:
> 
> Mark Hahn wrote:
> 
> >[snip]
> >pretty gross.  the reason is that it's not reasonable to use
> >interrupt-based timers for anything close to a 200ns wait,
> >(since programming a timer costs O(1us).)  therefore, this kind
> >of hardware requires either busy-waiting (eating 200ns each op),
> >or using the existing timer, which is 100 Hz in normal kernels
> >(faster in 2.5, and can be altered if you wish).
> >
> >
> Raising it up don't make the kernel scheduler itself take up too much
> time? In my application it won't bother too much since there are
> presumably not many competing tasks, but I could only think in
> fine-tuning the kernel as a last resort, since the idea is allow it to
> run fine in customer's kernel, preferably any version/series...
> 
> >
> >
> >>We wrote a program which accomplishes this by doing outb() to
> >>appropriate address(es), followed by usleep(1), but that  seems to take
> >>about 10 ms at average or so, which is far from good for our application.
> >>
> >>
> >
> >what's your target rate?
> >
> >
> The hardware is quite asynchronous, I need to get as fast as possible,
> but I guess my least acceptable average case would be something like a
> half milisecond or so.
> 
> >>I read somewhere that putting the process in real-time priority could
> >>lead the average to 2ms, but I had this though that I could solve this
> >>by using rdtsc instruction, because as far as I know it won't cause a
> >>trap to kernel mode, which maybe expensive, am I right?
> >>
> >>
> >
> >you can easily busy-wait using rdtsc.  I do this all the time in
> >my realtime video code for presenting psychophysiological stimuli.
> >(it often polls the video retrace register, as well.)
> >
> That was the original idea...
> 
> >you don't need RT prio to do busy-waits on rdtsc, though you will
> >naturally get preempted sometimes.  if you do use RT prio,
> >then you can always do at most 200ns, and this might wind up
> >being more efficient (depending on what else the system's doing.)
> >
> >
> >
> 
> I was mentioning the non busy-wait case (usleep), but that don't seemed
> good enough at first anyway.
> I could live up with preemption, because it happens very seldom (viewing
> from this application perspective), but if I can avoid that, it's even
> better :-)

The only way to prevent preemption in user land is to be the
most important (highest priority) task on the system.  Even
then interrupts can take the cpu away for a time.

If you only need to wait for ~200ns, a gettimeofday call is
the best bet in that it is VERY portable.  It should give
you resolution down to the micro second so you will wait,
most likely, 1.5 micro seconds.  If this is too long, you
will have to either calibrate a user space delay loop (still
very portable) or use the TSC, which is not available on all
x86 platforms, let alone other platforms, i.e. is not
portable.
> 
> >I do something like this:
> >
> >
> >
> Exactly what I was looking for, I'll experiment some different
> approaches, but the main idea is just that.
> 
> Thanks!
> 
> Alexandre
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
