Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267695AbUHRUtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267695AbUHRUtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUHRUtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:49:41 -0400
Received: from holomorphy.com ([207.189.100.168]:19641 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267695AbUHRUtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:49:05 -0400
Date: Wed, 18 Aug 2004 13:48:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Lameter <clameter@sgi.com>,
       "David S. Miller" <davem@redhat.com>, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for 8,32     and    512 cpu SMP
Message-ID: <20040818204838.GE11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ray Bryant <raybry@sgi.com>, Hugh Dickins <hugh@veritas.com>,
	Christoph Lameter <clameter@sgi.com>,
	"David S. Miller" <davem@redhat.com>, ak@muc.de,
	benh@kernel.crashing.org, manfred@colorfullife.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fa.ofiojek.hkeujs@ifi.uio.no> <fa.o1kt2ua.1bm6n0c@ifi.uio.no> <4123B873.4010403@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4123B873.4010403@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
>> Just handling that one anonymous case is not worth it, when we know
>> that the next day someone else from SGI will post a similar test
>> which shows the same on file pages ;)

On Wed, Aug 18, 2004 at 03:13:39PM -0500, Ray Bryant wrote:
> Hugh -- this is called full employment for kernel scalability analysts.
> :-) :-)
> Actually, disks are so slow that I wouldn't expect that scalability problem 
> to show up in the page fault code, but rather in the block I/O or page 
> cache management portions of the code instead.

mapping->tree_lock is a near-certain culprit-to-be.


On Wed, Aug 18, 2004 at 03:13:39PM -0500, Ray Bryant wrote:
> I think that the major impact here is actually grabbing the lock when
> 30 or more processors are trying to obtain it -- the amount of time that 
> the lock is actually held is insignificant in comparison.

The spinlocking algorithms in general use are rather weak. Queued locks
with O(contenders) cacheline transfers instead of unbounded may be
useful in such arrangements so that occasional contention is not so
catastrophic, and it appears you certainly have the space for them.
In general, everyone's favored rearranging algorithms for less
contention instead of fiddling with locking algorithms, but I suspect
in the case of such large systems the number of nontrivial algorithms
to devise is daunting enough locking algorithms may mitigate the issues.


Hugh Dickins wrote:
>> The main lesson I took from your patch (I think wli was hinting at
>> the same) is that we ought now to question page_table_lock usage,
>> should be possible to cut it a lot.

On Wed, Aug 18, 2004 at 03:13:39PM -0500, Ray Bryant wrote:
> That would be a useful avenue to explore.  Unfortunately, we are on kind of 
> a tight fuse here trying to get the next kernel release ready.   At the 
> moment we are in the mode of moving fixes from 2.4.21 to 2.6, and this is 
> one such fix.   I'd be willing to pursue both in parallel so that in a 
> future release
> we have gotten to page_table_lock reduction as well.  Does that make sense 
> at all?
> (I just don't want to get bogged down in a 6-month effort here unless we 
> can't avoid it.)

Scalability issues with fault handling have trivial enough hardware
requirements that it's likely feasible for others to work on it also.
Also fortunate for you is that others also have issues here, and those
on much smaller systems.


Hugh Dickins wrote:
>> I do think this will be a more fruitful direction than pte locking:
>> just looking through the arches for spare bits puts me off pte locking.

On Wed, Aug 18, 2004 at 03:13:39PM -0500, Ray Bryant wrote:
> The original patch that we had for 2.4.21 did exactly that, we shied away 
> from that due to concerns as to which processors allow you to update a 
> running pte using a cmpxchg (== the set of processors for which set_pte() 
> is a simple store.)  AFAIK, the only such processor is i386, but if 
> Christoph is correct, then more recent Intel x86 processors don't even have 
> that restriction.  I'll admit that I encouraged Christoph not to follow 
> that path due to concerns of arch dependent code creeping into the 
> do_anonymous_page() path.

I'm in general more concerned about how one synchronizes with TLB miss
handlers, particularly for machines where this would involve the TLB
miss handler looping until a valid value is fetched in what is now a
very highly optimized performance-critical codepath.


-- wli
