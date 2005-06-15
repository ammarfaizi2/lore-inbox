Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVFOXbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVFOXbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVFOXbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:31:24 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:38497 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261651AbVFOXbK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:31:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wrz7KQOXmNrdcOQxj84PEROVIQvJzAggtx3xybkglvHEWrt/j92OJCA7FKAPVhhOyz0ahopnu/Opv3L2O8MvERXA+1Kb1/rDDBwolpDkf6QW75Oqxj3AezOCE6V2slEy9nyjwEKwhridWarzHVOM5NX/zZLGHAXMuOPIrE4uX2Q=
Message-ID: <61bce7105061516313051dc1d@mail.gmail.com>
Date: Wed, 15 Jun 2005 19:31:10 -0400
From: Hemant Mohapatra <hemant.mohapatra@gmail.com>
Reply-To: Hemant Mohapatra <hemant.mohapatra@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: cdev_init() problems in char device driver (kernel 2.6.4-52) (newbie ques)
In-Reply-To: <61bce71050615115860d35f38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <61bce7105061511335b66cced@mail.gmail.com>
	 <61bce7105061511544f6635e3@mail.gmail.com>
	 <61bce71050615115860d35f38@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am writing a simple char driver on Linux (Suse 9.1, kernel 2.6.4.52,
gcc 3.3.3) and having the following problems (code is cut-pasted at
the end):

1) MODULE_LICENSE gives the following on make -

error: parse error before string constant
warning: type defaults to `int' in declaration of `MODULE_LICENCE'
warning: data definition has no type or storage class

Btw, it works fine in another program which simply does module_init()
and module_exit().

2) insmod faults (SIGSEGV) with strace ending at the line:

init_module("^?ELF^A^A^A", 0xc529 <unfinished ...>
4299  +++ killed by SIGSEGV +++

dmesg output:

MAJOR(dev)=253
Before cdev_init
Unable to handle kernel NULL pointer dereference at virtual address 00000018
printing eip:
c01da533
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c01da533>]    Tainted: PF
EFLAGS: 00010292   (2.6.4-52-default)
EIP is at kobject_init+0x3/0x40
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: d9126880   edi: d912684c   ebp: d059de48   esp: d059de28
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 3877, threadinfo=d059c000 task=d6494d70)
Stack: c0341da8 d91280cc d9126800 000000fd 00000001 d9126232 0fd00000 c0341d98
       c0341d98 c0132305 00000000 d9142e54 d9142e54 00000500 00000500 d05dc9a0
       d059de8c c0138db0 0000304c 00000282 00000000 d05dc980 00000001 d059deb4
Call Trace:
 [<d91280cc>] scull_init+0xcc/0x15f [cd]
 [<c0132305>] sys_init_module+0x105/0x15b0
 [<c0138db0>] file_read_actor+0x0/0xe0
 [<c01da3e0>] kobject_put+0x0/0x20
 [<d9128000>] scull_init+0x0/0x15f [cd]
 [<c01c8d96>] selinux_file_alloc_security+0x26/0x80
 [<c01ca1e0>] selinux_file_permission+0x160/0x170
 [<c0155b5e>] __fput+0x9e/0xf0
 [<c0107dc9>] sysenter_past_esp+0x52/0x79

Code: c7 40 18 01 00 00 00 8d 40 1c 89 43 1c 89 43 20 8b 43 28 31


Analysis done:

I was getting the same erorr on cdev_init() so to find out where
exactly the inmod was crashing, I manually did whatever was being done
inside cdev_init and figured out that it was crashing at
kobject_init().

I have gone through /proc/ksyms to figure out exactly which
instruction causes the fault but have not been successful.

relevant ksymoops info:

Code;  c01da533 <kobject_init+3/40>
00000000 <_EIP>:
Code;  c01da533 <kobject_init+3/40>   <=====
   0:   c7 40 18 01 00 00 00      movl   $0x1,0x18(%eax)   <=====
Code;  c01da53a <kobject_init+a/40>
   7:   8d 40 1c                  lea    0x1c(%eax),%eax
Code;  c01da53d <kobject_init+d/40>
   a:   89 43 1c                  mov    %eax,0x1c(%ebx)
Code;  c01da540 <kobject_init+10/40>
   d:   89 43 20                  mov    %eax,0x20(%ebx)
Code;  c01da543 <kobject_init+13/40>
  10:   8b 43 28                  mov    0x28(%ebx),%eax
Code;  c01da546 <kobject_init+16/40>
  13:   31 00                     xor    %eax,(%eax)


Any help extended would be highly appreciated.

Thanks,
Hemant R Mohapatra



------------------------------------------------------------------------

Code:

#if defined( CONFIG_MODVERSIONS ) && ! defined( MODVERSIONS )
#define MODVERSIONS
#endif

#include <linux/module.h>
#include <linux/init.h>
#include <asm/current.h>
#include <asm/uaccess.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/kobject.h>
#include <linux/kobj_map.h>
#include <linux/cdev.h>
#ifdef CONFIG_KMOD
#include <linux/kmod.h>
#endif
#include <linux/cdev.h>

#define DEVICE_NAME "scull"
#define SUCCESS 0
#define FAIL -1
#define SIZE 10
#define TYPE(dev) (MINOR(dev) >> 4)     //highers 4 bits refer to type
of device (char, in this case)
//lower 4 bits refer to NUM for the device
#define NUM(dev) (MINOR(dev) & 0xf)


static int Major, Minor;
static int device_opened = 0;

static char MSGBUF[SIZE];
static char *msg_ptr;
static int device_open (struct inode *in, struct file *filp);
static int device_release (struct inode *in, struct file *filp);
/* static ssize_t device_read (struct file *, char *, size_t, loff_t *);
 static ssize_t device_write (struct file *, char *, size_t, loff_t *);
 * */

static int
device_open (struct inode *in, struct file *filp)
{

  /* int type=TYPE(in->i_rdev); */// Old way of getting the driver's
  // major/minor number.
  /* int num=NUM(in->i_rdev); */
  int counter = 0;
  int type = TYPE (iminor (in));
  int num = NUM (iminor (in));

  if (device_opened)
    {
      return -EBUSY;
    }
  device_opened++;
  msg_ptr = MSGBUF;      //this is the pointer used in reading from
the device in the device_read func

  sprintf (MSGBUF, "This is call to open() device number: %d\n", ++counter);

  //return some info about the driver
  printk ("<1> TYPE of device = %d\n and NUM of device = %d\n", type, num);
  MOD_INC_USE_COUNT;
  return SUCCESS;
}


static int
device_release (struct inode *in, struct file *filp)
{

  device_opened--;
  MOD_DEC_USE_COUNT;
  return SUCCESS;
}

static struct file_operations scull_fops = {
  .open        =    device_open,
  .release     =    device_release,
  .owner       =    THIS_MODULE,
 // .read = device_read,
 // .write = device_write,
};

static struct cdev scull_cdev = {
     .kobj     =    {.name    =    "scull",  },
     .owner    =    THIS_MODULE,
};

static int __init scull_init (void)
{
  /* dev_t dev=MKDEV(63,0); */
  dev_t dev;
  int retval;

 retval=alloc_chrdev_region(&dev, 0, 1, DEVICE_NAME);
 if(!retval)
      {
           Major=MAJOR(dev);
           Minor=MINOR(dev);
      }
 else {
      return FAIL;
 }
 printk("MAJOR(dev)=%d\n", MAJOR(dev));

printk("<1> Before cdev_init\n");


memset(&scull_cdev, 0, sizeof(scull_cdev));
INIT_LIST_HEAD(&scull_cdev.list);
//scull_cdev.kobj.ktype = &ktype_cdev_default; -- not working, why?
kobject_init(&scull_cdev.kobj);
scull_cdev.ops = &scull_fops;
//kobject_set_name(&scull_cdev.kobj,"scull");

//cdev_init(&scull_cdev, &scull_fops); -- was not working, so the above
//simplification

printk("<1> after cdev_init:\n");

  retval=cdev_add(&scull_cdev, dev, 1);
  if(retval)
  {
       cdev_del(&scull_cdev);
       kobject_put(&scull_cdev.kobj);
       unregister_chrdev_region(dev, 1);
       printk("<1> Error in cdev_add:");
       goto error;
  }
  printk ("<1> scull_init was a Success and the major device number is
%d \n",  Major);
  return 0;

error:
   printk(KERN_ERR "error register raw device\n");
   return FAIL;

}

static void scull_exit (void)
{
  printk ("<1> Removing scull drivers from /proc/devices\n");
  unregister_chrdev_region (MKDEV(Major,0), 1);
}


module_init (scull_init);
module_exit (scull_exit);
//MODULE_LICENCE("GPL"); - doesn't work.
