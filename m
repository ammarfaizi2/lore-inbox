Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbULBSIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbULBSIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULBSIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:08:44 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:49820 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261687AbULBSIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:08:38 -0500
Date: Thu, 2 Dec 2004 19:08:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041202180823.GD32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041201211638.GB4530@dualathlon.random> <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202085518.58e0e8eb.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 08:55:18AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I believe the thing you're hiding with the callback, is some screwup in
> >  the VM. It shouldn't fire oom 300 times in a row.
> 
> Well no ;)

Could you explain why do we need all_unreclaimable?  What is the point
of all_unreclaimable if we bypass it at priority = 0?  Just to loop a
few times (between DEF_PRIORITY and 1) at 100% cpu load?

OTOH we must not forget 2.4(-aa) calls do_exit synchronously and it
never sends signals. That might be why 2.4 doesn't kill more than one
task by mistake, even without a callback-wakeup. So if we keep sending
signals I certainly agree with Thomas that using a callback to stop the
VM until the task is rescheduled is a good idea, and potentially it may
be even the only possible fix when the oom killer is enabled like in 2.6
(though the 300 kills in between SIGKILL and the reschedule sounds like
the VM isn't even trying anymore).  Otherwise perhaps his workload is
spawning enough tasks, that it takes an huge time for the rechedule
(that would explain it too).

Actually this should fix it too btw:

-	if (p->flags & PF_MEMDIE)
-		return 0;

Thomas can you try the above?

I'd rather fix this by removing buggy code, than by adding additional
logics on top of already buggy code (i.e. setting PF_MEMDIE is a smp
race and can corrupt other bitflags), but at least the
oom-wakeup-callback from do_exit still makes a lot of sense (even if
PF_MEMDIE must be dropped since it's buggy, and something else should be
used instead).

Whatever we change I'd like to change it on top of my last patch that
already removes the 5 seconds fixed waits, and does the right watermark
checks before killing the next task (Thomas already attempted that with
a not accurate nr_free_pages check, so he at least agrees about the need
of checking watermarks before firing up the oom killer).

BTW, checking for pid == 1 like in Thomas's patch is a must, I advocated
it for years but nobody listened yet, hope Thomas will be better at
convincing the VM mainline folks than me.
