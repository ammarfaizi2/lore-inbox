Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUC1V1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 16:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUC1V1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 16:27:12 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:10839 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262351AbUC1V0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 16:26:54 -0500
Message-ID: <40674452.1080305@sgi.com>
Date: Sun, 28 Mar 2004 15:32:02 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] [0/6] HUGETLB memory commitment
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk> <20040325130433.0a61d7ef.akpm@osdl.org> <41997489.1080257240@42.150.104.212.access.eclipse.net.uk> <4067131A.7000405@sgi.com> <98220000.1080501001@[10.10.2.4]>
In-Reply-To: <98220000.1080501001@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:
>>As I understood this originally, the suggestion was to reserve hugetlb 
>>pages at mmap() or shm_get() time so that the user would get an -ENOMEM 
>>at that time if there aren't enough hugetlb pages to (eventually) satisfy 
>>the request, as per the notion that we shouldn't modify the user API due 
>>to going with allocate on fault instead of hugetlb_prefault().
> 
> 
> Yup, but there were two parts to it:
> 
> 1. Stop hugepages using the existing overcommit pool for small pages, 
> which breaks small page allocations by prematurely the pool.
> 2. Give hugepages their own over-commit pool, instead of prefaulting.
> 
> Personally I think we need both (as you seem to), but (1) is probably
> more urgent.

Just to review:  even if we allocate hugetlb pages at fault rather than at mmap() time, hugetlb 
pages are created either at system boot time (kernel parameter "hugepages=") or by setting 
/proc/sys/vm/nr_hugepages (or by using the corresponding sysctl).  Once the set of hugepages is 
created this way, it never is changed by the act of allocating a huge page to a process.  (Changing 
nr_pages can cause the number of unallocated hugetlbpages to be increased or decreased.)

The reason for pointing this out (apologies if this was obvious to all) is to emphaisze that 
hugetlbpages are not created at hugetlbpage allocation time (which is now done at mmap() time and 
we'd like to change it to happen at fault time).

So to stop hugepages from using the small page overcommit pool, we just need code in 
set_hugetlb_mem_size() to reduce the number of hugetlbpages created by that code.

As for (2), I'm a little confused there, as later you appear to agree with me that overcomitting 
hugetlbpages is likely not useful.   Is it possible that you meant that there should be a list of 
hugetlbpages from which all allocations are made?  If so, that is the way the code has always 
worked; step 1 was to create the list of hugetlbpages, and step 2 was to allocate them.

(Once again, if this is obvious to all, I apologize and we can dump the last 4 paragraphs into the 
bit bucket with no known effect on entropy in this universe, at least.)

> 
> 
>>Since the reservation belongs to the mapped object (file or segment), 
>>I've been storing the current file/segments's reservation in the file 
>>system dependent part of the inode.  That way, it is easily accessible 
>>when the hugetlbfs file or SysV segment is removed and we can reduce 
>>the total number of reserved pages by that file's reservation at that 
>>time.  This also allows us to handle the reservation in the absence 
>>of a vma, as per Andy'c comment below.
> 
> 
> Do we need to store it there, or is one central pool number sufficient?
> I would have thought it was ...
> 

Yes, there is a central pool number indicating how many hugepages are reserved. The question is, 
when (and how) do you release that reservation?   My take is that the reservation is associated with 
the file (for mmap) or segment for SysV.

For example, program A mmap()'s a hugetlbfs file, but only touches part of the pages.  Program B 
then mmap()'s the same file with the same size, etc.  When program B does the mmap() the previous 
reservation should still be in place, right?  (The file is persistent in the page cache even if it 
does not persist over reboot, so the 2nd program is exepecting to see the data that the first 
program put there.)

Ditto for a SysV segement.

So one can't release the reservation when the current process doing the mmap() goes away, one has to 
release the reservation when the file/segment is deleted.  Since both mmap() and shmget() create an 
inode, and the inode is released by hugetlbfs_drop_inode() and friends, it seemed simplest to put 
the size of the mapped object's reservation in the inode.

The global count of reserved pages (the "central pool number" in your note), is incremented at 
mmap() time (well, actually done by hugetlbfs_file_mmap() for both mmap() and shmget()) and 
decremented at hugetlbfs_drop_inode() time.  If at mmap() time, incrementing the global reservation 
count would make the global reserved pages count > the number of hugetlbpages, we fail the mmap() 
with -ENONMEM.

At least that is the way my 2.4.21 code works.  Does that make things clearer?

> 
>>Admittedly this doesn't alow one to request that hugetlbpages be 
>>overcommitted, or to handle problems caused to the "normal" page 
>>overcommit code due to the presence of hugepages.  But we figure that 
>>anyone that is actually using hugetlb pages is likely to take over 
>>almost all of main memory anyway in a single job, so overcommit 
>>doesn't make much sense to us.
> 
> 
> Seeing as you can't swap them, overcommitting makes no sense to me
> either ;-)
> 
> M.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

