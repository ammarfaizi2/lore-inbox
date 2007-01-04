Return-Path: <linux-kernel-owner+w=401wt.eu-S964792AbXADLUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbXADLUb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 06:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbXADLUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 06:20:31 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:44212 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964778AbXADLU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 06:20:27 -0500
Date: Thu, 4 Jan 2007 16:54:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-aio@kvack.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070104112455.GA15934@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <459C95FE.1090802@yahoo.com.au> <20070104062622.GB24532@in.ibm.com> <459CA3A3.5090106@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459CA3A3.5090106@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 05:50:11PM +1100, Nick Piggin wrote:
> Suparna Bhattacharya wrote:
> >On Thu, Jan 04, 2007 at 04:51:58PM +1100, Nick Piggin wrote:
> 
> >>So long as AIO threads do the same, there would be no problem (plugging
> >>is optional, of course).
> >
> >
> >Yup, the AIO threads run the same code as for regular IO, i.e in the rare
> >situations where they actually end up submitting IO, so there should
> >be no problem. And you have already added plug/unplug at the appropriate
> >places in those path, so things should just work.
> 
> Yes I think it should.
> 
> >>This (is supposed to) give a number of improvements over the traditional
> >>plugging (although some downsides too). Most notably for me, the VM gets
> >>cleaner ;)
> >>
> >>However AIO could be an interesting case to test for explicit plugging
> >>because of the way they interact. What kind of improvements do you see
> >>with samba and do you have any benchmark setups?
> >
> >
> >I think aio-stress would be a good way to test/benchmark this sort of
> >stuff, at least for a start.
> >Samba (if I understand this correctly based on my discussions with Tridge)
> >is less likely to generate the kind of io patterns that could benefit from
> >explicit plugging (because the file server has no way to tell what the next
> >request is going to be, it ends up submitting each independently instead of
> >batching iocbs).
> 
> OK, but I think that after IO submission, you do not run sync_page to
> unplug the block device, like the normal IO path would (via lock_page,
> before the explicit plug patches).

In the buffered AIO case, we do run sync page like normal IO ... just
that we don't block in io_schedule(), everything else is pretty much 
similar.

In the case of AIO-DIO, the path is like the just like non-AIO DIO, there
is a call to blk_run_address_space() after submission.

> 
> However, with explicit plugging, AIO requests will be started immediately.
> Maybe this won't be noticable if the device is always busy, but I would
> like to know there isn't a regression.
> 
> >In future there may be optimization possibilities to consider when
> >submitting batches of iocbs, i.e. on the io submission path. Maybe
> >AIO - O_DIRECT would be interesting to play with first in this regardi ?
> 
> Well I've got some simple per-process batching in there now, each process
> has a list of pending requests. Request merging is done locklessly against
> the last request added; and submission at unplug time is batched under a
> single block device lock.
> 
> I'm sure more merging or batching could be done, but also consider that
> most programs will not ever make use of any added complexity.

I guess I didn't express myself well - by batching I meant being able to
surround submission of a batch of iocbs with explicit plug/unplug instead
of explicit plug/unplug for each iocb separately. Of course there is no
easy way to do that, since at the io_submit() level we do not know about
the block device (each iocb could be directed to a different fd and not
just block devices). So it may not be worth thinking about.

> 
> Regarding your patches, I've just had a quick look and have a question --
> what do you do about blocking in page reclaim and dirty balancing? Aren't
> those major points of blocking with buffered IO? Did your test cases
> dirty enough to start writeout or cause a lot of reclaim? (admittedly,
> blocking in reclaim will now be much less common since the dirty mapping
> accounting).

In my earlier versions of patches I actually had converted these waits to
be async retriable, but then I came to the conclusion that the additional
complexity wasn't worth it. For one it didn't seem to make a difference 
compared to the other bigger cases, and I was looking primarily at handling
the gross blocking points (say to enable an application to keep device queues
busy) and not making everything asynchronous; for another we had a long
discussion thread waay back about not making AIO submitters exempt from
throttling or memory availability waits.

Regards
Suparna

> 
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

