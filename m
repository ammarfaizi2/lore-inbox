Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVCWPwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVCWPwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVCWPwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:52:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64173 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261646AbVCWPwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:52:19 -0500
Date: Wed, 23 Mar 2005 16:51:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org, sebastien.godard@wanadoo.fr
Subject: Re: Patch for inconsistent recording of block device statistics
Message-ID: <20050323155150.GE16149@suse.de>
References: <42409313.1010308@hp.com> <20050323091916.GO24105@suse.de> <42417FE3.2090506@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42417FE3.2090506@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2005, Mark Seger wrote:
> 
> >I don't like this patch, it adds 4 * sizeof(unsigned long) to struct
> >request when it can be solved without adding anything. The idea is
> >sound, though, the current way the stats are done isn't very
> >interesting.
> > 
> >
> Actually I wasn't all that excited about using the extra variable 
> myself.  However, I wasn't entirely sure what was going on and this at 
> least allowed me to test the concept without doing anything harmful. 
> 
> >How about accounting merges the way we currently do it, since that piece
> >of the stats _is_ interesting at queueing time. And then account
> >completion in __end_that_request_first(). Untested patch attached.
> > 
> >
> I also agree with your suggestion about keeping the merged counts where 
> they are and am copying the author of iostat to suggest the man page be 
> updated to reflect the fact that merges are counts for requests queued 
> rather than 'issued to the device' as it currently states.
> 
> re: your patch - I did try it on both an Operton and Xeon box.  It 
> worked find on the Opeteron and reported 0 for all the sectors on the 
> Xeon.  If nothing immediately jumps to your mind could it have been 
> something I did wrong?  I'll try another build after I send this along, 
> but I don't see how that will help as I did the first one from a brand 
> new source kit.

Sounds very strange, it is generic code so should work for all.
Different storage?

> The one thing that still jumps out at me about this patch is that the 
> sectors are being counted in one routine and the number of I/Os in 
> another.  If the best place to update the sector counts is indeed where 
> you suggest doing it, is there any reason not to move the update code 
> for all the disk stats from end_that_request_last() to that same place 
> as well for consistency and for better assurances that they are updated 
> as close to the same point in time as possible?

The reason that the sector counting is done in end_that_request_first()
is that it may not be valid in end_that_request_last().
end_that_request_first() may be invoked several times for a single
request, so I did not move the 'number of io count' there as well as
that would require additional tracking in the request. But
end_that_request_last() will in 99.9% of the cases be called _right_
after end_that_request_first(), so I think it should work fine. The
cases where that doesn't happen is for partial io completions.

-- 
Jens Axboe

