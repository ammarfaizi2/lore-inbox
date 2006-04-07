Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWDGCzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWDGCzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 22:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWDGCzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 22:55:21 -0400
Received: from alt.aurema.com ([203.217.18.57]:10606 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S932298AbWDGCzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 22:55:20 -0400
Date: Fri, 7 Apr 2006 12:55:05 +1000
From: kingsley@aurema.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Roger Heflin <rheflin@atipa.com>,
       "'linux mailing-list'" <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
Message-ID: <20060407025504.GF20522@aurema.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Roger Heflin <rheflin@atipa.com>,
	"'linux mailing-list'" <linux-kernel@vger.kernel.org>
References: <442AEB3A.9030503@tmr.com> <EXCHG2003g3Sv0YKpDS000000d0@EXCHG2003.microtech-ks.com> <4432C8E6.6010301@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4432C8E6.6010301@tmr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 03:28:38PM -0400, Bill Davidsen wrote:
> Roger Heflin wrote:
> > 
> >
> >>A process has no control over its RSS size, only its virtual 
> >>size. I'm not sure you're clear on that, or just not saying 
> >>it clearly. Therefore the same process, say a largish perl 
> >>run, may be 175mB in vsize, and during the day have rss of 
> >>perhaps half that. At night, with next to no load on the 
> >>machine, the rss is 175mB because there is a bunch of free 
> >>memory available.
> >>
> >>If you want to make rss a hard limit the result should be 
> >>swapping, not failure to run. I'm not sure the limit in that 
> >>form is a good idea, and before someone reminds me, I do 
> >>remember liking it better a few years ago.
> >
> >working_set_size limits sucked on VMS.  The OS would limit a process to
> >its working set size and casue the entire machine to swap
> >even though there was adequate free memory.   I believe they
> >had a normalworkingset size variable, and a maxworkingsetsize
> >one indicated how much ram you could get on a memory limited 
> >system, the other indicated the most it would ever let you get even if
> >there was plenty of free ram.   The maxworkingsetsize caused
> >a lot of issues, as the default appeared to be defined for
> >much smaller systems that we were using at the time, and so
> >were much too low, and cause unnecessary swapping.  Part of the
> >issue would be that the admin would need to know what he was
> >doing to use the feature, and most don't.
> >
> >The argument from the admins at the time was that this limited
> >the damage to other processes by preventing certain processes
> >from getting too much memory, they ignored the fact that
> >anything swapping (even only the one process) unnecessarly 
> >*KILLED* performance for the entire machine, since swapping
> >is rather expensive on the os.

Apologies for just jumping in, but this is an area of interest to me.

I agree with the above point.  Though perhaps hard limits would be
acceptable if there was mechanism for capping the swapping caused by
hard limits to minimise the effect of swapping on the rest of the
system.

> After thinking about this, I have the opinion that if an RSS limit is 
> working it would be a hard limit. The alternative is a process which 
> gets large and then when memory pressure increases the oversize process 
> either causes a lot of swapping or worse yet ties up a lot of memory if 
> swap rate is limited.
> 
> There are many ways to tune Linux badly, adding one more will not add 
> much to the pain if the default is off. The values available to a normal 
> users might be limited to prevent the most obvious bad choices. Or a 
> corresponding option could be provided to take corrective action for a 
> process with RSS set (to any value) and swap rate high.

A while back, I had a patch for limits for the old 2.4 VM subsystem.
It implemented both hard and soft limits, with the hard limit
corresponding to rlim_max and the soft limit corresponding to
rlim_cur.  

The hard limit was straight forward, serving as an upper cap on the
total RSS of the task.  In contrast the scaled value of the task (soft
limit / RSS) served as an indicator as to the proportional usage of
each address space.  It would be used by VM subsystem to select (via a
bit-search and array look up as for the O(1) scheduler) a victim for
page replacement when memory usage was low.

Anyway, while I'm not for advocating hard limits, my point is that I
think solutions with both soft and hard limits are possible.  We have
two limits after all.  If any experimental work were done, perhaps it
could support both types of limits, permitting people to play with
both and to decide the merits of each.

-- 
		Kingsley
