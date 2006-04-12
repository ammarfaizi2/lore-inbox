Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWDLXEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWDLXEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWDLXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:04:42 -0400
Received: from mta206-rme.xtra.co.nz ([210.86.15.58]:36550 "EHLO
	mta206-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S932384AbWDLXEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:04:41 -0400
X-Originating-IP: [139.80.27.22]
From: Zhiyi Huang <zhiyi6@xtra.co.nz>
Reply-To: hzy@cs.otago.ac.nz
Organization: Univ of Otago
To: "Pekka Enberg" <penberg@cs.helsinki.fi>, <hzy@cs.otago.ac.nz>
CC: "Hareesh Nagarajan" <hnagar2@gmail.com>, <linux-kernel@vger.kernel.org>,
       <zhiyi6@xtra.co.nz>
Subject: Re: Re: Slab corruption after unloading a module
Date: Thu, 13 Apr 2006 11:04:39 +1200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20060412230439.WMCC8268.mta4-rme.xtra.co.nz@[202.27.184.228]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.8 is an old kernel, you could very well be hitting a kernel bug
> that has been fixed already. Can you reproduce this with 2.6.16? 

I will try that soon.

> Also,
> you're not including sources to your module so it's impossible to tell
> whether you're doing something wrong.
> 
>                                                          Pekka

Below is my baby module which only uses kmalloc and kfree for my device 
structure. I found the slab corruption address is the address of the structure. 
It seems to be a bug for kmalloc and kfree.


/
*----------------------------------------------------------------
------------*/
/* File: tem.c                                                             */
/* Date: 13/03/2006                                                           */
/* Author: Zhiyi Huang                                                       */
/* Version: 0.1                                                               */
/
*----------------------------------------------------------------
------------*/
 
/* This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/fs.h>
#include <linux/errno.h>
#include <linux/types.h>
#include <linux/proc_fs.h>
#include <linux/fcntl.h>
#include <linux/aio.h>
#include <asm/uaccess.h>

#include <linux/ioctl.h>
#include <linux/cdev.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Zhiyi Huang");
MODULE_DESCRIPTION("A template module");


/* The parameter for testing */
int major=0;
MODULE_PARM(major, "i");
MODULE_PARM_DESC(major, "device major number");

#define MAX_DSIZE	3071
struct my_dev {
        char data[MAX_DSIZE+1];
        size_t size;              /* 32-bit will suffice */
        struct semaphore sem;     /* Mutual exclusion */
        struct cdev cdev;
} *temp_dev;

int temp_open (struct inode *inode, struct file *filp)
{
	return 0;
}

int temp_release (struct inode *inode, struct file *filp)
{
	return 0;
}

ssize_t temp_read (struct file *filp, char __user *buf, size_t count,loff_t *f_pos)
{
	int rv=0;

	if (down_interruptible (&temp_dev->sem))
		return -ERESTARTSYS;
	if (*f_pos > MAX_DSIZE)
		goto wrap_up;
	if (*f_pos + count > MAX_DSIZE)
		count = MAX_DSIZE - *f_pos;
	if (copy_to_user (buf, temp_dev->data+*f_pos, count)) {
		rv = -EFAULT;
		goto wrap_up;
	}
	up (&temp_dev->sem);
	*f_pos += count;
	return count;

wrap_up:
	up (&temp_dev->sem);
	return rv;
}

ssize_t temp_write (struct file *filp, const char __user *buf, size_t count, loff_t 
*f_pos)
{
	int count1=count, rv=count;

	if (down_interruptible (&temp_dev->sem))
		return -ERESTARTSYS;

	if (*f_pos > MAX_DSIZE)
		goto wrap_up;
	if (*f_pos + count > MAX_DSIZE)
		count1 = MAX_DSIZE - *f_pos;

	if (copy_from_user (temp_dev->data+*f_pos, buf, count1)) {
		rv = -EFAULT;
		goto wrap_up;
	}
	up (&temp_dev->sem);
	*f_pos += count1;
	return count;

wrap_up:
	up (&temp_dev->sem);
	return rv;
}

int temp_ioctl (struct inode *inode, struct file *filp,unsigned int cmd, 
unsigned long arg)
{

	return 0;
}

loff_t temp_llseek (struct file *filp, loff_t off, int whence)
{
        long newpos;

        switch(whence) {
        case 0: /* SEEK_SET */
                newpos = off;
                break;

        case 1: /* SEEK_CUR */
                newpos = filp->f_pos + off;
                break;

        case 2: /* SEEK_END */
                newpos = temp_dev->size + off;
                break;

        default: /* can't happen */
                return -EINVAL;
        }
        if (newpos<0 || newpos>MAX_DSIZE) return -EINVAL;
        filp->f_pos = newpos;
        return newpos;
}

struct file_operations temp_fops = {
        .owner =     THIS_MODULE,
	.llseek =    temp_llseek,
        .read =      temp_read,
        .write =     temp_write,
        .ioctl =     temp_ioctl,
        .open =      temp_open,
        .release =   temp_release,
};


/**
 * Initialise the module and create the master device
 */
int __init tem_init_module(void){
	int rv;
	dev_t devno = MKDEV(major, 0);

	if(major) {
		rv = register_chrdev_region(devno, 1, "temp");
		if(rv < 0){
			printk(KERN_WARNING "Can't use the major number %d; try 
atomatic allocation...\n", major);
			rv = alloc_chrdev_region(&devno, 0, 1, "temp");
			major = MAJOR(devno);
		}
	}
	else {
		rv = alloc_chrdev_region(&devno, 0, 1, "temp");
		major = MAJOR(devno);
	}

	if(rv < 0) return rv;

	temp_dev = kmalloc(sizeof(struct my_dev), GFP_KERNEL);
	if(temp_dev == NULL){
		rv = -ENOMEM;
		unregister_chrdev_region(devno, 1);
		return rv;
	}

	memset(temp_dev, 0, sizeof(struct my_dev));
	cdev_init(&temp_dev->cdev, &temp_fops);
	temp_dev->cdev.owner = THIS_MODULE;
	temp_dev->cdev.ops = &temp_fops;
	temp_dev->size = MAX_DSIZE;
	sema_init (&temp_dev->sem, 1);
	rv = cdev_add (&temp_dev->cdev, devno, 1);
	if (rv) printk(KERN_WARNING "Error %d adding device temp", rv);

	printk(KERN_WARNING "Hello world from Template Module\n");
	printk(KERN_WARNING "temp device MAJOR is %d, dev addr: %lx\n", 
major, (unsigned long)temp_dev);

  return 0;
}


/**
 * Finalise the module
 */
void __exit tem_exit_module(void){

	kfree(temp_dev);
	unregister_chrdev_region(MKDEV(major, 0), 1);
	printk(KERN_WARNING "Good bye from Template Module\n");
}


module_init(tem_init_module);
module_exit(tem_exit_module);


