Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUHRUNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUHRUNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUHRUNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:13:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11944 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267585AbUHRUMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:12:50 -0400
Message-ID: <4123B873.4010403@sgi.com>
Date: Wed, 18 Aug 2004 15:13:39 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Hugh Dickins <hugh@veritas.com>
CC: Christoph Lameter <clameter@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for
 8,32     and    512 cpu SMP
References: <fa.ofiojek.hkeujs@ifi.uio.no> <fa.o1kt2ua.1bm6n0c@ifi.uio.no>
In-Reply-To: <fa.o1kt2ua.1bm6n0c@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

Hugh Dickins wrote:
> On Tue, 17 Aug 2004, Christoph Lameter wrote:
> 
> 

<snip>

> 
> Just handling that one anonymous case is not worth it, when we know
> that the next day someone else from SGI will post a similar test
> which shows the same on file pages ;)
> 

Hugh -- this is called full employment for kernel scalability analysts.
:-) :-)

Actually, disks are so slow that I wouldn't expect that scalability problem to 
show up in the page fault code, but rather in the block I/O or page cache 
management portions of the code instead.

<snip>

> 
>>Introducing the page_table_lock even for a short time makes performance
>>drop to the level before the patch.
> 
> 
> That's interesting, and disappointing.
> 

I think that the major impact here is actually grabbing the lock when
30 or more processors are trying to obtain it -- the amount of time that the 
lock is actually held is insignificant in comparison.

> The main lesson I took from your patch (I think wli was hinting at
> the same) is that we ought now to question page_table_lock usage,
> should be possible to cut it a lot.
> 

That would be a useful avenue to explore.  Unfortunately, we are on kind of a 
tight fuse here trying to get the next kernel release ready.   At the moment 
we are in the mode of moving fixes from 2.4.21 to 2.6, and this is one such 
fix.   I'd be willing to pursue both in parallel so that in a future release
we have gotten to page_table_lock reduction as well.  Does that make sense at 
all?

(I just don't want to get bogged down in a 6-month effort here unless we can't 
avoid it.)

> I recall from exchanges with Dave McCracken 18 months ago that the
> page_table_lock is _almost_ unnecessary in rmap.c, should be possible
> to get avoid it there and in some other places.
> 
> We take page_table_lock when making absent present and when making
> present absent: I like your observation that those are exclusive cases.
> 
> But you've found that narrowing the width of the page_table_lock
> in a particular path does not help.  You sound surprised, me too.
> Did you find out why that was?
>  

See above comment.

> 
>>- One could avoid pte locking by introducing a pte_cmpxchg. cmpxchg
>>seems to be supported by all ia64 and i386 cpus except the original 80386.
> 
> 
> I do think this will be a more fruitful direction than pte locking:
> just looking through the arches for spare bits puts me off pte locking.
>

The original patch that we had for 2.4.21 did exactly that, we shied away from 
that due to concerns as to which processors allow you to update a running pte 
using a cmpxchg (== the set of processors for which set_pte() is a simple 
store.)  AFAIK, the only such processor is i386, but if Christoph is correct, 
then more recent Intel x86 processors don't even have that restriction.  I'll 
admit that I encouraged Christoph not to follow that path due to concerns of 
arch dependent code creeping into the do_anonymous_page() path.

Best Regards,

Ray

raybry@sgi.com

