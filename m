Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUDFB74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUDFB74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:59:56 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:41956 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263592AbUDFB7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:59:48 -0400
Message-ID: <40720274.3000700@sgi.com>
Date: Mon, 05 Apr 2004 20:05:56 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Andy Whitcroft <apw@shadowen.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, anton@samba.org,
       sds@epoc.ncsc.mil, ak@suse.org, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Subject: Re: [Lse-tech] RE: [PATCH] HUGETLB memory commitment
References: <200404052318.i35NIHF29964@unix-os.sc.intel.com>
In-Reply-To: <200404052318.i35NIHF29964@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

Chen, Kenneth W wrote:
>>>>>Ray Bryant wrote on Monday, April 05, 2004 11:22 AM
>>>
>>>Chen, Kenneth W wrote:
>>>I actually started coding yesterday.  It doesn't look too bad (I think).
>>>I will post it once I finished it up later today or tomorrow.
>>
>>Hmmm...so did I.  Oh well.  We can pull the good ideas from both. :-)
> 
> 
> I did have a revelation from your original demand-paging patch with per-inode
> tracking ;-)  I extended it into tracking by struct address_space (so we don't
> pollute inode structure) and added per-block tracking.  See patch at the end of
> this post. I admit I had very pessimistic thoughts until I saw your patch.
> 

Cool!

Either way works, I think.  I just used the u.generic_ip pointer because it 
was there and convenient.  It's intended to be a hook in the VFS layer for a 
particular file system to add info to the inode, as near as I can tell, but 
neither hugetlbfs nor shmfs use it, so it was free for the taking.

> 
> 
>>>There are still some oddity in lifetime of the huge page reservation,
>>>but that can be discussed once everyone sees the code.
> 
> 
> I was thinking the lifetime of the huge page reservation should be the life
> of a mapping, i.e., only persist across mmap/munmap.  That means add a ref
> count in the per-block tracking.  This seriously complicates the design
> because now, ref count needs to be updated in munmap and fault_hander in
> addition to the mmap and truncate.  Not to mention that Andy Whitcroft already
> pointed out we don't get notification from munmap.  Plus it seriously make
> tracking logic complicated and have performance down side as well.
> 
> I guess everyone is OK with reservation lives until file truncate?

One can certainly argue that the only thing that is required to live until 
file truncate is the contents of the huge pages in the page cache, since 
applications expect that the data will be there in the file/segment across 
program executions until the file is truncated or the segment deleted.

But it certainly makes sense to me that if program A creates an mmap()'d file 
of 10 huge pages, that if Program B comes along later and re-mmaps() that same 
file, that Program B will be guaranteed to be able to touch all 10 pages, even 
if Program A only touched 5.  So that is an argument for having the 
reservation last until file truncate/segment removal time.

Additionally, recall that we are trying to emulate the behavior of the 
hugetlb_prefault() implementation. Under that implementation, if Program A 
would mmap() 10 huge pages, then Program B would be guarenteed not to get a 
SIGBUS when it mmap()'s and references those 10 pages, provided only that the 
underlying file/segment was not deleted in between execution of the two programs.

So, I think we >>have<< to have the reservation last until file 
truncate/segment deletion time.  Fortunately, that turns out to be easier to 
implement as well.  :-)

I'll check through your patch and make sure we've both covered the same bases 
there.  If so, we should be good to go with either version.

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

