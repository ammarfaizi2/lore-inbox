Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWGNGaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWGNGaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWGNGaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:30:08 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:10210
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1030221AbWGNGaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:30:07 -0400
Date: Fri, 14 Jul 2006 08:30:06 +0200
From: andrea@cpushare.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [test patch] seccomp: add code to disable TSC when enabling seccomp
Message-ID: <20060714063006.GF18774@opteron.random>
References: <200607140205_MC3-1-C4F5-E9D4@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607140205_MC3-1-C4F5-E9D4@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 02:02:55AM -0400, Chuck Ebbert wrote:
> But it looks like the mismatch could persist indefinitely: if a seccomp
> task inherits the wrong cr4 flag it could pass it on to another, or back
> to the original one and so on.  I think this is the only safe way:
> 
> 	if (test_tsk_thread_flag(next_p, TIF_NOTSC) ||
> 	    test_tsk_thread_flag(prev_p, TIF_NOTSC)) {
> 
> 		/* Flip TSC disable bit if necessary. */
> 		unsigned int cr4 = read_cr4();
> 
> 		if (test_tsk_thread_flag(next_p, TIF_NOTSC)) {
> 			if (!(cr4 & X86_CR4_TSD))
> 				write_cr4(cr4 | X86_CR4_TSD);
> 		} else
> 			write_cr4(cr4 & ~X86_CR4_TSD);
> 	}
> 
> (Testing TSD in the 'else' path is not worth the trouble.)

Yes that solves the problem of the first seccomp task propagating it
to the other seccomp tasks.

> The tiny window shouldn't be a problem, should it?  Just what is the
> risk to begin with, and how much harder is it to exploit in such a
> small window?

Even the original patch of yours was perfectly fine in
practice. Eventually one of the per-cpu daemons would also be
scheduled even if there are more seccomp tasks per cpu.

But in my opinion if we care about this window and we change
something, it worth to close it completely, mostly for code-style
reasons (i.e. strict code). Note that the NOTSC will never be checked
unless there's a second task, so it's not a single timeslice.

As far as I can tell, the only way to close it completely, is to
require that the task that fires up seccomp is the current task. That
is a very fine requirement. That guarantees that no other cpu could
require any update in-core. So it's enough to always flip the NOTSC
bit in the current cpu with test_and_set_bit and to synchronously
update the cr4 accordingly to the result of test_and_set_bit, then we
can go back to the nicer (and faster) xor way in the scheduler slow
path ;).

This is incidentally exactly what I implemented and tested with my
last patch ;) (which is of course a modification and extension of
yours)

Thanks.
