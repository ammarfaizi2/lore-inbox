Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUJPR3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUJPR3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUJPR3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:29:20 -0400
Received: from services.exanet.com ([212.143.73.102]:15879 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S268167AbUJPR3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:29:11 -0400
Message-ID: <41715A5F.2060006@exanet.com>
Date: Sat, 16 Oct 2004 19:29:03 +0200
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com> <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk> <4170DF18.50004@exanet.com> <20041016162836.GG17142@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041016162836.GG17142@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2004 17:29:06.0679 (UTC) FILETIME=[A378B870:01C4B3A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>On Sat, Oct 16, 2004 at 10:43:04AM +0200, Avi Kivity wrote:
>  
>
>>Using IO_CMD_READ for a vector entails
>>
>>- converting the userspace structure (which might well an iovec) to iocbs
>>    
>>
>
>	Why create an iov if you don't need to?
>
>  
>
If you aren't writing directly to the kernel API, an iovec is very 
convenient. It need not be an iovec, but surely you need _some_ vector.

>>- merging the iocbs
>>    
>>
>
>	I don't see how this is different than merging iovs.  Whether an
>I/O range is represented by two segments of an iov or by two iocbs, the
>elevator is going to merge them.  If the userspace program had the
>knowledge to merge them up front, it should have submitted one larger
>segment.
>  
>
No. An iovec is already merged; it is known that adjacent segments of an 
iovec have adjacent offsets. a single IO_CMD_READV iovec can generate a 
single bio without any merging.

The app did not submit a single large segment for the same reason 
non-aio readv is used: because app memory is paged. in my case, a 
userspace filesystem has a paged cache; large, disk-contiguous reads go 
into many small noncontiguous memory pages. or it might be a database 
performing a sequential scan and reading a large block into multiple 
block buffers, which are usually discontiguous.

>  
>
>>- coalescing the multiple completions in userspace to a single completion
>>    
>>
>
>	You generally have to do this anyway.  In fact, it is often far
>more efficient and performant to have a pattern of:
>
>	submit 10;
>	reap 3; submit 3 more;
>	reap 6; submit 6 more;
>	repeat until you are done;
>
>than to wait on all 10 before you can submit 10 again.
>  
>
If the data is physically contiguous, it will (should) be merged, and 
thus completed in a single event anyway. All 10 completions will happen 
at the same time.

I might divide a 1M read into 4 iocbs to get the effect you mention. I 
don't want to be forced into dividing them based on virtual address, 
into 256 4K iocbs. *if* I wanted to do anything with partial data.

>>error handling is difficult as well. one would expect that a bad sector 
>>with multiple iocbs would only fail one of the requests. it seems to be 
>>non-trivial to implement this correctly.
>>    
>>
>
>	I don't follow this.  If you mean that you want all io from
>later segments in an iov to fail if one segment has a bad sector, I
>don't know that we can enforce it without running one segment at a
>time.  That's terribly slow.
>  
>
That's not what I meant. If you submit 16 iocbs which are merged by the 
kernel, and there is an error somewhere within the seventh iocb, I would 
expect to get 15 success completions and one error completion. so error 
information from the merged iocb must be demultiplexed into the originals.

If you have a single iocb, then any error simply fails that iocb.

>	Again, even if READV is a good idea, we need to fix whatever
>inefficiencies io_submit() has.  copying to/from userspace just can't be
>that slow.
>  
>
The inefficiencies I refered to were disk inefficiencies, not processor.

I think what happened was that the number of iocbs submitted (64 iocbs 
of 4K each) did not merge because the device queue depth was very large; 
no queuing occured because (I imagine) merging happens while a request 
is waiting for disk readiness.

Decreasing the queue depth is not an option, because I might want to do 
random reads of small iovecs later.

Of course, it is better to copy less than to copy more; so that is an 
additional win for PREADV.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

