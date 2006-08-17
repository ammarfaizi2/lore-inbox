Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWHQWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWHQWSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWHQWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:18:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41383 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964970AbWHQWSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:18:14 -0400
Date: Fri, 18 Aug 2006 08:17:17 +1000
From: David Chinner <dgc@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow writeback.
Message-ID: <20060817221717.GV51703024@melbourne.sgi.com>
References: <17633.2524.95912.960672@cse.unsw.edu.au> <20060815010611.7dc08fb1.akpm@osdl.org> <20060815230050.GB51703024@melbourne.sgi.com> <17635.60378.733953.956807@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17635.60378.733953.956807@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 02:08:58PM +1000, Neil Brown wrote:
> On Wednesday August 16, dgc@sgi.com wrote:
> > 
> > IMO, if you've got slow writeback, you should be reducing the amount
> > of dirty memory you allow in the machine so that you don't tie up
> > large amounts of memory that takes a long time to clean. Throttle earlier
> > and you avoid this problem entirely.
> 
> I completely agree that 'throttle earlier' is important.  I just not
> completely sure what should be throttled when.
> 
> I think I could argue that pages in 'Writeback' are really still
> dirty.  The difference is really just an implementation issue.

No argument here - I think you're right, Neil.

> So when the dirty_ratio is set to 40%, that should apply to all
> 'dirty' pages, which means both that flagged as 'Dirty' and those
> flagged as 'Writeback'.

Don't forget NFS client unstable pages.

FWIW, with writeback not being accounted as dirty, there is a window
in the NFS client where a page during writeback is not dirty or
unstable and hence not visible to the throttle. Hence if we have
lots of outstanding async writes to NFS servers, or their I/O
completion is held off, the throttle won't activate where is should
and potentially let too many pages get dirtied.

This may not be a major problem with the traditional small write
sizes, but with 1MB I/Os this could be a fairly large number of
pages that are unaccounted for a short period of time.

> So I think you need to throttle when Dirty+Writeback hits dirty_ratio
> (which we don't quite get right at the moment).  But the trick is to
> throttle gently and fairly, rather than having a hard wall so that any
> one who hits it just stops.

I disagree with the "throttle gently" bit there. If a process is
writing faster than the underlying storage can write, then you have
to stop the process in it's tracks while the storage catches up.
Especially if other processes are writing tothe same device. You
may as well just hit it with a big hammer becauses it's simple and
pretty effective.

Besides, it is difficult to be gentle when you can dirty memory at
least an order of magnitude faster than you can clean it.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
