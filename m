Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUG0PoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUG0PoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUG0Pmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:42:49 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:60308 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266450AbUG0Pku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:40:50 -0400
Message-ID: <757c55c6040727084035039172@mail.gmail.com>
Date: Tue, 27 Jul 2004 12:40:50 -0300
From: Maikon Bueno <maikon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: bytes from mouse
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
In the follow code, I try to get the bytes from the mouse, but the
bytes that I got are always either 0 or -128, in any state of mouse
(with or without pressed buttons).
I'm using COM1 and I read the bytes from the 0x3f8 port. 
Am I reading the values from the correct address? Is there other way to do that?

Thanks.


--------------------------



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

#include <linux/string.h>
#include <linux/unistd.h>
#include <asm/system.h>
#include <asm/io.h>
#include <asm/irq.h>
#define PORT 0x3f8 //COM1
#define LCR  3
#define MSB 1
#define LSB 0
#define FCR 2
#define SCR 7

#define OURMOUSE_BASE 0x300
#define OURMOUSE_MINOR 1
#define OURMOUSE_MAJOR 56
#define MOUSE_IRQ 4 //COM1

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
static int enable_irq_interrupt();

static int bufferin;
static int bufferout;
static char buffer[1024];
static unsigned interrupt_enabled = 0;

MODULE_LICENSE("GPL");
MODULE_AUTHOR("OURMOUSE");

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
	
	interrupt_enabled=!enable_irq_interrupt();
	if (!interrupt_enabled)
	  return -EBUSY;
        	
	return 0;
}

void cleanup_module(void){
	release_region(OURMOUSE_BASE, 3);
	devfs_unregister(ourmouse_dev);
	free_irq(mouse_intr, NULL);
	printk("<1> Bye %i\n",interrupt_count);
}

static int ourmouse_open(struct inode *inode, struct file *file)
{ 
    int err = 0;
    if(mouse_users++)
        return 0;
    if(!interrupt_enabled)
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
    MOD_DEC_USE_COUNT; 
    return 0;
}

static void ourmouse_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
    //interrupt_count++;
	
	int i;
	do { 
		i = inb(PORT + 5);
		if (i & 1) {
			buffer[bufferin] = inb(PORT);
			printk("<1> Byte %i: %i\n",bufferin,buffer[bufferin]);
			bufferin++;
			if (bufferin == 1024) bufferin = 0;
		}
	}while (i & 1);

}

static unsigned int mouse_poll(struct file *file, poll_table *wait)
{
    return 0;
}

static int enable_irq_interrupt() 
{
	unsigned long flags;
	int i;
	bufferin = 0;
	bufferout = 0;
	save_flags(flags); cli();
	i=request_irq(mouse_intr,ourmouse_interrupt,SA_INTERRUPT,"Ourmouse",NULL);
	if(i) {
		restore_flags(flags);
		return i;
	}
	outb(0,PORT + 1);     // Turn off interrupts - Port1 
	outb(0,PORT + 1);     // Disable interrupts - bit 0 ->0 
	outb(0x80,PORT + 3);  // enable DLAB - bit 7 ->1
	outb(0x0C,PORT + 0);  // Set Divisor LSB 
	outb(0x00,PORT + 1);  // Set Divisor MSB 
	outb(0x03,PORT + 3);  // 8 Bits, No Parity, 1 Stop Bit 
	outb(0xC7,PORT + 2);  // Enable FIFO if UART is 16500+ 
	outb(0x0B,PORT + 4);  // Turn on DTR, RTS, and OUT2 
	outb(0x01,PORT + 1);  // Interrupt when data received 
	printk("<1> sioEnable --ok ... irq: %d\n", mouse_intr);
	restore_flags(flags);
	return 0;

}
