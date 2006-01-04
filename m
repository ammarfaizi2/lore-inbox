Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWADJXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWADJXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWADJXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:23:10 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:11306 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030184AbWADJXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:23:08 -0500
Message-ID: <43BB94AD.8090909@sw.ru>
Date: Wed, 04 Jan 2006 12:26:05 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: torvalds@osdl.org, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       den@sw.ru, st@sw.ru, Andrew Morton <akpm@osdl.org>
Subject: Re: cpusets: BUG: cpuset_excl_nodes_overlap() may sleep under tasklist_lock
References: <43B28996.7060006@sw.ru> <20060103143158.8ab385d0.pj@sgi.com>
In-Reply-To: <20060103143158.8ab385d0.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>FYI, there is an obvious bug in cpusets in 2.6.15-rcX:
>>cpuset_excl_nodes_overlap() may sleep (as it takes semaphore), but is 
>>called from atomic context - select_bad_process() under tasklist_lock.
>>BUG. Found by Denis Lunev.
> 
> 
> Sorry for not responding sooner - I was off the air for a week.
> 
> Thanks for finding and reporting this.
> 
> Apparently, from KUROSAWA Takahiro's report, this bug was also in
> 2.6.14.  My initial reading of the code in 2.6.14 and 2.6.15-* agrees,
> and finds that this bug was present since the cpuset_excl_nodes_overlap
> call was added, Sept 8, 2005 (in Linus's tree.)
> 
> 
> 
>>the same actually applies to cpuset_zone_allowed() which is called e.g. 
>>from __alloc_pages()->get_page_from_freelist() and doesn't check for 
>>GPF_NOATOMIC anyhow...
> 
> 
> I don't think so.  Please read the comments in kernel/cpuset.c above
> the routine cpuset_zone_allowed().  Either that routine is called with
> the __GFP_HARDWALL flag set, so returns before it gets to the semaphore
> call, or it is not called at all, due to the check for ATOMIC (!wait)
> in mm/page_alloc.c.
> 
> I don't see any bugs like this, in the cpuset_zone_allowed code path.
this piece of code in __alloc_pages():

         if (((p->flags & PF_MEMALLOC) || 
unlikely(test_thread_flag(TIF_MEMDIE)))
                         && !in_interrupt()) {
                 if (!(gfp_mask & __GFP_NOMEMALLOC)) {
nofail_alloc:
                         /* go through the zonelist yet again, ignoring 
mins */
                         page = get_page_from_freelist(gfp_mask, order,
                                 zonelist, 
ALLOC_NO_WATERMARKS|ALLOC_CPUSET);

ALLOC_CPUSET is specified, gfp_mask can be GFP_ATOMIC still and no 
__GFP_HARDWALL. Am I wrong?

Kirill


