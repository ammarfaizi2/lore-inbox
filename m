Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271295AbTHLSgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTHLSgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:36:17 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:30160 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S271295AbTHLSgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:36:11 -0400
Date: Tue, 12 Aug 2003 11:36:10 -0700
From: Simon Kirby <sim@netnation.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int
Message-ID: <20030812183610.GB12036@netnation.com>
References: <20030808220821.61cb7174.lista1@telia.com> <200308091036.18208.kernel@kolivas.org> <20030810084827.GA30869@netnation.com> <20030810100836.GP1715@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810100836.GP1715@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 03:08:36AM -0700, William Lee Irwin III wrote:

> Most of this isn't of much concern; most of the 2.4.x semantics have
> largely been carried over to 2.6.x with algorithmic improvements, apart
> from the same-mm heuristic (which was of dubious value anyway). Even
> epochs are still there in the form of the duelling arrays, which
> renders the thing vaguely timeout-based like 2.4.x.

Hmm.  I admit I haven't read the code enough to understand really what is
going on -- I'm just guessing how it is working (and how it did work)
based on experiences I've had with it over the years.

> On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> > It seems that newer schedulers are now temporarily postponing the
> > waking up of other processes when the running process is running with
> > "preemptive" ticks, and that there's all sorts of hacks involved in
> > trying to hide the bad effects of this decision.
> 
> If this would deliberate it would be a "selfish" scheduling algorithm,
> where the delay in preemptively capturing the cpu is a number of ticks
> equal to whatever the value of beta/alpha was chosen to be, and some
> raw scheduling algorithm is used otherwise unaltered for those tasks in
> the service box. I see no evidence of such an organization (it'd be
> really obvious, as a queue box and service box would need to exist),
> hence this is probably just something in need of a performance tweak
> if it's a real problem.

Perhaps I should read the code to see what is actually going on (though
it is now fairly complex), but it definitely feels like this is
happening.  Why else would my keystrokes to an otherwise-idle rxvt be
delayed while my browser is rendering a page?  I suppose there may be
interactions with X.  This never used to happen, however.

The simple question: Does the scheduler ever intend to delay a context
switch to a process (which has been idle long enough to rebuild its
maximum timeslice) when a wake up event occurs?  If so, what is the
reasoning for this?

> > If this is indeed what is going on, what is the reasoning behind it?
> > I didn't really see any problems before with the simple scheduler, so
> > it seems to me like this may just be a hack to make poorly-written
> > applications seem to be a bit "faster" by starving other processes of
> > CPU when the poorly-written applications decide they want to do
> > something (such as rendering a page with a large table in Mozilla
> > -- grr).  Is this really making a large enough difference to be worth
> > all of this trouble?
> 
> Yes. The SMP issues addressed by the algorithmic improvements in the
> scheduler are performance issues so severe, they may safely be called
> functional issues.

Obviously the scheduler O(1) changes and other scalability improvements
are worthwhile, but I don't think (unless I'm missing something) they
explain the problem I'm seeing.

> On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> > To me it would seem the best algorithm would be what we had before all
> > of this started.  Isn't it best to switch to a task as soon as an event
> > (such as disk I/O finishing or a mouse move waking up X to read mouse
> > input) occurs for both latency and cache reasons (queued in LIFO
> > order)?  DMA may make some this more complicated, I don't know.
> 
> This sounds like either LCFS or FB. FB's not usable out of the box for
> long-running tasks, as its context switch rates are excessive there.
> LCFS has some rather undesirable properties that render it unsuitable
> for general purpose operating systems. Something like multilevel
> processor sharing would be a much better alternative, as long-running
> tasks can be classified and scheduled according to a more appropriate
> discipline with a lower context switch rate while maintaining the
> (essentially infinitely) strong preference for short-running tasks.

What makes the context switches excessive?  As far as I can see, the
only thing that can initiate a context switch are a process sleeping or
finishing, a timer tick and the scheduler deciding to switch, or a device
causing a wake up event.  I was also wondering: Isn't it best to always
switch to the process which has just had an event for cache coherency?

> > I am seeing similar starvation problems that others are seeing in these
> > threads.  At first it was whenever I clicked a link in Mozilla -- xmms
> > would stop, sometimes for a second or so, on a Celeron 466 MHz machine.
> > More recently I found that loading a web page consisting of several
> > large animated gif images (a security camera web page) caused
> > absolutely horrible jerking of mouse and keyboard input in all other
> > windows, even when the browser window was minimized or hidden.  What's
> > worse is the jerking tends to subside if I do a lot of typing or more
> > the mouse a lot, probably because I'm changing the scheduler's idea of
> > what "kind" of processes are running (which makes this stuff even
> > harder to debug).
> 
> One problem with these kinds of reports is that they aren't coming with
> enough information to determine if the scheduler truly is the cause of
> the problem, and worse yet, assuming the scheduler did cause these
> problems, this isn't enough actual information to address it. We're
> going to need proper instrumentation at some point here.

I can do this, but I'm not seeing inefficiency, I'm seeing large decision
problems.  If the context switches were up in the hundreds of thousands
or higher, I would understand, but they're in the low hundreds.  Isn't
top far too slow to figure out what is actually going on?  Also, kernel
time is less than 10 percent, so I don't think kernel profiles will help.

Maybe I'm dreaming, but shouldn't the scheduler be simple enough so that
it can be considered "obviously correct"?  ...Or close to that? :)

Simon-
