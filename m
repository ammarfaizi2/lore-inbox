Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273298AbRIWHFu>; Sun, 23 Sep 2001 03:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273299AbRIWHFl>; Sun, 23 Sep 2001 03:05:41 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:4878 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273298AbRIWHFc>; Sun, 23 Sep 2001 03:05:32 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Andre Pang <ozone@algorithm.com.au>
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
In-Reply-To: <1001143341.117502.5311.nullmailer@bozar.algorithm.com.au>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
	<1001131036.557760.4340.nullmailer@bozar.algorithm.com.au>
	<1001139027.1245.28.camel@phantasy> 
	<1001143341.117502.5311.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 23 Sep 2001 03:05:41 -0400
Message-Id: <1001228764.864.53.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 03:22, Andre Pang wrote:
> arrgh!  i just realised my script buggered up and was producing the same
> graph for all the results.  please have a look at the page again, sorry.

no problem...

> apart from that, i'm still confused.  compared to other graphs produced
> by the latencytest program, my system seems to have huge latencies.
> unless i'm reading it wrongly, the graph is saying that i'm getting
> latencies of up to 30ms, and a lot of overruns.  compare this to
> 
>     http://www.gardena.net/benno/linux/audio/2.4.0-test2/3x256.html
> 
> which shows latencytest on 2.4.0-test2, and
> 
>     http://www.gardena.net/benno/linux/audio/2.2.10-p133-3x128/3x128.html
> 
> which are the results for latencytest on 2.2.10.  admittedly these
> kernels are much older, but i'm consistently getting far more latency
> than those kernels.  that's the bit i'm confused about :)  i've tried
> Andrew Morton's low-latency patches as well, to no avail.  i've made
> sure i've tuned my hard disks correctly, and i don't have any other
> realtime processes running.
> 
> am i concerned with a different issue than the one you're addressing?

No, I understand now.  I honestly don't know what to say about your
results.

You are right, those older kernels are showing much better response
times than your kernel.  One would think your newer kernel, with
preemption or low-latency patch, would be an improvement.

I honestly don't know what to tell you.  It could be a piece of hardware
(or, more accurately) its driver ... 

the /proc/latencytimes output shows us that no single lock is accounting
for your bad times.  In fact, all your locks aren't that bad, so...

maybe the problem is in the "overruns" -- I don't know what that means
exactly.  maybe someone else on the list can shed some light? 
otheriwse, you can email the author perhaps.

With whatever buffer or whatnot is overrunning (and you are getting a
bit of them, compared to those other URLs you posted), something is
stalling or repeating.

> > the preemption-test patch is showing _MAX_ latencies of 0.8ms through
> > 12ms.  this is fine, too.
> 
> yep, i agree with that ... so why is latencytest showing scheduling
> latencies of > 30ms?  i get the feeling i'm confusing two different
> issues here.  from what i understand, /proc/latencytimes shows the
> how long it takes for various functions in the kernel to finish, and
> the latencytest result shows how long it takes for it to be
> re-scheduled (represented by the white line on the graph).

Pretty much.

/proc/latencytimes shows you how long specific locks are held in the
kernel, so this isn't the same as how long certain functions take (which
could be longer or shorter).  The reason for showing lock duration is
that preemption (with the preemptible kernel patch) can not occur during
a lock for concurrency reasons, so we want to find long-held locks and
try to find a solution to them.

latencytest does indeed show scheduling latency.  it tries to show you
how well the system can keep up with the audio buffer.  with a
preemptible kernel, you can reduce this latency to a very small number,
baring any large locks (from above).

latencytest's latency is a function of the sum of the latencies reported
by /proc/latencytimes. thus, a bad latency in latencytest could be
caused by what you see in /proc/latencytest.  you would think we would
see one or two long locks screwing everything up, but we do not.

I would try to see what the overruns mean exactly, and see if any
hardware drivers could be at fault (right now we don't report time with
interrupts disabled in /proc/latencytimes, which could be a factor too).

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

