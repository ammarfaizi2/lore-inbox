Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSDEKXj>; Fri, 5 Apr 2002 05:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSDEKXa>; Fri, 5 Apr 2002 05:23:30 -0500
Received: from gw.wmich.edu ([141.218.1.100]:46978 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S312457AbSDEKXV> convert rfc822-to-8bit;
	Fri, 5 Apr 2002 05:23:21 -0500
Subject: Re: some more nifty benchmarks
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@zip.com.au>, George Anzinger <george@mvista.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200204050549.08558.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 05 Apr 2002 05:22:45 -0500
Message-Id: <1018002175.23296.71.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 22:49, Dieter Nützel wrote:
> On Tuesday, March 2002-04-02 17:15:40, Ed Sweetman wrote:
> > benchmark url: http://www.gardena.net/benno/linux/audio/
> >
> > The jam2 patch: http://giga.cps.unizar.es/~magallon/linux/kernel/
> >
> > command used:  ./do_tests none 3 256 0 1400000000
> >
> > System ram: Mem:  661925888
> >
> > both kernels use the same config on the same system run with the same
> > apps open at the time of the test.  
> >
> > Only one real issue is present.  Patching preempt to jam2 had big issues
> > with the new schedular, i had to remove all the preempting in sched.c. 
> > This sounds like it would disable preemption altogether but i did it
> > anyway in hopes that something still preempts.  Either way it didn't
> > hurt anything and worst case scenario is that it acts just like jam2
> > without any preempt patch applied.  
> >
> > The results are quite interesting.
> > http://safemode.homeip.net/2.4.19-pre4-ac3-preempt/3x256.html
> >
> > http://safemode.homeip.net/2.4.19-pre5-jam2-preempt/3x256.html
> >
> > Max Latency:
> >
> > As you can see, procfs latency has increased 2x with the jam2 patch.  
> > The jam2 patch uses AA's new vm patches and low latency patches. With
> > mostly schedular and vm changes in AA's patches, it seems more likely
> > something with pre5 hurting procfs performance, Although the changelog
> > is so cluttered with email addresses of every single submission
> > included, it's difficult to glance and see if any fs/procfs changes were
> > made.
> 
> Hello Ed and others,
> 
> it must be something in the "latest" O(1) scheduler for 2.4.
> I found weird latency numbers since 2.4.19-pre2-ac2 (Alan had the
> O(1)-scheduler included). See what I found below.
> 2.4.19-pre5 + vm33 + preemption show the same ;-(
> 
> I had best numbers for latency with 2.4.17/2.4.18-pre something together
> with O(1) and preemption+lock-break (max ~2ms).
> Maybe Robert have some of my numbers in his maildir.
> 
> I think someone should put an eye on it.
> 
> -Dieter
> 
> BTW Is Ingo OK? I haven't seen post from him for some weeks, now.
> 
> 
> ----------  Weitergeleitete Nachricht  ----------
> 
> Subject: Re: latencytest0.42-png looks weird for 2.4.19-pre2-ac2-prlo
> Date: Thu, 7 Mar 2002 03:41:27 +0100
> From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
> To: Robert Love <rml@tech9.net>
> Cc: Ingo Molnar <mingo@elte.hu>, George Anzinger <george@mvista.com>, Alan Cox <alan@redhat.com>, Linux Kernel List <linux-kernel@vger.kernel.org>
> 
> On Dienstag, 5. März 2002 03:29:03, you wrote:
> > On Mon, 2002-03-04 at 21:22, Dieter Nützel wrote:
> > > This is really weird.
> > > I get results and my feeling was before it _is_ running with preemption
> > > on 'cause it is smooth and speedy.
> > >
> > > preempt-kernel-rml-2.4.19-pre2-ac2-3.patch
> > > Applied.
> > >
> > > But the numbers for latencytest0.42-png look ugly.
> > > I'll enable DEBUG. Hope I find something.
> >
> > Let me know ... I really need to see comparisons.  The above vs
> > 2.4.19-pre2-ac2 with no preemption.  Or 2.4.19-pre2 with just O(1) or
> > 2.4.19-pre2 with rmap, etc ... I need to see a baseline (nothing) and
> > then find out if it is rmap or O(1) causing the problem.
> 
> 2.4.18 clean running OK, apart from the inherent slowness...;-)
> 
> > From your results, preemption is definitely working.  It must be
> > something else causing a bad mix...
> 
> Yep, FOUND it.
> Ingo`s latest sched-O1-2.4.18-pre8-K3 is the culprit!!!
> Even with -ac (2.4.19-pre2-ac2) and together with -aa (latest here is
> 2.4.18-pre8-K3-VM-24-preempt-lock).
> 
> Below are the number for 2.4.18+sched-O1-2.4.18-pre8-K3.
> Have a look into the attachment, too.
> 
> Hopefully you or Ingo will find something out.

I seem to have lost your earlier emails.  Did you get a max latency of
around <2 before this 0(1) scheduler patch?  2.2 with low latency patch
gets that.  2.4 with low latency patch is many many times worse.  The
high latency areas of the kernel are already known.  It's just a matter
of deciding how to deal with them that's the problem. It seems that it
might be a general consensus that it can't be dealt with in 2.4
mainstream.  

As you've implied before though,  the scheduler is much more important
than latency is to the average user.  As most people would know from
2.2, audio would skip unless it was running -20 nice and the highest
priority etc.  With 2.4's scheduler and preempt, well you dont have to
worry about skips and you can leave the player at a normal nice and
priority value.  


i'll continue to look at them over the weekend.  Right now i'm playing
with software suspend.  

 
> See yah.
> 	Dieter
> 
> SunWave1 dbench/latencytest0.42-png# time ./do_tests none 3 256 0 350000000
> x11perf - X11 performance program, version 1.5
> The XFree86 Project, Inc server version 40200000 on :0.0
> from SunWave1
> Thu Mar  7 03:23:44 2002
> 
> Sync time adjustment is 0.1117 msecs.
> 
>    3000 reps @   1.7388 msec (   575.0/sec): Scroll 500x500 pixels
>    3000 reps @   1.7427 msec (   574.0/sec): Scroll 500x500 pixels
>    3000 reps @   1.7416 msec (   574.0/sec): Scroll 500x500 pixels
>    3000 reps @   1.7401 msec (   575.0/sec): Scroll 500x500 pixels
>    3000 reps @   1.7434 msec (   574.0/sec): Scroll 500x500 pixels
>   15000 trep @   1.7413 msec (   574.0/sec): Scroll 500x500 pixels
> 
>     800 reps @   7.4185 msec (   135.0/sec): ShmPutImage 500x500 square
>     800 reps @   7.4216 msec (   135.0/sec): ShmPutImage 500x500 square
>     800 reps @   7.4239 msec (   135.0/sec): ShmPutImage 500x500 square
>     800 reps @   7.4210 msec (   135.0/sec): ShmPutImage 500x500 square
>     800 reps @   7.4219 msec (   135.0/sec): ShmPutImage 500x500 square
>    4000 trep @   7.4214 msec (   135.0/sec): ShmPutImage 500x500 square
> 
> fragment latency = 1.451247 ms
> cpu latency = 1.160998 ms
>  13.5ms ( 13)|
> 1MS num_time_samples=43483 num_times_within_1ms=35936 factor=82.643792
> 2MS num_time_samples=43483 num_times_within_2ms=43447 factor=99.917209
> PIXEL_PER_MS=103
> fragment latency = 1.451247 ms
> cpu latency = 1.160998 ms
> 321.2ms ( 16)|
> 1MS num_time_samples=19656 num_times_within_1ms=18006 factor=91.605617
> 2MS num_time_samples=19656 num_times_within_2ms=19563 factor=99.526862
> PIXEL_PER_MS=103
> fragment latency = 1.451247 ms
> cpu latency = 1.160998 ms
>  79.1ms ( 36)|
> 1MS num_time_samples=15681 num_times_within_1ms=11212 factor=71.500542
> 2MS num_time_samples=15681 num_times_within_2ms=15595 factor=99.451566
> PIXEL_PER_MS=103
> -rw-r--r--    1 root     root     350000000 Mär  7 03:25 tmpfile
> fragment latency = 1.451247 ms
> cpu latency = 1.160998 ms
> 147.3ms (158)|
> 1MS num_time_samples=19290 num_times_within_1ms=18423 factor=95.505443
> 2MS num_time_samples=19290 num_times_within_2ms=19030 factor=98.652151
> PIXEL_PER_MS=103
> -rw-r--r--    1 root     root     350000000 Mär  7 03:25 tmpfile
> -rw-r--r--    1 root     root     350000000 Mär  7 03:26 tmpfile2
> fragment latency = 1.451247 ms
> cpu latency = 1.160998 ms
> 484.1ms ( 64)|
> 1MS num_time_samples=14912 num_times_within_1ms=13493 factor=90.484174
> 2MS num_time_samples=14912 num_times_within_2ms=14783 factor=99.134925
> PIXEL_PER_MS=103
> -rw-r--r--    1 root     root     350000000 Mär  7 03:25 tmpfile
> -rw-r--r--    1 root     root     350000000 Mär  7 03:26 tmpfile2
> 66.180u 17.240s 3:21.28 41.4%   0+0k 0+0io 10374pf+0w
> 
> -------------------------------------------------------


