Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUC2REx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUC2REN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:04:13 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:63908 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263017AbUC2QvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:51:22 -0500
Date: Mon, 29 Mar 2004 08:50:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ray Bryant <raybry@sgi.com>
cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <180830000.1080579038@[10.10.2.4]>
In-Reply-To: <40674452.1080305@sgi.com>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk> <20040325130433.0a61d7ef.akpm@osdl.org> <41997489.1080257240@42.150.104.212.access.eclipse.net.uk> <4067131A.7000405@sgi.com> <98220000.1080501001@[10.10.2.4]> <40674452.1080305@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yup, but there were two parts to it:
>> 
>> 1. Stop hugepages using the existing overcommit pool for small pages, 
>> which breaks small page allocations by prematurely the pool.
>> 2. Give hugepages their own over-commit pool, instead of prefaulting.
>> 
>> Personally I think we need both (as you seem to), but (1) is probably
>> more urgent.
> 
> Just to review:  even if we allocate hugetlb pages at fault rather than 
> at mmap() time, hugetlb pages are created either at system boot time 
> (kernel parameter "hugepages=") or by setting /proc/sys/vm/nr_hugepages 
> (or by using the corresponding sysctl).  Once the set of hugepages is 
> created this way, it never is changed by the act of allocating a huge 
> page to a process.  (Changing nr_pages can cause the number of unallocated 
> hugetlbpages to be increased or decreased.)

Yup.

> The reason for pointing this out (apologies if this was obvious to all) 
> is to emphaisze that hugetlbpages are not created at hugetlbpage allocation 
> time (which is now done at mmap() time and we'd like to change it to happen 
> at fault time).

Yup.

> So to stop hugepages from using the small page overcommit pool, we just 
> need code in set_hugetlb_mem_size() to reduce the number of hugetlbpages 
> created by that code.

I think Andy already fixed that bit, though I'm not sure what method he used.
It seems to me (without really looking), that we just need to not decrement
the pool size when we map a huge page.

> As for (2), I'm a little confused there, as later you appear to agree 
> with me that overcomitting hugetlbpages is likely not useful.  

I think I'm just being confusing via sloppy terminology, but we're in
resounding agreement in reality ;-)

> Is it  possible that you meant that there should be a list of hugetlbpages 
> from which all allocations are made?  If so, that is the way the code has 
> always worked; step 1 was to create the list of hugetlbpages, and step 2 
> was to allocate them.

I meant if we keep a counter of the number of hugetlb pages available, every
time we get a call to allocate them, we can avoid prefault by just decrementing
the counter of "available" pages, and fault them in later, just like the existing
strict-overcommit code does, and we'll never fail to allocate. If we're doing
*strict* NUMA bindings, it does need to be a little more complex, in that 
things will need to remember which node they're "pre-allocated" from. The fact
that the "overcommit" code *prevents* overcommit is probably not helping the
discussion's clarity ;-)

> (Once again, if this is obvious to all, I apologize and we can dump the last 
> 4 paragraphs into the bit bucket with no known effect on entropy in this 
> universe, at least.)

Well, above is what *I* meant, and I *think* roughly what you meant. But probably
best to clarify ;-)

>>> Since the reservation belongs to the mapped object (file or segment), 
>>> I've been storing the current file/segments's reservation in the file 
>>> system dependent part of the inode.  That way, it is easily accessible 
>>> when the hugetlbfs file or SysV segment is removed and we can reduce 
>>> the total number of reserved pages by that file's reservation at that 
>>> time.  This also allows us to handle the reservation in the absence 
>>> of a vma, as per Andy'c comment below.
>> 
>> 
>> Do we need to store it there, or is one central pool number sufficient?
>> I would have thought it was ...
> 
> Yes, there is a central pool number indicating how many hugepages are reserved. 
> The question is, when (and how) do you release that reservation?   My take is 
> that the reservation is associated with the file (for mmap) or segment for SysV.

Ah, I see what you mean. You can't really release it at 0 refcount without changing
the semantics, in case it's re-used later. Hum. Yes, I see what you mean.

> For example, program A mmap()'s a hugetlbfs file, but only touches part of the 
> pages.  Program B then mmap()'s the same file with the same size, etc.  When 
> program B does the mmap() the previous reservation should still be in place, right?  
> (The file is persistent in the page cache even if it does not persist over reboot, 
> so the 2nd program is exepecting to see the data that the first program put there.)
> 
> Ditto for a SysV segement.

Yes. I think Adam's patches in my tree support anon mem_map though. That's going to
get rather tricky ... we run into similar problems as objrmap, I think.

> So one can't release the reservation when the current process doing the mmap() 
> goes away, one has to release the reservation when the file/segment is deleted.  
> Since both mmap() and shmget() create an inode, and the inode is released by 
> hugetlbfs_drop_inode() and friends, it seemed simplest to put the size of the 
> mapped object's reservation in the inode.

Yup, I'd missed that -  thanks for explaining ;-)

> The global count of reserved pages (the "central pool number" in your note), 
> is incremented at mmap() time (well, actually done by hugetlbfs_file_mmap() 
> for both mmap() and shmget()) and decremented at hugetlbfs_drop_inode() time.  
> If at mmap() time, incrementing the global reservation count would make the 
> global reserved pages count the number of hugetlbpages, we fail the mmap() 
> with -ENONMEM.
> 
> At least that is the way my 2.4.21 code works.  Does that make things clearer?

A lot ;-)

Thanks,

M.

