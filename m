Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWFBRxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWFBRxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWFBRxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:53:45 -0400
Received: from mail.visionpro.com ([63.91.95.13]:38747 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S932089AbWFBRxo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:53:44 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Still struggling with Shared Kernel/User memory
Date: Fri, 2 Jun 2006 10:53:43 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3368@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Still struggling with Shared Kernel/User memory
Thread-Index: AcaGbXyzgq5pH+tTSp2ll2TlKx1SZQ==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>, <linux-poweredge@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on these drivers and all is working well except the chunks
of memory that we allocate between kernel space and userspace for the
"shared" memory.  

When we load the driver at boot, we allocate, map and reserve the
memory:

typedef struct RtcSoftDev_struct {

    struct semaphore sem;
    u_int  Interrupt;
    u_int  context;
    void                *base;
    unsigned long       iobase;
    unsigned long       iosize;
    char                devname[8];
    int                 dev_num;
    struct pci_dev *    pdev;
    int                 rtc_major;
    u8                  myint;
    unsigned long       irq_cnt;


    spinlock_t mutex;           /* linux mutex equivilent */

    RtcShared *         shared_host_mem;
    RtcShared *         shared_host_mem_area;

} RtcSoftDev;
~

typedef struct rtc_shared {
    unsigned long       snap_addrs_loc;
    time_t              ntimestamp;
} RtcShared;

static int
alloc_rtc_usr_shared(RtcSoftDev *rtc_sp) {
    debug_out(("ALLOC_RTC_USR_SHARED\n"));

    unsigned long addr;
    unsigned long bytes = PAGE_SIZE << get_order(RTC_COMMON_SIZE);
    unsigned long sz;

    debug_out(("BYTES: %#lx, ORDER: %#lx, RTC_COMMON_SIZE: %#lx\n",
        bytes, get_order(RTC_COMMON_SIZE), RTC_COMMON_SIZE));

    rtc_sp->shared_host_mem =
        __get_free_pages(GFP_KERNEL, get_order(RTC_COMMON_SIZE));

    if (rtc_sp->shared_host_mem == NULL) {
        debug_out(("alloc_rtc_usr_shared: out of memory.\n"));
        return(0);
    }

    memset((void *)rtc_sp->shared_host_mem, 0, bytes);

    for (addr = rtc_sp->shared_host_mem, sz = bytes;
        sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
            debug_out(("SetPageReserved: virt: %#lx, addr: %#lx\n",
                virt_to_page(addr), addr));

            SetPageReserved(virt_to_page(addr));
    }

    rtc_sp->shared_host_mem->snap_addrs_loc     = 911;
    rtc_sp->shared_host_mem->ntimestamp         = 119;

    debug_out(("rtc_sp->shared_host_mem = %#lx\n",
        rtc_sp->shared_host_mem));

    debug_out(("rtc_sp->shared_host_mem->snap_addrs_loc = %#lx (%d)\n",
        rtc_sp->shared_host_mem->snap_addrs_loc,
        rtc_sp->shared_host_mem->snap_addrs_loc));

    debug_out(("rtc_sp->shared_host_mem->ntimestamp = %#lx (%d)\n",
        rtc_sp->shared_host_mem->ntimestamp,
        rtc_sp->shared_host_mem->ntimestamp));

    debug_out(("ALLOC_RTC_USR_SHARED\n"));
    return(0);
}

And then when we mmap, we do this:

static int
alloc_rtc_usr_shared(RtcSoftDev *rtc_sp) {
    debug_out(("ALLOC_RTC_USR_SHARED\n"));

    unsigned long addr;
    unsigned long bytes = PAGE_SIZE << get_order(RTC_COMMON_SIZE);
    unsigned long sz;

    debug_out(("BYTES: %#lx, ORDER: %#lx, RTC_COMMON_SIZE: %#lx\n",
        bytes, get_order(RTC_COMMON_SIZE), RTC_COMMON_SIZE));

    rtc_sp->shared_host_mem =
        __get_free_pages(GFP_KERNEL, get_order(RTC_COMMON_SIZE));

    if (rtc_sp->shared_host_mem == NULL) {
        debug_out(("alloc_rtc_usr_shared: out of memory.\n"));
        return(0);
    }

    memset((void *)rtc_sp->shared_host_mem, 0, bytes);

    for (addr = rtc_sp->shared_host_mem, sz = bytes;
        sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
            debug_out(("SetPageReserved: virt: %#lx, addr: %#lx\n",
                virt_to_page(addr), addr));

            SetPageReserved(virt_to_page(addr));
    }

    rtc_sp->shared_host_mem->snap_addrs_loc     = 911;
    rtc_sp->shared_host_mem->ntimestamp         = 119;

    debug_out(("rtc_sp->shared_host_mem = %#lx\n",
        rtc_sp->shared_host_mem));

    debug_out(("rtc_sp->shared_host_mem->snap_addrs_loc = %#lx (%d)\n",
        rtc_sp->shared_host_mem->snap_addrs_loc,
        rtc_sp->shared_host_mem->snap_addrs_loc));

    debug_out(("rtc_sp->shared_host_mem->ntimestamp = %#lx (%d)\n",
        rtc_sp->shared_host_mem->ntimestamp,
        rtc_sp->shared_host_mem->ntimestamp));

    debug_out(("ALLOC_RTC_USR_SHARED\n"));
    return(0);
}

int
rtc_mmap(struct file *filep, struct vm_area_struct *vma) {
    RtcSoftDev *rtc_sp = filep->private_data;

    unsigned long start = vma->vm_start;
    unsigned long size = vma->vm_end - vma->vm_start;
    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
    unsigned long page = ((rtc_sp->iobase + offset) >> PAGE_SHIFT);

    if (offset > __pa(high_memory) || (filep->f_flags & O_SYNC)) {
        vma->vm_flags |= VM_IO;
    }

    vma->vm_flags |= VM_RESERVED;

    if ((offset == RTC_SNAP_INTERVAL_OFFSET)
        || (offset == RTC_DIGIO_OFFSET)
        || (offset == RTC_STROBE_TIMER_OFFSET)
        || (offset == RTC_CONTROL_REG_OFFSET)
        || (offset == RTC_ENCODER_CNT_OFFSET)
        || (offset == RTC_GRAPHICS_REG_OFFSET)
        || (offset == RTC_CY545_TRANS_OFFSET)
        || (offset == RTC_CY545_CONTROL_OFFSET)
        || (offset == RTC_GRAPHICS_MEM_OFFSET))
    {
        while (size > 0) {
            if (remap_pfn_range(vma, start, page, PAGE_SIZE,
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

    else if (offset == RTC_COMMON_VADDR) {
        debug_out(("RTC_COMMON_VADDR\n"));

        debug_out(("RTC: vma = %#lx\n", vma));
        debug_out(("RTC: vma->vm_start = %#lx\n", vma->vm_start));
        debug_out(("RTC: vma->vm_end = %#lx\n", vma->vm_end));
        debug_out(("RTC: vma->vm_pgoff = %#lx\n", vma->vm_pgoff));
        debug_out(("RTC: vma->vm_end - vma->vm_start = %#lx\n", size));
        debug_out(("RTC: rtc_sp->iobase = %#lx\n", rtc_sp->iobase));
        debug_out(("RTC: page = %#lx\n", page));
        debug_out(("RTC: offset = %#lx\n", offset));
        debug_out(("RTC: rtc_sp->shared_host_mem = %#lx\n",
rtc_sp->shared_host_mem));

        if (remap_pfn_range(vma,
            start,
                rtc_sp->shared_host_mem,
                    PAGE_SIZE,
                        PAGE_SHARED))
        {
            return(-EAGAIN);
        }
    }

    else {
        debug_out(("RTC_???_OFFSET --- WE'RE BROKEN --- %x\n", offset));
    }

    return(0);
}

When the driver loads I get this in my kernel log file:

[17179664.560000] rtc_probe: RTC 0x000000a2 found @bus 6 dev 3 func 0
[17179664.560000] alloc_rtc_soft_state: return 0 [17179664.560000]
rtc_probe: device 0 [17179664.560000] rtc_probe_module: base start
0xd0000000 size 0x00400000 [17179664.560000] rtc_map_one(0): Successful
map Snap Interval: Phys 0xd0020000 [17179664.560000] rtc_map_one(0):
Successful map Digital I/O: Phys 0xd0040000 [17179664.568000]
rtc_map_one(0): Successful map Strobe Timer: Phys 0xd0060000
[17179664.568000] rtc_map_one(0): Successful map Control Reg: Phys
0xd0080000 [17179664.568000] rtc_map_one(0): Successful map Encoder
Counter: Phys 0xd00a0000 [17179664.584000] rtc_map_one(0): Successful
map Graphics Register: Phys 0xd00c0000 [17179664.584000] rtc_map_one(0):
Successful map CY545 Trans Reg: Phys 0xd00e0000 [17179664.588000]
rtc_map_one(0): Successful map CY545 Control Reg: Phys 0xd00f0000
[17179664.588000] rtc_map_one(0): Successful map Graphics Memory: Phys
0xd0200000 [17179664.588000] ALLOC_RTC_USR_SHARED [17179664.588000]
BYTES: 0x1000, ORDER: 0x0, RTC_COMMON_SIZE: 0x8 [17179664.588000]
rtc_sp->shared_host_mem = 0xd8c37000 [17179664.588000]
rtc_sp->shared_host_mem->snap_addrs_loc = 0x38f (911) [17179664.588000]
rtc_sp->shared_host_mem->ntimestamp = 0x77 (119) [17179664.588000]
ALLOC_RTC_USR_SHARED [17179664.588000] rtc_probe_module: got major 253
[17179664.588000] MVP Real Time Controller Board A: /dev/rtc0, A2.J,
Int: 225 [17179664.588000] driver(0) $Id: mvp_rtc.c,v 1.3 2006/04/18
21:20:36 brian Exp brian $ (c) MVP [17181068.308000] rtc_open: major 253
minor 0 [17181068.308000] find_rtc_soft_state: major 253
[17181068.308000] find_rtc_soft_state: return 0

Which is a good thing (I think).  But then I run my little test program:

#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <signal.h>

#define VADDR                           0x010000
#define SIZE                            0x1000

typedef struct rtc_shared {
    unsigned long       snap_addrs_loc;
    time_t              ntimestamp;
} RtcShared;

RtcShared       *rtc_shared;

static inline void
quick_unmap(int fd, char *pointer, int size) {
    if (pointer != MAP_FAILED) {
        if (munmap(pointer, size) < 0)
            abort();
    }
}

static inline char *
quick_map(int fd, off_t offset, size_t len, const char *name) {
    int prot = (PROT_READ | PROT_WRITE);
    int flags = MAP_SHARED;

    char *addr;
    addr = mmap(0, len, prot, flags, fd, offset);

    if (addr == MAP_FAILED) {
        abort();
    }

    return(addr);
}

int
main(int argc, char *argv[])
{
    int rtc = open("/dev/mvp_rtc", O_RDWR);

    if (!rtc)
        abort();

    rtc_shared = (RtcShared *) quick_map(rtc, VADDR, SIZE, "Common");
    printf("rtc_shared: %#lx\n", rtc_shared);
    printf("rtc_shared->snap_addrs_loc: %#lx\n", *rtc_shared);

#if 0
    rtc_shared->snap_addrs_loc = 0;
#else
    rtc_shared->snap_addrs_loc = 0;
    printf("rtc_shared->snap_addrs_loc: %#lx\n",
rtc_shared->snap_addrs_loc); #endif

    quick_unmap(rtc, (char *) rtc_shared, SIZE);

    close(rtc);
    return(0);
}

And I get:

12_ rtcquicktest
rtc_shared: 0xb7f32000
Segmentation fault
mvp-sw5:~/mvp/work/pcb-linux/misc/dev-drivers/linux/rtc 10:45:39 13_

And this is in my kernel log file:

[17182140.568000] rtc_open: major 253 minor 0 [17182140.568000]
find_rtc_soft_state: major 253 [17182140.568000] find_rtc_soft_state:
return 0 [17182140.568000] rtc opened by rtcquicktest pid 5978 PAGE_SIZE
0x1000 [17182140.568000] RTC_COMMON_VADDR [17182140.568000] RTC: vma =
0xde521184 [17182140.568000] RTC: vma->vm_start = 0xb7f32000
[17182140.568000] RTC: vma->vm_end = 0xb7f33000 [17182140.568000] RTC:
vma->vm_pgoff = 0x10 [17182140.568000] RTC: vma->vm_end - vma->vm_start
= 0x1000 [17182140.568000] RTC: rtc_sp->iobase = 0xd0000000
[17182140.568000] RTC: page = 0xd0010 [17182140.568000] RTC: offset =
0x10000 [17182140.568000] RTC: rtc_sp->shared_host_mem = 0xd8c37000

I'm pretty sure the problem is in my kernel in the remap_pfn_range with
the 'page' variable but I'm not sure what I'm doing wrong ... Anything
you can offer???  Cuz I really don't want to go to jail for homicide
today!!!

???

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

