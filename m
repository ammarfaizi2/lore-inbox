Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWESSi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWESSi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWESSi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:38:28 -0400
Received: from mail.visionpro.com ([63.91.95.13]:8242 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S964789AbWESSiZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:38:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Invalid module format?
Date: Fri, 19 May 2006 11:38:23 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3269@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Invalid module format?
Thread-Index: AcZ7bQSnJVA0DrP2SS6nayKHD4NbqAABasxg
From: "Brian D. McGrew" <brian@visionpro.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems my failure to post the complete set of files has caused great
confusion.  Is that a sign of stress or frustration or both???  

Here is a complete listing of all the files, including the Makefile.  I
think this is everything now.

I'm facing two problems.  First, the 2.6.16 kernel won't load this
driver; throws an invalid module format as where 2.6.15 loads it just
fine.

Secondly, the driver is supposed to allocate kernel memory that's
accessable from userspace.  If you see the function
alloc_ibb_user_shared(IbbSoftDev *) and the function
alloc_ibb_image_table_mem(IbbSoftDev *, int); you'll see where I've a
couple of attempts at calling __get_free_pages as well as a shot at
vmalloc.  I've narrowed it down to this one section that's killing me.  

If anyone can offer help, that would be great because I'm just stuck on
this and have been for six months!!!

Thanks!!

MAKEFILE --

obj-m += ibb.o
obj-m += ibb3d.o
obj-m += mvp_rtc.o


---[ SOURCES BEGING HERE ]---

---[ BEGIN IBB ]---
-->
/usr/src/redhat/BUILD/kernel-2.6.16/linux-2.6.16.16/drivers/mvp/ibb.c

static const char *ibb_c = "$Id: ibb.c,v 1.5 2006/04/18 19:48:02 brian
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

void ibb_rtc_wakeup(void);
irqreturn_t ibb_intr(int irq, void *dev_id, struct pt_regs *regs);

EXPORT_SYMBOL(ibb_rtc_wakeup);

/*
 * Split minors in two parts
 */
#define TYPE(dev)   (MINOR(dev) >> 4)  /* high nibble */
#define NUM(dev)    (MINOR(dev) & 0xf) /* low  nibble */

#define DEBUG

#ifdef DEBUG
#define debug_out(msg)		{ printk msg; }
#else
#define debug_out(msg)
#endif

/*
 * Place the call to START at the begining of the function and place the
call
 * to END where the function __should__ be returning at (not always at
the
 * end of the function, get it)!
 */

#define START
#define END

#if 0
#define START	{ debug_out(("IBB_START: %s\n", __func__)); }
#define END	{ debug_out(("IBB_FINISH: %s\n", __func__)); }
#endif

/*
 * array of devices
 */

static IbbSoftDev *IbbSoft[kMaxIbbs];

static const uint32_t kIoWaiting	= 0x04;
static const uint32_t MAG_FB_NUMBER	= 0xCE1E57E;
static const uint16_t kIbbWakeup	= 0x0fff;

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
    START;

    debug_out(("lock_ibb(%d): %s:\n", ibb_sp->dev_num, where));
    spin_lock_irqsave(&ibb_sp->mutex, *flags);
    debug_out(("lock_ibb(%d): Done %s:\n", ibb_sp->dev_num, where));

    END;
}

static void
unlock_ibb(IbbSoftDev *ibb_sp, u_long *flags, const char *where)
{
    START;
    debug_out(("unlock_ibb(%d): %s:\n", ibb_sp->dev_num, where));

    spin_unlock_irqrestore(&ibb_sp->mutex, *flags);

    debug_out(("unlock_ibb(%d): Done %s:\n", ibb_sp->dev_num, where));
    END;
}

static void
init_ibb_soft_state(void)
{
    int i;

    START;

    for (i = 0; i < kMaxIbbs; i++)
	IbbSoft[i] = NULL;

    END;
}

static int
alloc_ibb_soft_state(void)
{
    int i;

    START;

    for (i = 0; i < kMaxIbbs; i++) {
	if (IbbSoft[i] == NULL) {
	    IbbSoft[i] = kmalloc(sizeof(IbbSoftDev), GFP_KERNEL);

	    if (IbbSoft[i] == NULL) {
		debug_out(("alloc_ibb_soft_state: out of memory\n"));
		return(-1);
	    }

	    debug_out(("alloc_ibb_soft_state: return %d\n", i));

	    END;
	    return(i);
	}
    }

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

    START;
    debug_out(("find_ibb_soft_state: major %d\n", ibb_major));

    for (i = 0; i < kMaxIbbs; i++) {
	if (IbbSoft[i] != NULL) {
	    if (ibb_major == IbbSoft[i]->ibb_major) {
		debug_out(("find_ibb_soft_state: return %d\n", i));

		END;
		return(i);
	    }
	}
    }

    debug_out(("Can't find matching soft_state %d!\n", ibb_major));
    return(-1);
}

static void
free_ibb_soft_state(int i)
{
    START;

    if (IbbSoft[i] == NULL) {
	debug_out(("IbbSoft[%d] is already free and null\n", i));
	return;
    }

    debug_out(("free_ibb_soft_state(%d):\n", IbbSoft[i]->dev_num));

    kfree(IbbSoft[i]);
    IbbSoft[i] = NULL;

    END;
    return;
}

ssize_t
ibb_read(struct file *filp, char *buf, size_t count, loff_t *f_pos)
{
    debug_out(("ibb_read: -EINVAL\n"));
    return(-EINVAL);
}

ssize_t 
ibb_write(struct file *filp, const char *buf, size_t count, loff_t
*f_pos)
{
    debug_out(("ibb_write: -EINVAL\n"));
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
    int dev_num = ibb_sp->dev_num;
    uint32_t table_index = (uint32_t) arg;

    u_long flags;
    int wq_ret = 0;

    START;

    if (ibb_sp->ushared == NULL) {
	return(EAGAIN);
    }

    if (ibb_sp->ushared->image_table_index > table_index) {
	debug_out(("ibb_ioctl(%d): IBBWAIT already got index %d\n",
	    dev_num, ibb_sp->ushared->image_table_index)); 

	return(0);
    }

    lock_ibb(ibb_sp, &flags, "IBBWAIT 0");

    ibb_sp->flags |= kIoWaiting;
    ibb_sp->wait_for = table_index;

    unlock_ibb(ibb_sp, &flags, "IBBWAIT 0");

    debug_out(("ibb_ioctl(%d): IBBWAIT wait for %u, %u\n",
	dev_num, ibb_sp->wait_for, ibb_sp->ushared->image_table_index)
);

    wq_ret = wait_event_interruptible(ibb_sp->wq, 
	(ibb_sp->ushared->image_table_index > table_index));

    debug_out(("ibb_ioctl(%d): IBBWAIT got index %d\n",
	dev_num,ibb_sp->wait_for));

    lock_ibb(ibb_sp, &flags, "IBBWAIT 1");
    ibb_sp->flags &= ~kIoWaiting;
    unlock_ibb(ibb_sp, &flags, "IBBWAIT 1");

    if (ibb_sp->wait_for == kIbbWakeup) {
	debug_out(("ibb_ioctl(%d): IBBWAIT got Wakeup\n", dev_num));
    }
    else if (ibb_sp->ushared->image_table_index > ibb_sp->wait_for) {
	debug_out(("ibb_ioctl(%d): IBBWAIT got index %d\n",
	    dev_num,ibb_sp->wait_for));
    }
    else {
	if(wq_ret != 0) {
	    debug_out(("ibb_ioctl(%d): IBBWAIT signal intr\n",
dev_num));
	} else {
	    debug_out(("ibb_ioctl(%d): IBBWAIT Weird cond.\n",
dev_num));
	}

	return(-1);	/* !! there's been a problem */
    }

    END;
    return(0);
}

int
ibb_ioctl(struct inode *inode, struct file *filp, u_int cmd, u_long arg)
{
    IbbSoftDev *ibb_sp = filp->private_data;

    int retval = 0;
    u_long flags;

    START;

    if (ibb_sp == NULL) {
	debug_out(("ibb_ioctl(%d): Soft Info Lost\n", ibb_sp->dev_num));
	return(-EFAULT);
    }

    switch (cmd) {
	case IBBWAIT:
	    debug_out(("ibb_ioctl(%d): cmd IBBWAIT arg %lu\n",
		ibb_sp->dev_num, arg));

	    retval = ibb_wait(ibb_sp, arg);
	    break;

	case IBBTST:
	    if (ibb_sp->image_table == NULL)
		return 0;

	    debug_out(("ibb_ioctl(%d): table 0 %x \n", 
		ibb_sp->dev_num,ibb_sp->image_table[0]) );

	    debug_out(("ibb_ioctl(%d): table 1 %x \n",
		ibb_sp->dev_num,ibb_sp->image_table[1]) );

	    break;

	case IBBWAKEUP:
	    debug_out(("ibb_ioctl(%d): cmd IBBWAKEUP\n",
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
	    debug_out(("ibb_ioctl(%d): cmd IBBFBACOUNT arg %lu\n",
		ibb_sp->dev_num, arg) );

	    lock_ibb(ibb_sp, &flags, "IBBFBACOUNT");
	    *(ibb_sp->fbac_virt) = (uint32_t) arg;
	    unlock_ibb(ibb_sp, &flags, "IBBFBACOUNT");

	    debug_out(("ibb_ioctl(%d): set fb count to %u\n",
		ibb_sp->dev_num,*(ibb_sp->fbac_virt)));

	    retval = 0;
	    break;

	case IBBFSIZE:
	    debug_out(("ibb_ioctl(%d): cmd IBBFSIZE arg %lu\n", 
		ibb_sp->dev_num,arg));

	    lock_ibb(ibb_sp, &flags, "IBBFSIZE");
	    *(ibb_sp->fsize_virt) = (uint32_t)arg;
	    unlock_ibb(ibb_sp, &flags, "IBBFSIZE");

	    debug_out(("ibb_ioctl(%d): set frame size to %u\n",
		ibb_sp->dev_num,*(ibb_sp->fsize_virt)));

	    break;

	case IBBSIZE:
	    debug_out(("ibb_ioctl(%d): cmd is IBBSIZE: %d\n", 
		ibb_sp->dev_num, ishared.frame_buffer_size));

	    retval = put_user(ishared.frame_buffer_size, (u_long *)
arg);
	    break;

	case IBBVERSION:
	    if (put_user(kIbbVersion, (u_long *) arg)) {
		debug_out(("ibb_ioctl(%d): can't copy ver info %d\n",
		    ibb_sp->dev_num,(int)kIbbVersion)) ;

		retval = -EFAULT;
	    }

	    debug_out(("ibb_ioctl(%d): Copied ver info %d\n",
		ibb_sp->dev_num, (int)kIbbVersion));
	
	    break;

	case IBBCLIBB_ID:
	    if (put_user(ibb_sp->clibb_id, (short *)arg)) {
		debug_out(("ibb_ioctl(%d): can't copy CLIBB ID %d\n",
		    ibb_sp->dev_num,ibb_sp->clibb_id)) ;

		retval = -EFAULT;
	    }

	    debug_out(("ibb_ioctl(%d): Copied CLIBB IDD %d\n",
		ibb_sp->dev_num,ibb_sp->clibb_id));
	
	    break;

	case IBBHEIGHTGO:
	    if (ibb_sp->clibb_id != kClibb_HSC) {
		debug_out(("ibb_ioctl(%d): ERROR: No Height Sensor\n",
		    ibb_sp->dev_num) );

		return(-EFAULT);
	    }

	    ibb_sp->height_inspection = 1;

	    debug_out(("ibb_ioctl(%d): Start Height Inspection %d\n",
		ibb_sp->dev_num,ibb_sp->height_inspection));
	
	    break;

	case IBBHEIGHTSTOP:
	    ibb_sp->height_inspection = 0;

	    debug_out(("ibb_ioctl(%d): Stop Height Inspection %d\n",
		ibb_sp->dev_num,ibb_sp->height_inspection));
	
	    break;

	default:
	    debug_out(("ibb_ioctl(%d): unknown case: %d\n", 
		ibb_sp->dev_num, cmd) );

	    return(-ENOTTY);
	    break;
    }

    END;
    return(retval);
}

int
ibb_open(struct inode *inode, struct file *filep)
{
    int dev_num;
    IbbSoftDev *ibb_sp;

    int major = MAJOR(inode->i_rdev);
    int minor = MINOR(inode->i_rdev);

    START;

    debug_out(("ibb_open: major %d minor %d\n", major, minor));
    dev_num = find_ibb_soft_state(major);

    if (dev_num < 0) {
	debug_out(("ibb_open: dev_num %d failed\n", dev_num));
	return(-1);
    }

    ibb_sp = IbbSoft[dev_num];
    filep->private_data = ibb_sp;

    debug_out(("ibb_open(%d): opened by %s pid %d PAGE_SIZE %#010lx\n",
    	dev_num,current->comm, current->pid, PAGE_SIZE));

    END;
    return(0);
}

int
ibb_close(struct inode *inode, struct file *filep)
{
    IbbSoftDev *ibb_sp = filep->private_data;

    START;
    debug_out(("ibb_close(%d): called\n", ibb_sp->dev_num));

    END;
    return(0);
}

/*
 * According to what I was told on the mailing lists, ClearPageReserved
is
 * now depricated and shouldn't be needed but we can leave it for now
for
 * backwards compatability (until when???) but also that you should
never,
 * ever access _count (in atomic_set(&page->_count) directly so it's
commented
 * out becuase I don't really know why it's there????
 *
 * BDM - 04/18/2006
 */

static void
free_ibb_usr_shared(IbbSoftDev *ibb_sp)
{
    struct page *page;

    u_long virt_addr;
    u_long ushared_addr = (u_long)ibb_sp->ushared;

    START;

    for (virt_addr = ushared_addr; 
	    virt_addr < ushared_addr + PAGE_ALIGN(IBB_SHARED_SIZE);
	    virt_addr += PAGE_SIZE)
    {
    	page = virt_to_page(virt_addr);
	ClearPageReserved(page);

	// atomic_set(&page->_count, 1);
	vfree((void *)virt_addr);
    }

    if (ibb_sp->ushared)
	ibb_sp->ushared = NULL;

    END;
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

    START;

    debug_out(("ibb::size is %d\n", size));
    debug_out(("ibb::order is %d\n", order));

    do {
	debug_out(("ibb::size is %d\n", size));
	debug_out(("ibb::order is %d\n", order));

    	order++;
    } while (size > (PAGE_SIZE * (1 << order)));

    ibb_sp->ushared = (IbbUserShared *) __get_free_pages(GFP_KERNEL,
order);
    // ibb_sp->ushared = (IbbUserShared *) vmalloc(4096 * 1024);
    // ibb_sp->ushared = (IbbUserShared *) vmalloc(size);

    if (ibb_sp->ushared == NULL) {
	debug_out(("alloc_ibb_usr_shared(%d): no memory.\n",
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

    END;
    return(0);
}

/*
 * According to what I was told on the mailing lists, ClearPageReserved
is
 * now depricated and shouldn't be needed but we can leave it for now
for
 * backwards compatability (until when???) but also that you should
never,
 * ever access _count (in atomic_set(&page->_count) directly so it's
commented
 * out becuase I don't really know why it's there????
 *
 * BDM - 04/18/2006
 */

static void
free_ibb_image_table_mem(IbbSoftDev *ibb_sp)
{
    uint32_t *virt_addr;
    struct page *page;

    START;

    debug_out(("free_ibb_image_table_mem(%d): Free size %d.\n",
	ibb_sp->dev_num, ibb_sp->image_table_size));

    /* unreserve all pages */

    for (virt_addr = ibb_sp->image_table; 
	   virt_addr < ibb_sp->image_table + ibb_sp->image_table_size;
	   virt_addr += PAGE_SIZE)
    {
    	page = virt_to_page(virt_addr);
	ClearPageReserved(page);

	// atomic_set(&page->_count, 1);
	free_page((u_long)virt_addr);
    }

    if (ibb_sp->image_table) {
	ibb_sp->image_table = NULL;
    }

    ibb_sp->image_table_size = 0;
    debug_out(("static void free_ibb_image_table_mem - DONE!\n"));

    END;
    return;
}

static int
alloc_ibb_image_table_mem(IbbSoftDev *ibb_sp, int size)
{
    int order = 0;
    uint32_t *virt_addr;

    u_int table_size = PAGE_ALIGN(size);

    START;

    debug_out(("alloc_ibb_image_table_mem(%d): Alloc size %d.\n",
	ibb_sp->dev_num,table_size));

    /* 
     * get a memory area with kmalloc and aligned it to a page. This
area
     * will be physically contigous
     */

    while (size > (PAGE_SIZE * (1 << order))) {
    	order++;
    }

    ibb_sp->image_table = (uint32_t *) __get_free_pages(GFP_KERNEL,
order);
    // ibb_sp->ushared = (IbbUserShared *) vmalloc(4096 * 1024);
    // ibb_sp->image_table = vmalloc(size);

    if (ibb_sp->image_table == NULL) {
	debug_out(("alloc_ibb_image_table_mem(%d): out of memory.\n",
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
    debug_out(("static int alloc_ibb_image_table_mem - DONE!\n"));

    END;
    return(0);
}

static int 
ibb_map_one(IbbSoftDev *ibb_sp, u_long phys, u_long size, uint32_t
**virt, const char *what)       
{
    struct resource *res;

    START;

    if ((res = request_mem_region(phys, size, ibb_sp->devname)) == NULL)
{
	debug_out(( "ibb_map_one(%d): can't allocate %s at %010lx
%#010lx %s\n",
	    ibb_sp->dev_num, what, phys, size, ibb_sp->devname));

	return(-1);
    }
    else {
	*virt = ioremap_nocache(phys, size);

	if (!virt) {
	    debug_out(("ibb_map_one(%d): Error in ioremap\n",
ibb_sp->dev_num));

	    release_mem_region(phys, size);
	    return(-1);
	}
    }

    debug_out(("ibb_map_one(%d): Successful map %s\n",
ibb_sp->dev_num,what));

    END;
    return(0);
}

static void
free_all_mappings(IbbSoftDev *ibb_sp)
{
    START;

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

    END;
    return;
}

static int
ibb_map_frame_buffer(IbbSoftDev *ibb_sp, u_long phys, ulong
*size,uint32_t **virt, const char *what)
{
    char whatsize[100];
    uint32_t *check_addr;

    long check;

    START;

    sprintf(whatsize, "%s 64", what);
    *size = IBB_FB_64_MG;

    if (ibb_map_one(ibb_sp, phys, *size, virt, whatsize) < 0) {
	return(-1);
    }

    check = MAG_FB_NUMBER;
    check_addr = *virt;

    writel(check, check_addr);

    debug_out(("ibb_map_frame_buffer(%d): %s put %lX at addr %p\n",
	ibb_sp->dev_num, whatsize, check, check_addr));

    check = readl(check_addr);

    debug_out(("ibb_map_frame_buffer(%d): %s read %lX at addr %p\n",
	ibb_sp->dev_num, whatsize, check, check_addr));

    check_addr = (*virt) + (IBB_FB_32_MG / 4);
    check = readl(check_addr);

    debug_out(("ibb_map_frame_buffer(%d): %s read %lX at addr %p\n",
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

    END;
    return(0);
}

static int
ibb_do_all_mappings(IbbSoftDev *ibb_sp)
{
    START;

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

    debug_out(("ibb_do_all_mappings(%d): fb0 Mapped Size %lx\n",
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

    debug_out(("ibb_do_all_mappings(%d): fb1 Mapped Size %lx\n",
	ibb_sp->dev_num,ibb_sp->fb1_size));

    if (alloc_ibb_usr_shared(ibb_sp) < 0) {
	free_all_mappings(ibb_sp);
        return(-1);
    }

    debug_out(("ibb_do_all_mappings(%d): IbbUserShared %lx\n",
	ibb_sp->dev_num, (long)IBB_SHARED_SIZE));

    END;
    return(0);
}

int
ibb_mmap(struct file *filep, struct vm_area_struct *vma)
{
    IbbSoftDev *ibb_sp = filep->private_data;

    unsigned long start = vma->vm_start;
    unsigned long size = vma->vm_end - vma->vm_start;
    unsigned long offset = (vma->vm_pgoff << PAGE_SHIFT);
    unsigned long page = (ibb_sp->iobase + offset) >> PAGE_SHIFT;

    START;

    if (offset > __pa(high_memory) || (filep->f_flags & O_SYNC)) {
	vma->vm_flags |= VM_IO;
    }

    vma->vm_flags |= VM_RESERVED;

    debug_out((
	"mmap(%d): st %#010lx off %#010lx(%#010lx) sz %#010lx (end
%#010lx)\n",
	ibb_sp->dev_num, vma->vm_start, ibb_sp->iobase + offset,
	offset, (vma->vm_end - vma->vm_start), vma->vm_end));

    debug_out(("ibb_mmap(%d): opened by %s pid %d\n",
	ibb_sp->dev_num, current->comm, current->pid));

    if (offset == IBB_IMAGE_ADDR) {
	debug_out(("IBB_IMAGE_ADDR\n"));

	if (ibb_sp->image_table != NULL && size >
ibb_sp->image_table_size) {
	    debug_out(("ibb_mmap(%d): Free Image Table\n",
ibb_sp->dev_num));
	    free_ibb_image_table_mem(ibb_sp);
	}

	if (ibb_sp->image_table == NULL) {
	    debug_out(("ibb_mmap(%d): Alloc New Image Table\n",
		ibb_sp->dev_num));

	    alloc_ibb_image_table_mem(ibb_sp, (vma->vm_end -
vma->vm_start));
	}

	if (ibb_sp->image_table != NULL && size <=
ibb_sp->image_table_size) {
	    while (size > PAGE_SIZE) {
		//if (io_remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		if (io_remap_pfn_range(vma, start,
(u_long)ibb_sp->image_table, PAGE_SIZE, PAGE_SHARED)) {
		    return(-EAGAIN);
		}

		start += PAGE_SIZE;

		if (size > PAGE_SIZE) {
		    size -= PAGE_SIZE;
		} else {
		    size = 0;
		}
	    }
	}

	debug_out(("IBB_IMAGE_ADDR - DONE!\n"));
    }

    else if (offset == IBB_SHARED_ADDR) {
	debug_out(("IBB_SHARED_ADDR\n"));

	if (ibb_sp->ushared != NULL && size <=
PAGE_ALIGN(IBB_SHARED_SIZE)) {
	    while (size > PAGE_SIZE) {
		if (io_remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		    return(-EAGAIN);
		}

		start += PAGE_SIZE;

		if (size > PAGE_SIZE) {
		    size -= PAGE_SIZE;
		} else {
		    size = 0;
		}
	    }

	    debug_out(("ibb_mmap(%d): \
		ushared remap: ibb_sp->ushared: %lx vma->vm_start:
%lx\n",
		ibb_sp->dev_num,
		(u_long)ibb_sp->ushared,
		(u_long)vma->vm_start) );
	} else {
	    debug_out(("ibb_mmap(%d): ushared mmap failed\n",
ibb_sp->dev_num));
	    return(-EAGAIN);
	}

	debug_out(("IBB_SHARED_ADDR - DONE!\n"));
    }

    else if (offset == IBB_CONTROL_OFF && size == PAGE_SIZE) {
	debug_out(("IBB_CONTROL_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_CONTROL_OFF - DONE!\n"));
    }

    else if (offset == IBB_CSRAM_OFF && size == IBB_CSRAM_SIZE) {
	debug_out(("IBB_CSRAM_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_CSRAM_OFF - DONE!\n"));
    }

    else if (offset == IBB_RSRAM_OFF && size == IBB_RSRAM_SIZE) {
	debug_out(("IBB_RSRAM_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_RSRAM_OFF - DONE!\n"));
    }

    else if (offset == IBB_FBACOUNT_OFF && size == PAGE_SIZE) {
	debug_out(("IBB_FBACOUNT_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_FBACOUNT_OFF - DONE!\n"));
    }

    else if (offset == IBB_CAMDELAY_OFF && size == PAGE_SIZE) {
	debug_out(("IBB_CAMDELAY_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_CAMDELAY_OFF - DONE!\n"));
    }

    else if (offset == IBB_FSIZE_OFF && size == PAGE_SIZE) {
	debug_out(("IBB_FSIZE_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_FSIZE_OFF - DONE!\n"));
    }

    else if (offset == IBB_EXTIME_OFF && size == PAGE_SIZE) {
	debug_out(("IBB_EXTIME_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_EXTIME_OFF - DONE!\n"));
    }

    else if (offset == IBB_PLSRAM_OFF && size == IBB_PLSRAM_SIZE) {
	debug_out(("IBB_PLSRAM_OFF\n"));

	debug_out(("ibb_mmap(%d): PLUT Sram %lx %lx\n",
	     ibb_sp->dev_num, (long)offset, size));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_PLSRAM_OFF - DONE!\n"));
    }

    else if (offset == IBB_FB0_OFF
	&& (size == IBB_FB_32_MG
	|| size == IBB_FB_64_MG))
    {
	debug_out(("IBB_FB0_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_FB0_OFF - DONE!\n"));
    }

    else if (offset == IBB_FB1_OFF
	&& (size == IBB_FB_32_MG
	|| size == IBB_FB_64_MG))
    {
	debug_out(("IBB_FB1_OFF\n"));

	while (size > PAGE_SIZE) {
	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
		size -= PAGE_SIZE;
	    } else {
		size = 0;
	    }
	}

	debug_out(("IBB_FB1_OFF - DONE!\n"));
    }

    else {
	debug_out(("IBB_???_OFFSET --- WE'RE BROKEN!!!\n"));
	return(-EAGAIN);
    }

    END;
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

    START;

    if (pci_enable_device(pdev))
	return(-ENODEV);

    result = 0;

    debug_out((
	"ibb_probe: IBB Device 0x%08x has been found @bus %d dev %d func
%d\n",
	 pdev->device,
	 pdev->bus->number,
	 PCI_SLOT(pdev->devfn),
	 PCI_FUNC(pdev->devfn)));

    /* alloc our per-device data */

    dev_num = alloc_ibb_soft_state();

    if (dev_num < 0)
	return(-ENOMEM);

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

    debug_out(("ibb_probe: device %d\n", dev_num));

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

    ibb_major = 0;
    result = register_chrdev(ibb_major, ibb_sp->devname, &ibb_fops);

    if (result < 0) {
	debug_out(("ibb_probe(%d): can't get register driver\n",
dev_num));

	free_all_mappings(ibb_sp);
	free_ibb_soft_state(ibb_sp->dev_num);

	return(-EBUSY);
    }

    if (ibb_major == 0) {
	ibb_major = result;	/* dynamic */
    }

    debug_out(("ibb_probe(%d): got major %d\n",dev_num,ibb_major));

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
	debug_out(("ibb_probe_module(%d): can't get int number\n",
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
	debug_out(("ibb_open(%d): irq request %d failed\n", dev_num,
res));
    	return(-1);
    }

    init_waitqueue_head(&ibb_sp->wq);

    if (ibb_sp->clibb_id == kIbbId) {
	debug_out(("MVP Image Buffer Board: ibb%d, %X.%c, Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibbSingle) {
	debug_out(("MVP Camera Link Single IBB: ibb%d, %X.%c, Int:
%d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibbDualRow) {
	debug_out(("MVP Camera Link DualRow IBB: ibb%d, %X.%c, Int:
%d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibbDualCol) {
	debug_out(("MVP CL DualCol IBB ibb%d, %X.%c, Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else if (ibb_sp->clibb_id == kClibb_HSC) {
	debug_out(("MVP HSC Camera Link IBB: ibb%d, %X.%c, Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    else {
	debug_out(("MVP Unknown IBB: ibb%d, %X.%c, Int: %d\n",
		dev_num,
		device_id,
		revid,
		ibb_sp->myint));
    }

    /* store device id */
    debug_out(("MVP driver(%d) %s\n", dev_num, ibb_c));

    END;
    return(result);
}

static void __exitdata
ibb_remove(struct pci_dev *pdev)
{
    IbbSoftDev *ibb_sp = (IbbSoftDev *)pci_get_drvdata(pdev);

    START;

    if (ibb_sp == NULL) {
	debug_out(("ibb_remove: Error: Null IBB Data in remove\n"));
	return;
    }

    debug_out(("ibb_remove(%d):\n", ibb_sp->dev_num));

    debug_out(("ibb_remove(%d): unregister drv %s\n",
	    ibb_sp->dev_num,
	    ibb_sp->devname));

    if (ibb_sp) {
	free_irq(ibb_sp->myint, (void *)ibb_sp);

	debug_out(("ibb_remove(%d): free_irq myint%d\n",
		ibb_sp->dev_num,
		ibb_sp->myint));

	ibb_sp->myint = 0;
    }
    
    unregister_chrdev(ibb_sp->ibb_major, ibb_sp->devname);

    debug_out(("ibb_remove(%d): release memory\n", ibb_sp->dev_num));

    free_all_mappings(ibb_sp);
    free_ibb_soft_state(ibb_sp->dev_num);

    END;
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
    START;
    init_ibb_soft_state();

    END;
    return(pci_module_init(&ibb_driver));
}

void __exit
ibb_cleanup_module(void)
{
    START;
    pci_unregister_driver(&ibb_driver);

    END;
}

static inline void
set_next_fb(uint32_t *control_regp, uint32_t next_snap, int instance,
int temp_debug)
{
    uint32_t next_fb = (next_snap & IAT_FB_MASK) >> IAT_FB_SHIFT;

    START;

    if (next_fb == 0) {
	*(control_regp) = *(control_regp) | ICR_FB0_ENABL;
	*(control_regp) = *(control_regp) & ~ICR_FB1_ENABL;
    }
    else if (next_fb == 1) {
	*(control_regp) = *(control_regp) | ICR_FB1_ENABL;
	*(control_regp) = *(control_regp) & ~ICR_FB0_ENABL;
    }

    debug_out(("ibb_intr(%d): set fb %d %x\n",
	    instance,
	    next_fb,
	    *(control_regp)));

    END;
}

static inline void
set_next_camera(uint32_t *control_regp, uint32_t next_snap, int
instance, int temp_debug)
{
    uint32_t next_camera;

    START;

    /* first, clear the previous camera settings */
    *(control_regp) &= ICR_CLEARCAM;

    next_camera = (next_snap & IAT_CAMERA_MASK) >> IAT_CAMERA_SHIFT;

    if (next_camera < 0 || next_camera > 7) {
	return;
    }

    *(control_regp) |= (next_camera << ICR_CAMERA_SHIFT);

    debug_out(("ibb_intr(%d): set camera %d reg %x\n",
	    instance,
	    next_camera,
	    *(control_regp)) );

    END;
}

static inline void
set_next_address(IbbSoftDev *ibb_p, uint32_t ibb_control_reg, uint32_t
next_snap, int instance, int temp_debug)
{
    uint32_t next_address = (next_snap & IAT_ADDR_MASK);

    START;

    debug_out(("ibb_intr(%d): got address 0x%x set 0x%x\n",
	    instance,
	    *(ibb_p->fbac_virt),	
	    next_address));

    *(ibb_p->fbac_virt) = next_address;

    END;
}

static inline void
check_intr_delay(IbbSoftDev *ibb_p)
{
    START;

#ifdef TESTCAMDELAY
    hrtime_t snap_ndelay;
    hrtime_t ibb_ntimestamp;

    /* this may be useful but only in fly mode */
    ibb_ntimestamp = gethrtime();

    debug_out(("ibb_intr: ibbtime %llu\n",ibb_ntimestamp / 1000000));
    debug_out(("ibb_intr: rtctime %llu\n", ishared.rtc_ntimestamp));

    if (ibb_ntimestamp < ishared.rtc_ntimestamp) {
	debug_out(("ibb_intr: Bad value %llu for rtc intr\n", 
		ishared.rtc_ntimestamp));
    }

    snap_ndelay = ibb_ntimestamp - ishared.rtc_ntimestamp;

    if (snap_ndelay < kMinSnapDelay) {
	debug_out(("ibb_intr: grab snap delay %lld too short\n",
		snap_ndelay / 1000000));

	ibb_p->ushared->badsnap = kIbbShortSnap;
    }

    else if (snap_ndelay > kMaxSnapDelay) {
	debug_out(("ibb_intr: grab snap delay %lld too long\n",
		snap_ndelay / 1000000));

	ibb_p->ushared->badsnap = kIbbLongSnap;
    }

#endif

    END;
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

    START;

    if (ibb_sp == NULL) {
	debug_out(("ERROR: ibb_intr: ibb_sp = NULL\n"));
	return(IRQ_NONE);
    }

    lock_ibb(ibb_sp, &flags, "ibb_intr");
    instance = ibb_sp->dev_num;
    creg_val = *ibb_sp->creg_virt;

    if (!(creg_val & ICR_INTR_PENDING)) {
	debug_out(("ibb_intr(%d): Not mine\n", ibb_sp->dev_num));

	unlock_ibb(ibb_sp, &flags, "ibb_intr Error");
	return(IRQ_NONE);
    }

    if (creg_val & ICR_CAM_FAIL) {
    	debug_out(("ibb_intr(%d): Camera Failure\n",ibb_sp->dev_num));
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

	debug_out(("ibb_intr(%d): set index %d\n",
		ibb_sp->dev_num,
		ibb_sp->ushared->image_table_index));

	next_snap =
ibb_sp->image_table[ibb_sp->ushared->image_table_index];

	debug_out(("ibb_intr(%d): got next entry %d %x\n",instance,
		ibb_sp->ushared->image_table_index,
		next_snap));

	creg_val = *ibb_sp->creg_virt;
	debug_out(("ibb_intr(%d): set %x intr %x\n", 
		ibb_sp->dev_num,
		intr_set,
		creg_val));

	set_next_fb(ibb_sp->creg_virt, next_snap, instance, temp_debug);
	set_next_camera(ibb_sp->creg_virt, next_snap, instance,
temp_debug);
	set_next_address(ibb_sp, creg_val, next_snap, instance,
temp_debug);

        debug_out(("ibb_intr(%d): fbacount 0x%x\n",
		instance,
		*(ibb_sp->fbac_virt)));

	if (ibb_sp->flags & kIoWaiting) {
	    debug_out(("ibb_intr(%d): waiting for ind %d got %d\n",
		    instance,
		    ibb_sp->wait_for,
		    ibb_sp->ushared->image_table_index));

	    if (ibb_sp->ushared->image_table_index > ibb_sp->wait_for) {
		debug_out(("ibb_intr(%d): wake up wait queue\n",
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

    debug_out(("irqreturn_t ibb_intr - DONE!\n"));

    END;
    return(IRQ_HANDLED);
}

void
ibb_rtc_wakeup(void)
{
    int i;
    u_long flags;

    START;

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

    END;
}

module_init(ibb_init_module);
module_exit(ibb_cleanup_module);

-->
/usr/src/redhat/BUILD/kernel-2.6.16/linux-2.6.16.16/drivers/mvp/ibbsoft.
h

#include <linux/pci.h>
#include <linux/fs.h>

typedef struct IbbSoftDev_struct {

    struct semaphore 	sem;
    u8  		myint;
    u_int  		context;
    void 		*mem_base;
    u_long 		iobase;
    u_long 		iosize;
    char    		devname[8];
    int			dev_num;
    struct pci_dev *	pdev;
    int 		ibb_major;
    u16 		device_id;
    u_char		flags;		/* state info */

    u_long 		creg_phys;
    u_long 		creg_size;
    uint32_t            *creg_virt;

    u_long 		height_phys;
    u_long 		height_size;
    uint32_t            *height_virt;

    u_long 		csram_phys;
    u_long 		csram_size;
    uint32_t            *csram_virt;

    u_long 		rsram_phys;
    u_long 		rsram_size;
    uint32_t            *rsram_virt;

    u_long 		fbac_phys;
    u_long 		fbac_size;
    uint32_t            *fbac_virt;

    u_long 		camdelay_phys;
    u_long 		camdelay_size;
    uint32_t            *camdelay_virt;

    u_long 		fsize_phys;
    u_long 		fsize_size;
    uint32_t            *fsize_virt;

    u_long 		extime_phys;
    u_long 		extime_size;
    uint32_t            *extime_virt;

    u_long 		plsram_phys;
    u_long 		plsram_size;
    uint32_t            *plsram_virt;

    u_long 		fb0_phys;
    u_long 		fb0_size;
    uint32_t            *fb0_virt;

    u_long 		fb1_phys;
    u_long 		fb1_size;
    uint32_t            *fb1_virt;

/*
 * shared memory (with user space) pointer
 */
    IbbUserShared	*ushared;
    uint32_t		*image_table;
    uint32_t		image_table_size;
    uint16_t		wait_for;

    uint16_t		height_inspection;
    uint16_t		clibb_id;


    spinlock_t mutex;		/* linux mutex equivilent */

    wait_queue_head_t	wq;	/* linux cv equivilent */
} IbbSoftDev;


#ifdef SOLARISBUILD

typedef struct ibb_soft_state {
    dev_info_t  	*dip;                  	/* back pointer */
    u_char              flags;                  /* state info */
    u_char              ufiller; 
    short               sfiller; 

    kmutex_t    	mutex;   	  	/* interrupt locking */

    u_long		fb0_memsize;
    u_long		fb1_memsize;

/*
 * interrupt data
 */
    ddi_iblock_cookie_t	iblock_cookie;	
    kcondvar_t		cv;
    short		sfiller2;
    long		have_intr;
/*
 * handles to reg space 
 */
    uint32_t             *config_regp;
    ddi_acc_handle_t    config_handle;
    uint32_t            *control_regp;
    ddi_acc_handle_t    control_handle;
    uint32_t            *col_sram_regp;
    ddi_acc_handle_t    col_sram_handle;
    uint32_t            *row_sram_regp;
    ddi_acc_handle_t    row_sram_handle;
    uint32_t            *fba_count_regp;
    ddi_acc_handle_t    fba_count_handle;
    uint32_t            *fsize_regp;
    ddi_acc_handle_t    fsize_handle;
    uint8_t            *fb0_regp;
    ddi_acc_handle_t    fb0_handle;
    uint8_t            *fb1_regp;
    ddi_acc_handle_t    fb1_handle;

    
/*
 * shared memory (with user space) pointer
 */
    IbbUserShared		*ushared;
    uint32_t		*image_table;
    uint32_t		image_table_size;
    uint32_t		wait_for;
/*
 * context switching structures
 */
    struct ibb_cntxt *curctx;      /* context switching */
    struct ibb_cntxt shared_ctx;   /* shared context */
    struct ibb_cntxt *pvt_ctx;     /* list of non-shared contexts */


} ibb_softc;

#endif

-->
/export/home/ultra-trix/brian/mvp/work/pcb-fedora/include/localinc/dev/i
bb.h

#ifndef IBB_h
#define IBB_h

/* 
 * The version information is compiled into both the MVP software
 * and the device driver, and is used to make sure the software
 * is being run with the proper driver.  If a change is made
 * to the functioning of the driver or to the size or offsets of
 * any of the areas of common memory, this version number should
 * increment.
 */

#include <sys/ioctl.h>                /* _IO */
#include <stdint.h>
#include <stdint.h>

/*
 * MVP image buffer board ioctls
 */

#if defined(UNIXHOST) || defined(_KERNEL) || defined(KERNEL)
#define NEW
#endif

#ifdef NEW
#define	IBBWAIT		_IOW('I', 0, u_long )
#define	IBBSIZE		_IOR('I', 1, u_long *)
#define	IBBTST		_IO('I', 2 )
#define	IBBWAKEUP	_IO('I', 3 )
#define	IBBFBACOUNT	_IOW('I', 4, u_long )
#define	IBBFSIZE	_IOW('I', 5, u_long )
#define	DUMP_TABLE	_IOW('I', 6, u_long )	/* XXXXX debug image
table */
#define	IBBVERSION	_IOR('I', 7, u_long *)
#define	IBBCLIBB_ID	_IOR('I', 8, short )
#define	IBBHEIGHTGO	_IO('I', 9 )
#define	IBBHEIGHTSTOP	_IO('I', 10 )
#define	IBB_SET_MTRR	_IO('I', 11 )
#define	IBB_CLEAR_MTRR	_IO('I', 12 )
#else
#define	IBBWAIT		(('I'<<8)|0)
#define	IBBSIZE		(('I'<<8)|1)
#define	IBBTST		(('I'<<8)|2)
#define	IBBWAKEUP	(('I'<<8)|3)
#define	IBBFBACOUNT	(('I'<<8)|4)
#define	IBBFSIZE	(('I'<<8)|5)
#define	DUMP_TABLE	(('I'<<8)|6)	/* XXXXX debug image table */
#define	IBBVERSION	(('I'<<8)|7)
#define	IBBCLIBB_ID	(('I'<<8)|8)
#define	IBBHEIGHTGO	(('I'<<8)|9)
#define	IBBHEIGHTSTOP	(('I'<<8)|10)
#define	IBB_SET_MTRR	(('I'<<8)|11)
#define	IBB_CLEAR_MTRR	(('I'<<8)|12)
#endif

#define	kIbbGoodSnap	0
#define	kIbbLongSnap	-1
#define kIbbShortSnap	-2

/* 
 * CLIBB type stored in subsystem id - available to 
 * user from IBBCLIBB_ID ioctl
 */

static const uint16_t kIbbId = 0;
static const uint16_t kClibbSingle = 1;
static const uint16_t kClibbDualRow = 2;
static const uint16_t kClibbDualCol = 3;
static const uint16_t kClibb_HSC = 4;

static const u_long kIbbVersion = 1001;

typedef struct ibb_shared {
    uint16_t 	image_table_index;
    int16_t	badsnap;
} IbbUserShared;

const long kOneMeg	= 1024L * 1024L;
const long kOneKbyte	= 1024L;

/*
 * max of one ibb per camera
 * (theoretical limit may be closer to 6 - keep an eye
 * on this number
 */

/* 
 * check delay between RTC interrupt and IBB interrupt 
 * if delay < kMinSnapDelay then the interupt happended too fast - error
 * if delay > kMaxSnapDelay then the interupt happended too slow - error
 */

#define kMaxIbbs		8

#define kMaxRtcEcounts		0x8000
#define kMinInterruptDelay	1000000			/* 1 millisecond
*/
#define kMaxSnapDelay		20000000000		/* 20 seconds */

#define IBB_DEVICE		"/dev/ibb"
#define IBB3D_DEVICE		"/dev/ibb3d"

/*
 * layout for the address space on the MVP image buffer board 
 */

#define	MEM_REG_NUM		1

/* Image Assignement Table */
#define IBB_IMAGE_ADDR		0x00000000
#define IBB_IMAGE_SIZE		kMaxRtcEcounts * sizeof(long)	

/* misc ibb shared information */
#define IBB_SHARED_ADDR		0x00100000
#define IBB_SHARED_SIZE		sizeof(IbbUserShared)


/* Control Register */
#define IBB_CONTROL_OFF		0x01000000
#define IBB_CONTROL_SIZE	0x04	

/* Height Sensor */
#define IBB_HEIGHT_OFF		0x01800000
#define IBB_HEIGHT_SIZE		0x04	

/* Column Sram */
#define IBB_CSRAM_OFF		0x02000000 
#define IBB_CSRAM_SIZE		8 * kOneKbyte		

/* Row Sram */
#define IBB_RSRAM_OFF		0x03000000
#define IBB_RSRAM_SIZE		8 * kOneKbyte

/* IVP Camera TXD Register (9 bit field) */
#define IBB3D_IVPCAM_OFF	0x01800000
#define IBB3D_IVPCAM_SIZE	0x04

/* 3D Encoder Counter Offset Count */
#define IBB3D_ECOC_OFF		0x02000000 
#define IBB3D_ECOC_SIZE		0x04

/* 3D Profile Count */
#define IBB3D_PROF_OFF		0x03000000
#define IBB3D_PROF_SIZE		0x04

/* Frame Buffer Address Counter */
#define IBB_FBACOUNT_OFF	0x04000000 
#define IBB_FBACOUNT_SIZE	0x04

/* Camera Delay Register */
#define IBB_CAMDELAY_OFF	0x04800000 
#define IBB_CAMDELAY_SIZE	0x04

/* Frame Size Register */
#define IBB_FSIZE_OFF		0x05000000
#define IBB_FSIZE_SIZE		0x04

/* Exposure Time Register */
#define IBB_EXTIME_OFF		0x05800000
#define IBB_EXTIME_SIZE		0x04

/* Pixel LUT SRAM */
#define IBB_PLSRAM_OFF		0x06000000
#define IBB_PLSRAM_SIZE		4 * kOneKbyte

/* 3D Encoder Counter SRAM */
#define IBB3D_ECSRAM_OFF	0x06000000
#define IBB3D_ECSRAM_SIZE 	0x00200000	/* 2 megs? */

#define IBB3D_MAX_ECSRAM_VALUE	0xFFFFF

/* 3D EC SRAM Offset Register*/
#define IBB3D_ECSOR_OFF		0x07000000
#define IBB3D_ECSOR_SIZE	0x04

/* Frame Buffers */
#define IBB_FB0_OFF		0x08000000 
#define IBB_FB1_OFF		0x0c000000 
#define IBB_FB_32_MG		32 * kOneMeg 
#define IBB_FB_64_MG		64 * kOneMeg

/* FB0 & FB1 offsets for 3D */
#define IBB3D_FB0_START_COUNTER 0x0
#define IBB3D_FB1_START_COUNTER 0x04000000

#define k32MB			1
#define k64MB			2

/* Image Assignment Table masks and shifts */
#define IAT_ADDR_MASK    	0x07ffffff
#define IAT_FB_MASK         	0x08000000
#define IAT_CAMERA_MASK     	0x70000000
#define IAT_DONE_MASK       	0x80000000

/* IAT_ADDR_SHIFT = 0 */
#define IAT_FB_SHIFT        	27
#define IAT_CAMERA_SHIFT    	28
#define IAT_DONE_SHIFT      	31
#define IAT_SNAP_DONE		0x80000000

/* IBB Control Register masks */
#define ICR_INTR_PENDING	0x00000001	
#define ICR_INTR_CLEAR		0x00000002	

#define ICR_PLUT_PG0		0x00000010
#define ICR_PLUT_PG1		0x00000020
#define ICR_PLUT_PG2		0x00000040

#define ICR_CAM_FAIL 		0x00000200
#define ICR_CLR_CAM_FAIL	0x00000400
#define ICR_FB1REGEN		0x00000800
#define IVP_CLEAR_CAMERA	0x00004000	
#define ICR_SNAP_ENABLE		0x00008000	

#define ICR_CAMSEL0		0x00010000	
#define ICR_CAMSEL1		0x00020000	
#define ICR_CAMSEL2		0x00040000	
#define ICR_CAMSELOFF		0x00080000	

#define ICR_CLEARCAM		~(ICR_CAMSEL0|ICR_CAMSEL1|ICR_CAMSEL2)

#define ICR_CAMERA_SHIFT	16

#define ICR_3DSEL0		0x00100000
#define ICR_3DSEL1		0x00200000
#define ICR_3DSELON		0x00400000

#define ICR_SRAM_ENABL		0x00800000
#define ICR_SIM_FIRE		0x01000000
#define ICR_SOFT_IMAGE		0x02000000
#define ICR_RSRAM0		0x04000000
#define ICR_RSRAM1		0x08000000
#define ICR_CSRAM0		0x10000000
#define ICR_CSRAM1		0x20000000
#define ICR_CLEARSRAM
~(ICR_RSRAM0|ICR_RSRAM1|ICR_CSRAM0|ICR_CSRAM1)
#define ICR_FB0_ENABL		0x40000000
#define ICR_FB1_ENABL		0x80000000

#define ICR_PLUT_GR1		ICR_PLUT_PG2
#define ICR_PLUT_RED		(ICR_PLUT_PG0|ICR_PLUT_PG2 )  
#define ICR_PLUT_BLUE		(ICR_PLUT_PG1|ICR_PLUT_PG2 )
#define ICR_PLUT_GR2		(ICR_PLUT_PG0|ICR_PLUT_PG1|ICR_PLUT_PG2)
#define ICR_CLEARPLUT
~(ICR_PLUT_PG0|ICR_PLUT_PG1|ICR_PLUT_PG2)

#define ICR_COUNTDIR		0x00001800

#endif
---{ END IBB ]---

---[ BEGIN RTC ]---

-->
/usr/src/redhat/BUILD/kernel-2.6.16/linux-2.6.16.16/drivers/mvp/mvp_rtc.
c

static const char *rtc_c = "$Id: mvp_rtc.c,v 1.3 2006/04/18 21:20:36
brian Exp brian $ (c) MVP ";

#include <asm/io.h>		/* ioremap */
#include <asm/uaccess.h>	/* put_user */
#include <linux/config.h>	/* access CONFIG_PCI macro */
#include <linux/fs.h>
#include <linux/interrupt.h>	/* request/free_irq */
#include <linux/mm.h>		/* memory mapping */
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/slab.h>		/* kmalloc() */
#include <linux/types.h>

#include "dev/rtc.h"
#include "rtcsoft.h"

#ifndef __KERNEL__
#define __KERNEL__
#endif

#ifndef MODULE
#define MODULE
#endif

#ifndef CONFIG_PCI
#error "This driver REQUIRES PCI support"
#endif

#if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
#define MODVERSIONS /* force it on */
#endif

#ifdef CONFIG_DEVFS_FS
#include <linux/devfs_fs_kernel.h>
#endif

#ifdef CONFIG_DEVFS_FS
devfs_handle_t rtc_devfs_dir;
#endif

#define TYPE(dev)   (MINOR(dev) >> 4)  /* high nibble */
#define NUM(dev)    (MINOR(dev) & 0xf) /* low  nibble */

#define kOneByteShift 8

extern void ibb_rtc_wakeup(void);
irqreturn_t rtc_intr(int irq, void *dev_id, struct pt_regs *regs);

static RtcSoftDev *RtcSoft[kNrtc];

#define DEBUG

#ifdef DEBUG
#define debug_out(msg)          { printk msg; }
#else
#define debug_out(msg)
#endif

static void
lock_rtc(RtcSoftDev *rtc_sp, unsigned long *flags, const char *where)
{
    debug_out(("lock_rtc(%d): %s:\n", rtc_sp->dev_num, where));
    spin_lock_irqsave(&rtc_sp->mutex, *flags);
    debug_out(("lock_rtc(%d): Done %s:\n", rtc_sp->dev_num, where));
}

static void
unlock_rtc(RtcSoftDev *rtc_sp, unsigned long *flags, const char *where)
{
    debug_out(("unlock_rtc(%d): %s:\n", rtc_sp->dev_num, where));
    spin_unlock_irqrestore(&rtc_sp->mutex, *flags);
    debug_out(("unlock_rtc(%d): %s:\n", rtc_sp->dev_num, where));
}

static void
init_rtc_soft_state(void)
{
    int i;

    for (i = 0; i < kNrtc; i++) {
	RtcSoft[i] = NULL;
    }
}

static int
alloc_rtc_soft_state(void)
{
    int i;

    for (i = 0; i < kNrtc; i ++) {
	if (RtcSoft[i] == NULL) {
	    RtcSoft[i] = kmalloc(sizeof(RtcSoftDev), GFP_KERNEL);

	    if (RtcSoft[i] == NULL) {
		debug_out(("alloc_rtc_soft_state: out of memory.\n"));
		return(-1);
	    }

	    debug_out(("alloc_rtc_soft_state: return %d\n", i));
	    return(i);
	}
    }

    return(-1);
}

/*
 * There may be a better way to do this!
 *
 * I need to make sure the data I initialized in rtc_probe()
 * for device "X"  is the same data I use in rtc_open().
 *
 * I could use the minor numbers, but I have to trust that
 * the 'load' script for the rtc device is written correctly,
 * since that's where minor numbers are assigned.
 *
 * So I'm using the major numbers.  It's a little slower, since
 * major  numbers tend to be >200 I'm not just going to use
 * them as indexes into my array.  Instead I'm going though
 * all the devices looking for the matching major.
 *
 * My concern, frankly, is that no other drivers seem to be
 * using this method.  But it seems the only foolproof way
 * to keep the data with the device
 */

static int
find_rtc_soft_state(int rtc_major)
{
    int i;

    debug_out(("find_rtc_soft_state: major %d\n", rtc_major));

    for (i = 0; i < kNrtc; i++) {
	if (RtcSoft[i] != NULL) {
	    if( rtc_major == RtcSoft[i]->rtc_major) {
		debug_out(("find_rtc_soft_state: return %d\n", i));

		return(i);
	    }
	}
    }

    debug_out(("Can't find matching soft_state %d!\n", rtc_major));
    return(-1);
}

static void
free_rtc_soft_state(int i)
{
    if (RtcSoft[i] == NULL)
	return;

    debug_out(("free_rtc_soft_state(%d):\n", RtcSoft[i]->dev_num));

    kfree(RtcSoft[i]);
    RtcSoft[i] = NULL;

    return;
}

ssize_t
rtc_read(struct file *filp, char * buf, size_t count, loff_t *f_pos)
{
    return(-EINVAL);
}

ssize_t 
rtc_write(struct file *filp, const char *buf, size_t count, loff_t
*f_pos)
{
    return(-EINVAL);
}

int
rtc_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
unsigned long __user arg)
{
    RtcSoftDev *rtc_sp = filp->private_data;
    RtcStrobes rtc_light;

    struct timeval tv;

    u_long ecounts;
    u_long flags;

    int retval = 0;

    uint16_t i;
    uint16_t light_mask;

    uint32_t control_reg;
    uint32_t fireoff;
    uint32_t fireon;
    uint32_t reset;
    uint32_t set;
    uint32_t strobe_timer;
    uint32_t strobe_timer_mask;
    volatile uint32_t StartInspecting;

    if (rtc_sp == NULL) {
	debug_out(("rtc_ioctl: Soft Info Lost\n"));
	return(-EFAULT);
    }

    switch(cmd) {
	case RTCBONVOYAGE:
	    debug_out(("RTCBONVOYAGE\n"));
	    do_gettimeofday(&tv);

	    lock_rtc(rtc_sp, &flags, "RTCBONVOYAGE");

	    rtc_sp->shared_host_mem->ntimestamp = tv.tv_sec;
	    rtc_sp->snap_int_virt[kLastSnapLoc] = FIRST_SCAN;
	    StartInspecting = rtc_sp->snap_int_virt[kLastSnapLoc];

	    unlock_rtc(rtc_sp, &flags, "RTCBONVOYAGE");

	    debug_out(("RTCBONVOYAGE - DONE\n"));
	    break;

	case RTCWAKEUP:
	    debug_out(("RTCWAKEUP\n"));
	    ibb_rtc_wakeup();

	    debug_out(("RTCWAKEUP - DONE\n"));
	    break;


	case RTC_STROBEPROG_ON:
	    debug_out(("RTC_STROBEPROG_ON\n"));

	    if (copy_from_user((void *)rtc_light, 
		    (const void *)__user arg,
		    sizeof(RtcStrobes)))
	    {
		debug_out(("rtc_ioctl: can't copy RtcStrobes %lx %d\n",
			arg, sizeof(RtcStrobes)));

		return(EFAULT);
	    }

	    lock_rtc(rtc_sp, &flags, "RTC_STROBEPROG_ON");

	    light_mask = 0;
	    strobe_timer = 0;

	    for (i = 0; i < kMaxRtcRings; i++) {
		if (rtc_light[i].hw_time > -1) {
		    debug_out(("rtc_ioctl: Enter time 0x%x for ring
%d\n",
			    rtc_light[i].hw_time,i));

		    light_mask |= (1 << (i));

		    strobe_timer_mask = rtc_light[i].hw_time;
		    strobe_timer_mask = strobe_timer_mask <<(i *
kOneByteShift);

		    strobe_timer = strobe_timer | strobe_timer_mask;
		}
	    }

	    *(rtc_sp->strobe_virt) = strobe_timer;
	    control_reg = *(rtc_sp->control_virt);

	    /* turn off all lights before putting in the ones we want */
	    control_reg &= ~ RCR_ALLLIGHTS;

	    if (light_mask == 0) {
		control_reg &= ~RCR_STROBEPROG;
	    }

	    else {
		light_mask = light_mask << 4;
		control_reg |= RCR_STROBEPROG;
		control_reg |= light_mask;
	    }

	    *(rtc_sp->control_virt) = control_reg;
	    unlock_rtc(rtc_sp, &flags, "RTC_STROBEPROG_ON");

	    debug_out(("rtc_ioctl:control_reg at %#x\n", control_reg));
	    debug_out(("rtc_ioctl:strobe_reg at %#x\n", strobe_timer));

	    debug_out(("RTC_STROBEPROG_ON - DONE\n"));
	    break;

	case RTC_STROBEPROG_OFF:
	    /* set byte 0 in control reg to 0 */
	    debug_out(("RTC_STROBEPROG_OFF\n"));

	    lock_rtc(rtc_sp, &flags, "RTC_STROBEPROG_OFF");
	    *(rtc_sp->control_virt) &= ~RCR_ALLLIGHTS;

	    debug_out(("rtc_ioctl:control_reg at %#x\n",
		*(rtc_sp->control_virt)));

	    *(rtc_sp->control_virt) &= ~RCR_STROBEPROG;

	    debug_out(("rtc_ioctl:control_reg at %#x\n",
		    *(rtc_sp->control_virt)));

	    unlock_rtc(rtc_sp, &flags, "RTC_STROBEPROG_OFF");

	    debug_out(("RTC_STROBEPROG_OFF - DONE\n"));
	    break;

	case RTCFIRESTROBE:
	    /* set and reset bit 1 in control register */
	    debug_out(("RTCFIRESTROBE\n"));

	    lock_rtc(rtc_sp, &flags, "RTCFIRESTROBE");

	    fireoff = *(rtc_sp->control_virt);
	    fireon = fireoff | RCR_FIRESTROBE;

	    *(rtc_sp->control_virt) = fireon;
	    *(rtc_sp->control_virt) = fireoff;

	    unlock_rtc(rtc_sp, &flags, "RTCFIRESTROBE");

	    debug_out(("RTCFIRESTROBE - DONE\n"));
	    break;

	case RTCSTARTECOUNT:
	    /* 
	     * we need to set this bit so the encoder counts will be
	     * available to our encoder_regp regisert.  
	     */

	    debug_out(("RTCSTARTECOUNT\n"));

	    lock_rtc(rtc_sp, &flags, "RTCSTARTECOUNT");
	    *(rtc_sp->control_virt) |= RCR_ECOUNTON;
	    unlock_rtc(rtc_sp, &flags, "RTCSTARTECOUNT");

	    debug_out(("RTCSTARTECOUNT - DONE\n"));
	    break;

	case RTCGETECOUNT:
	    debug_out(("RTCGETECOUNT\n"));

	    lock_rtc(rtc_sp, &flags, "RTCGETECOUNT");
	    ecounts = *(rtc_sp->encoder_virt);

	    if (put_user(ecounts, (unsigned long *)__user arg)) {
		debug_out(("rtc_ioctl: can't copy encoder counts %lx
%d\n",
			ecounts, sizeof(long)));

		retval = -EFAULT;
	    }

	    /*
	     * clear the bit
	     */

	    *(rtc_sp->control_virt) &= ~RCR_ECOUNTON;
	    unlock_rtc(rtc_sp, &flags, "RTCGETECOUNT");

	    debug_out(("RTCGETECOUNT - DONE\n"));
	    break;

	case RTCRESETSNAP:
	    /* 
	     * if there has been an estop or a software crash, it's
possible
	     * the RTC state machine has gotten confused.  Setting and
reseting
	     * bit 15 will clear the state machine so it's ready for new
	     * inspections 
	     */

	    debug_out(("RTCRESETSNAP\n"));

	    lock_rtc(rtc_sp, &flags, "RTCRESETSNAP");
	    reset = *(rtc_sp->control_virt);
	    set = reset | RCR_SRESET;

	    *(rtc_sp->control_virt) = set;
	    *(rtc_sp->control_virt) = reset;

	    unlock_rtc(rtc_sp, &flags, "RTCRESETSNAP");

	    debug_out(("RTCRESETSNAP - DONE\n"));
	    break;

	case RTC_STAGE_NON_LINEAR:
	    /*
	     * change the dig cam compensation distance for non-linear
	     * stages, which have fewer encoder counts per inch
	     */

	    debug_out(("RTC_STAGE_NON_LINEAR\n"));

	    lock_rtc(rtc_sp, &flags, "RTC_STAGE_NON_LINEAR");
	    *(rtc_sp->control_virt) |= RCR_COMPSIZE;
	    unlock_rtc(rtc_sp, &flags, "RTC_STAGE_NON_LINEAR");

	    debug_out(("RTC_STAGE_NON_LINEAR - DONE\n"));
	    break;

	case RTCVERSION:
	    debug_out(("RTCVERSION\n"));

	    lock_rtc(rtc_sp, &flags, "RTCVERSION");

	    if (put_user(kRtcVersion, (unsigned long *)__user arg)) {
		debug_out(("rtc_ioctl: can't copy Version info %ld\n",
			kRtcVersion));

		retval = -EFAULT;
	    }

	    unlock_rtc(rtc_sp, &flags, "RTCVERSION");

	    debug_out(("rtc_ioctl: COPIED Version info %ld\n",
kRtcVersion));
	    debug_out(("RTCVERSION - DONE\n"));

	    break;

	default:
	    debug_out(("rtc_ioctl: unknown case: %d\n", cmd));
	    debug_out(("RTC---WTF\n"));

	    retval = -ENOTTY;
    }

    return(retval);
}

/*
 * just make sure the area mmap is requesting falls within
 * valid areas for the RTC card
 */

/* our off - 0x20000
 * our phys_off - 0x20000
 * our phys_diff - 0x20000
 */

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

    if (offset == RTC_SNAP_INTERVAL_OFFSET) {
	debug_out(("RTC_SNAP_INTERVAL_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_DIGIO_OFFSET) {
	debug_out(("RTC_DIGIO_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_STROBE_TIMER_OFFSET) {
	debug_out(("RTC_STROBE_TIMER_OFFSET: %x\n", offset));


	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));


	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_CONTROL_REG_OFFSET) {
	debug_out(("RTC_CONTROL_REG_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}

    }

    else if (offset == RTC_ENCODER_CNT_OFFSET) {
	debug_out(("RTC_ENCODER_CNT_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_GRAPHICS_REG_OFFSET) {
	debug_out(("RTC_GRAPHICS_REG_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_CY545_TRANS_OFFSET) {
	debug_out(("RTC_CY545_TRANS_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_CY545_CONTROL_OFFSET) {
	debug_out(("RTC_CY545_CONTROL_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_GRAPHICS_MEM_OFFSET) {
	debug_out(("RTC_GRAPHICS_MEM_OFFSET: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

	    if (size > PAGE_SIZE) {
	    	size -= PAGE_SIZE;
	    } else {
	    	size = 0;
	    }
	}
    }

    else if (offset == RTC_COMMON_VADDR) {
	debug_out(("RTC_COMMON_VADDR: %x\n", offset));

	while (size > 0) {
	    debug_out(("START: %x, SIZE: %x, OFFSET: %x, PAGE: %x\n",
	    	start, size, offset, page));

	    if (remap_pfn_range(vma, start, page, PAGE_SIZE,
PAGE_SHARED)) {
		return(-EAGAIN);
	    }

	    start += PAGE_SIZE;

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

int
rtc_open(struct inode *inode, struct file *filep)
{
    RtcSoftDev *rtc_sp;
    int dev_num;

    int major = MAJOR(inode->i_rdev);
    int minor = MINOR(inode->i_rdev);

    /*
     * the type and num values are only valid if we are not using devfs.
     * hmm - sounds bad
     */

    /*
     * assign the private data so we can access it later
     * ( in read, write, ioctl, etc );
     */

    debug_out(("rtc_open: major %d minor %d\n", major, minor));
    dev_num = find_rtc_soft_state(major);

    if (dev_num < 0) {
	debug_out(("rtc_open: dev_num %d failed\n", dev_num));
    	return(-1);
    }

    rtc_sp = RtcSoft[dev_num];
    filep->private_data = rtc_sp;

    debug_out(("rtc opened by %s pid %d PAGE_SIZE %#lx\n",
	    current->comm, current->pid, PAGE_SIZE));

    return(0);
}

int
rtc_close( struct inode *inode, struct file *filep )
{
    return(0);
}

struct file_operations rtc_fops = {
    read:	rtc_read,
    write:	rtc_write,
    ioctl:	rtc_ioctl,
    mmap:	rtc_mmap,
    open:	rtc_open,
    release:	rtc_close,
};

static int
free_rtc_usr_shared(RtcSoftDev *rtc_sp)
{
    unsigned long virt_addr;
    struct page *page;

    /* unreserve all pages */

    for (virt_addr = (unsigned long) rtc_sp->shared_host_mem; 
	virt_addr < (unsigned long) rtc_sp->shared_host_mem +
RTC_COMMON_SIZE;
	virt_addr+=PAGE_SIZE)
    {
    	page = virt_to_page(virt_addr);
	ClearPageReserved(page);

	// atomic_set(&page->_count, 1);
	free_page(virt_addr);
    }

    if (rtc_sp->shared_host_mem) {
	rtc_sp->shared_host_mem = NULL;
    }

    return(0);
}

static int
alloc_rtc_usr_shared(RtcSoftDev *rtc_sp)
{
    unsigned long virt_addr;
    int order = 0;

    /* 
     * get a memory area with kmalloc and aligned it to a page. This
area
     * will be physically contigous
     */

    while (RTC_COMMON_SIZE > (PAGE_SIZE * (1 << order))) {
    	order++;
    }

    rtc_sp->shared_host_mem = (RtcShared *)__get_free_pages(GFP_KERNEL,
order);

    if (rtc_sp->shared_host_mem == NULL) {
	debug_out(("alloc_rtc_usr_shared: out of memory.\n"));
	return(-1);
    }

    for (virt_addr = (unsigned long)rtc_sp->shared_host_mem; 
	    virt_addr < (unsigned
long)rtc_sp->shared_host_mem+RTC_COMMON_SIZE;
	    virt_addr += PAGE_SIZE)
    {
	/* reserve all pages to make them remapable */
	SetPageReserved(virt_to_page(virt_addr));
    }

    return(0);
}

static void
free_all_mappings(RtcSoftDev *rtc_sp)
{
    if (rtc_sp->snap_int_virt != NULL) {
	iounmap(rtc_sp->snap_int_virt);
	rtc_sp->snap_int_virt = NULL;
    }

    /*
     * we can call release_mem_region() without checking anything -
     * if the region hasn't been requested, the function will
     * just exit with an error message.
     * ( unlink iounmap() )
     */

    release_mem_region(rtc_sp->snap_int_phys, rtc_sp->snap_int_size);
    if (rtc_sp->digio_virt != NULL) {
	iounmap(rtc_sp->digio_virt);
	rtc_sp->digio_virt = NULL;
    }

    release_mem_region(rtc_sp->digio_phys, rtc_sp->digio_size);
    if (rtc_sp->strobe_virt != NULL) {
	iounmap(rtc_sp->strobe_virt);
	rtc_sp->strobe_virt = NULL;
    }

    release_mem_region(rtc_sp->strobe_phys, rtc_sp->strobe_size);
    if (rtc_sp->control_virt != NULL) {
	iounmap(rtc_sp->control_virt);
	rtc_sp->control_virt = NULL;
    }

    release_mem_region(rtc_sp->control_phys, rtc_sp->control_size);
    if (rtc_sp->encoder_virt != NULL) {
	iounmap(rtc_sp->encoder_virt);
	rtc_sp->encoder_virt = NULL;
    }

    release_mem_region(rtc_sp->encoder_phys, rtc_sp->encoder_size);
    if (rtc_sp->graphics_reg_virt != NULL) {
	iounmap(rtc_sp->graphics_reg_virt);
	rtc_sp->graphics_reg_virt = NULL;
    }

    release_mem_region(rtc_sp->graphics_reg_phys,
rtc_sp->graphics_reg_size);
    if (rtc_sp->cy545_trans_virt != NULL) {
	iounmap(rtc_sp->cy545_trans_virt);
	rtc_sp->cy545_trans_virt = NULL;
    }

    release_mem_region(rtc_sp->cy545_trans_phys,
rtc_sp->cy545_trans_size);
    if (rtc_sp->cy545_cr_virt != NULL) {
	iounmap(rtc_sp->cy545_cr_virt);
	rtc_sp->cy545_cr_virt = NULL;
    }

    release_mem_region(rtc_sp->cy545_cr_phys, rtc_sp->cy545_cr_size);
    if (rtc_sp->graphics_mem_virt != NULL) {
	iounmap(rtc_sp->graphics_mem_virt);
	rtc_sp->graphics_mem_virt = NULL;
    }

    release_mem_region(rtc_sp->graphics_mem_phys,
rtc_sp->graphics_mem_size);
    if (rtc_sp->shared_host_mem != NULL) {
	free_rtc_usr_shared(rtc_sp);
    }
}

static int 
rtc_map_one(RtcSoftDev *rtc_sp, u_long phys, u_long size, uint32_t
**virt, const char *what)       
{
    struct resource *res;

    if ((res = request_mem_region(phys,size,rtc_sp->devname)) == NULL) {
	debug_out(("rtc_map_one(%d): can't allocate %s at %010lx %#010lx
%s\n",
	    rtc_sp->dev_num, what, phys, size, rtc_sp->devname));

	return(-1);
    }

    else {
	*virt = ioremap_nocache(phys, size);
	if (!virt) {
	    debug_out(("rtc_map_one(%d): Error in ioremap\n",
rtc_sp->dev_num));

	    release_mem_region(phys, size);
	    return(-1);
	}
    }

    debug_out(("rtc_map_one(%d): Successful map %s: Phys %#lx\n",
	    rtc_sp->dev_num, what, phys));

    return(0);
}

static int
rtc_do_all_mappings(RtcSoftDev *rtc_sp)
{
    rtc_sp->snap_int_virt	= NULL;
    rtc_sp->digio_virt		= NULL;
    rtc_sp->strobe_virt		= NULL;
    rtc_sp->control_virt	= NULL;
    rtc_sp->encoder_virt	= NULL;
    rtc_sp->graphics_reg_virt	= NULL;
    rtc_sp->cy545_trans_virt	= NULL;
    rtc_sp->cy545_cr_virt	= NULL;
    rtc_sp->graphics_mem_virt	= NULL;

    /* Map Snap Interval */

    rtc_sp->snap_int_phys = rtc_sp->iobase + RTC_SNAP_INTERVAL_OFFSET;
    rtc_sp->snap_int_size = RTC_SNAP_INTERVAL_SIZE;		

    if (rtc_map_one(rtc_sp,
	    rtc_sp->snap_int_phys,
	    rtc_sp->snap_int_size,
	    &rtc_sp->snap_int_virt,
	    "Snap Interval") < 0)
    {
	return(-1);
    }

    /* Map Digital I/O */

    rtc_sp->digio_phys = rtc_sp->iobase + RTC_DIGIO_OFFSET;
    rtc_sp->digio_size = RTC_DIGIO_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->digio_phys,
	    rtc_sp->digio_size,
	    &rtc_sp->digio_virt,
	    "Digital I/O") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map Strobe Timer */

    rtc_sp->strobe_phys = rtc_sp->iobase + RTC_STROBE_TIMER_OFFSET;
    rtc_sp->strobe_size = RTC_STROBE_TIMER_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->strobe_phys,
	    rtc_sp->strobe_size,
	    &rtc_sp->strobe_virt,
	    "Strobe Timer") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map Control Register */

    rtc_sp->control_phys = rtc_sp->iobase + RTC_CONTROL_REG_OFFSET;
    rtc_sp->control_size = RTC_CONTROL_REG_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->control_phys,
	    rtc_sp->control_size,
	    &rtc_sp->control_virt,
	    "Control Reg") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map Encoder Counter */

    rtc_sp->encoder_phys = rtc_sp->iobase + RTC_ENCODER_CNT_OFFSET;
    rtc_sp->encoder_size = RTC_ENCODER_CNT_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->encoder_phys,
	    rtc_sp->encoder_size,
	    &rtc_sp->encoder_virt,
	    "Encoder Counter") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map Graphics Register */

    rtc_sp->graphics_reg_phys = rtc_sp->iobase +
RTC_GRAPHICS_REG_OFFSET;
    rtc_sp->graphics_reg_size = RTC_GRAPHICS_REG_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->graphics_reg_phys,
	    rtc_sp->graphics_reg_size,
	    &rtc_sp->graphics_reg_virt,
	    "Graphics Register") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map CY545 Trans Reg */

    rtc_sp->cy545_trans_phys = rtc_sp->iobase + RTC_CY545_TRANS_OFFSET;
    rtc_sp->cy545_trans_size = RTC_CY545_TRANS_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->cy545_trans_phys,
	    rtc_sp->cy545_trans_size,
	    &rtc_sp->cy545_trans_virt,
	    "CY545 Trans Reg") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map CY545 Control Reg */

    rtc_sp->cy545_cr_phys = rtc_sp->iobase + RTC_CY545_CONTROL_OFFSET;
    rtc_sp->cy545_cr_size = RTC_CY545_CONTROL_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->cy545_cr_phys,
	    rtc_sp->cy545_cr_size,
	    &rtc_sp->cy545_cr_virt,
	    "CY545 Control Reg") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    /* Map Graphics Memory */

    rtc_sp->graphics_mem_phys = rtc_sp->iobase +
RTC_GRAPHICS_MEM_OFFSET;
    rtc_sp->graphics_mem_size = RTC_GRAPHICS_MEM_SIZE;

    if (rtc_map_one(rtc_sp,
	    rtc_sp->graphics_mem_phys,
	    rtc_sp->graphics_mem_size,
	    &rtc_sp->graphics_mem_virt,
	    "Graphics Memory") < 0)
    {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    if (alloc_rtc_usr_shared(rtc_sp) < 0) {
	free_all_mappings(rtc_sp);
	return(-1);
    }

    return(0);
}

static int __initdata
rtc_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
{
    RtcSoftDev *rtc_sp;
    char revid = ' ';

    u8  rev_id = 0;
    u16 device_id;

    int result;
    int dev_num;
    int rtc_major;
    int intr_handler_req;

    if (pci_enable_device(pdev)) {
	return(-ENODEV);
    }

    /* stealing code from cciss.c - thanks compaq! */

    debug_out(("rtc_probe: RTC 0x%08x found @bus %d dev %d func %d\n",
	 pdev->device,
	 pdev->bus->number,
	 PCI_SLOT(pdev->devfn),
	 PCI_FUNC(pdev->devfn)));

    /* alloc our per-device data */
    dev_num = alloc_rtc_soft_state();

    if (dev_num < 0) {
	/* I've already printk'd error message */
	return(-ENOMEM);
    }

    result = 0;

    memset(RtcSoft[dev_num], 0, sizeof(RtcSoft[dev_num]));
    rtc_sp = RtcSoft[dev_num];

    sprintf(rtc_sp->devname, "mvp_rtc");

    spin_lock_init(&rtc_sp->mutex);
    rtc_sp->dev_num = dev_num;
    rtc_sp->pdev = pdev;

    sema_init(&rtc_sp->sem, 1);
    pci_set_drvdata(pdev,rtc_sp);	/* we'll need this in remove: */

    debug_out(("rtc_probe: device %d\n", dev_num));

#define REQUESTMEM
#ifdef REQUESTMEM
    /* 
     * map the card memory areas into kernel space
     * and store the address in our RtcDev info 
     */

    rtc_sp->iobase = pci_resource_start(pdev, 0);
    rtc_sp->iosize = pci_resource_len(pdev, 0);

    debug_out(("rtc_probe_module: base start %#010lx size %#010lx\n",
	    rtc_sp->iobase,
	    rtc_sp->iosize));

    if (rtc_do_all_mappings(rtc_sp) < 0) {
	debug_out(("rtc_probe: do_all_mappings failed\n"));

	free_rtc_soft_state(rtc_sp->dev_num);
	return(-ENODEV);
    }
#endif

#ifdef CONFIG_DEVFS_FS
    rtc_sp->rtc_devfs_dir = devfs_mk_dir(NULL, rtc_sp->devname, NULL);

    if (!rtc_sp->rtc_devfs_dir) {
	debug_out(("rtc_probe(%d): can't register devfs\n", dev_num));

	free_all_mappings(rtc_sp);
	free_rtc_soft_state(rtc_sp->dev_num);

	return(-EBUSY);
    }

    devfs_resister(rtc_sp->rtc_devfs_dir,
	    rtc_sp->devname,
	    DEVFS_FL_AUTO_DEVNUM,               /* autoallocate
major/minor */
	    0,                                  /* ignored because of
flag */
	    0,                                  /* ignored because of
flag */
	    S_IFCHR | S_IRUGO | S_IWUGO,        /* ??? */
	    &rtc_fops,
	    rtc_sp);

#else

    rtc_major = 0;
    result = register_chrdev(rtc_major, rtc_sp->devname, &rtc_fops);

    if (result < 0) {
	debug_out(("rtc_probe_module: can't get major %d\n",
rtc_major));

	free_all_mappings(rtc_sp);
	free_rtc_soft_state(rtc_sp->dev_num);

	return(-EBUSY);
    }

    if (rtc_major == 0) {
	rtc_major = result;
    }

    debug_out(("rtc_probe_module: got major %d\n", rtc_major));

#endif

    rtc_sp->rtc_major = rtc_major;

    pci_read_config_word(pdev, 2, &device_id);
    pci_read_config_byte(pdev, 8, &rev_id);

    if (rev_id > 0 && rev_id < 27) {
	rev_id += 0x40; 
	revid = rev_id;
    }

    if (!pdev->irq) {
	debug_out(("rtc_probe_module: can't get interrupt number\n"));

	free_all_mappings(rtc_sp);
	free_rtc_soft_state(rtc_sp->dev_num);
	return(-ENODEV);
    }

    rtc_sp->myint = pdev->irq;

    rtc_sp->irq_cnt = 0;
    intr_handler_req = request_irq(rtc_sp->myint,rtc_intr,
	    SA_SHIRQ,
	    rtc_sp->devname,
	    rtc_sp);

    if (intr_handler_req != 0) {
	debug_out(("rtc_probe_module: can't req interrupt handler\n"));

	free_all_mappings(rtc_sp);
	free_rtc_soft_state(rtc_sp->dev_num);
	return(-ENODEV);
    }

    debug_out(("MVP Real Time Controller Board A: %s%d, %X.%c, Int:
%d\n",
	    RTC_DEVICE, dev_num, device_id, revid, rtc_sp->myint));

    debug_out(("driver(%d) %s\n", dev_num, rtc_c));

    return(result);
}

static void __exitdata
rtc_remove(struct pci_dev *pci_dev)
{
    RtcSoftDev *rtc_sp = (RtcSoftDev *)pci_get_drvdata(pci_dev);

    if (rtc_sp == NULL) {
	debug_out(("rtc_remove: Error: Null RTC Data in remove\n"));
	return;
    }

    debug_out(("rtc_remove:\n"));

    unregister_chrdev(rtc_sp->rtc_major, rtc_sp->devname);

    free_irq(rtc_sp->myint, rtc_sp);
    rtc_sp->myint = 0;

    free_all_mappings(rtc_sp);
    free_rtc_soft_state(rtc_sp->dev_num);
}

static struct pci_device_id rtc_id_table[] __devinitdata = {
    { 0x8f73, 0xa1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
    { 0x8f73, 0xa2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }
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

MODULE_DEVICE_TABLE(pci, rtc_id_table);

struct pci_driver rtc_driver = {
    name:		"rtc0",
    id_table:		rtc_id_table,
    probe:		rtc_probe,
    remove:		rtc_remove,
};

int __init
rtc_init_module(void)
{
    init_rtc_soft_state();
    return(pci_module_init(&rtc_driver));
}

void __exit
rtc_cleanup_module(void)
{
    pci_unregister_driver(&rtc_driver);
}

/*
 * RTC interrupt routine.  I could not get the outl() and inl() macros
to 
 * work using the physical address.  So,using the virtual address of the

 * hardware seems to work.
 */

irqreturn_t 
rtc_intr(int irq, void *dev_id, struct pt_regs *regs)
{
    unsigned long creg_val = 0L;
    struct timeval tv;

    unsigned long flags;
    RtcSoftDev *rtc_sp = dev_id;

    if (rtc_sp == NULL)	{
	debug_out(("Rtc Intr: rtc_sp is NULL\n"));
	return(IRQ_NONE);
    }

    lock_rtc(rtc_sp,&flags,"rtc_intr");
    rtc_sp->irq_cnt++;
    creg_val = *rtc_sp->control_virt;

    if (!(creg_val & RCR_INTR)) {
	debug_out(("rtc_intr: SNAPINT not set\n"));

	unlock_rtc(rtc_sp, &flags, "rtc_intr Error");
	return(IRQ_NONE);
    }

    if (rtc_sp->shared_host_mem != NULL) {
    	rtc_sp->shared_host_mem->snap_addrs_loc++;
	do_gettimeofday(&tv);
	rtc_sp->shared_host_mem->ntimestamp = tv.tv_sec;

	debug_out(("rtc_intr: rtc_sp->shared_host_mem->snap_addrs_loc:
%d\n", 
	    rtc_sp->shared_host_mem->snap_addrs_loc));
    }
    else {
	debug_out(("rtc_intr: rtc_sp->shared_host_mem->snap_addrs_loc
NULL\n"));
    }

    *rtc_sp->control_virt |= RCR_INTRRESET;
    barrier();

    *rtc_sp->control_virt &= ~RCR_INTRRESET;
    unlock_rtc(rtc_sp,&flags,"rtc_intr");

    return(IRQ_HANDLED);
}

module_init(rtc_init_module);
module_exit(rtc_cleanup_module);

-->
/usr/src/redhat/BUILD/kernel-2.6.16/linux-2.6.16.16/drivers/mvp/rtcsoft.
h

#include "dev/rtc.h"

typedef struct RtcSoftDev_struct {

    struct semaphore sem;
    u_int  Interrupt;
    u_int  context;
    void 		*base;
    unsigned long 	iobase;
    unsigned long 	iosize;
    char    		devname[8];
    int			dev_num;
    struct pci_dev *	pdev;
    int 		rtc_major;
    u8			myint;
    unsigned long	irq_cnt;


    spinlock_t mutex;		/* linux mutex equivilent */

    int32_t 		*config_regp;

    unsigned long	snap_int_phys;
    unsigned long	snap_int_size;
    uint32_t 		*snap_int_virt;

    unsigned long	digio_phys;
    unsigned long	digio_size;
    uint32_t 		*digio_virt;

    unsigned long	strobe_phys;
    unsigned long	strobe_size;
    uint32_t 		*strobe_virt;

    unsigned long	control_phys;
    unsigned long	control_size;
    uint32_t 		*control_virt;

    unsigned long	encoder_phys;
    unsigned long	encoder_size;
    uint32_t 		*encoder_virt;

    unsigned long	graphics_reg_phys;
    unsigned long	graphics_reg_size;
    uint32_t 		*graphics_reg_virt;

    unsigned long	cy545_trans_phys;
    unsigned long	cy545_trans_size;
    uint32_t 		*cy545_trans_virt;

    unsigned long	cy545_cr_phys;
    unsigned long	cy545_cr_size;
    uint32_t 		*cy545_cr_virt;

    unsigned long	graphics_mem_phys;
    unsigned long	graphics_mem_size;
    uint32_t 		*graphics_mem_virt;

    RtcShared *		shared_host_mem;
    RtcShared *		shared_host_mem_area;

} RtcSoftDev;

-->
/export/home/ultra-trix/brian/mvp/work/pcb-fedora/include/localinc/dev/r
tc.h

#ifndef RTC_h
#define RTC_h

/* 
 * The version information is compiled into both the MVP software
 * and the device driver, and is used to make sure the software
 * is being run with the proper driver.  If a change is made
 * to the functioning of the driver or to the size or offsets of
 * any of the areas of common memory, this version number should
 * increment.
 */

static const u_long kRtcVersion = 1001;

#include <sys/ioctl.h>

#include "dev/ibb.h"

/* RTC only supports 4 lighting rings */
#define kMaxRtcRings	 	4

struct rtc_strobelight {
    int32_t hw_time;
};

typedef struct rtc_strobelight RtcStrobes[kMaxRtcRings];

/*
 * MVP real time controller ioctls
 */

#if defined(UNIXHOST) || defined(_KERNEL) || defined(KERNEL)
#define NEW
#endif

#ifdef NEW
#define	RTCBONVOYAGE		_IO('M', 0)
#define RTCWAKEUP		_IO('M', 1)
#define RTCTST			_IOWR('M', 2, long)	
#define RTC_STROBEPROG_ON	_IOWR('M', 3, RtcStrobes)	
#define RTC_STROBEPROG_OFF	_IO('M', 4)
#define RTCFIRESTROBE		_IO('M', 5)
#define RTCSTARTECOUNT		_IO('M', 7)
#define RTCGETECOUNT		_IOWR('M', 8,long *)
#define RTCRESETSNAP		_IO('M', 9)
#define RTC_STAGE_NON_LINEAR	_IO('M', 10)
#define RTCVERSION		_IOR('M', 11, u_long *)	
#else
#define RTCBONVOYAGE		(('M'<<8)|0)	
#define RTCWAKEUP		(('M'<<8)|1)	
#define RTCTST			(('M'<<8)|2)	
#define RTC_STROBEPROG_ON	(('M'<<8)|3)	
#define RTC_STROBEPROG_OFF	(('M'<<8)|4)	
#define RTCFIRESTROBE		(('M'<<8)|5)	
#define RTCSTARTECOUNT		(('M'<<8)|7)	
#define RTCGETECOUNT		(('M'<<8)|8)	
#define RTCSRESETSNAP		(('M'<<8)|9)	
#define RTC_STAGE_NON_LINEAR	(('M'<<8)|10)	
#define RTCVERSION		(('M'<<8)|11)	
#endif

#define	RTC_DEVICE	"/dev/mvp_rtc"

#define kNrtc 		1	/* Only 1 allowed per system */

/*
 * the rtc card can support 0x8000 addressses for 
 * encoder information
 * (note: kernel compiler doens't care for "const int k = value)
 */

#define kMaxRtcEcounts 		0x8000
#define kMostRtcSnaps 		0x1000
#define kLastSnapLoc 		0x7fff

/*
 * snap_addrs_loc 	- our current position in the snap addrs
 * phys_snap_addrs 	- all the snap addrs for a board
 * num_vcpus		- # on vcpus on our machine
 * num_cams		- # cameras on our machine
 */

typedef struct rtc_shared {
    unsigned long 	snap_addrs_loc;
    time_t	 	ntimestamp;
} RtcShared;

/*
 * layout for the address space on the MVP real time controller 
 */

#define	MEM_REG_NUM			1
#define RTC_COMMON_VADDR		0x010000	
#define RTC_SNAP_INTERVAL_OFFSET	0x020000
#define RTC_DIGIO_OFFSET		0x040000
#define RTC_STROBE_TIMER_OFFSET		0x060000
#define RTC_CONTROL_REG_OFFSET		0x080000
#define RTC_ENCODER_CNT_OFFSET		0x0a0000
#define RTC_GRAPHICS_REG_OFFSET		0x0c0000
#define RTC_CY545_TRANS_OFFSET		0x0e0000
#define RTC_CY545_CONTROL_OFFSET	0x0f0000
#define RTC_GRAPHICS_MEM_OFFSET		0x200000

/*
 * confused myself again -
 *
 * Snap interval memory can contain 0x8000 addresses, 
 * byte-size is 0x8000 * sizeof(long).  Sizeof long
 * is 4  - byte-size snap interval memory is 0x20000
 *
 * The digio register is 4 bytes.
 * The strobe timers end up 4 bytes.
 * The control register is 2 bytes, 16 bits.
 */

#define RTC_COMMON_SIZE			0x1000	/* XXX - force to page
size */

#define RTC_SNAP_INTERVAL_SIZE		kMaxRtcEcounts * sizeof(long)
#define RTC_DIGIO_SIZE			0x04		
#define RTC_STROBE_TIMER_SIZE		0x04
#define RTC_CONTROL_REG_SIZE		0x02
#define RTC_ENCODER_CNT_SIZE		0x04
#define RTC_GRAPHICS_REG_SIZE		0x04
#define RTC_CY545_TRANS_SIZE		0x04
#define RTC_CY545_CONTROL_SIZE		0x04
#define RTC_GRAPHICS_MEM_SIZE		0x40000

/* control register fields */
#define RCR_STROBEPROG			0x0001
#define RCR_FIRESTROBE			0x0002
#define RCR_STROBE_HI			0x0010
#define RCR_STROBE_MIDHI		0x0020
#define RCR_STROBE_LOW			0x0040
#define RCR_STROBE_MIDLO		0x0080
#define RCR_ALLLIGHTS			(RCR_STROBE_HI|RCR_STROBE_MIDHI|
\
	
RCR_STROBE_LOW|RCR_STROBE_MIDLO)
#define RCR_COMPSIZE			0x0100
#define RCR_TESTENC			0x0200
#define RCR_INTRRESET			0x0400
#define RCR_INTR			0x0800
#define RCR_QUAD			0x2000
#define RCR_ECOUNTON			0x4000
#define RCR_SRESET			0x8000

/*
 * scan bit fields
 */

#define CONT_SCAN	(0x0 << 20)
#define EXT_INT		(0x2 << 20)
#define SINGLE_SNAP	(0x3 << 20)
#define FIRST_SCAN	(0x4 << 20)
#define LAST_SCAN	(0x8 << 20)
#define END_SCAN	(0xc << 20)

#define SMALLCOUNT	0x300000

#endif

---[ END RTC ]---


:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

-----Original Message-----
From: Randy.Dunlap [mailto:rdunlap@xenotime.net] 
Sent: Friday, May 19, 2006 10:55 AM
To: Brian D. McGrew
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format?

On Fri, 19 May 2006 10:11:48 -0700 Brian D. McGrew wrote:

> My drivers are inline in this mail.  I'm still having this problem
with
> the 2.6.16 kernel as where I'm not having it with the 2.6.15 kernel --
> and it's the same source code, compiled the same way.
> 
> Also, I'm still having difficulties getting this driver to work
> correctly so any help would be great!

to work?  Does it even build?

> #include "dev/rtc.h"
> #include "rtcsoft.h"

missing files.

---
~Randy
