Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267489AbUGWCIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267489AbUGWCIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 22:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUGWCIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 22:08:44 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:43482 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S267489AbUGWCIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 22:08:24 -0400
Message-ID: <757c55c604072219086df290f6@mail.gmail.com>
Date: Thu, 22 Jul 2004 23:08:23 -0300
From: Maikon Bueno <maikon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: interrupt function
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All...
I`m trying to enable the serial interrupt, but whenever it happens
some event, the interrupt function isn't called.
The follow code will be a serial mouse driver. When some event occurs,
the "interrupt_count" is incremented and its result is shown when the
module is released.
I would like to know how to enable the interrupt function and the
IRQ... I don't know what is happening.
Thanks!!!

Maikon.

--------------------------------------------------

#define MODULE
#define __KERNEL__

#include<linux/ioport.h>
#include <linux/config.h>

#include <linux/module.h>

#include<linux/sched.h>
#include<linux/poll.h>
#include<linux/interrupt.h>
#include<linux/miscdevice.h>
#include<linux/init.h>

#include <linux/kernel.h>
#include<linux/slab.h> 
#include <linux/fs.h> 
#include <linux/errno.h> 
#include <linux/types.h> 
#include <linux/proc_fs.h>
#include <linux/fcntl.h> 
#include <linux/devfs_fs_kernel.h>

#define OURMOUSE_BASE 0x300
#define OURMOUSE_MINOR 1
#define OURMOUSE_MAJOR 56
#define MOUSE_IRQ 3

static int mouse_users = 0; 
static int mouse_dx = 0; 
static int mouse_dy = 0;
static int mouse_event = 0; 
static int mouse_buttons = 0;
static int mouse_intr = MOUSE_IRQ;
static int interrupt_count=0;

static struct wait_queue *mouse_wait;
static spinlock_t mouse_lock = SPIN_LOCK_UNLOCKED;
static devfs_handle_t ourmouse_dir;
static devfs_handle_t ourmouse_dev;

static int ourmouse_open(struct inode *inode, struct file *file);
static int ourmouse_close(struct inode *inode,struct file *file);
static void ourmouse_interrupt(int irq, void *dev_id, struct pt_regs *regs);
static unsigned int mouse_poll(struct file *file, poll_table *wait);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Maikon Bueno");

char ourmouse_str[] = "Hi Baby!\n ";

ssize_t ourmouse_read(struct file *filp , char *buf,
                 size_t count, loff_t *offp)
{   
    struct inode *inode = filp->f_dentry->d_inode;
    int minor = MINOR(inode->i_rdev);
    char *txt;

    if (filp->private_data) {
        txt = filp->private_data;
    } else {
        txt = ourmouse_str;
    }
    if (count > strlen(txt)) count = strlen(txt);
    copy_to_user(buf, txt, count);
    *offp += count;
    return count;
}

struct file_operations ourmouse_fops = {
	    read:   ourmouse_read,
	    open:   ourmouse_open,
	    release:  ourmouse_close,
};

int init_module(void){
	printk("<1> initing\n");
	if(check_region(OURMOUSE_BASE, 3))
		return -ENODEV;
	request_region(OURMOUSE_BASE, 3,"Ourmouse");
	
	devfs_register_chrdev(OURMOUSE_MAJOR,"Ourmouse",&ourmouse_fops);
	ourmouse_dir = devfs_mk_dir(NULL,"Ourmouse", NULL);
	if(ourmouse_dir == NULL){
		printk("<1> Couldn't make the Ourmouse's dir\n");
	}
	ourmouse_dev = devfs_register(ourmouse_dir,
"Ourmouse",DEVFS_FL_NONE,OURMOUSE_MAJOR,OURMOUSE_MINOR, S_IFCHR |
S_IRUGO,&ourmouse_fops, NULL);
	if (ourmouse_dev == NULL){
		printk("<1> Couldn't register Ourmouse\n");
	}
	
	return 0;
}

void cleanup_module(void){
	release_region(OURMOUSE_BASE, 3);
	devfs_unregister(ourmouse_dev);
	printk("<1> Bye %i\n",interrupt_count);
}

static int ourmouse_open(struct inode *inode, struct file *file)
{

    if(mouse_users++)
        return 0;
    if(request_irq(mouse_intr, ourmouse_interrupt, 0,"Ourmouse", NULL))
    {
	mouse_users--;
        return -EBUSY;
    }
    
    mouse_dx = 0;
    mouse_dy = 0;
    mouse_buttons = 0;
    mouse_event = 0;
    MOD_INC_USE_COUNT;
    
    return 0;
}

static int ourmouse_close(struct inode *inode,struct file *file)
{    
    if(--mouse_users)
            return 0;
    free_irq(mouse_intr, NULL);
    MOD_DEC_USE_COUNT; 
    return 0;
}

static void ourmouse_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
    interrupt_count++;
}

static unsigned int mouse_poll(struct file *file, poll_table *wait)
{
    return 0;
}
