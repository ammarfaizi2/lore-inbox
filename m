Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWACWcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWACWcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWACWcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:32:10 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:10624 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932510AbWACWcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:32:09 -0500
Date: Tue, 3 Jan 2006 14:31:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       den@sw.ru, st@sw.ru, Andrew Morton <akpm@osdl.org>
Subject: Re: cpusets: BUG: cpuset_excl_nodes_overlap() may sleep under
 tasklist_lock
Message-Id: <20060103143158.8ab385d0.pj@sgi.com>
In-Reply-To: <43B28996.7060006@sw.ru>
References: <43B28996.7060006@sw.ru>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> FYI, there is an obvious bug in cpusets in 2.6.15-rcX:
> cpuset_excl_nodes_overlap() may sleep (as it takes semaphore), but is 
> called from atomic context - select_bad_process() under tasklist_lock.
> BUG. Found by Denis Lunev.

Sorry for not responding sooner - I was off the air for a week.

Thanks for finding and reporting this.

Apparently, from KUROSAWA Takahiro's report, this bug was also in
2.6.14.  My initial reading of the code in 2.6.14 and 2.6.15-* agrees,
and finds that this bug was present since the cpuset_excl_nodes_overlap
call was added, Sept 8, 2005 (in Linus's tree.)


> the same actually applies to cpuset_zone_allowed() which is called e.g. 
> from __alloc_pages()->get_page_from_freelist() and doesn't check for 
> GPF_NOATOMIC anyhow...

I don't think so.  Please read the comments in kernel/cpuset.c above
the routine cpuset_zone_allowed().  Either that routine is called with
the __GFP_HARDWALL flag set, so returns before it gets to the semaphore
call, or it is not called at all, due to the check for ATOMIC (!wait)
in mm/page_alloc.c.

I don't see any bugs like this, in the cpuset_zone_allowed code path.


==> My initial analysis - I have one bug, in the oom_kill path,
    where the code takes callback_sem while holding tasklist_ lock,
    that has been in the main line kernel since 2.6.14.

My first guess is that it will take me about a week, with testing and
other priorities (including a few more days vacation), to respond with a
patch.  Speak up if that doesn't meet your needs.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
