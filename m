Return-Path: <linux-kernel-owner+w=401wt.eu-S932295AbXADGVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbXADGVv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 01:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbXADGVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 01:21:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49865 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295AbXADGVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 01:21:49 -0500
Date: Thu, 4 Jan 2007 11:56:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-aio@kvack.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070104062622.GB24532@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <459C95FE.1090802@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C95FE.1090802@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 04:51:58PM +1100, Nick Piggin wrote:
> Suparna Bhattacharya wrote:
> >On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> 
> >>Plus Jens's unplugging changes add more reliance upon context inside
> >>*current, for the plugging and unplugging operations.  I expect that the
> >>fsaio patches will need to be aware of the protocol which those proposed
> >>changes add.
> >
> >
> >Whatever logic applies to background writeout etc should also just apply
> >as is to aio worker threads, shouldn't it ? At least at a quick glance I
> >don't see anything special that needs to be done for fsaio, but its good
> >to be aware of this anyway, thanks !
> 
> The submitting process plugs itself, submits all its IO, then unplugs
> itself (ie. so the plug is now on the process, rather than the block
> device).
> 
> So long as AIO threads do the same, there would be no problem (plugging
> is optional, of course).

Yup, the AIO threads run the same code as for regular IO, i.e in the rare
situations where they actually end up submitting IO, so there should
be no problem. And you have already added plug/unplug at the appropriate
places in those path, so things should just work. 

> 
> This (is supposed to) give a number of improvements over the traditional
> plugging (although some downsides too). Most notably for me, the VM gets
> cleaner ;)
> 
> However AIO could be an interesting case to test for explicit plugging
> because of the way they interact. What kind of improvements do you see
> with samba and do you have any benchmark setups?

I think aio-stress would be a good way to test/benchmark this sort of
stuff, at least for a start. 
Samba (if I understand this correctly based on my discussions with Tridge)
is less likely to generate the kind of io patterns that could benefit from
explicit plugging (because the file server has no way to tell what the next
request is going to be, it ends up submitting each independently instead of
batching iocbs).

In future there may be optimization possibilities to consider when
submitting batches of iocbs, i.e. on the io submission path. Maybe
AIO - O_DIRECT would be interesting to play with first in this regardi ? 

Regards
Suparna

> 
> Thanks,
> Nick
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

