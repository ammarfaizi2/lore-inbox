Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285216AbRLXSuf>; Mon, 24 Dec 2001 13:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbRLXSuZ>; Mon, 24 Dec 2001 13:50:25 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:42001 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285216AbRLXSuL>; Mon, 24 Dec 2001 13:50:11 -0500
Date: Mon, 24 Dec 2001 10:52:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Momchil Velikov <velco@fadata.bg>,
        george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011223223348.A20895@hq2>
Message-ID: <Pine.LNX.4.40.0112241023310.1517-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Victor Yodaiken wrote:

> On Sun, Dec 23, 2001 at 05:31:11PM -0800, Davide Libenzi wrote:
> > On Sun, 23 Dec 2001, Victor Yodaiken wrote:
> >
> > >
> > >
> > > Run a "RT"  task that is scheduled   every millisecond (or time of your
> > > choice)
> > > 	while(1`){
> > > 		read cycle timer
> > > 		clock_nanosleep(time period using aabsolute time
> > > 		read cycle timer - what was actual delay? track worst
> > > 			case
> > > 		}
> > >
> > > Run this
> > > 	a) on aaaaaaaaan unstressed system
> > > 	b) under stress
> > > 	c) while a timed non-rt benchmark runs to figure out "RT"
> > > 	overhead.
> >
> > I've coded a test app that uses the LatSched latency patch ( that uses
> > rdtsc ).
> > It basically does 1) set the current process priority to RT 2) an ioctl()
> > to activate the scheduler latency sampler 3) sleep for 1-2 secs 4) ioctl()
> > to stop the sampler 5) peek the sample with pid == getpid().
> > In this way i get the net RT task scheduler latency. Yes it does not get
> > the real one that includes accessories kernel paths but my code does not
> > affect these ones. And they add noise to the measure.
>
>
> Seems to me that you are not testing what apps see. Internal benchmarks
> are useful only for figuring out how to remove bottlenecks that
> effect actual user apps - in my humble opinion of course.
> The nice thing about my benchmark is that it actually tests something
> useful - how well you can do periodic tasks. BTW, on RTLinux we get
> under 100 microseconds on even 50Mhzx PPC860 - 17us on a 800Mhz K7.
> I'd be happy to see some decent numbers in Linux, but you gotta
> measure something more applied.

I know what you're saying but my goal now is to fix the scheduler not the
overall RT latency ( at least not the one that does not depend on the
scheduler ). Just take for example your 17us for your 800MHz machine, in
my dual PIII 733 MHz with an rqlen of 4 the scheduler latency ( with that
std scheduler ) is about 0.9us ( real one, not lat_ctx ). That means the
the scheduler responsibility in your 17us is about 5%, and the remaining
95% is due "external" kernel paths. With an rqlen of 16 ( std scheduler )
the latency peaks up to ~2.4us going to ~14-15% of scheduler responsibility.
I've coded this simple app :

http://www.xmailserver.org/linux-patches/lnxsched.html#RtLats

and i use it with the cpuhog ( hi-tech software that is available inside
the same link ) to load the run queue. I'm going to plot the measured
latency versus the runqueue length. Thanks to OSDLAB i'll have an 8 way
machine to make some test on these big SMPs. I'll code even the simple
app you're proposing but the real problem is how to load the system. The
cpuhog load is a runqueue load and is "neutral", that means that is the
same on all the systems. Loading the system with other kind of loads can
introduce a device-driver/hw dependency on the measure ( much or less run
time with irq disabled for example ).





- Davide



