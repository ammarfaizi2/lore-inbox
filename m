Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314011AbSDFGB2>; Sat, 6 Apr 2002 01:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314012AbSDFGBT>; Sat, 6 Apr 2002 01:01:19 -0500
Received: from air-2.osdl.org ([65.201.151.6]:53519 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314011AbSDFGBD>;
	Sat, 6 Apr 2002 01:01:03 -0500
Date: Fri, 5 Apr 2002 21:58:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <skunta@cs.tamu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problems with copy_from_user
Message-ID: <Pine.LNX.4.33L2.0204052126160.3600-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

### Hi, my comments all begin with "###".


I am trying to run the following code

#define __KERNEL__         /* We're part of the kernel */
#define MODULE             /* Not a permanent part, though. */

#include <linux/modversions.h>

#include <linux/param.h>
#include <asm/system.h>
#include <linux/errno.h>
#include <linux/ioctl.h>
#include <linux/tty.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/wrapper.h>  /* header for unregister */
#include <linux/fs.h>     /* file types */
#include <asm/io.h>
#include <linux/types.h>   /* for ssize_t */
#include <linux/slab.h>
#include <asm/uaccess.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <asm/errno.h>
#include <asm/unistd.h>
#include <sys/syscall.h>

#ifndef min
#define min(a,b)    (((a) <(b)) ? (a) : (b))
#endif

#define SAMP_LEN 20

struct samp2_buf
{
        char *buffer;
        /*
        char *buffer,*end;
        int buffersize;
        char *rp,*wp;
        */
};

static int samp2_open(struct inode *inode, struct file *file)
{
        console_print(" Exiting open \n ");
        return 0;
}

### What kernel version are you using?
### I get warnings (important ones) when I compile this
### on 2.4.18.  You should get rid of those warnings.

### When did read/write file_operations have a first parameter
### of struct inode * ?  They don't in 2.4.18 or back in 2.4.2.
### open() and release() do, but read() and write() don't.
### That alone would cause serious errors in those functions.

static int samp2_release(struct inode *inode, struct file *file)
{
        //MOD_DEC_USE_COUNT;
        console_print(" Exiting Release \n ");
        return 0;
}

int samp2_read(struct inode *inode, struct file *fp, char *buff,int count)
{
### read(): wrong function parameters.
        struct samp2_buf *dev = fp->private_data;
        char *buf;
        int len;

        console_print("In read \n ");

        if(copy_to_user (buff,dev->buffer,sizeof(dev->buffer)))
               return -EFAULT;

        //dev->buffer = "\0";

        return sizeof(dev->buffer);
}

ssize_t samp2_write(struct inode *inode,struct file *fp,char *buf,ssize_t
count)
{
### write: wrong function parameters.
        struct samp2_buf *dev = (struct samp2_buf *)fp ->private_data;

        printk(KERN_CRIT "\n I AM IN WRITE ..............");

        //dev->buffer = (unsigned char *)kmalloc(SAMP_LEN,GFP_KERNEL);

        if(count > SAMP_LEN)
        {
                count = SAMP_LEN;
        }

        if(copy_from_user(dev->buffer,buf,count))
        {
                return -EFAULT;
        }

        dev->buffer[count] = '\0';
        console_print("In write \n ");
        printk(KERN_CRIT "\n I AM IN END of WRITE ..............");
        return count;
}

static struct file_operations samp2_fops =
{
        NULL,  /* seek */
        samp2_read,
        samp2_write,   /* write*/
        NULL,   /* readdir */
        NULL,   /* select */
        NULL,   /* ioctl */
        NULL,   /* mmap */
        samp2_open,       /* open */
        NULL,
        samp2_release,    /* release */
        NULL,
        NULL,
};
### This struct file_operations doesn't match what's in
### my kernel source files.  And you really should use the
### "field: value" initializer construct, as in:
###	read: samp2_read,
### etc.

int init_module(void)
{
        int ret;

        ret = register_chrdev(84,"samp2",&samp2_fops);

        if(ret == 0)
        {
                console_print("<0> Device registered <0>");
        }
        else
        {
                console_print(" Device not registered ");
        }

return 0;
}

void cleanup_module(void)
{
        if(MOD_IN_USE)
        {
                console_print(" Driver in use ");
                return;
        }
        unregister_chrdev(84,"samp2");

        console_print(" <0> Driver Unregistered <0> ");
}

I am compiling this code with

gcc -D__KERNEL__ -DMODULE -DMODVERSIONS -DLINUX
-I/usr/src/linux-2.4B/include -O6 -Wall -c samp.c

### kernel is usually compiled with "-O2", not -O6.

But when ever i run a sample test program on this the write and read
always return a -1.

### Why do you say that it's a copy_from_user() problem?
### Does the sample program print errno?
### Where is the sample program?

### ~Randy


