Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVETNEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVETNEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVETNEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:04:44 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57280 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261459AbVETNEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:04:31 -0400
Subject: RE: Why yield in coredump_wait? [was: Re: Resent: BUG in RT
	45-01whenRT program dumps core]
From: Steven Rostedt <rostedt@goodmis.org>
To: kus Kusche Klaus <kus@keba.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323215@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323215@MAILIT.keba.co.at>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 20 May 2005 09:04:14 -0400
Message-Id: <1116594254.4314.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 13:30 +0200, kus Kusche Klaus wrote:
> 
> First of all, yes, we are talking about busy waits:
> The CF cards run in PIO mode, i.e. the CPU polls and copies the data,
> and we know from measurements that this causes 100 % CPU load and
> blocks anything at lower prio for extended periods.
> 

Yeah, I figured as much.  I started looking at some of the flash code
and did see busy waits, usually with timeouts, but that's still not
acceptable in RT.

> Of course, in some cases you are in big trouble anyway 
> if some RT process in a control system dumps core,
> and it will not matter any more at which prio core is dumped.
> 

I'll send a patch to Ingo to at least drop the real time priority of a
process dumping core. But then the next question is, what should the
core priority be? Meaning, what nice value?  Should this be a sysctl
value?  For now it should probably just drop to nice 0.

> However, it might also be a non-critical part of the system,
> and in this case, other parts should continue at normal rate.
> If some part of the system which was designed to occupy the cpu
> exclusively for let's say at most 50 microseconds suddenly 
> monopolizes it for 5 seconds, that will cause surprises...
> 

I totally agree.

> Moreover, the lowest-pri parts of a control system are usually the
> graphical user interfaces. We are talking about core dump times
> in the order of 5 or 10 seconds, and the operators will panic madly
> if the system does not react to any user interaction and does not
> update its display for that long.

If the core dump drops the task out of RT, then the user interface
should still be responding. Here the nice value may be a factor to, but
you shouldn't see 5 or 10 seconds waiting (unless you are running
Evolution, but then that's just normal! :-)

> Similarly, log daemons should spread word about the problem 
> immediately, not 10 seconds late.

I'm not sure that this should be a kernel feature.  Maybe someday there
can be a notify event of when a process dumps core, but I suspect that
would be a low priority.  For now, since a core dump causes all tasks
sharing the memory to exit immediately, you may be able to figure out
how to monitor this externally. Or at least, check for activity of
something writing to core. 

Also, since a core dump is usually caused by a signal (is there any
other way?) you can have all the RT tasks catching these signals and try
to do something appropriately first.  But then again, a SIGSEGV is
usually something that makes the program unpredictable in continuing.
Just make sure your notifier doesn't do much (allocation or anything)
and is pretty bug free.

> So we are not yet at the question how to recover and how to
> continue. 
> 
> First of all, 
> we want to survive the core dumping itself gracefully, 

Capture the signal.

> we don't want to increase damage by dumping core, 

I'll work on lowering the priority.

> and we want to be able to inform and take action about the trouble
> before the core has finished dumping.

Again, do this via the signal handler.

> Greetings
> 

-- Steve


