Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTEGCCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTEGCB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:01:59 -0400
Received: from [202.181.238.133] ([202.181.238.133]:3814 "EHLO debian.org.hk")
	by vger.kernel.org with ESMTP id S262794AbTEGCB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:01:57 -0400
Message-ID: <3EB86BF1.5010805@linux.org.hk>
Date: Wed, 07 May 2003 10:14:09 +0800
From: Ben Lau <benlau@linux.org.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
References: <1052122784.2821.4.camel@pc-16.office.scali.no>	 <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no>
In-Reply-To: <1052127216.2821.51.camel@pc-16.office.scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am  interested with pt2, how NFS did for their syscall?

Terje Eggestad wrote:
> Unfortunately we live in an insane world. 
> 
> First of all, in the Changelog where the export was removed for 2.5.41
> 
> http://www.kernel.org/pub/linux/kernel/v2.5/ChangeLog-2.5.41
> 
> Arjan lists 4 reasons for having the export in the first place, and I'm
> on point 3. Here Arjan pretty much acknowledges that there is a
> legitimate need to have a event/hook system to be informed of a syscall.
> The exact quote is: "Eg the use of the export in this just a bandaid due
> to lack of a proper mechanism". 
> 
> My argument for *why* there should be a mechanism stops here. 
> 
> 
> Since you're bright inquisitive: The exact problem I'm facing is pretty
> complex:
> 
> 
> 1. performance is everything. 
> 2. We're making a MPI library, and as such we don't have any control
> with the application. 
> 3a. The various hardware for cluster interconnect all work with DMA. 
> 3b. the performance loss from copying from a receive area to the
> userspace buffer is unacceptable. 
> 3c. It's therefore necessary for HW to access user pages. 
> 4. In order to to 3, the user pages must be pinned down. 
> 5. the way MPI is written, it's not using a special malloc() to allocate
> the send receive buffers. It can't since it would break language binding
> to fortran. Thus ANY writeable user page may be used. 
> 6. point 4: pinning is VERY expensive (point 1), so I can't pin the
> buffers every time they're used. 
> 7. The only way to cache buffers (to see if they're used before and
> hence pinned) is the user space virtual address. A syscall, thus ioctl
> to a device file is prohibitive expensive under point 1.  
> 8a. if the app (glibc in practice, but you never know) use sbrk() with a
> negative arg, and then a positive argument, I can get a a different set
> of user pages with the same address. 
> 8b ditto with a set of munmap()/mmap().
> 9. since the number of times. any 'realloc' may happen is << than the
> numbers of times any buffer may be used, it's necessary under point 1 to
> to trace changes to virtual addresses to phys pages, rather than test
> every time an address is being used. 
> 10. kernel patches are impractical, I must be able to do this with std
> stock, redhat, AND suse kernels.   
>  
> 
> 
> 
> On Mon, 2003-05-05 at 10:23, Christoph Hellwig wrote:
> 
>>On Mon, May 05, 2003 at 10:19:45AM +0200, Terje Eggestad wrote:
>>
>>>Now that it seem that all are in agreement that the sys_call_table
>>>symbol shall not be exported to modules, are there any work in progress
>>>to allow modules to get an event/notification whenever a specific
>>>syscall is being called?
>>
>>No.
>>
>>
>>>We have a specific need to trace mmap() and sbrk() calls. 
>>
>>Well, you get mmap events for your driver and I can't imagine a sane
>>reason for intwercepting sbrk().  Do you have a pointer to the driver
>>source doing such strange things?


