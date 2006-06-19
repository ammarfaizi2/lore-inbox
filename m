Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWFSJNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWFSJNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWFSJNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751257AbWFSJNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:13:21 -0400
Date: Mon, 19 Jun 2006 02:13:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to
 1 min
Message-Id: <20060619021314.a6ce43f5.akpm@osdl.org>
In-Reply-To: <20060619083518.GA14265@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
	<20060617100710.ec05131f.akpm@osdl.org>
	<20060619070229.GA8293@elte.hu>
	<20060619005955.b05840e8.akpm@osdl.org>
	<20060619081252.GA13176@elte.hu>
	<20060619013238.6d19570f.akpm@osdl.org>
	<20060619083518.GA14265@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 10:35:18 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > OK.  That sucks.  A sufficiently large machine with the right mix of 
> > latencies will get hit by the NMI watchdog in write_lock_irq().
> > 
> > But presumably the situation is much worse with CONFIG_DEBUG_SPINLOCK 
> > because of that __delay().
> > 
> > So how about we remove the __delay() (which is wrong anyway, because 
> > loops_per_jiffy isn't calculated with a write_trylock() in the loop 
> > (which means we're getting scarily close to the NMI watchdog at 
> > present)).
> > 
> > Instead, calculate a custom loops_per_jiffy for this purpose in 
> > lib/spinlock_debug.c?
> 
> hm, that would be yet another calibration loop with the potential to be 
> wrong (and which would slow down the bootup process).

We should be able to do it in two jiffies, max.

> If loops_per_jiffy 
> is wrong then our timings are toast anyway.

loops_per_jiffy measures how long we can run __delay(), which is basically
two rdtsc's (x86_64).  But in __write_lock_debug() we're also doing a
failed write_trylock(), so it'll take more than a second.  Perhaps a lot
more, depending on relative speeds, and whether the lock is exclusive-owned
in another CPU (it often will be).

...  which means that calculating loops_per_jiffy_for_write_lock_debug will
be hard - need to have N other CPUs simultaneously hammering the lock for
reading (!)

Maybe we just shouldn't enable this code if the CPU doesn't have an
rdtsc-like thingy we can get at.

> I think increasing the timeout to 60 secs ought to be enough - 1 sec was 
> a bit too close to valid delays and i can imagine really high loads 
> causing 1 sec delays (especially if something like SysRq-T is holding 
> the tasklist_lock for long).

No way can _this_ workload be taking the lock for anything like that amount
of time.  We have

- one CPU taking the lock for reading, looking to see if a page is in
  pagecache.

- the same CPU taking the lock for writing, adding pages to pagecache. 
  This is infrequent on average because we need to modify the contents of
  each page.

- one CPU perhaps taking the lock for writing running page reclaim at the
  same average rate as the rate of pagecache consumption.  Also slow.

Each of these code paths are really short, and relatively infrequent. 
There's just no way that a write_lock on tree_lock should be taking a
second (more than a second, but we don't know how much more).

Surely something is busted.

> The write_trylock + __delay in the loop is not a problem or a bug, as 
> the trylock will at most _increase_ the delay - and our goal is to not 
> have a false positive, not to be absolutely accurate about the 
> measurement here.

Precisely.  We have delays of over a second (but we don't know how much
more than a second).  Let's say two seconds.  The NMI watchdog timeout is,
what?  Five seconds?

That's getting too close.  The result will be a total system crash.  And RH
are shipping this.

