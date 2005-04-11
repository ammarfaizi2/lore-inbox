Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVDKSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVDKSir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVDKSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:38:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39601 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261882AbVDKSid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:38:33 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 11 Apr 2005 11:38:30 -0700
Message-Id: <1113244710.4413.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 12:48 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2005-04-08 at 19:10, Mingming Cao wrote:
> 
> > > It still needs to be done under locking to prevent us from expanding
> > > over the next window, though.  And having to take and drop a spinlock a
> > > dozen times or more just to find out that there are no usable free
> > > blocks in the current block group is still expensive, even if we're not
> > > actually fully unlinking the window each time.
> 
> > Isn't this a rare case? The whole group is relatively full and the free
> > bits are all reserved by other files.
> 
> Well, that's not much different from the case where there _are_ usable
> bits but they are all near the end of the bitmap.  And that's common
> enough as you fill up a block group with small files, for example.  Once
> the bg becomes nearly full, new file opens-for-write will still try to
> allocate in that bg (because that's where the inode was allocated), but
> as it's a new fd we have no prior knowledge of _where_ in the bh to
> allocate, and we'll have to walk it to the end to find any free space. 
> This is the access pattern I'd expect of (for example) "tar xvjf
> linux-2.6.12.tar.bz2", not exactly a rare case.
> 

Okey.

> >   Probably we should avoid trying
> > to make reservation in this block group at the first place
> 
> Not in this case, because it's the "home" of the file in question, and
> skipping to another bg would just leave useful space empty --- and that
> leads to fragmentation.
> 
I agree. We should not skip the home block group of the file.  I guess
what I was suggesting is, if allocation from the home group failed and
we continuing the linear search the rest of block groups, we could
probably try to skip the block groups without enough usable free blocks
to make a reservation. Checking for the number of free blocks left in
the quary bg is a good way, but probably not good enough, since those
free blocks might already being reserved.

> > You are proposing that we hold the read lock first, do the window search
> > and bitmap scan, then once we confirm there is free bit in the candidate
> > window, we grab the write lock and update the tree?  
> 
> No, I'm suggesting that if we need the write lock for tree updates, we
> may still be able to get away with just a read lock when updating an
> individual window.  If all we're doing is winding the window forwards a
> bit, that's not actually changing the structure of the tree.
> 
> > However I am still worried that the rw lock will allow concurrent files
> > trying to lock the same window at the same time. 
> 
> Adding a new window will need the write lock, always.  But with the read
> lock, we can still check the neighbouring windows (the structure is
> pinned so those remain valid), so advancing a window with just that lock
> can still be done without risking overlapping the next window.
> 

Ah.. I see the win with the read lock now: once the a reservation window
is added, updating it (either winding it forward and or searching for a
avaliable window) probably is the majorirty of the operations on the
tree, and using read lock for that should help reduce the latency.

I will work on a patch for Lee to try sometime tonight.

Thanks,

Mingming

