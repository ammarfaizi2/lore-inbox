Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSLDLxF>; Wed, 4 Dec 2002 06:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266444AbSLDLxF>; Wed, 4 Dec 2002 06:53:05 -0500
Received: from fetch.runbox.com ([193.71.199.211]:34196 "EHLO aibo.runbox.com")
	by vger.kernel.org with ESMTP id <S266443AbSLDLw5>;
	Wed, 4 Dec 2002 06:52:57 -0500
Message-ID: <00d101c29b8d$63e45e80$4b614ccb@zaman>
From: "Shahid" <z-shahid@runbox.com>
To: "kernel" <linux-kernel@vger.kernel.org>
Date: Wed, 4 Dec 2002 18:04:26 +0600
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Subject: testing mouse device driver
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everybody,

                    I am trying to develop a mouse
device driver for Linux. my linux verison is Redhat
7.2. In writing the code i followed a tutorial by Alan
Cox on developing mouse driver, where actually Alan
Cox gives every code needed to build a mouse driver.
You can find out out this tutorial in linux's kernel
documentation and also in the site - www.linux-mag.com
.

                    i worked on the codes of the
tutorial. The tutorial uses an imaginary mouse port
base address and irq number and i have to make few
changes to compile the code and loading it as a module
with insmod. However when i am able to load it as
module, i wanted to test the driver. As my pc mouse
uses ps/2 port - so i use 0x064h as ps/2 ports base
address and irq number 12 (ps/2 ports interrupt
number, i get it from a list in the /proc/interrupts).
But then for testing i boot linux with the mouse
device removed. So in the boot process, kudzu appears
reporting ps/2 mouse device removed. From that screen
i choose remove configuration as i ant to use my own
driver for the mouse. Then after entering into linux,
first i make a node in the /dev directory for the
mouse device by the following command -

                    mknod  ourmouse  c  10  0

    here i used the major number for misc devices(as
the code registers mouse as misc devices) and use the
minor number 0 for mouse. Then i compile the code to
make mouse.o object file, then whenever i am trying to
loading the mdule with insmod the an error message
like the following appears -

this module can't be loaded, it can taint the kernel
invalid i/o or irq number used a parameter


   i also tried with 0x23Ch as port address and 5 as
irq number, which i got from the kernel source file -
logimouse.c and logimouse.h....... but i got the same
result.
i am really desperate to test that driver and i tried
in many ways.......so u can help me a while?

below is my source code.  If u think u need the
tutorial to solve the problem and can't retrieve it
from the site or linux documentation, then also feel
free to contact with me. my e-mail address is:
z-shahid@runbox.com
thanx in advance for ur response.

best regards -

Shahid, Dhaka.


/*source code*/


#include<linux/ioport.h>
#include <linux/config.h>
#include <linux/module.h>
#include<linux/sched.h>
#include<linux/poll.h>
#include<linux/interrupt.h>
#include<linux/miscdevice.h>
#include<linux/init.h>

 #include <linux/kernel.h> /* printk() */
#include <linux/malloc.h> /* kmalloc() */
#include <linux/fs.h>     /* everything... */
#include <linux/errno.h>  /* error codes */
#include <linux/types.h>  /* size_t */
#include <linux/proc_fs.h>
#include <linux/fcntl.h>        /* O_ACCMODE */

#include <asm/system.h>
#include<asm/segment.h>
#include<asm/io.h>



/*Listing 1: File Operations*/
static ssize_t mouse_read(struct file *f, char *buffer,size_t count, loff_t
*pos);
static ssize_t write_mouse(struct file *file, const char *buffer, size_t
count, loff_t *ppos);
static unsigned int mouse_poll(struct file *file, poll_table *wait);
static int open_mouse(struct inode *inode, struct file *file);
static int close_mouse(struct inode *inode,struct file *file);

struct file_operations our_mouse_fops = {
    NULL,        /* Mice don't seek */
    mouse_read,  /* You can read a mouse */
    write_mouse, /* This won't do a lot */
    NULL,        /* No readdir - not a directory */
    mouse_poll,  /* Poll */
    NULL,        /* No ioctl calls */
    NULL,        /* No mmap */
    open_mouse,  /* Called on open */
    NULL,        /* Flush - 2.2 only */
    close_mouse, /* Called on close */
    NULL,        /* No media change on a mouse */
    NULL,        /* Asynchronous I/O - we will add this later*/
    NULL
};

/*=====================================================*/

/*Listing 2: Initializing Functions*/
/*#define OURMOUSE_BASE   0x300*/
/*#define OURMOUSE_BASE   0x23c*/
#define OURMOUSE_BASE 0x064

#define OURMOUSE_MINOR 0

/*#define MOUSE_IRQ 5*/
#define MOUSE_IRQ 12


static struct miscdevice our_mouse = {
 OURMOUSE_MINOR, "ourmouse",&our_mouse_fops, &our_mouse_fops
};

/*__init ourmouse_init(void)*/
static int ourmouse_init(void)
{

    if(check_region(OURMOUSE_BASE, 3))
         return -ENODEV;
    request_region(OURMOUSE_BASE, 3,"ourmouse");

    misc_register(&our_mouse);
    return 0;
}

/*=====================================================*/

/*Listing 3: Module Wrapper Code*/
#ifdef MODULE

int init_module(void)
{
    if(ourmouse_init()<0)
          return -ENODEV;
    return 0;
}

void cleanup_module(void)
{
    misc_deregister(&our_mouse);
    release_region(OURMOUSE_BASE, 3);
}

#endif


/*===================================================*/

static int mouse_users = 0; /* User count */
static int mouse_dx = 0;    /* Position changes */
static int mouse_dy = 0;
static int mouse_event = 0;  /* Mouse has moved */
static int mouse_buttons = 0;
static int mouse_intr = MOUSE_IRQ;

/*Listing 4: The Interrupt Handler*/
static struct wait_queue *mouse_wait;
static spinlock_t mouse_lock = SPIN_LOCK_UNLOCKED;

static void ourmouse_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
    char delta_x;
    char delta_y;
    unsigned char new_buttons;

    delta_x = inb(OURMOUSE_BASE);
    delta_y = inb(OURMOUSE_BASE+1);
    new_buttons = inb(OURMOUSE_BASE+2);

    if(delta_x || delta_y || new_buttons != mouse_buttons)
    {
            /* Something happened */
            spin_lock(&mouse_lock);
            mouse_event = 1;
            mouse_dx += delta_x;
            mouse_dy += delta_y;
            mouse_buttons = new_buttons;
            spin_unlock(&mouse_lock);

            wake_up_interruptible(&mouse_wait);
    }
}


/*======================================================*/


/*Listing 5: Managing Interrupts*/

static int open_mouse(struct inode *inode, struct file *file)
{
    if(mouse_users++)
        return 0;
    if(request_irq(mouse_intr, ourmouse_interrupt, 0,
       "ourmouse", NULL))
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


/*========================================================*/



/*Listing 6: The close_mouse Function*/
static int close_mouse(struct inode *inode,struct file *file)
{
    if(--mouse_users)
            return 0;
    free_irq(mouse_intr, NULL);
    MOD_DEC_USE_COUNT;
    return 0;
}


/*======================================================*/


/*Listing 7: Filling in the Write Handler*/
static ssize_t write_mouse(struct file *file, const char *buffer, size_t
count, loff_t *ppos)
{
    return -EINVAL;
}



/*=====================================================*/


/*Listing 8: The poll function*/
static unsigned int mouse_poll(struct file *file, poll_table *wait)

{
    poll_wait(file, &mouse_wait, wait);
    if(mouse_event)
            return POLLIN | POLLRDNORM;
    return 0;
}


/*===================================================*/


/*Listing 9: Waiting for an Event*/
static ssize_t mouse_read(struct file *f, char *buffer,size_t count, loff_t
*pos)
{
    int dx, dy;
    unsigned char button;
    unsigned long flags;
    int n;

    if(count < 3)
        return -EINVAL;

/*Wait for an event */

/*struct task_struct *current;*/
while(!mouse_event)
{
    if(f->f_flags&O_NDELAY)
    return -EAGAIN;
    interruptible_sleep_on(&mouse_wait);
    if(signal_pending(current))
    return -ERESTARTSYS;
}


/*===================================================*/

/*Reading the Event*/
/* mouse_read continued */

/* Grab the event */

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


/*=================================================*/

/*Copying Results to the Buffer*/
/* mouse_read continued */

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

/* all quiet on the western front */



