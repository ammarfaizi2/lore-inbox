Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVGOIYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVGOIYB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVGOIYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:24:01 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:56732 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261875AbVGOIXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:23:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GE5wiYMyrgDakaH1Nv9c1pNxmXKrs6F8vR4SE1URbexmaqwH4DbgUHxdjBazoHTKArM5ALz+3xbSg42eyW2gzIVTME/LI8n3KbdtaNBYeUROdjAdH7xQY9VW7W1IBDxlH7E5D/ljDA2SbPcwih2r7K2VRVp/AYfNPUJFyA4ebCg=
Message-ID: <42D77293.3050900@gmail.com>
Date: Fri, 15 Jul 2005 17:23:47 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Daniel McNeil <daniel@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net> <42D70318.1000304@gmail.com> <42D74724.8000703@us.ibm.com>
In-Reply-To: <42D74724.8000703@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Tejun Heo wrote:
> 
>> Daniel McNeil wrote:
>>
>>> This patch relaxes the direct i/o alignment check so that user addresses
>>> do not have to be a multiple of the device block size.
>>>
>>> I've done some preliminary testing and it mostly works on an ext3
>>> file system on a ide disk.  I have seen trouble when the user address
>>> is on an odd byte boundary.  Sometimes the data is read back incorrectly
>>> on read and sometimes I get these kernel error messages:
>>>     hda: dma_timer_expiry: dma status == 0x60
>>>     hda: DMA timeout retry
>>>     hda: timeout waiting for DMA
>>>     hda: status error: status=0x58 { DriveReady SeekComplete 
>>> DataRequest }
>>>     ide: failed opcode was: unknown
>>>     hda: drive not ready for command
>>>
>>> Doing direct-io with user addresses on even, non-512 boundaries appears
>>> to be working correctly.
>>>
>>> Any additional testing and/or comments welcome.
>>>
>>
>>  Hi, Daniel.
>>
>>  I don't think the change is a good idea.  We may be able to relax 
>> alignment contraints on some hardware to certain levels, but IMHO it 
>> will be very difficult to verify.  All internal block IO code follows 
>> strict block boundary alignment.  And as raw IOs (especially unaligned 
>> ones) aren't very common operations, they won't get tested much.  Then 
>> when some rare (probably not an open source one) application uses it 
>> on some rare buggy hardware, it may cause *very* strange things.
>>
>>  Also, I don't think it will improve application programmer's 
>> convenience.  As each hardware employs different DMA alignemnt, we 
>> need to implement a way to export the alignment to user space and 
>> enforce it.   So, in the end, user application must do aligned 
>> allocation accordingly.  Just following block boundary will be easier.
>>
>>  I don't know why you wanna relax the alignment requirement, but 
>> wouldn't it be easier to just write/use block-aligned allocator for 
>> such buffers?  It will even make the program more portable.
>>
> 
> I can imagine a reason for relaxing the alignment. I keep getting asked
> whether we can do "O_DIRECT mount option".  Database folks wants to
> make sure all the access to files in a given filesystem are O_DIRECT
> (whether they are accessing or some random program like ftp, scp, cp
> are acessing them). This was mainly to ensure that buffered accesses to
> the file doesn't polute the pagecache (while database is using O_DIRECT
> access). Seems like a logical request, but not easy to do :(
> 
> Thanks,
> Badari

  I don't know much about VM, but, if that's necessary, I think that 
limiting pagecache size per mounted fs (or by some other applicable 
category) is easier/more complete approach.  After all, you cannot mmap 
w/ O_DIRECT and many programs (gcc, ld come to mind) mmap large part of 
their memory usage.

  Thanks.

-- 
tejun
