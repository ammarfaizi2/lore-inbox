Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTHJKH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 06:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTHJKH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 06:07:28 -0400
Received: from holomorphy.com ([66.224.33.161]:46498 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261741AbTHJKHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 06:07:25 -0400
Date: Sun, 10 Aug 2003 03:08:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Simon Kirby <sim@netnation.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int
Message-ID: <20030810100836.GP1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Simon Kirby <sim@netnation.com>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <20030808220821.61cb7174.lista1@telia.com> <200308091036.18208.kernel@kolivas.org> <20030810084827.GA30869@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810084827.GA30869@netnation.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> I haven't been following this as closely as I would have liked to
> (recent vacation and all), but I am definitely seeing issues with the
> recent 2.5.x, 2.6.x-testx secheduler code and have been looking over
> these threads.
> I don't really understand why these changes were made at all to the
> scheduler.  As I understand it, the 2.2.x and older 2.4.x scheduler was
> simple in that it allowed any process to wake up if it had available
> ticks, and would switch to that process if any new event occurred and
> woke it up.  The rest was just limiting the ticks based on nice value
> and remembering to switch when the ticks run out.

Most of this isn't of much concern; most of the 2.4.x semantics have
largely been carried over to 2.6.x with algorithmic improvements, apart
from the same-mm heuristic (which was of dubious value anyway). Even
epochs are still there in the form of the duelling arrays, which
renders the thing vaguely timeout-based like 2.4.x.


On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> It seems that newer schedulers are now temporarily postponing the
> waking up of other processes when the running process is running with
> "preemptive" ticks, and that there's all sorts of hacks involved in
> trying to hide the bad effects of this decision.

If this would deliberate it would be a "selfish" scheduling algorithm,
where the delay in preemptively capturing the cpu is a number of ticks
equal to whatever the value of beta/alpha was chosen to be, and some
raw scheduling algorithm is used otherwise unaltered for those tasks in
the service box. I see no evidence of such an organization (it'd be
really obvious, as a queue box and service box would need to exist),
hence this is probably just something in need of a performance tweak
if it's a real problem.


On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> If this is indeed what is going on, what is the reasoning behind it?
> I didn't really see any problems before with the simple scheduler, so
> it seems to me like this may just be a hack to make poorly-written
> applications seem to be a bit "faster" by starving other processes of
> CPU when the poorly-written applications decide they want to do
> something (such as rendering a page with a large table in Mozilla
> -- grr).  Is this really making a large enough difference to be worth
> all of this trouble?

Yes. The SMP issues addressed by the algorithmic improvements in the
scheduler are performance issues so severe, they may safely be called
functional issues.


On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> To me it would seem the best algorithm would be what we had before all
> of this started.  Isn't it best to switch to a task as soon as an event
> (such as disk I/O finishing or a mouse move waking up X to read mouse
> input) occurs for both latency and cache reasons (queued in LIFO
> order)?  DMA may make some this more complicated, I don't know.

This sounds like either LCFS or FB. FB's not usable out of the box for
long-running tasks, as its context switch rates are excessive there.
LCFS has some rather undesirable properties that render it unsuitable
for general purpose operating systems. Something like multilevel
processor sharing would be a much better alternative, as long-running
tasks can be classified and scheduled according to a more appropriate
discipline with a lower context switch rate while maintaining the
(essentially infinitely) strong preference for short-running tasks.


On Sun, Aug 10, 2003 at 01:48:27AM -0700, Simon Kirby wrote:
> I am seeing similar starvation problems that others are seeing in these
> threads.  At first it was whenever I clicked a link in Mozilla -- xmms
> would stop, sometimes for a second or so, on a Celeron 466 MHz machine.
> More recently I found that loading a web page consisting of several
> large animated gif images (a security camera web page) caused
> absolutely horrible jerking of mouse and keyboard input in all other
> windows, even when the browser window was minimized or hidden.  What's
> worse is the jerking tends to subside if I do a lot of typing or more
> the mouse a lot, probably because I'm changing the scheduler's idea of
> what "kind" of processes are running (which makes this stuff even
> harder to debug).

One problem with these kinds of reports is that they aren't coming with
enough information to determine if the scheduler truly is the cause of
the problem, and worse yet, assuming the scheduler did cause these
problems, this isn't enough actual information to address it. We're
going to need proper instrumentation at some point here.

Until then, when you deliver these reports, could you do the following:

(a) vmstat 1 | cat -n | tee -a vmstat.log

(b) run top under script

(c) regularly snapshot profiles with
	n=1
	while true
	do
		readprofile -n -m /boot/System.map-`uname -r` \
			| sort -k 2,2 > prof.$n
		n=`expr $n + 1`
		sleep 1
	done

while running interactivity tests?

(a) will give some moderately useful information about how much io is
	going on and interrupt and context switch rates.

(b) will report dynamic priorities and other general conditions so the
	scheduler's decisions can be examined.

(c) will determine if the issue is due to in-kernel algorithms consuming
	excessive amounts of cpu and causing application-level latency
	issues via cpu burn

Also, send in bootlogs (dmesg), so that general information about the
system can be communicated.


-- wli
