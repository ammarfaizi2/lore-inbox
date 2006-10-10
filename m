Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030177AbWJJQNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030177AbWJJQNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030178AbWJJQNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:13:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34783 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030177AbWJJQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:13:14 -0400
Subject: Re: RSS accounting (was: Re: 2.6.19-rc1-mm1)
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>
In-Reply-To: <1160486087.25613.52.camel@taijtu>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <1160464800.3000.264.camel@laptopd505.fenrus.org>
	 <20061010004526.c7088e79.akpm@osdl.org>
	 <1160467401.3000.276.camel@laptopd505.fenrus.org>
	 <1160486087.25613.52.camel@taijtu>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 18:13:10 +0200
Message-Id: <1160496790.3000.319.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 15:14 +0200, Peter Zijlstra wrote:
> > 
> > We need to consider at least if any of the following are part of rss:
> > * VM_IO io mmaped device stuff 
> > * Non-linear mappings
> > * Shared hugetlb memory that shares pagetables
> > * Shared hugetlb memory
> > * Hugetlb memory in general
> > * Shared normal memory that shares pagetables
> > * Shared normal memory (file backed; eg pagecache)
> > * Shared normal memory (anonymous/non-file-backed)
> > * Sysv/ipc shared memory
> > * Not shared normal memory


> So we have three cases where RSS matters besides presenting a number to
> user-space;
>  - shared page tables
>  - containers
>  - rlimit
> 
> Preferably they will all share a common definition of what RSS is; since
> containers must account shared pages somehow (not doing so would open up
> a large hole to DoS the other containers) and the container case can be
> argued to be an extension of the rlimit case we cannot just ignore them.
> 
> As then what to do with them, I've yet to figure out. Some random bit
> floating in my brain;
>  - VM_IO can be discarted, its not actual memory

agreed (although I think we do count it today; this is half of what
makes X look so bloated, next to firefox ;)

> 
>  - hugetlb is memory too, so I'd not special case this (other than the
> different unit of accounting)

agreed again; personally I don't think hugetlb memory should be special;
especially with all the libhugetlbfs work on making it real easy for
apps to use; the more it's used the more people would notice something
funky with it.


>  - shared mapped pages could be accounted on vma level, since both
> containers have access to the same file, there is already an imbalance,
> so I'd not worry about the 1%-99% usage scenario here.

or one level below; if you count it in the actual PTE page then the
sharing case will "just work". It's a trick question; do you count it as
100% or do you count it as 100% / number of sharers.


>  - regular, non mapped, pagecache pages however have no owner - what to
> do. (fake vma - which would result in each container paying equally for
> all these pages?)

if they're clean I wouldn't count them to anything actually


> Anyway, I'd rather not break RSS twice, once now because we don't quite
> know what to do, and later when we do get an acceptable mm container and
> have to include shared memory in one way or the other.


RSS of a container versus RSS of a process is an interesting question
for sure ;)


