Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUGMTKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUGMTKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 15:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUGMTKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 15:10:51 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:11302 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265763AbUGMTKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 15:10:17 -0400
Message-ID: <757c55c604071312106d515d78@mail.gmail.com>
Date: Tue, 13 Jul 2004 16:10:09 -0300
From: Maikon Bueno <maikon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Mouse driver
In-Reply-To: <757c55c6040713071814ff655c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <757c55c6040712065266e867e5@mail.gmail.com> <20040712172844.GA2375@prot.minidns.net> <757c55c6040713071814ff655c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...
I'm developing a serial mouse driver and I would like to know how can
I do to associate a driver with the device.
To do this driver code I followed a tutorial by Alan Cox. I used the
register_chrdev function to associate the driver with the device,
however when I issue "cat /dev/mymouse" (the mymouse device was
created using the "mknod" command with the same major number of the
driver and the module is already loaded), I got a error message.
Is there any way of to do this?
When are the open_mouse and ourmouse_interrupt functions called?

Thanks!!

#define MODULE

#include<linux/ioport.h>
#include <linux/config.h>

#include <linux/module.h>

#include<linux/sched.h>
#include<linux/poll.h>
#include<linux/interrupt.h>
#include<linux/miscdevice.h>
#include<linux/init.h>

#include <linux/kernel.h> // printk()
#include <linux/malloc.h> // kmalloc()
#include<linux/slab.h> //
#include <linux/fs.h> // everything...
#include <linux/errno.h> // error codes
#include <linux/types.h> // size_t
#include <linux/proc_fs.h>
#include <linux/fcntl.h> // O_ACCMODE
#include <linux/devfs_fs_kernel.h>
#include <linux/devfs_fs.h>

#include <asm/system.h>
#include<asm/segment.h>
#include<asm/io.h>

#ifdef CONFIG_DEVFS_FS
#include <linux/devfs_fs_kernel.h>
#else
typedef void * devfs_handle_t;
#endif

/**/

#define OURMOUSE_BASE 0x300
//#define OURMOUSE_BASE 0x23c
//#define OURMOUSE_BASE 0x064
#define OURMOUSE_MINOR 0
#define OURMOUSE_MAJOR 250
//#define MOUSE_IRQ 5
#define MOUSE_IRQ 12

static int mouse_users = 0; // User count
static int mouse_dx = 0; // Position changes
static int mouse_dy = 0;
static int mouse_event = 0; // Mouse has moved
static int mouse_buttons = 0;
static int mouse_intr = MOUSE_IRQ;

static struct wait_queue *mouse_wait;
static spinlock_t mouse_lock = SPIN_LOCK_UNLOCKED;

//Listing 1: File Operations
static ssize_t mouse_read(struct file *f, char *buffer,size_t count, loff_t
*pos);
static ssize_t write_mouse(struct file *file, const char *buffer, size_t
count, loff_t *ppos);
static unsigned int mouse_poll(struct file *file, poll_table *wait);
static int open_mouse(struct inode *inode, struct file *file);
static int close_mouse(struct inode *inode,struct file *file);

//static devfs_handle_t mydev;

struct file_operations our_mouse_fops = {
   NULL, // Mice don't seek
   mouse_read, // You can read a mouse
   write_mouse, // This won't do a lot
   NULL, // No readdir - not a directory
   mouse_poll, // Poll
   NULL, // No ioctl calls
   NULL, // No mmap
   open_mouse, // Called on open
   NULL, // Flush - 2.2 only
   close_mouse, // Called on close
   NULL, // No media change on a mouse
   NULL, // Asynchronous I/O - we will add this later
   NULL
};

static struct miscdevice our_mouse = {
OURMOUSE_MINOR, "ourmouse",&our_mouse_fops, &our_mouse_fops
};

static int ourmouse_init(void)
{
   printk("estou no ourmouse_init \n");
   if(check_region(OURMOUSE_BASE, 3))
        return -ENODEV;
   printk("ourmouse: depois do check_region(OURMOUSE_BASE,3) \n");
   request_region(OURMOUSE_BASE, 3,"ourmouse");
   register_chrdev(OURMOUSE_MAJOR,"ourmouse",&our_mouse_fops);
/*
   devfs_register(NULL,
                  "ourmouse",
                 0,
                 OURMOUSE_MAJOR,
                 OURMOUSE_MINOR,
                 S_IFCHR | S_IRUGO | S_IWUGO,
                 &our_mouse_fops,
                 0);
 */
   //misc_register(&our_mouse);
   return 0;
}

int init_module(void)
{
   printk("estou no init_module \n");
   if(ourmouse_init()<0)
         return -ENODEV;
   printk("init_module: depois de ourmouse_init() \n");
   return 0;
}

void cleanup_module(void)
{
   //misc_deregister(&our_mouse);
   //deffs_unregister(mydev);
   unregister_chrdev(OURMOUSE_MAJOR,"ourmouse");
   release_region(OURMOUSE_BASE, 3);
}

static void ourmouse_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
   char delta_x;
   char delta_y;
   unsigned char new_buttons;

   printk("uma interrupcao foi chamada \n");

   delta_x = inb(OURMOUSE_BASE);
   delta_y = inb(OURMOUSE_BASE+1);
   new_buttons = inb(OURMOUSE_BASE+2);

   if(delta_x || delta_y || new_buttons != mouse_buttons)
   {
           // Something happened
           spin_lock(&mouse_lock);
           mouse_event = 1;
           mouse_dx += delta_x;
           mouse_dy += delta_y;
           mouse_buttons = new_buttons;
           spin_unlock(&mouse_lock);

           wake_up_interruptible(&mouse_wait);
   }
}

static int open_mouse(struct inode *inode, struct file *file)
{
   printk("estou no open_mouse \n");

   if(mouse_users++)
       return 0;
   if(request_irq(mouse_intr, ourmouse_interrupt, 0,
      "ourmouse", NULL))
   {
       printk("request_irq: dentro do IF... algo deu errado \n");
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

static int close_mouse(struct inode *inode,struct file *file)
{
   if(--mouse_users)
           return 0;
   free_irq(mouse_intr, NULL);
   MOD_DEC_USE_COUNT;
   return 0;
}

static ssize_t write_mouse(struct file *file, const char *buffer, size_t
count, loff_t *ppos)
{
   return -EINVAL;
}

static unsigned int mouse_poll(struct file *file, poll_table *wait)
{
   poll_wait(file, &mouse_wait, wait);
   if(mouse_event)
           return POLLIN | POLLRDNORM;
   return 0;
}

static ssize_t mouse_read(struct file *f, char *buffer,size_t count, loff_t
*pos)
{
   int dx, dy;
   unsigned char button;
   unsigned long flags;
   int n;

   if(count < 3)
       return -EINVAL;

//Wait for an event
//struct task_struct *current;
while(!mouse_event)
{
   if(f->f_flags&O_NDELAY)
   return -EAGAIN;
   interruptible_sleep_on(&mouse_wait);
   if(signal_pending(current))
   return -ERESTARTSYS;
}

//Reading the Event
// mouse_read continued
// Grab the event
spin_lock_irqsave(&mouse_lock, flags);

dx = mouse_dx;
dy = mouse_dy;
button = mouse_buttons;

if(dx<=-127)
       dx=-127;
if(dx>=127)
       dx=127;
if(dy<=-127)
       dy=-127;
if(dy>=127)
       dy=127;

mouse_dx -= dx;
mouse_dy -= dy;

if (mouse_dx == 0 && mouse_dy == 0)
       mouse_event = 0;

spin_unlock_irqrestore(&mouse_lock, flags);

//=================================================
//Copying Results to the Buffer
// mouse_read continued

if(put_user(button|0x80, buffer))
       return -EFAULT;
if(put_user((char)dx, buffer+1))
       return -EFAULT;
if(put_user((char)dy, buffer+2))
       return -EFAULT;

for(n=3; n < count; n++)
       if(put_user(0x00, buffer+n))
               return -EFAULT;

return count;
}
/**/
