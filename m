Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbULEA1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbULEA1o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbULEA1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:27:44 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:30342 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261207AbULEA1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:27:40 -0500
Date: Sun, 5 Dec 2004 01:27:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Voluspa <lista4@comhem.se>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041205002736.GE13244@dualathlon.random>
References: <200412041242.iB4CgsN07246@d1o408.telia.com> <20041204164353.GE32635@dualathlon.random> <1102185205.13353.309.camel@tglx.tec.linutronix.de> <1102194124.13353.331.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102194124.13353.331.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 10:02:03PM +0100, Thomas Gleixner wrote:
> On Sat, 2004-12-04 at 19:33 +0100, Thomas Gleixner wrote:
> >
> > I added some debug output and it calls __alloc_pages a couple of times.
> > All those calls get out from the first goto got_pg as expected.
> > 
> > I will try to add some more debug later
> > 
> 
> Your assumption that reverting the 
> 
> -       might_sleep_if(wait);
> +       if (wait)
> +               cond_resched();
> 
> change does solve the problem is correct. Looking at the diffs its the
> only change which can have any influence at this point.
> 
> Mats. I don't understand why this did not work for you. The change has
> to be reverted to the original line "might_sleep_if(wait)" !

Ok, so some piece of code is buggy: somebody is using GFP_KERNEL instead
of GFP_ATOMIC.  Reverting my change will only hide the real bug so I
wouldn't recommend it (except for testing purposes).

Would be very nice to find the real bug.

> It then works so far except that it kills the wrong process (sshd), but
> I did expect that from the previous experience. 
> 
> There is no multi kill or other strange things happening. I tested it
> with hackbench and the real application _after_ adding my "whom to kill
> patch" on top.
> 
> Looks much better now. 

So you mean there's a separate issue with the task selection right? I
didn't touch the task selection at all.

> Can you agree to add the selection patch, which takes the multi child
> forking process into account ? I don't explain again why it makes
> sense :)

I didn't recall that part of your patch, but it seems very orthogonal. I
didn't want to change the process selection at the same time. If I will
touch the task selection I'll probably rewrite it from scratch to choose
tasks only in function of the allocation rate, sure not with anything
similar to the current algorithm which is close to a DoS with big
database servers if some other smaller app hits a memleak and allocates
in a loop.
