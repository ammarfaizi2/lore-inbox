Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTHGX7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271108AbTHGX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:58:59 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:40894
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271104AbTHGX64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:58:56 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Thu, 7 Aug 2003 20:01:02 -0400
User-Agent: KMail/1.5
Cc: Daniel Phillips <phillips@arcor.de>, Eugene Teo <eugene.teo@eugeneteo.net>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308071651.07522.rob@landley.net> <3F32C752.4000403@wmich.edu>
In-Reply-To: <3F32C752.4000403@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308072001.02249.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 17:40, Ed Sweetman wrote:

> > XFree86 and Konqueror Xterm and Kmail could all say "latency in me is
> > end-user visible, so I care more about latency than throughput".  And
> > stuff like the nightly cron job that exists just to screw up my desktop
> > because I AM awake at 4 am a noticeable percentage of the time... 
> > Anyway, it cares about throughput and not at all about latency.  Same
> > with just about any invocation of gcc, so they'd never set the flags.
>
> cron is user setable. Just set it to work at a time you aren't there.

I would using it as an example.  It doesn't do anything I want to have done on 
a regular basis.  (If I want to find stuff, I use fine.  Generally if I don't 
know where it is, it's moved in the past hour or two anyway.)  So the first 
thing I do customizing my own system is rip cron out by the roots and burn it 
ceremonially.

> > So with SCHED_SOFTRR, if the system gets heavily loaded enough later on
> > then the SOFTRR tasks can get demoted and start skipping.  So we're back
> > to having a system where cron had better not start up while you're mixing
> > sound because it might put you over the edge.
>
> Again, cron is not something inevitable that you cant control. If you're
> mixing sound, dont run cron at times where it can interfere with your
> work. Cron is a throughput intensive process.  Complaining about
> processes like cron is like complaining about how your audio is skipping
> while running hdparm -t on the drive or dbench.

I am using cron as an example of an unrelated asynchronous background load. 

Are you suggesting that the scheduler is fundamentally incapable of even 
addressing any asynchronous background load in the case of latency-critical 
tasks, and that the only way Linux can be made to deal with this sort of 
thing is via a hand-configured embedded system that might as well run the 
latency critical task in place of "init" so the scheduler never actually has 
anything non-trivial to do?

If not, then cron may make a good example, even if I don't personally use it.

> > I fail to see how this is an improvement on Con's "carpet bomb the
> > problem with heuristics out the wazoo" approach?  (I like heuristcs. 
> > They're like Duct Tape.  I like Duct Tape.
> >
> >>Regards,
> >>
> >>Daniel
> >
> > Rob
>
> the problem is you want a process that works like it was run on a single
> tasking OS on an operating system that is built from the ground up to be
>   a multi-user multi-tasking OS and you want both to work perfectly at
> peak performance and you want it to know when you want which to work at
> peak performance automatically.

And world peace, sure.

I suggested that applications could potentially provide an "I am interested in 
latency" hint, which could kill their throughput (make their timeslices 
really small) if necessary in the name of giving them good latency with 
approximately the same amount of scheduler resources.  And that the attempt 
to supply the hint could fail if the system has too many processes interested 
in latency, so they know up front that it ain't gonna work rather than having 
it fail halfway through, and so that attempts to spawn new tasks don't 
interfere with the existing PVR thread that's halfway through recording a 4 
hour live teleconference or some such.

If SCHED_SOFTRR doesn't do that, then at best it's just one more heuristic.

> Duct tape cant do that, because just about nothing can. You're gonna
> have to make some effort as a user to do the job because short of
> artificial intelligence, the schedular is never going to be good enough
> for everyone to always be happy with heuristics or not.

Hence the "I care about latency at the expense of throughput" scheduler hint.  
(It's entirely possible that Con is coming up with his own heuristics to 
handle this without such a hint, but what he's basically doing is trying to 
figure out which tasks care about latency and which tasks care about 
throughput, and in many cases the author of the tasks knows.  There's 
probably never a time when X or XMMS does NOT care about latency over 
throughput, for example.)

The traditional behavior (2.4 and earlier) was to optimize for throughput at 
the expense of latency, at least until the task became a CPU hog, and I'm not 
suggesting changing that default behavior.

We're starting to get this kind of role-based hint thing now, by the way.  
There was some kind of SCHED_BATCH tweak a while back when people wanted 
jumbo timeslices to keep the cache hot for processor-intensive background 
stuff.  That got merged into the priority stuff if I recall, but low latency 
is not quite the same thing as high priority, because high priority implies 
you want a bigger percentage of the CPU time and the truth may be the 
opposite.

> Tune and optimize the schedular to handle problems with latency within
> like-processes and throughput within like-processes and allow priority
> levels to take care of how they work together. There is always room to
> optimize the code without changing what it eventually does too, in that
> way the schedular can be improved without exchanging it for something
> else whenever a problem occurs or allowing it to be directed by a
> specific group of loud users and set of userspace programs.

Actually, in MY specific case of having 6 desktops full of open windows (and 
now Konqueror's ability to open a zillion websites in tabbed windows), I 
usually drive my system deeply enough into swap that what the scheduler is 
doing is a sideshow at best.  You're mouse is GOING to skip if code mouse 
movement is blocked on has been sent to the swap file. :)

> I'd just like to see less complication because less is faster and faster
> means less overhead in kernel time.  If i have to do some of the work
> that a bloated artificially intelligent schedular will do then i'm more
> than happy to because that system is going to be able to scale much
> better than something with complicated scheduling as the number of
> processes increases.

The user supplying a hint so the scheduler doesn't have to figure out whether 
a particular process cares more about latency or throughput is hopefully a 
simplifying suggestion.  Otherwise, to provide good low-latency behavior for 
interactive tasks, you have to figure out what's an interactive task, as 
Con's patches seem to be doing a fairly good (if not necessarily perfect) job 
of.

I also think it's a bit late in the game in 2.5 to be adding that sort of 
thing.  I thought it might already be part of SCHED_SOFTRR, hence I was 
asking.  Since it isn't, I'll wait until 2.7...

Rob
