Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWJJNOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWJJNOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWJJNOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:14:41 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32309 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750722AbWJJNOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:14:40 -0400
Subject: RSS accounting (was: Re: 2.6.19-rc1-mm1)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>
In-Reply-To: <1160467401.3000.276.camel@laptopd505.fenrus.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <1160464800.3000.264.camel@laptopd505.fenrus.org>
	 <20061010004526.c7088e79.akpm@osdl.org>
	 <1160467401.3000.276.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:14:47 +0200
Message-Id: <1160486087.25613.52.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 10:03 +0200, Arjan van de Ven wrote:
> On Tue, 2006-10-10 at 00:45 -0700, Andrew Morton wrote:
> 
> > > if it's ok to ignore RSS,
> > 
> > We'd prefer not to.  But what's the alternative?
> 
> it's a good question; today (2.6.18) we have some defacto behavior of
> RSS; 2.6.19-rc1-mm1 has a somewhat different one. Either can be entirely
> valid; and we can obviously implement either. We can go even further and
> remove more from RSS to help save memory and pagefaults (both help
> desktop performance) by going the shared pagetable road

> > > So.. what does RSS actually mean? Can we ignore it somewhat for
> > > shared-readonly mappings ? 
> > 
> > We'd prefer to go the other way, and implement RLIMIT_RSS wouldn't we?
> 
> Well... that again depends on how we define RSS. implementing the rlimit
> doesn't mean we can't NOT count certain things (like the hugetlb pages
> in the patch above, or shared read only pagecache pages) to be part of
> it. It's a fundamental "what does it mean" thing.
> You can argue that RSS means "all memory that the application has in
> it's address space", you can argue "all such memory except a few cases",
> you can argue "all memory that is private/exclusive to the
> application"... 
> This is not a pointless piss-in-the-wind discussion; unless we define
> rather specific what it really means, the RLIMIT doesn't mean anything
> either.
> 
> We need to consider at least if any of the following are part of rss:
> * VM_IO io mmaped device stuff 
> * Non-linear mappings
> * Shared hugetlb memory that shares pagetables
> * Shared hugetlb memory
> * Hugetlb memory in general
> * Shared normal memory that shares pagetables
> * Shared normal memory (file backed; eg pagecache)
> * Shared normal memory (anonymous/non-file-backed)
> * Sysv/ipc shared memory
> * Not shared normal memory
> 
> I don't think posix or anything else helps us here so we can vote or
> otherwise reason which make sense and which don't. I hope the outcome is
> reasonably consistent ;)
> 
> I know the desktop guys at least consider RSS useless as measure of "how
> much memory does my desktop app take"; especially since they have many
> shared libraries and they consider it unfair that each app pays the full
> price in terms of RSS for those. So personally I'm not unhappy with a
> definition that comes down to "all memory that's private to the app";
> although it is a change from what 2.6.18 does.

So we have three cases where RSS matters besides presenting a number to
user-space;
 - shared page tables
 - containers
 - rlimit

Preferably they will all share a common definition of what RSS is; since
containers must account shared pages somehow (not doing so would open up
a large hole to DoS the other containers) and the container case can be
argued to be an extension of the rlimit case we cannot just ignore them.

As then what to do with them, I've yet to figure out. Some random bit
floating in my brain;
 - VM_IO can be discarted, its not actual memory

 - hugetlb is memory too, so I'd not special case this (other than the
different unit of accounting)

 - shared mapped pages could be accounted on vma level, since both
containers have access to the same file, there is already an imbalance,
so I'd not worry about the 1%-99% usage scenario here.

 - regular, non mapped, pagecache pages however have no owner - what to
do. (fake vma - which would result in each container paying equally for
all these pages?)

Anyway, I'd rather not break RSS twice, once now because we don't quite
know what to do, and later when we do get an acceptable mm container and
have to include shared memory in one way or the other.



