Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319094AbSHSWxr>; Mon, 19 Aug 2002 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319095AbSHSWxr>; Mon, 19 Aug 2002 18:53:47 -0400
Received: from host-65-162-110-4.intense3d.com ([65.162.110.4]:15629 "EHLO
	exchusa03.intense3d.com") by vger.kernel.org with ESMTP
	id <S319094AbSHSWxq>; Mon, 19 Aug 2002 18:53:46 -0400
Message-ID: <3D60DF41.65636FAB@3dlabs.com>
Date: Mon, 19 Aug 2002 12:06:26 +0000
From: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gilad Ben-Yossef <gilad@benyossef.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Alloc and lock down large amounts of memory
References: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com> <1029672587.12504.88.camel@sake>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gilad Ben-Yossef wrote:

>
> > 1. Is there a mechanism to lock down large amounts of memory (>128M, upto
> > 256M).
>
> >From user space? kernel space? The answer is yes to both but the
> mechnism is different.

In the kernel space.    I've looked at the boot-time allocation examples and
Rubini's
allocator.c.  I don't have the option of making the user compile the kernel to
obtain a chunk of the high memory by passing in the 'mem' option at boot time.

 Here's the scenario:  I need to be able to alloc virtual memory, create the
page table
and temporarily pin down (lock) the pages in memory in order to do the DMA.
This
memory should be paged in and out as needed.    This memory should also have
visibility across processes.

Does the VM_RESERVED flag lock down the memory so that it doesn't get paged out
during DMA?

>
>
> >     Can 256M be allocated using vmalloc, if so is it swappable?
>
> It can be alloacted via vmalloc and AFAIK it is not swappable by
> default. This doesn't sound like a very good idea though.

Is there a good way to allocate large sums of memory in Linux?  Doesn't have to
be
vmalloc but I don't think kmalloc, get_free_pages will work for this purpose.  I
looked
into get_free_pages, but the largest order is 9 which results in 512 pages.
Does the memory allocated by vmalloc has visibility across processes?

>
>
> > 2. Is it possible for a user process and kernel to access the same shared
> > memory?
>
> Yes. See /proc/kcore for a very obvious example. Also "Linux device
> drivers second edition" has many good exmaple on the subject in the
> chapter devoted to mmap.

Great.  I see remap_page_range and nopage examples.

>
>
> > 3. Can a shared memory have visibility across processes, i.e. can process A
> > access
> > memory that was allocated by process B?
>
> Of course. This is the definition of shared memeory...
> Just one thing to keep in mind - 'allocating' memory really doesn't do
> that much as you might think. Until the memory is *accessed* for the
> first time, all you got for the most part are some entries in a table
> somwehere...
>
> > 4. When a process exits will it cause a close to occur on the device?
>
> Depends how you got the shared memeory. With mmap() it's yes (for
> regular files at least), with shmget/shmat it's no by default. For mmap
> of non regulat files (e.g. device files) anything the device file writer
> had in mind is the answer.

I didn't mean shared memory.   If several processes open a given device,
under normal conditions the data structure stays till the last close at which
time a
release is done.   This depends on the usage or minor number count.  Can there
be a case where the device exits before the processes close?   In which case
the processes will be left hanging.    How is the close handled if the driver is

killed?

>
>
> man shmget, shmat, shmat and finally mmap will help you a lot.

Yep, I'll look at them.  Thanks a lot for your reply.

Bhavana

--
Bhavana Nagendra
(256) 319-1267
Bhavana.Nagendra@3dlabs.com



