Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWIWTqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWIWTqc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIWTqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:46:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751507AbWIWTqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:46:31 -0400
Date: Sat, 23 Sep 2006 12:46:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
Message-Id: <20060923124618.e5ef3a51.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609231421110.25804@blonde.wat.veritas.com>
References: <1158274508.14473.88.camel@localhost.localdomain>
	<20060915001151.75f9a71b.akpm@osdl.org>
	<45107ECE.5040603@google.com>
	<1158709835.6002.203.camel@localhost.localdomain>
	<1158710712.6002.216.camel@localhost.localdomain>
	<20060919172105.bad4a89e.akpm@osdl.org>
	<1158717429.6002.231.camel@localhost.localdomain>
	<20060919200533.2874ce36.akpm@osdl.org>
	<1158728665.6002.262.camel@localhost.localdomain>
	<20060919222656.52fadf3c.akpm@osdl.org>
	<1158735299.6002.273.camel@localhost.localdomain>
	<20060920105317.7c3eb5f4.akpm@osdl.org>
	<Pine.LNX.4.64.0609231421110.25804@blonde.wat.veritas.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 15:21:40 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> On Wed, 20 Sep 2006, Andrew Morton wrote:
> > On Wed, 20 Sep 2006 16:54:59 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 
> > > That's what I don't understand... where is the actual race that can
> > > cause the livelock you are mentioning.
> > 
> > Suppose a program (let's call it "DoS") is written which sits in a loop
> > doing fadvise(FADV_DONTNEED) against some parts of /lib/libc.so.
> 
> I agree there's an issue here, but I believe you're attacking the wrong
> end, thereby complicating and uglifying the pagefault path (in every
> arch) with your proposed arg block and retry limitation.

"simplifying and cleaning up the pagefault path (in every arch) with my
proposed arg block and retry improvement".

We're presently passing from four to six arguments down many layers of
function call.  Can be replaced with a single arg.

> (Maybe one day there will be need for such an arg block,
> but I don't see that yet.)

I agree it's marginal.

> Isn't the real problem that fadvise(FADV_DONTNEED) is much more
> powerful than it should be?  Whereas madvise(MADV_DONTNEED) is simply
> releasing pages from my address space, fadvise(FADV_DONTNEED) is going
> so far as to remove them from pagecache (if nothing at that instant
> prevents): forcing others into I/O.  Why should I be allowed to
> invalidate pagecache useful to others so quickly?
> 
> Shouldn't it merely, say, move the pages in its range to the inactive
> list, giving other processes a chance to reassert an interest in them?
> May not turn out as easy as that, I admit.

Could be, although that would cause inodes to remain unreclaimable.

> I'm fine with your idea of dropping mmap_sem while nopage waits on I/O,
> I'm fine with your idea of an mm mmap transaction count, so nopage can
> just reget mmap_sem without backing out when nothing changed meanwhile.
> 
> But I do think Ben should have the simple NOPAGE_RETRY he proposed,
> going right back out to userspace; and that should be enough for your
> case too (the mmap transaction count would make its use a rarity).

Perhaps we should concentrate on that for now.  Did we have a patch to look
at?

> > So I think there's a nasty DoS here if we permit infinite retries.  But
> > it's not just that - there might be other situations under really heavy
> > memory pressure where livelocks like this can occur.
> 
> filemap_nopage would want to mark_page_accessed() before returning
> NOPAGE_RETRY, but if that's not good enough to hold the page in cache
> before the retried fault grabs it, your memory pressure is already
> into thrashing.  I believe the livelock is peculiar to FADV_DONTNEED.

Maybe.  Putting a potential infinite loop like this into the pagefault path
gives me the creeps.

Bear in mind that direct-io (both block and NFS) shoots down pagecache too.
It has to.

