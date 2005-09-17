Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVIQCHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVIQCHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 22:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIQCHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 22:07:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48778 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750830AbVIQCG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 22:06:59 -0400
Date: Sat, 17 Sep 2005 04:06:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050915104535.6058bbda.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0509170350200.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org> <20050912075155.3854b6e3.pj@sgi.com>
 <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com>
 <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com>
 <Pine.LNX.4.61.0509141446590.3728@scrub.home> <20050914124642.1b19dd73.pj@sgi.com>
 <Pine.LNX.4.61.0509150116150.3728@scrub.home> <20050915104535.6058bbda.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Paul Jackson wrote:

> > > 	if (atomic_read(&cs->count) == 1 && notify_on_release(cs)) {
> 
> if per chance the cs->count was one, then for an instant no other task
> was using this cpuset, and it had no children.  But you can still get
> to the cpuset via its /dev/cpuset path.
> 
> So by the time we get to the second half of this line where we check
> for "notify_on_release(cs)", all hell could have broken loose, and
> there might be 17 tasks using this self same cpuset, and 19 child
> cpusets of this cpuset.  These interlopers. could have arrived by
> accessing the cpuset using its path below /dev/cpuset.

Define "using", as long as the count is different from the cpuset is 
active and the possible actions on it are limited.

> The flip side is just as plausible.  We cannot, in any case, execute an
> unguarded atomic_dec on cpuset->count, if that cpuset has been marked
> notify_on_release, and if that cpuset is accessible by any of the
> above three possible ways, due to the risk the decrement will put the
> count to zero, and we'd miss issuing a release notifier.

No, as long as you own the cpuset (i.e. increased count) no one else can 
take it away from you (without proper locking). So once you get the 
locking right, the rest will fall in place. :-)

> Putting that part aside, why would you make a point of stating that
> "that clearing tsk->cpuset doesn't require the spinlock"?  I don't
> take cpuset_sem when I clear tsk->cpuset, so why would you think I'd
> take this new spinlock instead?

But you take task_lock currently, which is replaced by the new spinlock.
In general _any_ access to tsk->cpuset is protected by the spinlock.

bye, Roman
