Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269471AbUINQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269471AbUINQNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUINQLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:11:21 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:35730 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269471AbUINQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:06:24 -0400
Date: Tue, 14 Sep 2004 18:05:31 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Ray Bryant <raybry@sgi.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914160531.GP4180@dualathlon.random>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040914113419.GH4180@dualathlon.random> <20040914155103.GR9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914155103.GR9106@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:51:03AM -0700, William Lee Irwin III wrote:
> On Mon, Sep 13, 2004 at 09:47:48PM -0700, William Lee Irwin III wrote:
> >> timer interrupt, usually at boot. The following patch attempts to 
> >> amortize the atomic operations done on the profile buffer to address 
> >> this stability concern. This patch has nothing to do with performance;
> 
> On Tue, Sep 14, 2004 at 01:34:19PM +0200, Andrea Arcangeli wrote:
> > isn't it *much* simpler and much more efficient to just have a per-cpu
> > idle function? I seriously doubt you'll get simultaneous collisions on
> > anything but the 'halt' instruction in the idle function.
> 
> Sampling the profile buffer at regular intervals shows far less than
> 256 distinct functions hit in 1s intervals even with all cpus busy. As
> for whether that would be sufficient, that will have to be answered by
> those who reported the bug. I suppose to test whether things besides
> idling do cause this problem, one would boot with a restricted
> prof_cpu_mask, load all cpus on the machine, set the prof_cpu_mask to
> unrestricted, and see if it livelocks before the load terminates.

It probably worth to measure it. The real bottleneck happens when all
cpus tries to get an exclusive lock on the same cacheline at the *same*
time. 1 second is a pretty long time, if there's no contention of the
cacheline, things are normally ok.

this is basically the same issue we had with RCU since all timers fired
at the same wall clock time, and all of them tried to change bits in the
same cacheline at the same time, that is a workload that collapse a
512-way machine ;). The profile timer is no different.

Simply removing the idle time accounting would fix it, however this
cripple down functionality a little bit, but it'll be a very good way to
test if my theory is correct, or if you truly need some per-cpu logic in
the profiler.

You could also fake it, have a per-cpu counter only for the current->pid
case, and then once somebody reads /proc/profile, you flush the total
per-cpu count to the counter in the buffer that corresponds to the EIP
of the idle func.

Before dedicidng I'd suggest to have a look and see how the below patch
compares to your approch in performance terms.

--- sles/arch/ia64/kernel/time.c.~1~	2004-08-25 02:47:33.000000000 +0200
+++ sles/arch/ia64/kernel/time.c	2004-09-14 18:01:39.792182008 +0200
@@ -206,6 +206,9 @@ ia64_do_profile (struct pt_regs * regs)
 	if (!prof_buffer)
 		return;
 
+	if (!current->pid)
+		return;
+
 	ip = instruction_pointer(regs);
 	/* Conserve space in histogram by encoding slot bits in address
 	 * bits 2 and 3 rather than bits 0 and 1.
