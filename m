Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVGOT6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVGOT6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVGOT6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:58:55 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:60716 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261716AbVGOT6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:58:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bHgeea8Zu8lxA3OBQR7bj6a3D0LtIaPmrMjiELiiZ8R1djrv+bCCYDrqpxLyqANoHxiOJw3M4NAZ/6q7ALw5Ar8BS5dIcLhJ4at2V16WyOB1IbjeX7QO3Rr8LcBk920pHbwmNvpwdWB4tgFDEFqWw7/3AWx3rYy5FcDzQnSefis=
Message-ID: <feed8cdd050715125846f8c42f@mail.gmail.com>
Date: Fri, 15 Jul 2005 12:58:49 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: Stephen Pollei <stephen.pollei@gmail.com>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <1121392856.7934.11.camel@orbiter>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com> <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	 <1121392856.7934.11.camel@orbiter>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Eric St-Laurent <ericstl34@sympatico.ca> wrote:
> On Thu, 2005-07-14 at 17:24 -0700, Linus Torvalds wrote:
> > Trust me. When I say that the right thing to do is to just have a fixed
> > (but high) HZ value, and just changing the timer rate, I'm -right-.

> Of course you are, jiffies are simple and efficient.

> If i sum-up the discussion from my POV:

> - use a 32-bit tick counter on 32-bit platforms and use a 64-bit counter
> on 64-bit platforms
If the 64bit counter doesn't have any overhead then sure.

> - keep the constant HZ=1000 (mS resolution) on 32-bit platforms
Which HZ Is that? CONFIG_JIFFIES_HZ or CONFIG_FIXED_PIT_HZ ?
I think you meant CONFIG_JIFFIES_HZ which I think for even 32bit
counters could go up to 1e4 to 5e4 , with some patching going on in
some places of course.

> - remove the assumption that timer interrupts and jiffies are 1:1 thing
> (jiffies may be incremented by >1 ticks at timer interrupt)
Yes maybe nuke CONFIG_HZ and replace it with CONFIG_JIFFIES_HZ and
CONFIG_(FIXED|DEFAULT|DYNAMIC)_PIT_HZ . Starting with just
CONFIG_FIXED_PIT_HZ, add others as needed.

Extreme might be to also just nuke HZ and replace it with JHZ and PHZ,
or whatever so that people are *crystal* clear about the difference.

> - determine jiffies_increment at boot
So CONFIG_<foo>_PIT_HZ could be a per boot time thing maybe.
So you'd have CONFIG_DEFAULT_PIT_HZ if it was a per per boot or runtime thing.
CONFIG_DYNAMIC_PIT_HZ if it was changable as the system is running --
like windows.
CONFIG_FIXED_PIT_HZ if it is a compile time constant.
Or something like the that?

> - have a slow clock mode to help power management (adjust
> jiffies_increment by the slowdown factor)
CONFIG_DYNAMIC_PIT_HZ unless it's overhead is so low that everyone
just wants it by default.

> - it may be useful to bump up HZ to 1e6 (uS res.) or 1e9 (nS res.) on
> 64-bit platforms, if there are benefits such as better accuracy during
> time units conversions or if a higher frequency timer hardware is
> available/viable.
Too high starts to cause other troubles. I think that the real time
people want 10uS scheduling, but even the ipipe and rt-preempt has
18us-70uS delays at times IIRC. So 5e4 to 1e5 is about the extreme end
of the road for CONFIG_JIFFIES_HZ . I think even long term that 1e5 to
1e6 would be extreme because of speed of light issues, etc. Hpet is
only 1.4e7 IIRC.

I think that you should start with:
1) CONFIG_FIXED_PIT_HZ=50 CONFIG_JIFFIES_HZ=2000
2) try it out and fix any bugs, send the fixes to Linus to see if how
much he bitches.
3) if you still need CONFIG_JIFFIES_HZ to be larger, double it and then goto 2.
4) enjoy your higher frequency jiffies

I bet that even that going to somewhere between 2e3 through 1e5 will
make you want to change a few things for performance and sanity
reasons. So I'd focus on that before I even thought about 1e6 through
1e10 . Plus I think the interest level really fails off to go that
extreme.

Just making JIFFIES_HZ != PIT_HZ will require patches.
Dynamic pit hz or lazy update of jiffies based on tsc/hpet/other are
other patches.

> - it may be also useful to bump HZ on -RT (Real-time) kernels,
yes they sound like they want JIFFIES_HZ to be 1e3 through 1e5
depending on task. They also want hpet(or other), vertical retrace
interrupts(so xsync works for video), perhaps a nist mini atomic
clock, and a few other goodies AFAIK.
> -HRT (High-resolution timers support).
Yes tsc or hpet or whatever users might benefit in several ways.
1) both tsc and hpet might be able to bump up to a more accurate value
on entry to idle and then test to see if anything got scheduled.
2) hpet can set set one shot timers for the next up coming event on
idle if it's sooner than when the PIT interrupt is suppose to come in.
Of course update the jiffies when that hpet interrupt comes.

>Users of those kernel are willing
> to pay the cost of the overhead to have better resolution
Yes realtime users with something like hpet might not vary the pit
timer, but place hooks to update the jiffies between pit interrupts
like idle, scheduler(task switch), etc. And use the hpet one shot
interrupts as well.

> - avoid direct usage of the jiffies variable, instead use jiffies()
> (inline or MACRO), IMO monotonic_clock() would be a better name
I don't know I think it could remain a variable you usual just want it
to be a light-weight memory read not a call out to an hpet and then a
math conversion, or a call out to tsc that then has to known about if
the tsc represents work or time, and if the cpu has been slowed for
power save reasons etc etc etc. I think you want a symbol exported gpl
of something like void force_update_jiffies(void); that you can call
in different hook locations to force the update of jiffies from
non-interupt sources. Actually you might want more than one version of
that function or have it take an argument, becuase some people might
want to be super lazy and only update it when the enter or leave idle,
while others(real timers) might want it updated on every interupt and
scheduling decision point. Hook placement might have strong affinity
with where the preemption hooks are placed for the various levels of
preemption(voluntary,standard,rt).


But If I understand Linus's points he wants jiffies to remain a memory
fetch, and make sure it doesn't turn into a singing dancing christmas
tree.

Sounds like it might be a a bunch of config options or some of it
might be low enough overhead that the non-lazy approach might work for
everyone.

P.S.
http://www.nist.gov/public_affairs/releases/miniclock.htm
[[The clock's inner workings are about the size of a grain of rice
(1.5 millimeters on a side and 4 millimeters high), consume less than
75 thousandths of a watt (enabling the clock to be operated on
batteries) and are stable to one part in 10 billion, equivalent to
gaining or losing just one second every 300 years. ...  measuring time
by the natural vibrations of cesium atoms, at 9.2 billion "ticks" per
second ... ]]
This thing measures time on the order of 1e10 .

http://keithp.com/~keithp/talks/xarch_ols2004/xarch-ols2004-html/
mentions xsync.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
