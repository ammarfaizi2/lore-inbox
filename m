Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUCEM1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUCEM1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:27:33 -0500
Received: from [202.125.86.130] ([202.125.86.130]:49125 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262571AbUCEM1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:27:23 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: INIT_REQUEST & CURRENT undeclared!
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 5 Mar 2004 17:54:44 +0530
Message-ID: <1118873EE1755348B4812EA29C55A9721286EB@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: INIT_REQUEST & CURRENT undeclared!
Thread-Index: AcQCrNeUSpNfqGwOSmiURaUHQiKhqw==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

I am studying the block device driver. I just tried the request function (blk_init_queue).
Even though I included linux/blk.h on compiling I get "INIT_REQUEST" & "CURRENT" undeclared.

Below are the code and the cc command I use to compile it.
I would like to know what the problem is.

Thanks in advance,
-Joy


*** simple.c ***
/* kernel headers */
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blk.h>

#define DEV_NAME "jdev"
#define MAJOR_NR 220

/* GPL Licensed */
MODULE_LICENSE("GPL");

/* version information */
static char version[]="Block Driver 0.1\n";

/*
 * ioctl() entry point
 */
static int
simple_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
{
	int minor = MINOR(inode->i_rdev);

	printk("device number = %d\n",minor);

	return 0;
}


/* 
 * open() entry point
 */
static int
simple_open(struct inode *inode, struct file *filp)
{
	int minor = MINOR(inode->i_rdev);
	
	printk("device number = %d\n",minor);

	return 0;
}


/*
 * close() entry point
 */
static int
simple_close(struct inode *inode, struct file *filp)
{
	int minor = MINOR(inode->i_rdev);
	
	printk("device number = %d\n",minor);

	return 0;
}

static struct block_device_operations ji_bd_op = {
	owner:	THIS_MODULE,
	open:		simple_open,
	ioctl:	simple_ioctl,
	release:	simple_close,
};


/*
 * Initializations from here!
 */
static int 
simple_start(void)
{
	/* register device */
	if(devfs_register_blkdev(MAJOR_NR, DEV_NAME, &ji_bd_op)) {
		printk("ERROR| Could not register major %d!\n", MAJOR_NR);
		return -EIO;
	}

	return 0;
}


/*
 * Read/Write interface function.
 */
static void simple_do_request(request_queue_t *q)
{
	while(1) {
		INIT_REQUEST; /* do some checking on the request function */
		
		PRINTK("request %p cmd %i sec %li (nr. %li)\n",	CURRENT, CURRENT->cmd, CURRENT->sector, CURRENT->current_nr_sectors);

		end_request(1);
	}
}


/* 
 * This is the module entry point.
 */
static int __init 
simple_init(void)
{
	int status = 0;
	
#ifdef MODULE
	printk(version);
#endif
	
	/* device/driver init */
	if((status=simple_start()) != 0)
		return status;

	/* register request queue */
	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), simple_do_request);
	
	return 0;
}


/*
 * This is the module exit point.
 */
static void __exit 
simple_exit(void)
{
	/* unregister device */
	devfs_unregister_blkdev(MAJOR_NR, DEV_NAME);

	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
}

/* module entry/exit points */
module_init(simple_init);
module_exit(simple_exit);



Compiling is done using the following command.
#cc -D__KERNEL__ -I/usr/src/linux-2.4/include -O2 -DMODULE -c simple.c

