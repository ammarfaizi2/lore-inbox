Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUG1UyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUG1UyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUG1UyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:54:02 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:12994 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S263736AbUG1Uwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:52:33 -0400
Date: Wed, 28 Jul 2004 16:52:11 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Scott Wood <scott@timesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040728205211.GC6685@yoda.timesys>
References: <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040722185308.GC4774@yoda.timesys> <20040722194513.GA32377@nietzsche.lynx.com> <20040728064547.GA16176@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728064547.GA16176@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:45:47AM +0200, Ingo Molnar wrote:
> i have another worry with the 'everything is a mutex' concept. Currently
> we still do have a number of 'central' locks such as dcache_lock, or the
> SLAB locks. So even if all (but the scheduling) spinlocks are converted
> to sleeping mutexes what do you gain? A high-prio RT task will get to
> execute userspace instructions almost immediately, but any kernel
> functionality use of this RT thread might still be blocked by a priority
> inversion problem. So the same type of latency problems that we are
> detecting and solving currently will occur on a mutex-based system as
> well - if the RT application wants to use kernel functionality.

The difference is that latency issues are isolated to code which uses
the locks with bad critical sections.  If some random driver holds an
internal lock for a few milliseconds, it won't slow down anything
that doesn't interact with the driver (either directly or by blocking
on something else that interacts with the driver).  Turning the
spinlocks into mutexes doesn't eliminate the need for lock-breaking;
it just lets the lock-breaking effort be concentrated on the core
mutexes, so you don't need to fix *all* of the bad critical sections
to see a reduction in worst case latency of common code.

Those critical sections where lock-breaking has been done can be
converted back into spinlocks.  Essentially, mutexes would be used
for "untrusted" locks, as opposed to using spinlocks just where
they're absolutely necessary.  Over time, the set of trusted locks
would presumably go up, though we'd have to be careful to make sure
people know that they need to be especially careful of latency issues
when they touch code that uses such locks.

One of the main benefits is that it significantly increases the RT
guarantees for those users for whom the RT portion of their app can
be verified as only using a limited, testable/auditable subset of
kernel paths.  Otherwise, you run the risk of some special code path
(such as out-of-memory, perhaps) that didn't get hit in latency
testing showing up and causing problems for a RT task that doesn't
need memory, and doesn't go anywhere near the lock in question.  How
much this matters depends on how hard the RT one needs is.

Another is that the observed latencies of many apps is likely to go
down faster than when squashing each individual latency in the system
as it shows up.  Said squashing can (and should) still occur, but at
least some apps will not have to wait.

-Scott
