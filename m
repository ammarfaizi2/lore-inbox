Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbUKRPWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUKRPWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUKRPWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:22:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46988 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262429AbUKRPTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:19:55 -0500
Date: Thu, 18 Nov 2004 17:21:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling bugs
Message-ID: <20041118162151.GA16592@elte.hu>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au> <20041116232827.GA842@elte.hu> <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org> <20041117102651.GA13768@elte.hu> <Pine.LNX.4.58.0411170734531.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411170734531.2222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> And it's not just P4's either. It shows up on at least P-M's too, even
> though that's a PPro-based core like a PIII. It's at least 22 cycles
> according to my tests (certainly not 10), but it seems to have a
> bigger impact than that, likely because it also ends up serializing
> the pipeline around it (ie it makes the instructions _around_ it
> slower too, something you don't end up seeing if you just do rdtsc
> which _also_ serializes).
> 
> Try lmbench some time. Just pick a UP machine, compile a UP kernel on
> it, run lmbench, then compile a SMP kernel, and run it again. There's
> literally a 10-20% performance hit on a lot of things. Just from a
> _couple_ of locks on the paths. 
> 
> Sure, some of it is actual different paths, like the VM teardown,
> which on SMP is just fundamentally more expensive because we have to
> be more careful. So mmap latency (delayed page frees) and file delete
> (delayed RCU delete of dentry) ends up having differences of 30-40%.
> But the 10-20% differences are things where the _only_ difference
> really is just the totally uncontended locking.
> 
> That's on a P-M. On a P4 it is _worse_, I think.

oh well. The Athlon64 really shines doing atomic ops though, and this
fooled me into thinking that the LOCK prefix has been properly taken
care of forever. What the hell is Intel doing ... atomic ops are so
fundamental to spinlocks. Thank God we can do the movb $1,%0 trick for
spin-unlock.

	Ingo
