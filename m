Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTERALe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 20:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTERALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 20:11:34 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:52908 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261895AbTERALc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 20:11:32 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
References: <x54r3tddhs.fsf@lola.goethe.zz>
	<20030517174100.GT1429@dualathlon.random>
	<x5r86x74ci.fsf@lola.goethe.zz>
	<20030517203045.GZ1429@dualathlon.random>
	<x565o9717j.fsf@lola.goethe.zz>
	<20030517215345.GA1429@dualathlon.random>
	<x53cjd5hf6.fsf@lola.goethe.zz>
	<20030517235048.GB1429@dualathlon.random>
Reply-To: dak@gnu.org
From: David.Kastrup@t-online.de (David Kastrup)
Date: 18 May 2003 02:24:10 +0200
In-Reply-To: <20030517235048.GB1429@dualathlon.random>
Message-ID: <x5of213xw5.fsf@lola.goethe.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sun, May 18, 2003 at 12:37:01AM +0200, David Kastrup wrote:
> > Of course it does.  I told it to do so.  But there is no necessity to
> > do an immediate context switch: it would be completely sufficient if
> > Emacs (which is waiting on select) were put in the run queue and
> > scheduled when the time slice of dd was up.  Performance gets better
> 
> the switch happens because emacs has higher dynamic priority, as it
> was sleeping for the longest time. without these special cases for
> the interactive tasks we couldn't use these long timeslices without
> making the system not responsive.

Then we will need a smaller timeslice for making this decision.  If I
have a sending process able to write 1000000 characters per second,
it is wasteful if such a process is scheduled away after writing a
single line (most processes running inside of a shell will work
line-buffered, won't they?).

> > But if I am doing process communication with other processes, the I/O
> > _will_ arrive in small portions, and when the generating processes are
> > running on the same CPU instead of being I/O bound, I don't stand a
> > chance of working efficiently, namely utilizing the pipes, if I do a
> 
> writing 1 byte per syscall isn't very efficient in the first place
> (no matter if the cxt switch happens or not).

Sure, but we are more typically talking about writing a line at a
time, which is easily by a factor 50 smaller than the pipe capacity
for typical output.

> I see what you mean, but I still don't think it is a problem. If
> bandwidth matters you will have to use large writes and reads
> anyways, if bandwidth doesn't matter the number of ctx switches
> doesn't matter either and latency usually is way more important with
> small messages.
> 
> you're applying small messages to a "throughput" test, this is why
> you have a problem. If you really did interprocess communication
> (and not a throughput benchmark) you would probably want the
> smallest delay in the delivery of the signal/message.

Not when I could have my pipe filled within a fraction of a
millisecond _without_ idling (starting up the reading process the
moment that the writing process has taken more than its due of time
or is in itself waiting is, of course, perfectly sensible).

Xterm:
time dd if=/dev/zero bs=16k count=16|od -v
real    0m8.656s
user    0m0.240s
sys     0m0.090s

time dd if=/dev/zero bs=16k count=16|od -v|dd obs=16k
real    0m3.794s
user    0m0.240s
sys     0m0.060s

Do you really think that I would have appreciated the "smaller
latency" of few milliseconds at best in the first case?  Note that
this is exclusively a uni-processor problem: the fast context switch
will starve the writing process from CPU time and make sure that even
if it could crank out hundreds of writes in millisecond, it will only
get a single one of them placed into the pipe, ever, unless the
receiving end gets preempted before reaching select, at which time the
writer can finally stuff the pipe completely.

This all-or-nothing utilization of a pipe or pty is not a sane
tradeoff.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
