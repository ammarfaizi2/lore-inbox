Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274723AbRIUArx>; Thu, 20 Sep 2001 20:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274724AbRIUAro>; Thu, 20 Sep 2001 20:47:44 -0400
Received: from maile.telia.com ([194.22.190.16]:40678 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S274723AbRIUAre>;
	Thu, 20 Sep 2001 20:47:34 -0400
Message-Id: <200109210047.f8L0lkv26045@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Oliver Xymoron <oxymoron@waste.org>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Stefan Westerfeld <stefan@space.twc.de>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Fri, 21 Sep 2001 02:42:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109201756400.20823-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0109201756400.20823-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 September 2001 01.15, Oliver Xymoron wrote:
> On Fri, 21 Sep 2001, Dieter Nützel wrote:
> > > > > Right, the patch is returning the length preemption was unavailable
> > > > > (which is when a lock is held) in us. So it is indded 4ms.
> > > > >
> > > > > But, I think Dieter is saying he _sees_ 0.5~1s latencies (in the
> > > > > form of audio skips).  This is despite the 4ms locks being held.
> > > >
> > > > Yes, that's the case. During dbench 16,32,40,48, etc...
> > >
> > > You might actually be waiting on disk I/O and not blocked.
> > >
> > > Does your audio source depend on any files (eg mp3s) and if so, could
> > > they be moved to a ramfs? Do the skips go away then?
> >
> > Good point.
> >
> > I've copied one video (MP2) and one Ogg-Vorbis file into /dev/shm.
> > Little bit better but hiccup still there :-(
>
> Is anything else freezing up? Do you see your mouse stop moving, for
> instance? Do other apps stop getting scheduled (eg, ico)?
>
> You might try stracing artsd to see if it hangs at a particular syscall.
> Use -tt or -r for timestamps and pipe the output through tee (to a file on
> your ramfs).


Hi,

I tried playing a mp3 with noatun via artsd. Starting dbench 32 I get the
same kind of dropouts - and no indication with my latency profiling patch =>
no process with higher prio is waiting to run!

One of noatun or artsd is waiting for something else! (That is why I included
Stefan Westerfeld... artsd)

I noticed very nice improvement then reniceing (all) artsd and noatun.
(I did also change the buffer size in artsd down to 40 ms)

(This part most for Stefan...
So I thought - lets try to run artsd with RT prio - changed the option
HOW can it get RT prio when it is not suid? I guess it can not...

So I manually added suid bit - but then noatun could not connect with
artsd... bug?, backed out the suid change... but is behaves as it works,
could be that it has so short bursts that prio never get a chance to drop)

I have been doing some stracing but on noatun. It does some strange things...
It does some non blocking IO...

Then I tried to run Bennos latencytest, with generated output (sine).
pages locked, SCHED_FIFO prio - killed artsd before testing... (so it won't
do secondary buffering)
Result - did only get some very short skips.

Let artsd start - tried again after artsd had started.

Still getting very good results - I have a SB Live (kernel),
it can mix on board...
am I using that or do the sound pass artsd in all cases???

My conclusion is that it is noatun that is waiting for something.
Maybe the priorities can be the cause:

noatun runs => priority goes down over time (increased when all running 
processes has zero prio)
many dbench some with more prio than noatun => blocks the bursty, but CPU 
consuming, noatun
=> dropouts...

Look at top - one artsd stays on top (of top). But noatun drops...
dbenches comes and goes in between...

If this analysis is correct:
We really need to run RT processes with RT priorities!

It is also possible that multimedia applications needs to be rewritten to
this new situation, i.e. remove some workarounds...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
