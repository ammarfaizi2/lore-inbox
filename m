Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbUKQPxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbUKQPxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUKQPxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:53:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:19687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262340AbUKQPxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:53:01 -0500
Date: Wed, 17 Nov 2004 07:52:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
In-Reply-To: <20041117102651.GA13768@elte.hu>
Message-ID: <Pine.LNX.4.58.0411170734531.2222@ppc970.osdl.org>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au>
 <20041116232827.GA842@elte.hu> <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
 <20041117102651.GA13768@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Ingo Molnar wrote:
> 
> In practice this means it's 10 cycles more expensive on P3-style CPUs. 
> (I think on P4 style CPUs it should be much closer to 0, but i havent
> been able to reliably time it there - cycle measurements show a 76
> cycles cost which is way out of line.)

No, it's not way out of line. It _is_ that expensive. It seems to totally 
synchronize the trace cache or something.

It shows up very clearly in profiles. Spinlocks and atomic operations are 
very expensive even on UP, where there are zero cache bounce issues. I'm 
not kidding you - compile an SMP kernel, run it on a UP P4, and check it 
out with oprofile.

I did that just a few weeks ago out of idle curiousity about some lmbench 
numbers. 

And it's not just P4's either. It shows up on at least P-M's too, even
though that's a PPro-based core like a PIII. It's at least 22 cycles
according to my tests (certainly not 10), but it seems to have a bigger
impact than that, likely because it also ends up serializing the pipeline
around it (ie it makes the instructions _around_ it slower too, something
you don't end up seeing if you just do rdtsc which _also_ serializes).

Try lmbench some time. Just pick a UP machine, compile a UP kernel on it,
run lmbench, then compile a SMP kernel, and run it again. There's
literally a 10-20% performance hit on a lot of things. Just from a
_couple_ of locks on the paths. 

Sure, some of it is actual different paths, like the VM teardown, which 
on SMP is just fundamentally more expensive because we have to be more 
careful. So mmap latency (delayed page frees) and file delete (delayed RCU 
delete of dentry) ends up having differences of 30-40%. But the 10-20% 
differences are things where the _only_ difference really is just the 
totally uncontended locking.

That's on a P-M. On a P4 it is _worse_, I think.

		Linus
