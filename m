Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUDEQUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDEQUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:20:43 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:6447 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262911AbUDEQUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:20:36 -0400
Message-ID: <40717AA8.9050900@sgi.com>
Date: Mon, 05 Apr 2004 10:26:32 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [Lse-tech] RE: [PATCH] HUGETLB memory commitment
References: <200404040331.i343VSF02496@unix-os.sc.intel.com>
In-Reply-To: <200404040331.i343VSF02496@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken,

Chen, Kenneth W wrote:

> 
> A simple counter won't work for different file offset mapping.  It has to
> be some sort of per-inode, per-block reservation tracking.  I think we are
> steering in the right direction though.
> 
> 
> 

OK, pardon my question about test code, that is trivial enough I guess.

Anyway, the only way I can see to make this work with non-zero offset is to 
hang a list of segment descriptors (offset and size) for each reserved segment 
off of the inode.  Then when a new mapping comes in, we search the segment 
list to see if the new offset and size overlaps with any of the existing 
reserved segments.  If it doesn't, then we make a new reservation (and request 
file system quota) for the current size, and add the current request to the 
reserved segment list.  If it does, and it fits entirely in a previously 
reserved segement, then no change to reservation/quota needs to be made.  If 
it only partially fits, then we need to make a new reservation/quota request 
for the number of new huge pages required and update the overlapping segment's 
length to reflect the new reservation.

Then in truncate_hugepages() we can search the segment list again, discarding 
full or partial segments that occur either entirely or partially beyond 
"lstart", as appropropriate and doing hugetlb_unreserve() and 
hugetlbfs_put_quota() for the appropriate number of pages.

This will be quite a bit of code and complexity.  Do we still think this is 
all worth it to follow Andrew's suggestion of no API changes for "allocate on
fault" hugetlbpages?  It would be a lot cleaner just to return SIGBUS if we 
run out of hugepages and be done with it, in spite of the API change.

Is there a simpler way to do the correct reservation?  (One could allocate the 
pages at mmap() time, resurrecting hugetlb_prefault(), but zero the pages at 
fault time, this would solve the original problem we ran into at SGI, but 
would not solve Andi's requirement to postpone allocation so NUMA API's can 
control placement.)

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

