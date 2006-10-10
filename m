Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWJJX4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWJJX4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJJX4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:56:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61641 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030358AbWJJX4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:56:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@infradead.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>
Subject: Re: RSS accounting (was: Re: 2.6.19-rc1-mm1)
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<1160464800.3000.264.camel@laptopd505.fenrus.org>
	<20061010004526.c7088e79.akpm@osdl.org>
	<1160467401.3000.276.camel@laptopd505.fenrus.org>
	<1160486087.25613.52.camel@taijtu>
	<1160496790.3000.319.camel@laptopd505.fenrus.org>
Date: Tue, 10 Oct 2006 17:54:16 -0600
In-Reply-To: <1160496790.3000.319.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Tue, 10 Oct 2006 18:13:10 +0200")
Message-ID: <m11wpfohg7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Tue, 2006-10-10 at 15:14 +0200, Peter Zijlstra wrote:
>> > 
>> > We need to consider at least if any of the following are part of rss:
>> > * VM_IO io mmaped device stuff 
>> > * Non-linear mappings
>> > * Shared hugetlb memory that shares pagetables
>> > * Shared hugetlb memory
>> > * Hugetlb memory in general
>> > * Shared normal memory that shares pagetables
>> > * Shared normal memory (file backed; eg pagecache)
>> > * Shared normal memory (anonymous/non-file-backed)
>> > * Sysv/ipc shared memory
>> > * Not shared normal memory

There is a concept related to RSS that is very interesting.  The
minimum RSS that a process needs to keep from thrashing.

It can be shown that if your RSS rlimit is greater that your minimum
RSS your process will never thrash. 

One thing that older paging algorithms would try and do when there
was memory pressure was to dynamically discover an applications
minimum RSS, and if they couldn't meet it swap that process out,
because the program can't make progress anyway.

A per process not a per application RSS fails to model multiple
process applications but the concepts are sound.

So since VM_IO does not have any effect on paging it should not
be counted but if you were a stickler the page tables from the
VM_IO should be counted.

The other thing to note is even if you RSS is just above your minimum
RSS that will only result in your process having pages bounce in and
out of the page cache (not necessarily to disk).   So while it will
increase minor faults a restrictive RSS is not a problem when
you have excess resources.

>>  - shared mapped pages could be accounted on vma level, since both
>> containers have access to the same file, there is already an imbalance,
>> so I'd not worry about the 1%-99% usage scenario here.
>
> or one level below; if you count it in the actual PTE page then the
> sharing case will "just work". It's a trick question; do you count it as
> 100% or do you count it as 100% / number of sharers.

I'm not certain I even want to follow the logic here. The answer is
clear.

For processes shared pages are not special.

For computing a container RSS shared pages need to be counted the
first time they are mapped by any process in a container, and
uncounted the last time they are unmapped by a process in a container.
With rmap we have the data structures necessary to do the accounting,
although it might be a bit of a pain.


>>  - regular, non mapped, pagecache pages however have no owner - what to
>> do. (fake vma - which would result in each container paying equally for
>> all these pages?)
>
> if they're clean I wouldn't count them to anything actually

If the pages aren't mapped they aren't part of the resident set size.

At least not until we start worrying about per container or per
process splits of the page cache, and there are clearly good reasons
to avoid that.

>> Anyway, I'd rather not break RSS twice, once now because we don't quite
>> know what to do, and later when we do get an acceptable mm container and
>> have to include shared memory in one way or the other.
>
>
> RSS of a container versus RSS of a process is an interesting question
> for sure ;)

Agreed.  Historically it was much more interesting because we didn't
have rmap so telling if your set of processes had mapped the page
already is a challenge.  At this point unless the performance of
the accounting is to much it should just be a simple counting problem.

The real challenge is doing a decent job of picking the appropriate
page to unmap when a new mapping by a process would exceed the rss
limit.  That is the one piece of the puzzle we have never implemented
:(

You can declare success when you can push one container into heavy
swapping and the rest of the containers are still running fine.

Eric
