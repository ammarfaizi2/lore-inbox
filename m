Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbVIORqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbVIORqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVIORqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:46:06 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61658 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030555AbVIORqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:46:05 -0400
Date: Thu, 15 Sep 2005 10:45:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050915104535.6058bbda.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0509150116150.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
	<Pine.LNX.4.61.0509141446590.3728@scrub.home>
	<20050914124642.1b19dd73.pj@sgi.com>
	<Pine.LNX.4.61.0509150116150.3728@scrub.home>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman wrote:
> Sorry, I thought it was more obvious... :)

Likely it was obvious.  On the other hand, I wouldn't be in this mess
if I understood everything I should here.

Most of what you wrote this time actually made sense to me as I read
it.  Thanks for taking the time.

One part left to discuss and then I will put this aside for a few
days while I focus on my day job.


Roman, replying to pj:
> > > I don't think that works at all.  Consider the following sequence:
> > > 	1) ...
> > > 	4) Oops - we just missed doing a release.
> > 
> > If you want to do it like this, just add an else before the last 
> > atomic_dec().
> > The main point I was trying to make is that clearing tsk->cpuset doesn't 
> > require the spinlock, as long as you check for dead tasks in 
> > attach_task(). Ignore the rest if it's too confusing.

I don't think confusion is the problem here.  I think your proposal was
wrong.

There are *three* ways to get to a cpuset:
 1) via some task->cpuset pointer, 
 2) via that cpuset's path below /dev/cpuset, and
 3) walking up the parent chain from a child.

In the first half of your line:

> > 	if (atomic_read(&cs->count) == 1 && notify_on_release(cs)) {

if per chance the cs->count was one, then for an instant no other task
was using this cpuset, and it had no children.  But you can still get
to the cpuset via its /dev/cpuset path.

So by the time we get to the second half of this line where we check
for "notify_on_release(cs)", all hell could have broken loose, and
there might be 17 tasks using this self same cpuset, and 19 child
cpusets of this cpuset.  These interlopers. could have arrived by
accessing the cpuset using its path below /dev/cpuset.

The flip side is just as plausible.  We cannot, in any case, execute an
unguarded atomic_dec on cpuset->count, if that cpuset has been marked
notify_on_release, and if that cpuset is accessible by any of the
above three possible ways, due to the risk the decrement will put the
count to zero, and we'd miss issuing a release notifier.

Actually, even the single check that is in the code now:

        if (notify_on_release(cs)) {

would be bogus if we required instruction level synchronization, but it
is racing on an attribute set by some poor schlob user, so the kernel
need only preserve ordering at the system call level, not at the machine
instruction level.

Putting that part aside, why would you make a point of stating that
"that clearing tsk->cpuset doesn't require the spinlock"?  I don't
take cpuset_sem when I clear tsk->cpuset, so why would you think I'd
take this new spinlock instead?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
