Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWGNCCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWGNCCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWGNCCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:02:11 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:16524
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1161172AbWGNCCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:02:09 -0400
Date: Fri, 14 Jul 2006 04:02:57 +0200
From: andrea@cpushare.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [test patch] seccomp: add code to disable TSC when enabling seccomp
Message-ID: <20060714020257.GC18774@opteron.random>
References: <200607131613_MC3-1-C4EC-45F9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607131613_MC3-1-C4EC-45F9@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 04:11:12PM -0400, Chuck Ebbert wrote:
> Is the below patch acceptable in generic code, or should some arch
> helper function hide it?  It lets i386 / x86_64 add TIF_NOTSC
> independently.  
>
> Also, what prevents this flag from being set on a running process?
> If that happens the CPU state and flag could get out of sync and
> this could cause problems because of the way the current code tests
> the flag.

Yes, there could be a tiny race where if the controller and seccomp
tasks run on two different CPUs: the seccomp task may write to the
pipe, and then read, but the read may not actually stop anywhere,
because the second CPU may have enabled seccomp and answered faster
than the first cpu. So there's tiny window for the TSC not to be
disabled synchronously at the start of the seccomp computations (and
if there are multiple seccomp tasks running the new ones could let the
old ones run a timeslice with the tsc enabled). The inverse isn't
possible because the SECCOMP/TSC bits cannot be cleared anywhere. In
short the only problem is that it's not a guarantee that the tsc is
always permanently disabled with seccomp in SMP.

To fix the tiny window if it's the current task writing to self, we
should also update the cr4 before returning from base.c. If it was a
different task it's more complicated (we would need to send a forced
sigstop, and wait the task->state to change, but then we go into the
ptrace parallelism I truly don't want to deal with in any way in
seccomp context). The whole point of seccomp is to be simple. So my
suggestion is either we ignore the tiny window, or we do it only from
the current task. If I've to deal with any sigstop then I could use
ptrace or utrace in the first place ;).

I generally preferred to be the controller task that fires up seccomp
(the controller tasks did a number of checks that everything was going
ok before firing it up), but if we forbid other tasks to fire up
seccomp, then perhaps there's no more reason to leave it a /proc
interface. I guess we could move it to a prctl which would probably
waste a few less bytes, so it gets even more friendly.

Thanks Chunk!
