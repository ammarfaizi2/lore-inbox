Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbULEOza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbULEOza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 09:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULEOza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 09:55:30 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57728
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261310AbULEOzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 09:55:16 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Voluspa <lista4@comhem.se>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041205002736.GE13244@dualathlon.random>
References: <200412041242.iB4CgsN07246@d1o408.telia.com>
	 <20041204164353.GE32635@dualathlon.random>
	 <1102185205.13353.309.camel@tglx.tec.linutronix.de>
	 <1102194124.13353.331.camel@tglx.tec.linutronix.de>
	 <20041205002736.GE13244@dualathlon.random>
Content-Type: text/plain
Date: Sun, 05 Dec 2004 15:55:07 +0100
Message-Id: <1102258507.13353.366.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 01:27 +0100, Andrea Arcangeli wrote:
> On Sat, Dec 04, 2004 at 10:02:03PM +0100, Thomas Gleixner wrote:
> > On Sat, 2004-12-04 at 19:33 +0100, Thomas Gleixner wrote:

> Ok, so some piece of code is buggy: somebody is using GFP_KERNEL instead
> of GFP_ATOMIC.  Reverting my change will only hide the real bug so I
> wouldn't recommend it (except for testing purposes).
> 
> Would be very nice to find the real bug.

Hmm, most of the allocations in early init have the GFP_WAIT bit set.
When I block the call to cond_resched() up to cpu_idle() in rest_init()
everything works. Enabling the call to cond_resched() at any place
before brings the problem back.

> So you mean there's a separate issue with the task selection right? I
> didn't touch the task selection at all.

I know.

> > Can you agree to add the selection patch, which takes the multi child
> > forking process into account ? I don't explain again why it makes
> > sense :)
> 
> I didn't recall that part of your patch, but it seems very orthogonal. I

Yes, the modification are not interfering with your patch. They just add
the accounting of child processes to the selection.

> didn't want to change the process selection at the same time. If I will
> touch the task selection I'll probably rewrite it from scratch to choose
> tasks only in function of the allocation rate, 

That makes sense, but it does not catch processes forking a lot of
childs, because the allocation rate is not accounted to the parent.

> sure not with anything
> similar to the current algorithm which is close to a DoS with big
> database servers if some other smaller app hits a memleak and allocates
> in a loop.

The comment above badness() is the best part of it, especially the
"least surprise part" :)

 * 5) we try to kill the process the user expects us to kill, this
 *    algorithm has been meticulously tuned to meet the principle
 *    of least surprise ... (be careful when you change it)

tglx


