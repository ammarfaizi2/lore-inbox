Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWDZGiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWDZGiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDZGiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:38:07 -0400
Received: from [202.125.80.34] ([202.125.80.34]:15504 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750902AbWDZGiG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:38:06 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Simulating the REMOVABLE media - Could any one please suggest me.
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Wed, 26 Apr 2006 12:08:41 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3FD577@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Simulating the REMOVABLE media - Could any one please suggest me.
Thread-Index: AcZo6fmHmfubR3BKTeKdcPNW/McGeAADpUCQ
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Cc: <arjan@infradead.org>, <erik@harddisk-recovery.com>, <greg@kroah.com>,
       <root@chaos.analogic.com>, <vatsa@in.ibm.com>, <davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I am facing a problem while simulating a removable media via simple
block driver. But if I remove the floppy disk after mounting it, I could
not get any problem with the floppy disk. But I do not understand why I
am facing the problem with my device.

I prepared an IOCTL to simulate the removable media to the kernel.
When the applications issues IOCTL, it removes the device from the
kernel space.

when I issue #ls /mnt (mount point) ( i.e. after the application issues
the IOCTL) the CONSOLE crashes, OR it crashes when tried to unload the
module.

I have been trying hard to understand the real problem with this module.

What wrong am I doing in this module?
Could any body explain the problem? Thanks in advance.

Thanks and Regards,
Srinivas G


Here is the module code for your reference.
-------------------------------------------

/*
 * A sample, extra-simple block driver.
 *
 * Copyright 2003 Eklektix, Inc.  Redistributable under the terms
 * of the GNU GPL.
 */

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>

#include <linux/kernel.h> 		/* printk() */
#include <linux/fs.h>    	 	/* everything... */
#include <linux/errno.h>  		/* error codes */
#include <linux/types.h>  		/* size_t */
#include <linux/vmalloc.h>
#include <linux/genhd.h>
#include <linux/blkdev.h>
#include <linux/hdreg.h>
#include <linux/buffer_head.h>		/* for invalidate_bdev */	

#include "sbd_drv.h"

MODULE_LICENSE("Dual BSD/GPL");
//static char *Version = "0.1";

static int major_num = 0;
module_param(major_num, int, 0);
static int hardsect_size = 512;
module_param(hardsect_size, int, 0);
static int nsectors = 1024;  /* How big the drive is */
module_param(nsectors, int, 0);

/*
 * We can tweak our hardware sector size, but the kernel talks to us
 * in terms of small sectors, always.
 */
#define KERNEL_SECTOR_SIZE 512

/*
 * Our request queue.
 */
static struct request_queue *Queue;

/*
 * The internal representation of our device.
 */
static struct sbd_device {
    unsigned long size;
    spinlock_t lock;
    u8 *data;
    struct gendisk *gd;	
    struct block_device *bdev;
} Device;

static int
sbd_open(struct inode  *inode, struct file *filp)
{
	printk("<%s> invoked\n",__FUNCTION__);

	Device.bdev=inode->i_bdev;
	
	return 0;
}

static int
sbd_close(struct inode  *inode, struct file *filp)
{
	printk("<%s> invoked\n",__FUNCTION__);

	Device.bdev=NULL;
	
	return 0;
}

/*
 * Handle an I/O request.
 */
static void sbd_transfer(struct sbd_device *dev, unsigned long sector,
		unsigned long nsect, char *buffer, int write)
{
    unsigned long offset = sector*hardsect_size;
    unsigned long nbytes = nsect*hardsect_size;
    
    if ((offset + nbytes) > dev->size) {
       printk (KERN_NOTICE "sbd: Beyond-end write (%ld %ld)\n", offset,
nbytes);
       return;
    }
    if (write)
	memcpy(dev->data + offset, buffer, nbytes);
    else
	memcpy(buffer, dev->data + offset, nbytes);
}

static void sbd_request(request_queue_t *q)
{
    struct request *req;

    while ((req = elv_next_request(q)) != NULL) {
	if (! blk_fs_request(req)) {
	    printk (KERN_NOTICE "Skip non-CMD request\n");
	    end_request(req, 0);
	    continue;
	}
	sbd_transfer(&Device, req->sector, req->current_nr_sectors,
			req->buffer, rq_data_dir(req));
	end_request(req, 1);
    }
}



/*
 * Ioctl.
 */
int sbd_ioctl (struct inode *inode, struct file *filp,
                 unsigned int cmd, unsigned long arg)
{
	long size;
	struct hd_geometry geo;

	switch(cmd) {
	/*
	 * The only command we need to interpret is HDIO_GETGEO, since
	 * we can't partition the drive otherwise.  We have no real
	 * geometry, of course, so make something up.
	 */
	    case HDIO_GETGEO:
		size = Device.size*(hardsect_size/KERNEL_SECTOR_SIZE);
		geo.cylinders = (size & ~0x3f) >> 6;
		geo.heads = 4;
		geo.sectors = 16;
		geo.start = 4;
		if (copy_to_user((void *) arg, &geo, sizeof(geo)))
			return -EFAULT;
		return 0;

	    case REMOVE_MOUNTED_DISK:
		if(Device.bdev)
			invalidate_bdev(Device.bdev,1);

    		del_gendisk(Device.gd);
		put_disk(Device.gd);
    		blk_cleanup_queue(Queue);
 	   	vfree(Device.data);
		return 0;
    }

    return -ENOTTY; /* unknown command */
}

/*
 * The device operations structure.
 */
static struct block_device_operations sbd_ops = {
    .owner    	= THIS_MODULE,
    .ioctl	= sbd_ioctl,
    .open	= sbd_open,
    .release    = sbd_close     
};

static int __init sbd_init(void)
{
     printk("<%s> invoked\n",__FUNCTION__);

    /*
     * Set up our internal device.
     */
     Device.size = nsectors*hardsect_size;
     spin_lock_init(&Device.lock);
     Device.data = vmalloc(Device.size);
     if (Device.data == NULL)
	return -ENOMEM;
    /*
     * Get a request queue.
     */
     Queue = blk_init_queue(sbd_request, &Device.lock);
     if (Queue == NULL)
	    goto out;
     blk_queue_hardsect_size(Queue, hardsect_size);

    /*
     * Get registered.
     */
     major_num = register_blkdev(major_num, "sbd");
     if (major_num <= 0) {
	  printk(KERN_WARNING "sbd: unable to get major number\n");
	  goto out;
     }

     /*
      * And the gendisk structure.
      */
      Device.gd = alloc_disk(16);
      if (! Device.gd)
	   goto out_unregister;

      Device.gd->major = major_num;
      Device.gd->first_minor = 0;
      Device.gd->fops = &sbd_ops;
      Device.gd->private_data = &Device;
      strcpy (Device.gd->disk_name, "sbd0");
      set_capacity(Device.gd,
nsectors*(hardsect_size/KERNEL_SECTOR_SIZE));
      Device.gd->queue = Queue;
      
      add_disk(Device.gd);

      return 0;

  out_unregister:
      unregister_blkdev(major_num, "sbd");
  out:
      vfree(Device.data);
      return -ENOMEM;
}

static void __exit sbd_exit(void)
{
    printk("<%s> invoked\n",__FUNCTION__);

    del_gendisk(Device.gd);
    put_disk(Device.gd);
    unregister_blkdev(major_num, "sbd");
    blk_cleanup_queue(Queue);
    vfree(Device.data);
}
	
module_init(sbd_init);
module_exit(sbd_exit);

************************************************************************
***

.h file
-------
include <asm/ioctl.h>

#define SBD_MAJOR 'b'
#define REMOVE_MOUNTED_DISK _IO(SBD_MAJOR,0x01)

************************************************************************
***
Makefile
--------
#
# Makefile for the simple hello world program
# Author: Srinivas G.	Date: 17th April 2006
#
DEVICE:=sbd
MAJOR:=230

KDIR:=/lib/modules/$(shell uname -r)/build
TRGT:=sbd
OBJS:=sbd_drv.o

obj-m += $(TRGT).o
$(TRGT)-objs := $(OBJS)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
clean:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean

************************************************************************
***
app.c file to issue an IOCTL
----------------------------
#include <fcntl.h>
#include <stdio.h>

#include "sbd_drv.h"

main()
{
	int fd;

	fd = open("/dev/sbd0",O_RDONLY);
	if(fd == -1)
	{
		printf("Open failed\n");
		exit(0);
	}

	ioctl(fd,REMOVE_MOUNTED_DISK);

	close(fd);
}
	
