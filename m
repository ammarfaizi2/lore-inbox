Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUCTMXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbUCTMXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:23:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59073
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263389AbUCTMXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:23:20 -0500
Date: Sat, 20 Mar 2004 13:24:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040320122411.GB9009@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org> <s5hbrmuc6ed.wl@alsa2.suse.de> <20040318221006.74246648.akpm@osdl.org> <20040319172203.GB4537@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319172203.GB4537@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 10:52:03PM +0530, Dipankar Sarma wrote:
> On Thu, Mar 18, 2004 at 10:10:06PM -0800, Andrew Morton wrote:
> > The worst-case latency is during umount, fs/inode.c:invalidate_list() when
> > the filesystem has a zillion inodes in icache.  Measured 250 milliseconds
> > on a 256MB 2.7GHz P4 here.   OK, so don't do that.
> > 
> > The unavoidable worst case is in the RCU callbacks for dcache shrinkage -
> > I've seen 25 millisecond holdoffs on the above machine during filesystem
> > stresstests when RCU is freeing a huge number of dentries in softirq
> > context.
> 
> What filesystem stresstest was that ? 
> 
> > 
> > This if Hard To Fix.  Dipankar spent quite some time looking into it and
> > had patches, but I lost track of where they're at.
> 
> And I am still working on this on a larger scope/scale. Yes, I have
> a patch that hands over the rcu callbacks to a per-cpu kernel thread
> reducing the softirq time. However this is not really a solution to

why a per-cpu kernel thread when you can use a softirq?

> the overall problem, IMO. I am collecting some instrumentation
> data to understand softirq/rcu behavior during heavy loads and
> ways to counter long running softirqs.
> 
> Latency isn't the only issue. DoS on route cache is another
> issue that needs to be addressed. I have been experimenting
> with Robert Olsson's router test and should have some more results
> out soon.

why don't you simply interrupt rcu_do_batch after a dozen of callbacks?
if it gets interrupted you then go ahead and you splice the remaining
entries into another list for a tasklet, then the tasklet will be a
reentrant one, so the ksoftirqd will take care of the latency.

the only valid reason to use the timer irq instead of the tasklet in the
first place is to delay the rcu invocation and coalesce the work
together, but if there's too much work to do you must go back to the
tasklet way that has always been scheduler-friendy.
