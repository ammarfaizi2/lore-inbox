Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264832AbSJOSEU>; Tue, 15 Oct 2002 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264843AbSJOSEU>; Tue, 15 Oct 2002 14:04:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:44255 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264832AbSJOSEP>;
	Tue, 15 Oct 2002 14:04:15 -0400
Message-ID: <3DAC59F7.18678FA6@digeo.com>
Date: Tue, 15 Oct 2002 11:09:59 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Saurabh Desai <sdesai@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
References: <Pine.LNX.4.44.0210151438440.10496-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 18:10:02.0832 (UTC) FILETIME=[1512ED00:01C27476]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> ...
> 
> Saurabh reported a slowdown after the first couple of thousands of
> threads, which i can reproduce as well. The reason for this slowdown is
> the get_unmapped_area() implementation, which tries to achieve the most
> compact virtual memory allocation, by searching for the vma at
> TASK_UNMAPPED_BASE, and then linearly searching for a hole. With thousands
> of linearly allocated vmas this is an increasingly painful thing to do ...

We've had reports of problems with that linear search before - for
a single-threaded application which was mapping a lot of little windows
into a huge file.
 
> ...
> 
> there are various solutions to this problem, none of which solve the
> problem in a 100% sufficient way, so i went for the simplest approach: i
> added code to cache the 'last known hole' address in mm->free_area_cache,
> which is used as a hint to get_unmapped_area().

This will have no effect on current kernel behaviour other than speeding
it up.  Looks good.
 
> ...
> The most generic and still perfectly-compact VM allocation solution would
> be to have a vma tree for the 'inverse virtual memory space', ie. a tree
> of free virtual memory ranges, which could be searched and iterated like
> the space of allocated vmas. I think we could do this by extending vmas,
> but the drawback is larger vmas. This does not save us from having to scan
> vmas linearly still, because the size constraint is still present, but at
> least most of the anon-mmap activities are constant sized. (both malloc()
> and the thread-stack allocator uses mostly fixed sizes.)

Yup.  We'd need to be able to perform a search based on "size of hole"
rather than virtual address.  That really needs a whole new data structure
and supporting search code, I think...  It also may have side effects
to do with fragmentation of the virtual address space.
