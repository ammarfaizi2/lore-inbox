Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJSIxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTJSIxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:53:11 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:24004 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262081AbTJSIxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:53:04 -0400
Message-ID: <20031019085008.7505.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 19 Oct 2003 03:50:08 -0500
Subject: Re: Circular Convolution scheduler
X-Originating-Ip: 172.150.60.69
X-Originating-Server: ws3-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(perhaps a bit less vague)

While the long-term time series analyses
would doubtless be interesting for enterprise
networks, I had something more modest in mind.

Most of the heuristic work so far seems to have
been directed toward how to identify interactive
processes as interactive without false positives
on batch processes, making the code correct (no
bugs), making it fast, and a little tuning to
obtain generally ("for most people") usable
values for how fast to scale up the priority
on a process that has matched the heuristics,
yes?

My question about inserting a convolution
would be more relevant to what do we do
with that information ("we believe that
this process is interactive")once we have it.

Do we just hit a boolean switch,
"this process is interactive, add N to
its nice value," and then leave it that
way until it exits? That might work for
most people with the right N, but it does
not take into account two other values
that we could obtain that (imho) should
modulate the interactive process priority
scaling.

Those two values would be a history value (how
many time slices since the last heuristic match
for this process) and how much time owned
by other processes in front of us in the
scheduler when we are requeued.

As the history value counts up, it's weight
as a factor in the interactive priority scaling
should decrease (adapting to when the user
falls asleep at the keyboard with half a dozen
interactive applications open, or when
something like a continuous network
traffic display initially matched an
interactivity heuristic).

As the number of processes in front of us
at reschedule time (regardless of whether
we called schedule ourselves or our time
slice expired) increases, that should
increase the weight of that factor in
scaling up the effective process priority
of an "interactive" (matched the heuristics)
process. "In front of us" would mean higher
nominal priority processes, processes with our
own nominal priority that were already queued
when our time slice expired, and processes
with lower priority that that have been
migrated upward in the queue by the
"no indefinite starvation" controls.

More processes in front of us means more
latency, so we should advance through
the scheduler at a faster rate (if we
don't want the interactivity response
enhancement to decay with process load).

Heuristic interactive process priority
promotion would thus adapt to actual
frequency of heuristic matches by a process
over time and to whatever latency in the
scheduler is attributable to the time slices
of other processes in front of us.

For batch processes, short circuit around the
whole thing if their heuristic history value
is 0 (never matched an interactive process
heuristic). They get scheduled by the scheduler's
normal priority queue management that happens
independent of interactive process heuristics.

(Perhaps a circular convolution is overkill
for these fairly simple adaptations. It was
initially interesting to me in this context
for its ability to encode an analog of something
of variable length in a fixed size data
structure and to reflect an approximation
of incremental changes in the variable length
input in its output. And for this task,
approximation is good enough. But a simple
gap-from-last-match history value and
scheduler-time-load-in-front-of-us already
fit in fixed size data structures.)

The key question, of course, is 'what does
it cost us to compute these?" Not much for
the history value, I don't know what it would
cost to keep track of schedulable aggregate
time load at a given nominal priority.

Comments?

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
__________________________________________________________
Sign-up for your own personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

