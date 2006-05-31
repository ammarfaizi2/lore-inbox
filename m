Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWEaUix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWEaUix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEaUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:38:52 -0400
Received: from mail.visionpro.com ([63.91.95.13]:28021 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S964936AbWEaUiv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:38:51 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Sharing memory between kernel and user space.
Date: Wed, 31 May 2006 13:38:50 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B333E@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: Sharing memory between kernel and user space.
Thread-Index: AcaE8jl4FCRRTv8bTvykh4rgeYF0Yg==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a lot of good help in the last couple days, thank you to everyone
who responded; I made major progress but I'm still having a hang up and
a bit confused.

I my driver, I allocate this structure:

typedef struct rtc_shared {
    unsigned long       snap_addrs_loc;
    time_t              ntimestamp;
} RtcShared;

In the driver like this:

static int
alloc_rtc_usr_shared(RtcSoftDev *rtc_sp)
{
    unsigned long addr;
    unsigned long bytes = PAGE_SIZE << get_order(RTC_COMMON_SIZE);
    unsigned long sz;

    rtc_sp->shared_host_mem =
        __get_free_pages(GFP_KERNEL, get_order(RTC_COMMON_SIZE));

    if (rtc_sp->shared_host_mem == NULL) {
        debug_out(("alloc_rtc_usr_shared: out of memory.\n"));
        return(0);
    }

    memset((void *)rtc_sp->shared_host_mem, 0, bytes);

    for (addr = rtc_sp->shared_host_mem, sz = bytes;
        sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {

            SetPageReserved(virt_to_page(addr));
    }

    return(0);
}

And then in my driver mmap routine:

int
rtc_mmap(struct file *filep, struct vm_area_struct *vma)
{
    RtcSoftDev *rtc_sp = filep->private_data;

    unsigned long start = vma->vm_start;
    unsigned long size = vma->vm_end - vma->vm_start;
    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
    unsigned long page = ((rtc_sp->iobase + offset) >> PAGE_SHIFT);

    if (offset > __pa(high_memory) || (filep->f_flags & O_SYNC)) {
        vma->vm_flags |= VM_IO;
    }

    vma->vm_flags |= VM_RESERVED;

    if (offset == RTC_COMMON_VADDR) {
        debug_out(("RTC_COMMON_VADDR: %x\n", offset));

        // page = virt_to_phys((void*)((unsigned
long)rtc_sp->shared_host_mem));
        // page = page_to_pfn(virt_to_page(phys_to_virt(__pa(page))));
        while (size > 0) {
            debug_out(("START: %#lx, SIZE: %#lx, OFFSET: %#lx, PAGE:
%#lx\n",
                start, size, offset, page));

            if (remap_pfn_range(vma,
                start,
                    page,
                        PAGE_SIZE,
                            PAGE_SHARED)) {
                return(-EAGAIN);
            }

            start += PAGE_SIZE;
            page += PAGE_SIZE;

            if (size > PAGE_SIZE) {
                size -= PAGE_SIZE;
            } else {
                size = 0;
            }
        }
    }

    else {
        debug_out(("RTC_???_OFFSET --- WE'RE BROKEN --- %x\n", offset));
    }

    return(0);
}

Now the driver like that loads and attaches without blowing up.
However, from userspace, when I open("/dev/mvp_rtc", O_RDWR) and then
try and mmap it, when I read it back, I can read back rtc_shared but I
can't read rtc_shared->snap_addrs_loc.

My main hope is that someone will spot something I'm obviously doing
wrong but if not, my next question is:

Is the virtual address that I get back from the kernel in
all_rtc_usr_shared going to be the same address that I read in
userspace?  Because right now I'm getting back something like 0xc11a0000
from the kernel and then I'm seeing something like 0xbf73000 in
userspace.

Thanks again for all the help and with a little more coaching I just
might get this blasted thing working before I retire 99 years from now!

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

