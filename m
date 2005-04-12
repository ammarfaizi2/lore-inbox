Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVDLGmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVDLGmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVDLGmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:42:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56522 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262017AbVDLGlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:41:35 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
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
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 11 Apr 2005 23:41:27 -0700
Message-Id: <1113288087.4319.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 20:57 +0100, Stephen C. Tweedie wrote:
> Hi,

Hi Stephen, 

> 
> On Mon, 2005-04-11 at 19:38, Mingming Cao wrote:
> > Ah.. I see the win with the read lock now: once the a reservation window
> > is added, updating it (either winding it forward and or searching for a
> > avaliable window) probably is the majorirty of the operations on the
> > tree, and using read lock for that should help reduce the latency.
> 
> Right.  The down side is that for things like a kernel "tar xf", we'll
> be doing lots of small file unpacks, and hopefully most files will be
> just one or two reservations --- so there's little winding forward going
> on.  The searching will still be improved in that case.

Just a side note that "tar xf" should know the file size before
unpacking it.  So it could set the reservation window size large enough
to fit the entire file before doing the file write through ioctl
command.

> Note that this may improve average case latencies, but it's not likely
> to improve worst-case ones.  We still need a write lock to install a new
> window, and that's going to have to wait for us to finish finding a free
> bit even if that operation starts using a read lock.  
> 
Yes indeed. However nothing is free and there are always trade-offs.:) 

By worse case you mean multiple writes trying to allocate blocks around
same area?

But I wonder if the latency saw by Lee belongs to this worst-case: the
latency comes mostly from loop calling find_next_zero_bit() in
bitmap_search_next_usable_block(). Even if we take out the whole
reservation, we still possibility run into this kind of latency: the
bitmap on disk and on journal are extremely inconsistent so we need to
keep searching them both until we find a free bit on both map.

> I'm not really sure what to do about worst-case here.  For that, we
> really do want to drop the lock entirely while we do the bitmap scan.
> 

Hmm...if we drop the lock entirely while scan the bitmap, assuming you
mean drop the read lock, then I am afraid we have to re-check the tree
(require a read or write lock ) to see if the new window space is still
there after the scan succeed. This is probably not very interesting for
the window rotating case.

> That leaves two options.  Hold a reservation while we do that; or don't.
> Holding one poses the problems we discussed before: either you hold a
> large reservation (bad for disk layout in the presence of concurrent
> allocators), or you hold smaller ones (high cost as you continually
> advance the window, which requires some read lock on the tree to avoid
> bumping into the next window.)
> 

Well, we cannot hold a reservation (which need to update the tree)
without a write lock. I guess if we want to improve the average case
latency by replacing the current spin_lock with the read lock for the
new window space searching, we don't have much choice here.

> Just how bad would it be if we didn't hold a lock _or_ a window at all
> while doing the search for new window space?  

I wonder if this is feasible: Walk through the rb tree without a lock?
What if some node is being removed by another thread while we are
walking through the tree and trying to get the next node from it?


Thanks,

Mingming

