Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbWGNGGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbWGNGGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWGNGGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:06:49 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:3765 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161273AbWGNGGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:06:48 -0400
Date: Fri, 14 Jul 2006 02:02:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [test patch] seccomp: add code to disable TSC when
  enabling seccomp
To: "andrea@cpushare.com" <andrea@cpushare.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607140205_MC3-1-C4F5-E9D4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060714020257.GC18774@opteron.random>

On Fri, 14 Jul 2006 04:02:57 +0200, andrea@cpushare.com wrote:

> > Also, what prevents this flag from being set on a running process?
> > If that happens the CPU state and flag could get out of sync and
> > this could cause problems because of the way the current code tests
> > the flag.
> 
> Yes, there could be a tiny race where if the controller and seccomp
> tasks run on two different CPUs: the seccomp task may write to the
> pipe, and then read, but the read may not actually stop anywhere,
> because the second CPU may have enabled seccomp and answered faster
> than the first cpu. So there's tiny window for the TSC not to be
> disabled synchronously at the start of the seccomp computations (and
> if there are multiple seccomp tasks running the new ones could let the
> old ones run a timeslice with the tsc enabled).

But it looks like the mismatch could persist indefinitely: if a seccomp
task inherits the wrong cr4 flag it could pass it on to another, or back
to the original one and so on.  I think this is the only safe way:

	if (test_tsk_thread_flag(next_p, TIF_NOTSC) ||
	    test_tsk_thread_flag(prev_p, TIF_NOTSC)) {

		/* Flip TSC disable bit if necessary. */
		unsigned int cr4 = read_cr4();

		if (test_tsk_thread_flag(next_p, TIF_NOTSC)) {
			if (!(cr4 & X86_CR4_TSD))
				write_cr4(cr4 | X86_CR4_TSD);
		} else
			write_cr4(cr4 & ~X86_CR4_TSD);
	}

(Testing TSD in the 'else' path is not worth the trouble.)

> To fix the tiny window if it's the current task writing to self, we
> should also update the cr4 before returning from base.c. If it was a
> different task it's more complicated (we would need to send a forced
> sigstop, and wait the task->state to change, but then we go into the
> ptrace parallelism I truly don't want to deal with in any way in
> seccomp context). The whole point of seccomp is to be simple. So my
> suggestion is either we ignore the tiny window, or we do it only from
> the current task. If I've to deal with any sigstop then I could use
> ptrace or utrace in the first place ;).

The tiny window shouldn't be a problem, should it?  Just what is the
risk to begin with, and how much harder is it to exploit in such a
small window?

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
