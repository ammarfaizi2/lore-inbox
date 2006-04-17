Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWDQRpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWDQRpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWDQRpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:45:20 -0400
Received: from mail.visionpro.com ([63.91.95.13]:2506 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751185AbWDQRpT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:45:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: PCI Device Driver / remap_pfn_range()
Date: Mon, 17 Apr 2006 10:45:18 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B2F38@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Device Driver / remap_pfn_range()
Thread-Index: AcZiRXnnGEv1/aZkSuSrONUN3yGUPwAAFqwA
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few weeks back I posted a cry for help with a PCI device driver which
maps hardware memory into user/kernel space using what used to be called
remap_page_range in the 2.6.9 kernel and now I'm trying to use
remap_pfn_range.

I'm still struggling with this and I'm hoping that there is an expert
out there who can point out what I'm doing wrong!!!  My source code is
attached and I know I'm probably not doing this in the best way; but
it's the only way I don't know how, since I'm tasked with a job where I
have no idea what I'm doing!

When I try and access my device, which should be /dev/ibb[0-3], I get a
segmentation fault then a core dump and within a few seconds after that,
the system becomes way unstable and has to be rebooted (if it doesn't
lock up hard first).

TIA,

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--

static const char *ibb_c = "$Id: ibb.c,v 1.3 2006/04/17 16:08:06 brian
Exp brian $(c) MVP ";

#include <asm/uaccess.h>
#include <linux/config.h>
#include <linux/fs.h>
#include <linux/interrupt.h>
#include <asm/io.h>
#include <linux/mm.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/slab.h>
#include <linux/types.h>

#include "dev/ibb.h"
#include "ibbsoft.h"

#ifndef __KERNEL__
#define __KERNEL__
#endif

#ifndef MODULE
#define MODULE
#endif

#ifndef CONFIG_PCI
#error "This driver REQUIRES PCI support!"
#endif

#if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
#define MODVERSIONS
#endif

#ifdef CONFIG_DEVFS_FS
#include <linux/devfs_fs_kernel.h>
#endif

void ibb_rtc_wakeup(void);
irqreturn_t ibb_intr(int irq, void *dev_id, struct pt_regs *regs);

EXPORT_SYMBOL(ibb_rtc_wakeup);

/*
 * Split minors in two parts
 */
#define TYPE(dev)   (MINOR(dev) >> 4)  /* high nibble */
#define NUM(dev)    (MINOR(dev) & 0xf) /* low  nibble */
#define dcmn_err(lvl, msg) { if ((lvl) < ibb_debug) printk msg; }

/*
 * array of devices
 */
static IbbSoftDev *IbbSoft[kMaxIbbs];

static const uint32_t kIoWaiting	= 0x04;
static const uint32_t MAG_FB_NUMBER	= 0xCE1E57E;
static const uint16_t kIbbWakeup	= 0x0fff;

/*
 * local static variable
 */
static u_int ibb_debug = 100;

/*
 * clamp the max frame buffer size to the lowest available memory size
 */
typedef struct ibb_ishared_attr {
    u_int32_t	frame_buffer_size;
    int32_t	dev_instance[kMaxIbbs];
} ibb_ishared_attr;

static ibb_ishared_attr ishared;

static void
lock_ibb(IbbSoftDev *ibb_sp, u_long *flags, const char *where)
{
    dcmn_err(70, ("<1>" "lock_ibb(%d): %s:\n", ibb_sp->dev_num, where));
    spin_lock_irqsave(&ibb_sp->mutex, *flags);
    dcmn_err(70, ("<1>" "lock_ibb(%d): Done %s:\n", ibb_sp->dev_num,
where));
}

static void
unlock_ibb(IbbSoftDev *ibb_sp, u_long *flags, const char *where)
{
    dcmn_err(70, ("<1>" "unlock_ibb(%d): %s:\n", ibb_sp->dev_num,
where));
    spin_unlock_irqrestore(&ibb_sp->mutex, *flags);
    dcmn_err(70, ("<1>" "unlock_ibb(%d): Done %s:\n", ibb_sp->dev_num,
where));
}

static void
init_ibb_soft_state(void)
{
    int i;
    dcmn_err(70, ("<1>" "init_ibb_soft_state:\n"));

    for (i = 0; i < kMaxIbbs; i++)
	IbbSoft[i] = NULL;

    dcmn_err(70, ("<1>" "init_ibb_soft_state: Done\n"));
}

static int
alloc_ibb_soft_state(void)
{
    int i;
    dcmn_err(70, ("<1>" "alloc_ibb_soft_state:\n"));

    for (i = 0; i < kMaxIbbs; i++) {
	if (IbbSoft[i] == NULL) {
	    IbbSoft[i] = kmalloc(sizeof(IbbSoftDev), GFP_KERNEL);

	    if (IbbSoft[i] == NULL) {
		dcmn_err(1, ("<1>" "alloc_ibb_soft_state: out of
memory.\n"));
		return(-1);
	    }

	    dcmn_err(70, ("<1>" "alloc_ibb_soft_state: return %d\n",
i));
	    return(i);
	}
    }

    /* Shouldn't get here! */
    return(-1);
}

/*
 * There may be a better way to do this!
 *
 * I need to make sure the data I initialized in ibb_probe()
 * for device "X"  is the same data I use in ibb_open().
 *
 * I could use the minor numbers, but I have to trust that
 * the 'load' script for the ibb device is written correctly,
 * since that's where minor numbers are assigned.
 *
 * So I'm using the major numbers.  It's a little slower, since
 * major numbers tend to be >200 I'm not just going to use
 * them as indexes into my array.  Instead I'm going though
 * all the devices looking for the matching major.
 *
 * My concern, frankly, is that no other drivers seem to be
 * using this method.  But it seems the only foolproof way
 * to keep the data with the device
 */

static int
find_ibb_soft_state(int ibb_major)
{
    int i;
    dcmn_err(70, ("<1>" "find_ibb_soft_state: major %d\n", ibb_major));

    for (i = 0; i < kMaxIbbs; i++) {
	if (IbbSoft[i] != NULL) {
	    if (ibb_major == IbbSoft[i]->ibb_major) {
		dcmn_err(70, ("<1>" "find_ibb_soft_state: return %d\n",
i));
		return(i);
	    }
	}
    }

    dcmn_err(1,("<1>"
	"find_ibb_soft_state: Can't find matching soft_state %d!\n",
	ibb_major));

    return(-1);
}

static void
free_ibb_soft_state(int i)
{
    if(IbbSoft[i] == NULL)
	return;

    dcmn_err(70, ("<1>" "free_ibb_soft_state(%d):\n",
IbbSoft[i]->dev_num));

    kfree(IbbSoft[i]);
    IbbSoft[i] = NULL;

    return;
}

ssize_t
ibb_read(struct file *filp, char *buf, size_t count, loff_t *f_pos)
{
    dcmn_err(1, ("<1>" "ibb_read:\n"));
    return(-EINVAL);
}

ssize_t 
ibb_write(struct file *filp, const char *buf, size_t count, loff_t
*f_pos)
{
    dcmn_err(1, ("<1>" "ibb_write:\n"));
    return(-EINVAL);
}

/* 
 * IBBWAIT ioctl routine 
 * wait for ushared->image_table_index to *exceed* value
 * passed in - (IBBWAIT,0) waits for snap 0 to be processed and
 * index to advance to 1
 */

static inline int 
ibb_wait(IbbSoftDev *ibb_sp, u_long arg)
{
    uint32_t table_index = (uint32_t)arg;
    int dev_num = ibb_sp->dev_num;

    u_long flags;
    int wq_ret = 0;

    if (ibb_sp->ushared == NULL) {
	return(EAGAIN);
    }

    if (ibb_sp->ushared->image_table_index > table_index) {
	dcmn_err(27, ("<1>" "ibb_ioctl(%d): IBBWAIT already got index
%d\n",
	    dev_num, ibb_sp->ushared->image_table_index)); 

	return(0);
    }

    lock_ibb(ibb_sp, &flags, "IBBWAIT 0");

    ibb_sp->flags |= kIoWaiting;
    ibb_sp->wait_for = table_index;

    unlock_ibb(ibb_sp, &flags, "IBBWAIT 0");

    dcmn_err(27, ("<1>" "ibb_ioctl(%d): IBBWAIT wait for %u, %u\n",
	dev_num, ibb_sp->wait_for, ibb_sp->ushared->image_table_index)
);

    wq_ret = wait_event_interruptible(ibb_sp->wq, 
	(ibb_sp->ushared->image_table_index > table_index));

    dcmn_err(27, ("<1>" "ibb_ioctl(%d): IBBWAIT got index %d\n",
	dev_num,ibb_sp->wait_for) );

    lock_ibb(ibb_sp, &flags, "IBBWAIT 1");

    ibb_sp->flags &= ~kIoWaiting;

    unlock_ibb(ibb_sp, &flags, "IBBWAIT 1");

    if (ibb_sp->wait_for == kIbbWakeup) {
	dcmn_err(27, ("<1>" "ibb_ioctl(%d): IBBWAIT got Wakeup\n",
	    dev_num));
    }
    else if (ibb_sp->ushared->image_table_index > ibb_sp->wait_for) {
	dcmn_err(27, ("<1>" "ibb_ioctl(%d): IBBWAIT got index %d\n",
	    dev_num,ibb_sp->wait_for));
    }
    else {
	if(wq_ret != 0) {
	    dcmn_err(0, ("<1>" "ibb_ioctl(%d): IBBWAIT signal intr\n",
	    dev_num));
	}
	else {
	    dcmn_err(0, ("<1>" "ibb_ioctl(%d): IBBWAIT Weird cond.\n",
	    dev_num));
	}

	return(-1);	/* !! there's been a problem */
    }

    return(0);
}

int
ibb_ioctl(struct inode *inode, struct file *filp, u_int cmd, u_long arg)
{
    IbbSoftDev *ibb_sp = filp->private_data;

    int retval = 0;
    u_long flags;

    if (ibb_sp == NULL) {
	dcmn_err(1, ("<1>" "ibb_ioctl(%d): Soft Info Lost\n",
	    ibb_sp->dev_num));

	return(-EFAULT);
    }

    switch (cmd) {
	case IBBWAIT:
	    dcmn_err(27, ("<1>" "ibb_ioctl(%d): cmd IBBWAIT arg %lu\n",
		ibb_sp->dev_num,arg));

	    retval = ibb_wait(ibb_sp, arg);
	    break;

	case IBBTST:
	    if (ibb_sp->image_table == NULL)
		return 0;

	    dcmn_err(1, ("<1>" "ibb_ioctl(%d): table 0 %x \n", 
		ibb_sp->dev_num,ibb_sp->image_table[0]) );
	    dcmn_err(1, ("<1>" "ibb_ioctl(%d): table 1 %x \n",
		ibb_sp->dev_num,ibb_sp->image_table[1]) );

	    break;

	case IBBWAKEUP:
	    dcmn_err(30, ("<1>" "ibb_ioctl(%d): cmd IBBWAKEUP\n",
		ibb_sp->dev_num));

	    retval = 0;

	    if (ibb_sp->flags & kIoWaiting) {
		lock_ibb(ibb_sp, &flags, "IBBWAKEUP");
		ibb_sp->wait_for = kIbbWakeup;
		unlock_ibb(ibb_sp, &flags, "IBBWAKEUP");
		wake_up_interruptible(&ibb_sp->wq);
	    }

	    break;

	case IBBFBACOUNT:
	    dcmn_err(30, ("<1>" "ibb_ioctl(%d): cmd IBBFBACOUNT arg
%lu\n",
		ibb_sp->dev_num, arg) );

	    lock_ibb(ibb_sp, &flags, "IBBFBACOUNT");
	    *(ibb_sp->fbac_virt) = (uint32_t)arg;
	    unlock_ibb(ibb_sp, &flags, "IBBFBACOUNT");

	    dcmn_err(37, ("<1>" "ibb_ioctl(%d): set fb count to %u\n",
		ibb_sp->dev_num,*(ibb_sp->fbac_virt)) );

	    retval = 0;
	    break;

	case IBBFSIZE:
	    dcmn_err(30, ("<1>" "ibb_ioctl(%d): cmd IBBFSIZE arg %lu\n",

		ibb_sp->dev_num,arg) );

	    lock_ibb(ibb_sp, &flags, "IBBFSIZE");
	    *(ibb_sp->fsize_virt) = (uint32_t)arg;
	    unlock_ibb(ibb_sp, &flags, "IBBFSIZE");

	    dcmn_err(37, ("<1>" "ibb_ioctl(%d): set frame size to %u\n",
		ibb_sp->dev_num,*(ibb_sp->fsize_virt)));

	    break;

	case IBBSIZE:
	    dcmn_err(30, ("<1>" "ibb_ioctl(%d): cmd is IBBSIZE: %d\n", 
		ibb_sp->dev_num, ishared.frame_buffer_size));

	    retval = put_user(ishared.frame_buffer_size, (u_long *)arg);
	    break;

	case IBBVERSION:
	    if (put_user(kIbbVersion, (u_long *)arg)) {
		dcmn_err(1, ("<1>" "ibb_ioctl(%d): can't copy ver info
%d\n",
		    ibb_sp->dev_num,(int)kIbbVersion)) ;

		retval = -EFAULT;
	    }

	    dcmn_err(1, ("<1>" "ibb_ioctl(%d): Copied ver info %d\n",
		ibb_sp->dev_num, (int)kIbbVersion));
	
	    break;

	case IBBCLIBB_ID:
	    if (put_user(ibb_sp->clibb_id, (short *)arg)) {
		dcmn_err(1, ("<1>" "ibb_ioctl(%d): can't copy CLIBB ID
%d\n",
		    ibb_sp->dev_num,ibb_sp->clibb_id)) ;

		retval = -EFAULT;
	    }

	    dcmn_err(1, ("<1>" "ibb_ioctl(%d): Copied CLIBB IDD %d\n",
		ibb_sp->dev_num,ibb_sp->clibb_id));
	
	    break;

	case IBBHEIGHTGO:
	    if (ibb_sp->clibb_id != kClibb_HSC) {
		dcmn_err(1, ("<1>" "ibb_ioctl(%d): ERROR: No Height
Sensor\n",
		    ibb_sp->dev_num) );

		return(-EFAULT);
	    }

	    ibb_sp->height_inspection = 1;

	    dcmn_err(1, ("<1>" "ibb_ioctl(%d): Start Height Inspection
%d\n",
		ibb_sp->dev_num,ibb_sp->height_inspection));
	
	    break;

	case IBBHEIGHTSTOP:
	    ibb_sp->height_inspection = 0;

	    dcmn_err(1, ("<1>" "ibb_ioctl(%d): Stop Height Inspection
%d\n",
		ibb_sp->dev_num,ibb_sp->height_inspection));
	
	    break;

	default:
	    dcmn_err(1,("<1>" "ibb_ioctl(%d): unknown case: %d\n", 
		ibb_sp->dev_num, cmd) );

	    return(-ENOTTY);
	    break;
    }

    return(retval);
}

int
ibb_open(struct inode *inode, struct file *filep)
{
    int dev_num;
    IbbSoftDev *ibb_sp;

    int major = MAJOR(inode->i_rdev);
    int minor = MINOR(inode->i_rdev);

    dcmn_err(40, ("<1>" "ibb_open: major %d minor %d\n",
	major, minor));

    dev_num = find_ibb_soft_state(major);

    if (dev_num < 0) {
	dcmn_err(0, ("<1>" "ibb_open: dev_num %d failed\n",
	    dev_num));

	return(-1);
    }

    ibb_sp = IbbSoft[dev_num];
    filep->private_data = ibb_sp;

    dcmn_err(40, ("<1>" "ibb_open(%d): opened by %s pid %d PAGE_SIZE
%#010lx\n",
    	dev_num,current->comm, current->pid, PAGE_SIZE));

    return(0);
}

int
ibb_close(struct inode *inode, struct file *filep)
{
    IbbSoftDev *ibb_sp = filep->private_data;

    dcmn_err(40, ("<1>" "ibb_close(%d): called\n",
	ibb_sp->dev_num));

    return(0);
}

static void
free_ibb_usr_shared(IbbSoftDev *ibb_sp)
{
    struct page *page;

    u_long virt_addr;
    u_long ushared_addr = (u_long)ibb_sp->ushared;

    for (virt_addr = ushared_addr; 
	    virt_addr < ushared_addr + PAGE_ALIGN(IBB_SHARED_SIZE);
	    virt_addr += PAGE_SIZE)
    {
    	page = virt_to_page(virt_addr);
	ClearPageReserved(page);

	atomic_set(&page->_count, 1);
	vfree((void *)virt_addr);
    }

    if (ibb_sp->ushared)
	ibb_sp->ushared = NULL;
}

static int
alloc_ibb_usr_shared(IbbSoftDev *ibb_sp)
{
    u_long virt_addr;
    u_long ushared_addr;
    int order = 0;

    /* 
     * From Linux Device Drivers - memory that is going to
     * be mmaped must be PAGE_SIZE grained.  Since we do mmap
     * ushared to user space, we need to allocated it in
     * PAGE_SIZE chunks.
     */

    int size = PAGE_ALIGN(IBB_SHARED_SIZE);

    dcmn_err(1, ("<1>" "ibb::size is %d\n", size));
    dcmn_err(1, ("<1>" "ibb::order is %d\n", order));

    do {
	dcmn_err(1, ("<1>" "ibb::size is %d\n", size));
	dcmn_err(1, ("<1>" "ibb::order is %d\n", order));

    	order++;
    } while (size > (PAGE_SIZE * (1 << order)));

//  ibb_sp->ushared = (IbbUserShared *) __get_free_pages(GFP_KERNEL,
order);
    ibb_sp->ushared = (IbbUserShared *) vmalloc(4096 * 1024);

    if (ibb_sp->ushared == NULL) {
	dcmn_err(1, ("<1>" "alloc_ibb_usr_shared(%d): out of memory.\n",
	    ibb_sp->dev_num));

	return(-1);
    }

    ushared_addr = (u_long) ibb_sp->ushared;

    /* reserve all pages to make them remapable */
    for (virt_addr = ushared_addr;
	    virt_addr < ushared_addr + size;
	    virt_addr += PAGE_SIZE)
    {
	SetPageReserved(virt_to_page(virt_addr));
    }

    ibb_sp->ushared->badsnap = 0;
    ibb_sp->ushared->image_table_index = 0;

    return(0);
}

static void
free_ibb_image_table_mem(IbbSoftDev *ibb_sp)
{
    uint32_t *virt_addr;
    struct page *page;

    dcmn_err(1, ("<1>" "free_ibb_image_table_mem(%d): Free size %d.\n",
	ibb_sp->dev_num,ibb_sp->image_table_size));

    /* unreserve all pages */
    for( virt_addr = ibb_sp->image_table; 
	   virt_addr < ibb_sp->image_table + ibb_sp->image_table_size;
	   virt_addr += PAGE_SIZE)
    {
    	page = virt_to_page(virt_addr);
	ClearPageReserved(page);

	atomic_set(&page->_count, 1);
	free_page((void *)virt_addr);
    }

    if (ibb_sp->image_table) {
	ibb_sp->image_table = NULL;
    }

    ibb_sp->image_table_size = 0;
    return;
}

static int
alloc_ibb_image_table_mem(IbbSoftDev *ibb_sp, int size)
{
    int order = 0;
    uint32_t *virt_addr;

    u_int table_size = PAGE_ALIGN(size);

    dcmn_err(1, ("<1>" "alloc_ibb_image_table_mem(%d): Alloc size
%d.\n",
	ibb_sp->dev_num,table_size) );

    /* 
     * get a memory area with kmalloc and aligned it to a page. This
area
     * will be physically contigous
     */

    while (size > (PAGE_SIZE * (1 << order))) {
    	order++;
    }

//  ibb_sp->image_table = (uint32_t *) __get_free_pages(GFP_KERNEL,
order);
    ibb_sp->ushared = (IbbUserShared *) vmalloc(4096 * 1024);

    if (ibb_sp->image_table == NULL) {
	dcmn_err(1, ("<1>" "alloc_ibb_image_table_mem(%d): out of
memory.\n",
	    ibb_sp->dev_num));

	ibb_sp->image_table_size = 0;
	return(-1);
    }

    /* reserve all pages to make them remapable */
    for (virt_addr = ibb_sp->image_table; 
	    virt_addr < ibb_sp->image_table + table_size; 
	    virt_addr += PAGE_SIZE)
    {
	SetPageReserved(virt_to_page(virt_addr));
    }

    ibb_sp->image_table_size = table_size;
    return(0);
}

static int 
ibb_map_one(IbbSoftDev *ibb_sp, u_long phys, u_long size, uint32_t
**virt, const char *what)       
{
    struct resource *res;

    if ((res = request_mem_region(phys, size, ibb_sp->devname)) == NULL)
{
	dcmn_err(0, ("<1>" 
	    "ibb_map_one(%d): can't allocate %s at %010lx %#010lx %s\n",
	    ibb_sp->dev_num,what,phys,size,ibb_sp->devname));

	return(-1);
    }
    else {
	*virt = ioremap_nocache(phys, size);

	if (!virt) {
	    dcmn_err(0, ( "<1>" "ibb_map_one(%d): Error in ioremap\n",
		ibb_sp->dev_num));

	    release_mem_region(phys, size);
	    return(-1);
	}
    }

    dcmn_err(40, ( "<1>" "ibb_map_one(%d): Successful map %s\n",
	ibb_sp->dev_num,what));

    return(0);
}

static void
free_all_mappings(IbbSoftDev *ibb_sp)
{
    if (ibb_sp->creg_virt != NULL) {
	iounmap(ibb_sp->creg_virt);
	ibb_sp->creg_virt = NULL;
    }

    /* we can call release_mem_region() without checking anything -
     * if the region hasn't been requested, the function will
     * just exit with an error message.
     * (unlike iounmap())
     */

    release_mem_region(ibb_sp->creg_phys, ibb_sp->creg_size);
    if (ibb_sp->height_virt != NULL) {
	iounmap(ibb_sp->height_virt);
	ibb_sp->height_virt = NULL;
    }

    release_mem_region(ibb_sp->height_phys, ibb_sp->height_size);
    if (ibb_sp->csram_virt != NULL) {
	iounmap(ibb_sp->csram_virt);
	ibb_sp->csram_virt = NULL;
    }

    release_mem_region(ibb_sp->csram_phys, ibb_sp->csram_size);
    if (ibb_sp->rsram_virt != NULL) {
	iounmap(ibb_sp->rsram_virt);
	ibb_sp->rsram_virt = NULL;
    }

    release_mem_region(ibb_sp->rsram_phys, ibb_sp->rsram_size);
    if (ibb_sp->fbac_virt != NULL) {
	iounmap(ibb_sp->fbac_virt);
	ibb_sp->fbac_virt = NULL;
    }

    release_mem_region(ibb_sp->fbac_phys, ibb_sp->fbac_size);
    if (ibb_sp->camdelay_virt != NULL) {
	iounmap(ibb_sp->camdelay_virt);
	ibb_sp->camdelay_virt = NULL;
    }

    release_mem_region(ibb_sp->camdelay_phys, ibb_sp->camdelay_size);
    if (ibb_sp->fsize_virt != NULL) {
	iounmap(ibb_sp->fsize_virt);
	ibb_sp->fsize_virt = NULL;
    }

    release_mem_region(ibb_sp->fsize_phys, ibb_sp->fsize_size);
    if (ibb_sp->extime_virt != NULL) {
	iounmap(ibb_sp->extime_virt);
	ibb_sp->extime_virt = NULL;
    }

    release_mem_region(ibb_sp->extime_phys, ibb_sp->extime_size);
    if (ibb_sp->plsram_virt != NULL) {
	iounmap(ibb_sp->plsram_virt);
	ibb_sp->plsram_virt = NULL;
    }

    release_mem_region(ibb_sp->plsram_phys, ibb_sp->plsram_size);
    if (ibb_sp->fb0_virt != NULL) {
	iounmap(ibb_sp->fb0_virt);
	ibb_sp->fb0_virt = NULL;
    }

    release_mem_region(ibb_sp->fb0_phys, ibb_sp->fb0_size);
    if (ibb_sp->fb1_virt != NULL) {
	iounmap(ibb_sp->fb1_virt);
	ibb_sp->fb1_virt = NULL;
    }

    release_mem_region(ibb_sp->fb1_phys, ibb_sp->fb1_size);
    if (ibb_sp->image_table != NULL) {
	free_ibb_image_table_mem(ibb_sp);
    }

    if (ibb_sp->ushared != NULL) {
	free_ibb_usr_shared(ibb_sp);
    }

    return;
}

static int
ibb_map_frame_buffer(IbbSoftDev *ibb_sp, u_long phys, ulong
*size,uint32_t **virt, const char *what)
{
    char whatsize[100];
    uint32_t *check_addr;

    long check;

    sprintf(whatsize,"%s 64", what);
    *size = IBB_FB_64_MG;

    if (ibb_map_one(ibb_sp, phys, *size, virt, whatsize) < 0) {
	return(-1);
    }

    check = MAG_FB_NUMBER;
    check_addr = *virt;
    writel(check, check_addr);

    dcmn_err(45, ("<1>" "ibb_map_frame_buffer(%d): %s put %lX at addr
%p\n",
	ibb_sp->dev_num, whatsize, check, check_addr));

    check = readl(check_addr);

    dcmn_err(45, ("<1>" "ibb_map_frame_buffer(%d): %s read %lX at addr
%p\n",
	ibb_sp->dev_num, whatsize, check, check_addr));

    check_addr = (*virt) + (IBB_FB_32_MG / 4);
    check = readl(check_addr);

    dcmn_err(45, ("<1>" "ibb_map_frame_buffer(%d): %s read %lX at addr
%p\n",
	ibb_sp->dev_num, whatsize, check, check_addr));

    if (check == MAG_FB_NUMBER) {
	/* we only have 32 MB, but we've mapped 64 - try again */
	iounmap(*virt);
	(*virt) = NULL;
	release_mem_region(phys, *size);

	sprintf(whatsize, "%s 32", what);
	*size = IBB_FB_32_MG;

	if (ibb_map_one(ibb_sp, phys, *size, virt, whatsize) < 0) {
	    return(-1);
	}

	ishared.frame_buffer_size = IBB_FB_32_MG;
    }

    return(0);
}

static int
ibb_do_all_mappings(IbbSoftDev *ibb_sp)
{
    /* 
     * Initialize here so we can call free_all_mappings without
     * freeing unallocated mem
     */

    ibb_sp->creg_virt		= NULL;
    ibb_sp->height_virt		= NULL;
    ibb_sp->csram_virt		= NULL;
    ibb_sp->rsram_virt		= NULL;
    ibb_sp->fbac_virt		= NULL;
    ibb_sp->camdelay_virt	= NULL;
    ibb_sp->fsize_virt		= NULL;
    ibb_sp->extime_virt		= NULL;
    ibb_sp->plsram_virt		= NULL;
    ibb_sp->fb0_virt		= NULL;
    ibb_sp->fb1_virt		= NULL;
    ibb_sp->image_table		= NULL;
    ibb_sp->image_table_size	= 0;

    /* Map Control Register */

    ibb_sp->creg_phys = ibb_sp->iobase + IBB_CONTROL_OFF;
    ibb_sp->creg_size = IBB_CONTROL_SIZE;		

    if (ibb_map_one(ibb_sp,
	    ibb_sp->creg_phys,
	    ibb_sp->creg_size,
	    &ibb_sp->creg_virt,
	    "Control Register") < 0)
    {
	return(-1);
    }

    /* Map Height Sensor Register */

    ibb_sp->height_phys = ibb_sp->iobase + IBB_HEIGHT_OFF;
    ibb_sp->height_size = IBB_HEIGHT_SIZE;		

    if (ibb_map_one(ibb_sp,
	    ibb_sp->height_phys,
	    ibb_sp->height_size,
	    &ibb_sp->height_virt,
	    "Height Sensor") < 0)
    {
	return(-1);
    }

    /* Map Col Sram */

    ibb_sp->csram_phys = ibb_sp->iobase + IBB_CSRAM_OFF;
    ibb_sp->csram_size = IBB_CSRAM_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->csram_phys,
	    ibb_sp->csram_size,
	    &ibb_sp->csram_virt,
	    "Col Sram") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* Map Row Sram */

    ibb_sp->rsram_phys = ibb_sp->iobase + IBB_RSRAM_OFF;
    ibb_sp->rsram_size = IBB_RSRAM_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->rsram_phys,
	    ibb_sp->rsram_size,
	    &ibb_sp->rsram_virt,
	    "Row Sram") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* map FB Address Counter */

    ibb_sp->fbac_phys = ibb_sp->iobase + IBB_FBACOUNT_OFF;
    ibb_sp->fbac_size = IBB_FBACOUNT_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->fbac_phys,
	    ibb_sp->fbac_size,
	    &ibb_sp->fbac_virt,
	    "FB Addr Count") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* map Camera Delay Register */

    ibb_sp->camdelay_phys = ibb_sp->iobase + IBB_CAMDELAY_OFF;
    ibb_sp->camdelay_size = IBB_CAMDELAY_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->camdelay_phys,
	    ibb_sp->camdelay_size,
	    &ibb_sp->camdelay_virt,
	    "Cameral Delay Reg") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* map Frame Size Register */

    ibb_sp->fsize_phys = ibb_sp->iobase + IBB_FSIZE_OFF;
    ibb_sp->fsize_size = IBB_FSIZE_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->fsize_phys,
	    ibb_sp->fsize_size,
	    &ibb_sp->fsize_virt,
	    "Frame Size Reg") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* map Exposure Time Register */

    ibb_sp->extime_phys = ibb_sp->iobase + IBB_EXTIME_OFF;
    ibb_sp->extime_size = IBB_EXTIME_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->extime_phys,
	    ibb_sp->extime_size,
	    &ibb_sp->extime_virt,
	    "Exposure Time Reg") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* map Pixel LUT Sram */

    ibb_sp->plsram_phys = ibb_sp->iobase + IBB_PLSRAM_OFF;
    ibb_sp->plsram_size = IBB_PLSRAM_SIZE;

    if (ibb_map_one(ibb_sp,
	    ibb_sp->plsram_phys,
	    ibb_sp->plsram_size,
	    &ibb_sp->plsram_virt,
	    "Pixel LUT Sram") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    /* map Frame Buffers - now it gets a little trickier */

    ibb_sp->fb0_phys = ibb_sp->iobase + IBB_FB0_OFF;
    ibb_sp->fb0_size = 0;

    if (ibb_map_frame_buffer(ibb_sp,
	    ibb_sp->fb0_phys,
	    &ibb_sp->fb0_size,
	    &ibb_sp->fb0_virt,
	    "Frame Buffer 0") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    dcmn_err(40, ("<1>" "ibb_do_all_mappings(%d): fb0 Mapped Size
%lx\n",
	ibb_sp->dev_num,ibb_sp->fb0_size));

    ibb_sp->fb1_phys = ibb_sp->iobase + IBB_FB1_OFF;
    ibb_sp->fb1_size = 0;

    if (ibb_map_frame_buffer(ibb_sp,
	    ibb_sp->fb1_phys,
	    &ibb_sp->fb1_size,
	    &ibb_sp->fb1_virt,
	    "Frame Buffer 1") < 0)
    {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    dcmn_err(40, ("<1>" "ibb_do_all_mappings(%d): fb1 Mapped Size
%lx\n",
	ibb_sp->dev_num,ibb_sp->fb1_size));

#ifdef IMAGETABLEALLOC
    /* two pages of memory should always be enough ? */

    ibb_sp->image_table_mem = NULL;

    if (alloc_ibb_image_table_mem(ibb_sp, PAGE_SIZE * 2) < 0) {
	free_all_mappings(ibb_sp);
	return(-1);
    }

    ibb_sp->image_table_size = PAGE_SIZE * 2;

    dcmn_err(40,
	("<1>" "ibb_do_all_mappings(%d): Image Table Mapped Size %lx\n",
	ibb_sp->dev_num, PAGE_SIZE * 2));
#endif

    if (alloc_ibb_usr_shared(ibb_sp) < 0) {
	free_all_mappings(ibb_sp);
        return(-1);
    }

    dcmn_err(40, ("<1>" "ibb_do_all_mappings(%d): IbbUserShared %lx\n",
	ibb_sp->dev_num, (long)IBB_SHARED_SIZE));

    return(0);
}

int
ibb_mmap(struct file *filep, struct vm_area_struct *vma)
{
    IbbSoftDev *ibb_sp = filep->private_data;

    u_long offset = vma->vm_pgoff << PAGE_SHIFT;
    u_long vsize = vma->vm_end - vma->vm_start;

    if (offset > __pa(high_memory) || (filep->f_flags & O_SYNC)) {
	vma->vm_flags |= VM_IO;
    }

    vma->vm_flags |= VM_RESERVED;

    dcmn_err(90, ("<1>" 
	"mmap(%d): st %#010lx off %#010lx(%#010lx) sz %#010lx (end
%#010lx)\n",
	ibb_sp->dev_num, vma->vm_start, ibb_sp->iobase + offset,
	offset, vsize, vma->vm_end));

    dcmn_err(30, ("<1>" "ibb_mmap(%d): opened by %s pid %d\n",
	ibb_sp->dev_num, current->comm, current->pid));

    if (offset == IBB_IMAGE_ADDR) {
	if (ibb_sp->image_table != NULL && vsize >
ibb_sp->image_table_size) {
	    /* release the current memory and allocate new memory *
below */
	    dcmn_err(1, ("<1>" "ibb_mmap(%d): Free Image Table\n",
		ibb_sp->dev_num));

	    free_ibb_image_table_mem(ibb_sp);
	}

	if (ibb_sp->image_table == NULL) {
	    dcmn_err(1, ("<1>" "ibb_mmap(%d): Alloc New Image Table\n",
		ibb_sp->dev_num) );

	    alloc_ibb_image_table_mem(ibb_sp, vsize);
	}

	if (ibb_sp->image_table != NULL && vsize <=
ibb_sp->image_table_size) {
	    const u_long start = vma->vm_start;
	    const u_long size = (vma->vm_end - vma->vm_start);
	    const u_long page = (void *)ibb_sp->image_table;

	    if (io_remap_pfn_range(vma, start, page, size,
vma->vm_page_prot)) {
		dcmn_err(1, ("<1>" "ibb_mmap(%d): image table remap
failed\n",
		    ibb_sp->dev_num));

		return(-EAGAIN);
	    }
	}

	else {
	    dcmn_err(1, ("<1>" 
		"ibb_mmap(%d): image table params failed vs %d is %d\n",
		ibb_sp->dev_num, (int)vsize,
(int)ibb_sp->image_table_size));

	    return(-EAGAIN);
	}
    }
    else if (offset == IBB_SHARED_ADDR) {
	if (ibb_sp->ushared != NULL && vsize <=
PAGE_ALIGN(IBB_SHARED_SIZE)) {
	    const u_long start = vma->vm_start;
	    const u_long size = (vma->vm_end - vma->vm_start);
	    const u_long page = (void *)ibb_sp->ushared;

	    if (io_remap_pfn_range(vma, start, page, size,
vma->vm_page_prot)) {
		dcmn_err(1, ("<1>" "ibb_mmap(%d): ushared remap
failed\n",
		    ibb_sp->dev_num));

		return(-EAGAIN);
	    }

	    dcmn_err(1, ("<1>" "ibb_mmap(%d): \
		ushared remap: ibb_sp->ushared: %lx vma->vm_start:
%lx\n",
		ibb_sp->dev_num,
		(u_long)ibb_sp->ushared,
		(u_long)vma->vm_start) );
	}
	else {
	    dcmn_err(1, ("<1>" "ibb_mmap(%d): ushared mmap failed\n",
		ibb_sp->dev_num));

	    return(-EAGAIN);
	}
    }

    /* 
     * vsize is PAGE_SIZE at minimum.  For registers and other
     * small memory areas we need to check for VSIZE.  For large
     * chunks, vsize should equal the chunk size 
     */

    else if (offset == IBB_CONTROL_OFF && vsize == PAGE_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->creg_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return -EAGAIN;
	}
    }

    else if (offset == IBB_CSRAM_OFF && vsize == IBB_CSRAM_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->csram_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_RSRAM_OFF && vsize == IBB_RSRAM_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->rsram_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_FBACOUNT_OFF && vsize == PAGE_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->fbac_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_CAMDELAY_OFF && vsize == PAGE_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->camdelay_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_FSIZE_OFF && vsize == PAGE_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->fsize_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_EXTIME_OFF && vsize == PAGE_SIZE) {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->extime_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_PLSRAM_OFF && vsize == IBB_PLSRAM_SIZE) {
	dcmn_err(0, ("<1>" "ibb_mmap(%d): PLUT Sram %lx %lx\n",
	     ibb_sp->dev_num,
	     (long)offset,
	     (long)vsize));

	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->plsram_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_FB0_OFF
		&& (vsize == IBB_FB_32_MG
		|| vsize == IBB_FB_64_MG))
    {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->fb0_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else if (offset == IBB_FB1_OFF
		&& (vsize == IBB_FB_32_MG
		|| vsize == IBB_FB_64_MG))
    {
	const u_long start = vma->vm_start;
	const u_long size = (vma->vm_end - vma->vm_start);
	const u_long page = ibb_sp->fb1_phys;

	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))
{
	    return(-EAGAIN);
	}
    }

    else {
	return(-EAGAIN);
    }

    return(0);
}

struct file_operations ibb_fops = {
    read:	ibb_read,
    write:	ibb_write,
    ioctl:	ibb_ioctl,
    mmap:	ibb_mmap,
    open:	ibb_open,
    release:	ibb_close,
};

#ifdef MISCLOAD
struct miscdevice ibb_misc_device = {
    -1,
    "ibb",
    &ibb_fops
};
#endif

static int __initdata
ibb_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
{
    IbbSoftDev *ibb_sp;	

    int i = 0;
    int dev_num;
    int ibb_major;
    int result;
    int res;

    u8 rev_id = 0;
    u16 device_id;
    uint16_t subsystem_id = 0;

    char revid = ' ';

    dcmn_err(40, ("<1>" "ibb_probe: enter\n"))

    if (pci_enable_device(pdev)) {
	return(-ENODEV);
    }

    result = 0;

    /* stealing code from cciss.c - thanks compaq! */

    dcmn_err(0, ("<1>" 
	"ibb_probe: IBB Device 0x%08x has been found @bus %d dev %d func
%d\n",
	 pdev->device,
	 pdev->bus->number,
	 PCI_SLOT(pdev->devfn),
	 PCI_FUNC(pdev->devfn)));

    /* alloc our per-device data */

    dev_num = alloc_ibb_soft_state();

    if (dev_num < 0) {
	/* I've already printk'd error message */
	return(-ENOMEM);
    }

    /* initialize data */

    memset(IbbSoft[dev_num], 0, sizeof(IbbSoft[dev_num]));
    ibb_sp = IbbSoft[dev_num];

    sprintf(ibb_sp->devname, "ibb%d", dev_num);

    spin_lock_init(&ibb_sp->mutex);

    ibb_sp->dev_num = dev_num;
    ibb_sp->pdev = pdev;
    ibb_sp->height_inspection = 0;

    sema_init(&ibb_sp->sem, 1);
    pci_set_drvdata(pdev, ibb_sp);	/* we'll need this in remove: */

    dcmn_err(40, ( "<1>" "ibb_probe: device %d\n", dev_num));

#define REQUESTMEM
#ifdef REQUESTMEM

    for (i = 0; i < kMaxIbbs; i++) {
    	ishared.dev_instance[i] = -1;
    }

    /* start with the max size */
    ishared.frame_buffer_size = IBB_FB_64_MG;

    /* 
     * map the card memory areas into kernel space
     * and store the address in our IbbDev info 
     */

    ibb_sp->iobase = pci_resource_start(pdev, 0);
    ibb_sp->iosize = pci_resource_len(pdev, 0);

    if (ibb_do_all_mappings(ibb_sp) < 0) {
	free_ibb_soft_state(ibb_sp->dev_num);
	return(-ENODEV);
    }

#endif

#ifdef CONFIG_DEVFS_FS
    ibb_sp->ibb_devfs_dir = devfs_mk_dir(NULL, ibb_sp->devname, NULL);
    if (!ibb_sp->ibb_devfs_dir) {
	dcmn_err(0, ("<1>" "ibb_probe(%d): can't register devfs\n",
	    dev_num));

	free_all_mappings(ibb_sp);
	free_ibb_soft_state(ibb_sp->dev_num);

	return(-EBUSY);
    }

    devfs_register(ibb_sp->ibb_devfs_dir,
	    ibb_sp->devname,
	    DEVFS_FL_AUTO_DEVNUM,		/* autoallocate
major/minor */
	    0,					/* ignored because of
flag */
	    0,					/* ignored because of
flag */
	    S_IFCHR | S_IRUGO | S_IWUGO, 	/* ??? */
	    &ibb_fops,
	    ibb_sp);

#else	// ifdef CONFIG_DEVFS_FS

    ibb_major = 0;
    result = register_chrdev(ibb_major, ibb_sp->devname, &ibb_fops);

    if (result < 0) {
	dcmn_err(0, ( "<1>" "ibb_probe(%d): can't get register driver\n"
		,dev_num));

	free_all_mappings(ibb_sp);
	free_ibb_soft_state(ibb_sp->dev_num);

	return(-EBUSY);
    }

    if (ibb_major == 0) {
	ibb_major = result;	/* dynamic */
    }

    dcmn_err(30, ( "<1>" "ibb_probe(%d): got major
%d\n",dev_num,ibb_major));

#endif	// ifdef CONFIG_DEVFS_FS

    ibb_sp->ibb_major = ibb_major;

    pci_read_config_word(pdev, 2, &device_id);
    pci_read_config_byte(pdev, 8, &rev_id);
    pci_read_config_word(pdev, 46, &subsystem_id);

    ibb_sp->clibb_id = subsystem_id;

    if (rev_id > 0 && rev_id < 27) {
	rev_id += 0x40;         /* translate to ascii (A = 1, B = 2,
etc) */
	revid = rev_id;
    }

    if (!pdev->irq) {
	dcmn_err(0, ("<1>" "ibb_probe_module(%d): can't get interrupt
number\n",
		dev_num));

	free_all_mappings(ibb_sp);
	free_ibb_soft_state(ibb_sp->dev_num);

	return(-ENODEV);
    }

    ibb_sp->myint = pdev->irq;
    res = request_irq(ibb_sp->myint,
	    ibb_intr,
	    SA_SHIRQ,ibb_sp->devname,
	    ibb_sp);

    if (res != 0) {
	dcmn_err(0, ("<1>" "ibb_open(%d): irq request %d failed\n",
		dev_num,res) );

    	return(-1);
    }

    init_waitqueue_head(&ibb_sp->wq);

    if (ibb_sp->clibb_id == kIbbId) {
	dcmn_err(0, ("<1>" "MVP Image Buffer Board: ibb%d,%X.%c, Int:
%d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibbSingle) {
	dcmn_err(0, ("<1>" "MVP Camera Link Single IBB: ibb%d,%X.%c,
Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibbDualRow) {
	dcmn_err(0, ("<1>" "MVP Camera Link DualRow IBB: ibb%d,%X.%c,
Int: %d\n"
		,dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibbDualCol) {
	dcmn_err(0, ("<1>" "MVP CL DualCol IBB ibb%d, %X.%c, Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibb_HSC) {
	dcmn_err(0, ("<1>" "MVP HSC Camera Link IBB: ibb%d, %X.%c, Int:
%d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else {
	dcmn_err(0, ("<1>" "MVP Unknown IBB: ibb%d, %X.%c, Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    /* store device id */
    dcmn_err(0, ("<1>" "MVP driver(%d) %s\n",
	    dev_num,
	    ibb_c));

    return(result);
}

static void __exitdata
ibb_remove(struct pci_dev *pdev)
{
    IbbSoftDev *ibb_sp = (IbbSoftDev *)pci_get_drvdata(pdev);

    if (ibb_sp == NULL) {
	dcmn_err(0, ("<1>" "ibb_remove: Error: Null IBB Data in
remove\n"));
	return;
    }

    dcmn_err(40, ( "<1>" "ibb_remove(%d):\n", ibb_sp->dev_num));

#ifdef CONFIG_DEVFS_FS
    dcmn_err(40, ( "<1>" "ibb_remove(%d): unregister dev %s\n",
	    ibb_sp->dev_num,
	    ibb_sp->devname));

    devfs_unregister(ibb_sp->ibb_devfs_dir);
#else
    dcmn_err(40, ( "<1>" "ibb_remove(%d): unregister drv %s\n",
	    ibb_sp->dev_num,
	    ibb_sp->devname));

    if (ibb_sp) {
	free_irq(ibb_sp->myint, (void *)ibb_sp);
	dcmn_err(0, ("<1>" "ibb_remove(%d): free_irq myint%d\n",
		ibb_sp->dev_num,
		ibb_sp->myint));

	ibb_sp->myint = 0;
    }
    
    unregister_chrdev(ibb_sp->ibb_major, ibb_sp->devname);
#endif

    dcmn_err(40, ( "<1>" "ibb_remove(%d): release memory\n",
ibb_sp->dev_num));

    free_all_mappings(ibb_sp);
    free_ibb_soft_state(ibb_sp->dev_num);
}


static struct pci_device_id ibb_id_table[] __devinitdata = {
    { 0x8f73, 0xb1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
    { 0x8f73, 0xb2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
    { 0x8f73, 0xb3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
    { 0x8f73, 0xcb1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
    { 0x8f73, 0xcb2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }
};

/*
 * have _no idea_ why I'm calling this - find out!
 *
 *	from /usr/inluclude/linux/module.h
 * MODULE_DEVICE_TABLE exports information about devices
 * currently supported by this module.  A device type, such as PCI,
 * is a C-like identifier passed as the first arg to this macro.
 * The second macro arg is the variable containing the device
 * information being made public.
 *
 * The following is a list of known device types (arg 1),
 * and the C types which are to be passed as arg 2.
 * pci - struct pci_device_id - List of PCI ids supported by this module
 * isapnp - struct isapnp_device_id - 
 * List of ISA PnP ids supported by this module
 * usb - struct usb_device_id - List of USB ids supported by this module
 *
 * still - ok so it exports it, who imports it and what do they
 * do with it?
 */

MODULE_DEVICE_TABLE(pci, ibb_id_table);

struct pci_driver ibb_driver = {
    name:		"ibb",
    id_table:		ibb_id_table,
    probe:		ibb_probe,
    remove:		ibb_remove,
};

int __init
ibb_init_module(void)
{
    dcmn_err(0, ("<1>" "ibb_init_module: Start\n"))

    init_ibb_soft_state();

    return(pci_module_init(&ibb_driver));
}

void __exit
ibb_cleanup_module(void)
{
    dcmn_err(0, ("<1>" "ibb_cleanup_module: End\n"))
    pci_unregister_driver(&ibb_driver);
}

static inline void
set_next_fb(uint32_t *control_regp, uint32_t next_snap, int instance,
int temp_debug)
{
    uint32_t next_fb = (next_snap & IAT_FB_MASK) >> IAT_FB_SHIFT;

    if (next_fb == 0) {
	*(control_regp) = *(control_regp) | ICR_FB0_ENABL;
	*(control_regp) = *(control_regp) & ~ICR_FB1_ENABL;
    }
    else if (next_fb == 1) {
	*(control_regp) = *(control_regp) | ICR_FB1_ENABL;
	*(control_regp) = *(control_regp) & ~ICR_FB0_ENABL;
    }

    dcmn_err(temp_debug, ("<1>" "ibb_intr(%d): set fb %d %x\n",
	    instance,
	    next_fb,
	    *(control_regp)));
}

static inline void
set_next_camera(uint32_t *control_regp, uint32_t next_snap, int
instance, int temp_debug)
{
    uint32_t next_camera;

    /* first, clear the previous camera settings */
    *(control_regp) &= ICR_CLEARCAM;

    next_camera = (next_snap & IAT_CAMERA_MASK) >> IAT_CAMERA_SHIFT;

    if (next_camera < 0 || next_camera > 7) {
	return;
    }

    *(control_regp) |= (next_camera << ICR_CAMERA_SHIFT);

    dcmn_err(temp_debug, ("<1>" "ibb_intr(%d): set camera %d reg %x\n",
	    instance,
	    next_camera,
	    *(control_regp)) );
}

static inline void
set_next_address(IbbSoftDev *ibb_p, uint32_t ibb_control_reg, uint32_t
next_snap, int instance, int temp_debug)
{
    uint32_t next_address = (next_snap & IAT_ADDR_MASK);

    dcmn_err(temp_debug, ("<1>" 
	    "ibb_intr(%d): got address 0x%x set 0x%x\n",
	    instance,
	    *(ibb_p->fbac_virt),	
	    next_address));

    *(ibb_p->fbac_virt) = next_address;
}

static inline void
check_intr_delay(IbbSoftDev *ibb_p)
{
#ifdef TESTCAMDELAY
    hrtime_t snap_ndelay;
    hrtime_t ibb_ntimestamp;

    /* this may be useful but only in fly mode */
    ibb_ntimestamp = gethrtime();

    dcmn_err(10, ("<1>" "ibb_intr: ibbtime %llu\n",ibb_ntimestamp /
1000000));
    dcmn_err(10, ("<1>" "ibb_intr: rtctime %llu\n",
ishared.rtc_ntimestamp));

    if (ibb_ntimestamp < ishared.rtc_ntimestamp) {
	dcmn_err(1, ("<1>" "ibb_intr: Bad value %llu for rtc intr\n", 
		ishared.rtc_ntimestamp));
    }

    snap_ndelay = ibb_ntimestamp - ishared.rtc_ntimestamp;

    if (snap_ndelay < kMinSnapDelay) {
	dcmn_err(1, ("<1>" "ibb_intr: grab snap delay %lld too short\n",
		snap_ndelay / 1000000));

	ibb_p->ushared->badsnap = kIbbShortSnap;
    }

    else if (snap_ndelay > kMaxSnapDelay) {
	dcmn_err(1, ("<1>" "ibb_intr: grab snap delay %lld too long\n",
		snap_ndelay / 1000000));

	ibb_p->ushared->badsnap = kIbbLongSnap;
    }
#endif

    return;
}


irqreturn_t
ibb_intr(int irq, void *dev_id, struct pt_regs *regs)
{
    IbbSoftDev *ibb_sp = dev_id;

    uint32_t creg_val;
    uint32_t intr_set;
    uint32_t last_snap;
    uint32_t next_snap;

    int	instance;
    int temp_debug = 100;

    u_long flags;

    if (ibb_sp == NULL) {
	/* WTF??? */
	dcmn_err(1, ("<1>" "ERROR: ibb_intr: ibb_sp = NULL\n"));
	return(IRQ_NONE);
    }

    lock_ibb(ibb_sp, &flags, "ibb_intr");
    instance = ibb_sp->dev_num;
    creg_val = *ibb_sp->creg_virt;

    if (!(creg_val & ICR_INTR_PENDING)) {
	dcmn_err(1, ("<1>" "ibb_intr(%d): Not mine\n",
ibb_sp->dev_num));

	unlock_ibb(ibb_sp, &flags, "ibb_intr Error");
	return(IRQ_NONE);
    }

    if (creg_val & ICR_CAM_FAIL) {
    	dcmn_err(1, ("<1>" "ibb_intr(%d): Camera
Failure\n",ibb_sp->dev_num));
    }

    /* RESET INTR set ICR_INTR_CLEAR hi and remove software intrs*/

    intr_set =
	(ICR_INTR_CLEAR | creg_val | ICR_CLR_CAM_FAIL)
	& ~(ICR_SOFT_IMAGE | ICR_SIM_FIRE);

    *ibb_sp->creg_virt = intr_set;

    if (ibb_sp->ushared != NULL && ibb_sp->image_table != NULL) {
	ibb_sp->ushared->badsnap = 0;
	last_snap =
ibb_sp->image_table[ibb_sp->ushared->image_table_index];

	if (ibb_sp->height_inspection) {
	    uint32_t *address_start;
	    uint32_t *last_frame;

	    uint32_t height_data;
	    uint32_t last_address;

	    uint32_t last_fb = (last_snap & IAT_FB_MASK) >>
IAT_FB_SHIFT;

	    if (last_fb == 0) {
		address_start = ibb_sp->fb0_virt;
	    }
	    else {
		address_start = ibb_sp->fb1_virt;
	    }

	    last_address = last_snap & IAT_ADDR_MASK;
	    last_frame = address_start + last_address;

	    height_data = *(ibb_sp->height_virt);
	    height_data <<= 16;

	    *(last_frame) = height_data;
	}

	last_snap = last_snap | IAT_SNAP_DONE;
	ibb_sp->image_table[ibb_sp->ushared->image_table_index] =
last_snap;

	ibb_sp->ushared->image_table_index++;

	dcmn_err(55, ("<1>" "ibb_intr(%d): set index %d\n",
		ibb_sp->dev_num,
		ibb_sp->ushared->image_table_index));

	next_snap =
ibb_sp->image_table[ibb_sp->ushared->image_table_index];

	dcmn_err(55, ("<1>" "ibb_intr(%d): got next entry %d
%x\n",instance,
		ibb_sp->ushared->image_table_index,
		next_snap));

	creg_val = *ibb_sp->creg_virt;
	dcmn_err(55, ("<1>" "ibb_intr(%d): set %x intr %x\n", 
		ibb_sp->dev_num,
		intr_set,
		creg_val));

	set_next_fb(ibb_sp->creg_virt, next_snap, instance, temp_debug);
	set_next_camera(ibb_sp->creg_virt, next_snap, instance,
temp_debug);
	set_next_address(ibb_sp, creg_val, next_snap, instance,
temp_debug);

        dcmn_err(55, ("<1>" "ibb_intr(%d): fbacount 0x%x\n",
		instance,
		*(ibb_sp->fbac_virt)));

	if (ibb_sp->flags & kIoWaiting) {
	    dcmn_err(55, ("<1>" "ibb_intr(%d): waiting for ind %d got
%d\n",
		    instance,
		    ibb_sp->wait_for,
		    ibb_sp->ushared->image_table_index));

	    if (ibb_sp->ushared->image_table_index > ibb_sp->wait_for) {
		dcmn_err(55, ("<1>" "ibb_intr(%d): wake up wait
queue\n",
			ibb_sp->dev_num));

		wake_up_interruptible(&ibb_sp->wq);
	    }
	}

	check_intr_delay(ibb_sp);
    }

    barrier();

    *ibb_sp->creg_virt =
	(~(ICR_INTR_CLEAR|ICR_CLR_CAM_FAIL) & *ibb_sp->creg_virt);

    unlock_ibb(ibb_sp, &flags, "ibb_intr");

    return(IRQ_HANDLED);
}

void
ibb_rtc_wakeup(void)
{
    int i;
    u_long flags;

    for (i = 0; i < kMaxIbbs; i++) {
	if (IbbSoft[i] != NULL) {
	    lock_ibb(IbbSoft[i], &flags, "ibb_rtc_wakeup");

	    IbbSoft[i]->wait_for = kIbbWakeup;
	    IbbSoft[i]->ushared->image_table_index =
IbbSoft[i]->wait_for + 1;

	    unlock_ibb(IbbSoft[i], &flags, "ibb_rtc_wakeup");
	    wake_up_interruptible(&IbbSoft[i]->wq);
	}
    }
}

module_init(ibb_init_module);
module_exit(ibb_cleanup_module);

