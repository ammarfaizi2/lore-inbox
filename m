Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJESiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJESiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJESiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:38:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264377AbUJESii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:38:38 -0400
Date: Tue, 5 Oct 2004 11:38:28 -0700
Message-Id: <200410051838.i95IcSgC006889@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: Christoph Lameter's message of  Tuesday, 5 October 2004 08:39:46 -0700 <Pine.LNX.4.58.0410050826400.26772@schroedinger.engr.sgi.com>
X-Shopping-List: (1) Atypical pancakes
   (2) Dynastic detention cheeses
   (3) Expectant cotillion detergents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your approach means that only a part of the range may be used. 
> What happens if a pid of say 2^31-10 is used with your API?

That is certainly true.  On a 32-bit machine, a PID value above 2^29-1
cannot be used, by definition.  So there is no "what happens", it just can't.
Userland will need to reject huge PIDs before trying to encode them.
PID_MAX_LIMIT is 2^22, so no actually valid PID can be a problem in practice.

> Does this approach take into consideration that the TSC or cputimer may be
> different on each CPU of a SMP system? 

Yes.  If you consider the methodology I described, you'll see that it does.
The absolute sched_clock time is never relevant here, so it doesn't matter
that it differs between CPUs.  I take a sample when the thread gets
scheduled, and another when it gets descheduled (and perhaps others on the
timer interrupts in between).  So all I ever use is the difference between
two samples taken on the same CPU.

> I just reviewed the code and to my surprise the simple things like
> 
> clock_gettime(CLOCK_PROCESS_CPUTIME_ID) and
> clock_gettime(CLOCK_THREAD_CPUTIME_ID) are not supported. 

You seem to be confused.  A clockid_t for a CPU clock encodes a PID, which
can be zero to indicate the current thread or current process.  

> The thread specific time measurements have nothing to do with the posix
> standard and may best be kept separate.

Nonsense.  POSIX defines the notion of CPU clocks for these calls, and that
is what I have implemented.

Of course glibc is in charge of what the meaning of the POSIX APIs is.
That is true for every call.


Thanks,
Roland
