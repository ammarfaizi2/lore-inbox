Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313570AbSDEVAj>; Fri, 5 Apr 2002 16:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313572AbSDEVAa>; Fri, 5 Apr 2002 16:00:30 -0500
Received: from gw.wmich.edu ([141.218.1.100]:7621 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S313570AbSDEVAO> convert rfc822-to-8bit;
	Fri, 5 Apr 2002 16:00:14 -0500
Subject: Re: some more nifty benchmarks
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@zip.com.au>, George Anzinger <george@mvista.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>
In-Reply-To: <200204052237.29299.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 05 Apr 2002 15:59:28 -0500
Message-Id: <1018040373.23296.112.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-04-05 at 15:37, Dieter Nützel wrote:
> On Freitag, 5. April 2002 :22, Ed Sweetman wrote:
> > On Thu, 2002-04-04 at 22:49, Dieter Nützel wrote:
> > > On Tuesday, March 2002-04-02 17:15:40, Ed Sweetman wrote:
> 
> [-]
> 
> > > Yep, FOUND it.
> > > Ingo`s latest sched-O1-2.4.18-pre8-K3 is the culprit!!!
> > > Even with -ac (2.4.19-pre2-ac2) and together with -aa (latest here is
> > > 2.4.18-pre8-K3-VM-24-preempt-lock).
> > >
> > > Below are the number for 2.4.18+sched-O1-2.4.18-pre8-K3.
> > > Have a look into the attachment, too.
> > >
> > > Hopefully you or Ingo will find something out.
> >
> > I seem to have lost your earlier emails.  Did you get a max latency of
> > around <2 before this 0(1) scheduler patch?
> 
> In short:
> 
> YES with 2.4 and with preemption+lock-break
> I repeated it for 2.4.19-pre5+vm33. See results below.
> 
> It is NOT in any case an -aa VM or preemption+lock-break bug.
> Ingo's latest sched-O1-2.4.18-pre8-K3.patch for 2.4 is the culprit. So all 
> latest -ac kernels are broken in this sense, too.
> 
> > 2.2 with low latency patch gets that.  2.4 with low latency patch is many
> > many times worse.  The high latency areas of the kernel are already known.
> 
> I know :-)
> Bad we badly need a newer lock-break for 2.4 from Robert (sorry Andrew :-).
> I will do some "stats data collection" with my next boot.
> 
> >  It's just a matter of deciding how to deal with them that's the problem.
> > It seems that it might be a general consensus that it can't be dealt with
> > in 2.4 mainstream.
> 
> No I think it is not.
> If we can eliminate the remaining bugs from O(1) and use preemption everything 
> should be smooth.
> 
> > As you've implied before though,  the scheduler is much more important
> > than latency is to the average user.
> 
> The O(1)-scheduler is great but broken (latency wise) in the current 2.4 
> version. Have anyone of you some older versions from Ingo around?
> 
> > As most people would know from
> > 2.2, audio would skip unless it was running -20 nice and the highest
> > priority etc.  With 2.4's scheduler and preempt, well you dont have to
> > worry about skips and you can leave the player at a normal nice and
> > priority value.
> 
> That's not true with the O(1)-scheduler.
> In most of my tests (Ingo got my results) you have to renice the audio daemon 
> to something like -16 (first "real time" class) and X to -10 (for good 
> interactivity) during "heavy" background stuff (40 gcc and 40 g++ processes 
> reniced +19 for example). This load resulting in ~350 processes, 80~85 
> running in parallel and sound playing on my "old" 1 GHz Athlon II with 640 
> MB...;-)

You realize that if you run enough processes your timeslice for all
proccesses sharing that priority is decreased. Decoding and audio
playing needs at least an N length timeslice and from the sound of it,
you're just running so many running processes that the length of that
priority's timeslice is below N.   There is nothing a schedular can do
about that, it's being fair.  Of course if you want something to run
with 350 other running processes you'll have to make it a higher
priority, if you let it be fair then it's timeslice is just too small
for it with that many divisions of your cpu.  You cant expect the kernel
to autodetect the functionality of the programs it's running and
auto-tune for usable performance, that's the user's job. 

What people complain about is a couple processes having the same effect
as running 350 procesess.  I dont see that at all with preempt anymore. 
There is no need to renice anything in a preempt kernel unless you know
you'll be running so many processes that your timeslice is just going to
be too small for applications that care.  This used to be the case in
2.2 back when i used it and before the preempt and new schedular patches
for 2.4.x. 

Running a couple apps and having it affect audio playing is something
you shouldn't expect to occur.  But running hundreds of programs and
having it affect audio playing is perfectly acceptable if they're all at
the same priority.  Would you say that it's the kernel's fault for
skipping on your 486 66Mhz cpu? no, you just dont have the processing
time/s to do what needs to be done, that's all that's happening with
your 350 processes at once on your 1Ghz cpu. it's preemption and
scheduling the way it's supposed to be,  before you'd only need one
process that hogged the cpu in kernel to bring your audio to a halt.    

An alternative fix would be to run your forkbombs and/or massively
threaded apps at +10 or so since it's a rare case that running so many
running processes is "normal use" 


 
> But that's not so good for the "normal" user. We need some "auto renicing".
> 
> BTW My former 2.4.17/2.4.18-pre numbers were much better for throughput and 
> somewhat for latency.
> 
> I used Andrea's -aa VM and Robert's preemption and lock-break on ReiserFS all 
> the time. But together with bootmem-2.4.17-pre6 and waitq-2.4.17-mainline-1.
> Anyone know where I can get newer versions of them?


