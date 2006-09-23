Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWIWOXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWIWOXV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 10:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWIWOXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 10:23:21 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:20664 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751198AbWIWOXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 10:23:21 -0400
Date: Sat, 23 Sep 2006 15:21:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
In-Reply-To: <20060920105317.7c3eb5f4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609231421110.25804@blonde.wat.veritas.com>
References: <1158274508.14473.88.camel@localhost.localdomain>
 <20060915001151.75f9a71b.akpm@osdl.org> <45107ECE.5040603@google.com>
 <1158709835.6002.203.camel@localhost.localdomain>
 <1158710712.6002.216.camel@localhost.localdomain> <20060919172105.bad4a89e.akpm@osdl.org>
 <1158717429.6002.231.camel@localhost.localdomain> <20060919200533.2874ce36.akpm@osdl.org>
 <1158728665.6002.262.camel@localhost.localdomain> <20060919222656.52fadf3c.akpm@osdl.org>
 <1158735299.6002.273.camel@localhost.localdomain> <20060920105317.7c3eb5f4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 14:21:36.0177 (UTC) FILETIME=[93B39A10:01C6DF1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Andrew Morton wrote:
> On Wed, 20 Sep 2006 16:54:59 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > That's what I don't understand... where is the actual race that can
> > cause the livelock you are mentioning.
> 
> Suppose a program (let's call it "DoS") is written which sits in a loop
> doing fadvise(FADV_DONTNEED) against some parts of /lib/libc.so.

I agree there's an issue here, but I believe you're attacking the wrong
end, thereby complicating and uglifying the pagefault path (in every
arch) with your proposed arg block and retry limitation.

(Maybe one day there will be need for such an arg block,
but I don't see that yet.)

Isn't the real problem that fadvise(FADV_DONTNEED) is much more
powerful than it should be?  Whereas madvise(MADV_DONTNEED) is simply
releasing pages from my address space, fadvise(FADV_DONTNEED) is going
so far as to remove them from pagecache (if nothing at that instant
prevents): forcing others into I/O.  Why should I be allowed to
invalidate pagecache useful to others so quickly?

Shouldn't it merely, say, move the pages in its range to the inactive
list, giving other processes a chance to reassert an interest in them?
May not turn out as easy as that, I admit.

I'm fine with your idea of dropping mmap_sem while nopage waits on I/O,
I'm fine with your idea of an mm mmap transaction count, so nopage can
just reget mmap_sem without backing out when nothing changed meanwhile.

But I do think Ben should have the simple NOPAGE_RETRY he proposed,
going right back out to userspace; and that should be enough for your
case too (the mmap transaction count would make its use a rarity).

> So I think there's a nasty DoS here if we permit infinite retries.  But
> it's not just that - there might be other situations under really heavy
> memory pressure where livelocks like this can occur.

filemap_nopage would want to mark_page_accessed() before returning
NOPAGE_RETRY, but if that's not good enough to hold the page in cache
before the retried fault grabs it, your memory pressure is already
into thrashing.  I believe the livelock is peculiar to FADV_DONTNEED.

Hugh
