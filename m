Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVEPTTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVEPTTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVEPTRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:17:33 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:63918 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261821AbVEPTN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:13:57 -0400
Message-ID: <4288F122.5090002@tmr.com>
Date: Mon, 16 May 2005 15:14:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it> <42889890.8090505@tls.msk.ru>
In-Reply-To: <42889890.8090505@tls.msk.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Roberto Fichera wrote:
> 
>>Hi All,
>>
>>I've a dual Xeon 3.2GHz HT with 8GB of memory running kernel 2.6.11.
>>I whould like to know the way how to use all the memory in a single
>>process, the application is a big simulation which needs big memory
>>chuncks.
>>I have readed about hugetlbfs, shmfs and tmpfs, but don't understand how
>>I can access
>>the whole memory. Ok! I can create a big file on tmpfs using shm_open() and
>>than map it by using mmap() or mmap2() but how can I access over 4GB using
>>standard pointers (if I had to use it)?
> 
> 
> There's no "standard" and simple way to utilize more than 4Gb memory on
> i386 hardware, especially in a userspace.  That is, the size of a pointer
> is 32bits, which is 4GB addresspace maximum.  i386 architecture just can't
> have a pointer of greather size.

And the original i286 couldn't address more than 64k, either. But of 
course it could and did, using the large model which used segment 
registers to address additional memory. In terms of hardware this 
certainly could be done using 4GB segments on newer processors. In terms 
of available compiler and O/S support, you're stuck with using tricks, 
as various people have noted.

In terms of generating correct code, with all the bad things people have 
said about the cost of doing segmentation, it was vastly more likely to 
be correct code if you could just pretend that you have linear address 
space and let the compiler/lib/os play let's pretend for you.

If you really need to address more than 4GB perhaps a 64 bit hardware is 
the better solution.
> 
> All "extra" (>4GB) space can be used like a file in a filesystem, not like
> a plain memory.  Think of read()/write() (or pread()/pwrite() for that matter),
> but much faster ones compared to disk-based storage -- in tmpfs.  You can
> also mmap() *parts* of such a file, but will be still limited to 4GB at
> once -- in order to have more, you will have to unmap() something.
> 
> All the "large applications" (most notable large database systems such as
> Oracle) can't use more than 4GB memory directly, but can utilize it for
> database cache.  In directly-addressible space there's a "table of content"
> of cached buffers is keept, and when a buffer is needed, it is mmap()'ed
> into the application's address space, and unmapped right away when it isn't
> needed anymore (but it is still in memory).  Ofcourse you can't have
> usual pointers into that memory, but you can use something like
> (block-number,offset) instead of a pointer (pagetables).
> 
> /mjt

