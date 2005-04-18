Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVDRV40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDRV40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDRV40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:56:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37823 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261171AbVDRV4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:56:20 -0400
Subject: Re: [Ext2-devel] Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1113847223.14961.141.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113597161.3899.80.camel@localhost.localdomain>
	 <1113847223.14961.141.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 18 Apr 2005 14:56:17 -0700
Message-Id: <1113861377.13550.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 19:00 +0100, Stephen C. Tweedie wrote:

> > > Note that there _is_ some additional complexity here.  It's not entirely
> > > free.  Specifically, if we have other tasks waiting on our provisional
> > > window, then we need to be very careful about the life expectancy of the
> > > wait queues involved, so that if the first task fixes its window and
> > > then deletes it before the waiters have woken up, they don't get
> > > confused by the provisional window vanishing while being waited for.
> 
> > This approach(provisional window) sounds interesting to me, but it's a
> > little more complicated than I thought:(
> 
> Yep.  Once you have other tasks waiting on your window while it's not
> locked, object lifetime becomes a much bigger problem.
> 
> > alloc_new_reservation()
> > retry:
> > lock the tree
> > 	search for a new space start from the given startblock
> > 	found a new space
> > 	if the new space is not a "provisional window" 

> I was thinking rather that we _start_ with the window, and _then_ look
> for new space.
> 

It seems I am lost here.  Could you elaborate more here, please?  What
is "the window" you are referring to here? The old(stale) reservation
window?  I thought we are discussing the algorithm to how to allocate a
new window.

> So we'd start with:
> 
> if we already have a window, 
> 	mark it provisional; 
> else,
> 	do
> 		search for a new window;
> 		if the immediately preceding window is provisional, 
> 			wait for that window;
> 			continue;
> 		allocate the window and mark it provisional;
> 		break
> 
> At this point we have a provisional window, and we know that nobody else
> is going to allocate either in it, or in the empty space following it
> (because if they tried to, they'd bump into our own provisional window
> as their predecessor and would wait for us.)  So even if the window
> doesn't occupy the _whole_ unreserved area, we can still keep searching
> without fear of multiple tasks trying to do so in the same space at the
> same time.
> 
> --Stephen
> 
> 
Hmm...... This thread was to address the latency of holding the global
per-fs reservation lock while scanning the block group bitmap.  And the
whole point of the "provisional window" is to prevent other inodes being
forced to put into other block groups when one inode hold/reserve the
whole block group as a temporary window to do the bitmap scan. I clearly
see it's a win if there are no multiple threads allocating blocks nearby
at the same time. However the whole reservation is there to address the
case where multiple allocations happen at the same time near the same
place. 

With the provisional method, if multiple threads trying to allocate new
windows in the same area, they are still have to wait for other new-
window-allocation-and-bitmap-scan finish. After that the probably will
compete the same window again and again....:(  I am worried that the
latency is not being being improved than before (holding the lock for
bitmap scan), and we have paid extra cpu time or context switches. Also
the changes to the algorithm is no going to be trivial. 

Now we all agree that the right thing to fix the latency is to drop the
lock and then scan the bitmap. Before that we need to reserve the open
window in case someone else is trying to target at the same window.
Question was should we reserve the whole free reservable space or just
the window size we need.  Now that we have explored and discussed so
many possible solutions,  I think the lest evil and less intrusive way
to just lock the small window.  We were worried about in the case the
scanned free bit is not inside the temporary reserved window, it is
possible we have to do many window unlink and link operations on the rb
tree, however this is not avoidable with the provisional window proposal
either.  Probably we could start with that simple proposal first, and if
there are benchmarks shows the cpu usage is really high and a concern,
we could address that later? 

Thanks,
Mingming

