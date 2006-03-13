Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWCMNWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWCMNWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWCMNV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:21:59 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:42430 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751054AbWCMNV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:21:57 -0500
Date: Mon, 13 Mar 2006 14:21:51 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <20060312220218.GA3469@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603131130460.25211-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006, Ingo Molnar wrote:

> i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> again, lots of changes all over the map:
>
> - firstly, the -rt tree has been rebased to 2.6.16-rc6, which was a more
>   complex operation than usual, due to the many changes in 2.6.16 (in
>   particular the mutex code).
>
> - the PI code got reworked again, this time by Thomas Gleixner. The
>   priority boosting chain is now instantaneous again (and not
>   wakeup/scheduling based) - but the previous list-walking hell has been
>   avoided via the clever use of plists. Plus many other changes and
>   lots of cleanups to the rt-mutex proper.

Hi,
 I briefly looked at the PI code. Looks fine. I will try it on my
rt-mutex testbed soonish.

However, I notice it re-introduces long latencies :-(
The problem is that the time need in adjust_prio_chain is proportional to
the lock depth and the function is called with two raw spinlocks held.
This is no problem when the locks are in the kernel and thus not very
deeply nested, but when it is exposed to futexes there is a problem as
Joe user can increase the task latency of the system by crafting deep
locking structures in userspace.

I will be on paternity leave soonish. I might get time solve it as I
originally suggested some months back when my daughter is asleep. The
solution I suggested last fall, includes releasing _all_ locks at each
iteration in the loop in adjust_prio_chain such that higher priority
tasks gets a chance to run. To avoid having tasks released in the middle
get/put_tast_struct() are needed. That will cost extra atomic
instructions compared to the present implementation. Are people prepared
to pay that price? I am not talking about the scheduler based solution;
just doing the PI iteration in a little different (and slightly more
epensive) way.

Esben

