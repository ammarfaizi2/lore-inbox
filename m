Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131753AbRCUTRh>; Wed, 21 Mar 2001 14:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131737AbRCUTR3>; Wed, 21 Mar 2001 14:17:29 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:29571 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131742AbRCUTRL>; Wed, 21 Mar 2001 14:17:11 -0500
Date: Wed, 21 Mar 2001 14:16:26 -0500
To: Josh Grebe <squash@primary.net>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Question about memory usage in 2.4 vs 2.2
Message-ID: <20010321141626.A3621@cs.cmu.edu>
Mail-Followup-To: Josh Grebe <squash@primary.net>,
	linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <001401c0b1ef$cb22f5e0$5517fea9@local> <Pine.LNX.4.32.0103211127510.2260-100000@scarface.primary.net> <20010320183238.B1508@unthought.net> <Pine.LNX.4.21.0103201156070.2405-100000@scarface.primary.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0103201156070.2405-100000@scarface.primary.net>; from squash@primary.net on Tue, Mar 20, 2001 at 02:29:47PM -0600
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 11:42:08AM -0600, Josh Grebe wrote:
> This is what I'm afraid of, in my case we have millions of files that are
> dealt with in no real order, and if cache fragmentation will keep the
> memory from being freed, we're in for problems. This reading was taken
> with the machine having been up for only 5 days. Currently, I show:

You shouldn't worry too much about fragmentation within the slabcache.
It actually is designed to limit the amount of fragmentation. And the
next 100000 dentry/inode allocations will come at no cost ;)

The fact that your icache/dcache slabs are not 100% used indicates that
shrink_i/dcache_memory actually was triggered a couple of times due to
free memory shortage. In contrast, on my machine, the available and
allocated numbers are pretty much always identical. I'm probably not
putting enough VM pressure on the machine so the normal aging/pageout
mechanisms manage to free up just enough memory to avoid dentry/inode
pruning.

> I've had to put my SMTP box back to 2.2 as it was up to 90% memory used,
> where the others were around 18%. I'm keeping the pop/imap server at 2.4
> as 44% is standable, while not exactly desirable. I'm

Did the SMTP box become unusable? Although the VM ends up working with
only the memory that is not locked up in slabs, it does a pretty good
job, as you reported yourself.

On Tue, Mar 20, 2001 at 02:29:47PM -0600, Josh Grebe wrote:
> As far as performance goes, I can only say that my max load is slightly
> lower on the 2.4 box then on the 2.2 boxes. Our average load for yesterday
> on 2.4 was .23, with a max of 1.11. In comparison, my averages for the
> other machines are .27, .27, .23, and .23. The maxes are 1.85, 1.33, 2.06,
> 1.47.
> 
> As far as speed goes, I am not able to measure any real difference (only
> testing pop3) between 2.2 and 2.4. I would blame this on the NAS device, a
> NetApp Filer F760 being only able to push about 110mbit sustained on the
> gig-e network.

Doing an (intuitive) cost/benefit analysis, throwing out an inode does
not guarantee to free up any memory. While throwing out clean pages from
the pagecache will free up some memory and they do not necessarily have
to be read back in at all (otherwise they would have been 'active').

I've been thinking about this a bit and one possible solution would be
to significantly lower the cost of prune_icache by removing the
sync_all_inodes and only let it prune inodes that do not have any
mappings associated with them. Then it might become possible to call it
more frequently, like every time we hit do_try_free_pages.

If there is enough memory available in the system, the inodes will have
mappings and won't be removed. Once memory pressure builds up the
mappings are cleaned and pruned, by the VM system and removing the
remains of the inode should be relatively inexpensive. There is probably
something that I missed, so I should just shut up now and write the code.

Jan

