Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310423AbSCPQUD>; Sat, 16 Mar 2002 11:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310424AbSCPQTq>; Sat, 16 Mar 2002 11:19:46 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:15286 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S310423AbSCPQT2>; Sat, 16 Mar 2002 11:19:28 -0500
Message-ID: <3C937EBD.C0308D21@free.fr>
Date: Sat, 16 Mar 2002 18:19:57 +0100
From: Romain =?iso-8859-1?Q?Li=E9vin?= <rlievin@free.fr>
Reply-To: roms@lpg.ticalc.org
Organization: LPG (Linux Programmer Group) on ticalc.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore T'so" <tytso@mit.edu>
Subject: [PATCH], tiser module: TI graphing calculators
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This new driver is the brother of tipar. It can handle a serial link
cable 
designed to connect a Texas Instruments graphing calculators to a 
computer/workstation.

This driver directly accesses some UART registers in a way similar to
serial.c. 
A better method should be to do some ioctl for toggling UART lines
rather than by-passing the ttySx driver.

Is there anyone who have some another ideas ?

Romain.

==============================[ cut here ]==============================
--- linux.orig/drivers/char/tiser.c     Sat Mar 16 18:16:06 2002
+++ linux/drivers/char/tiser.c  Sat Mar 16 18:15:49 2002
@@ -0,0 +1,500 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tiser - low level driver for handling a serial link cable designed
+ * for Texas Instruments graphing calculators (http://lpg.ticalc.org).
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <rlievin@mail.com>
+ * under the terms of the GNU General Public License.
+ *
+ * Fixes v1.12b: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
+ *
+ */
+
+#define TISER_VERSION "1.12b" /* March 2002 */
+
+/* This driver should, in theory, work with any RS232 compliant serial
port. 
+ *
+ *
+ *
+ * If this driver is built into the kernel, you can configure it using
the
+ * kernel command-line.  For example:
+ *
+ *      tiser=timeout,delay       (set timeout and delay)
+ *
+ * If the driver is loaded as a module, similar functionality is
available
+ * using module parameters.  The equivalent of the above commands would
be:
+ *
+ *      # insmod tiser.o tiser=15,10
+ */
+
+/* COMPATIBILITY WITH OLD KERNELS
+ *
+ * Usually, serial cables were bound to ports at
+ * particular I/O addresses, as follows:
+ *
+ *      tiser0             0x3f8
+ *      tiser1             0x2f8
+ *      tiser2             0x3e8
+ *      tiser3             0x2e8
+ *
+ * This driver, by default, binds tiser devices according to the minor
number.
+ * This means that if you do not have standard addresses for serial
port,
+ * you will have to manually edit the file and change structure values.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/fcntl.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <linux/devfs_fs_kernel.h> /* DevFs support */
+#include <linux/serial_reg.h>  
+#include <linux/slab.h>
+
+/*
+ * TI definitions
+ */
+#include "ticable.h" //#include <linux/ticable.h>
+
+/* ----- global variables ---------------------------------------------
*/
+
+#define TISER_MODULE_NAME      "tiser"
+#define PFX                    TISER_MODULE_NAME ": "
+
+/*
+ * You must set these - there is no sane way to probe for this link
cable.
+ */
+
+#define SP_NO 4
+/* ports to probe */
+static int serial_ports[SP_NO] = {0x3f8, 0x2f8, 0x3e8, 0x2e8};
+static int tiser_count = 0;         /* how many serial ports we have */
+
+static int delay   = IO_DELAY;      /* inter-bit delay in microseconds
*/
+static int timeout = TIMAXTIME;     /* timeout in tenth of seconds    
*/
+
+static devfs_handle_t devfs_handle = NULL;
+
+/* per port serial structure, allows per port locking  */
+struct tiser_dev_t {
+       int port;
+       int minor;
+       int delay;
+       int timeout;
+       char name[8];
+       spinlock_t lock;
+       struct semaphore open_sem;
+};
+
+static struct tiser_dev_t *tiser_dev[SP_NO];
+
+/* --- setting states on the D-bus with the right timing: -------------
*/
+
+static inline void outbyte(struct tiser_dev_t *dev, int value)
+{
+       spin_lock(&dev->lock);
+       outb(value, dev->port + UART_MCR);
+       spin_unlock(&dev->lock);
+}
+
+static inline int inbyte(struct tiser_dev_t *dev)
+{
+       unsigned char ret;
+       spin_lock(&dev->lock);
+       ret = inb(dev->port + UART_MSR);
+       spin_unlock(&dev->lock);
+       return ret;
+}
+
+static inline void init_ti_serial(struct tiser_dev_t *dev)
+{
+       outbyte(dev, 3);
+}
+
+/* ----- global defines -----------------------------------------------
*/
+
+#define START(x) { max=jiffies+HZ/(timeout/10); }
+#define WAIT(x) \
+do {if (!time_before(jiffies, (x))) \
+return -1; \
+if(current->need_resched) schedule(); \
+} while (0)
+
+/* ----- D-bus bit-banging functions ----------------------------------
*/
+
+/* D-bus protocol (45kbit/s max):
+                    1                 0                      0
+       _______        ______|______    __________|________   
__________
+Red  :        ________      |      ____          |        ____
+       _        ____________|________      ______|__________      
_____
+White:  ________            |        ______      |          _______
+*/
+
+/* Try to transmit a byte on the specified port (-1 if error). */
+static int put_ti_serial(struct tiser_dev_t *dev, unsigned char data)
+{
+       int bit;
+       unsigned long max;
+       
+       for (bit=0; bit<8; bit++) {
+               if (data & 1) {
+                       outbyte(dev, 2);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while(inbyte(dev) & 0x10);
+                       
+                       outbyte(dev, 3);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while(!(inbyte(dev) & 0x10));
+               } else {
+                       outbyte(dev, 1);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while(inbyte(dev) & 0x20);
+                       
+                       outbyte(dev, 3);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while(!(inbyte(dev) & 0x20));
+               }
+
+               data >>= 1;
+
+               udelay(delay);
+               if(current->need_resched) 
+                       schedule();
+       }
+       
+       return 0;
+}
+
+/* Receive a byte on the specified port or -1 if error. */
+static int get_ti_serial(struct tiser_dev_t *dev)
+{
+       int bit;
+       unsigned char v, data=0;
+       unsigned long max;
+       
+       for (bit=0; bit<8; bit++) {
+               START(max);
+               do {
+                       WAIT(max);
+               } while ((v=inbyte(dev) & 0x30) == 0x30); 
+               
+               if (v == 0x10) {
+                       data=(data>>1) | 0x80;
+                       outbyte(dev, 1);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while(!(inbyte(dev) & 0x20));
+                       outbyte(dev, 3);
+               } else {
+                       data=data>>1;
+                       outbyte(dev, 2);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while(!(inbyte(dev) & 0x10));
+                       outbyte(dev, 3);
+               }
+
+               udelay(delay);
+               if(current->need_resched) 
+                       schedule();
+       }
+
+       return (int)data;
+}
+
+/* Try to detect a parallel link cable on the specified port */
+static inline int probe_ti_serial(struct tiser_dev_t *dev)
+{
+        int i;
+        int seq[]={ 0x00, 0x20, 0x00, 0x30 };
+       
+        for(i=3; i>=0; i--) {
+                outbyte(dev, 3);
+                outbyte(dev, i);
+               udelay(delay);
+                /*printk("Probing -> %i: 0x%02x 0x%02x\n", i, data &
0x30, seq[i]);*/
+                if ( (inbyte(dev) & 0x30) != seq[i]) {
+                        outbyte(dev, 3);
+                        return -1;
+                }
+        }
+
+        outbyte(dev, 3);
+
+       return 0;
+}
+
+/* ----- kernel module functions---------------------------------------
*/
+
+static int tiser_open(struct inode *inode, struct file *file)
+{
+       unsigned int minor = MINOR(inode->i_rdev) - TISER_MINOR_0;
+
+       if (minor >= tiser_count)
+               return -ENXIO;
+       
+       if (file->f_flags & O_NONBLOCK) {
+               if (down_trylock (&tiser_dev[minor]->open_sem))
+                       return -EAGAIN;
+       } else {
+               if (down_interruptible (&tiser_dev[minor]->open_sem))
+                       return -ERESTARTSYS;
+       }
+
+       init_ti_serial(tiser_dev[minor]);
+       
+       return 0;
+}
+
+static int tiser_close(struct inode *inode, struct file *file)
+{
+       unsigned int minor = MINOR(inode->i_rdev) - TISER_MINOR_0;
+
+       up(&tiser_dev[minor]->open_sem);
+
+       return 0;
+}
+
+static ssize_t tiser_write(struct file *file, const char *buf, size_t
count, loff_t *ppos)
+{
+       unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev) - 
+               TISER_MINOR_0;
+       ssize_t n;
+  
+       if (minor >= tiser_count)
+                return -ENXIO;
+
+       for(n=0; n<count; n++) {
+               unsigned char b;
+               
+               if(get_user(b, buf + n))
+                       return -EFAULT;
+
+               if(put_ti_serial(tiser_dev[minor], b) == -1) {
+                       init_ti_serial(tiser_dev[minor]);
+                        return -ETIMEDOUT;
+               }
+       }
+       
+       return n;
+}
+
+static ssize_t tiser_read(struct file *file, char *buf, size_t count,
loff_t *ppos)
+{
+       int b=0;
+       unsigned int minor=MINOR(file->f_dentry->d_inode->i_rdev) -
TISER_MINOR_0;
+       ssize_t retval = 0;
+
+       if(count == 0)
+               return 0;
+
+       if(ppos != &file->f_pos)
+               return -ESPIPE;
+
+       do {
+               b = get_ti_serial(tiser_dev[minor]);
+               if(b == -1) {
+                       init_ti_serial(tiser_dev[minor]);
+                       retval = -ETIMEDOUT;
+                       goto out;
+               }               
+               else
+                       break;
+               
+               /* Non-blocking mode : try again ! */
+               if (file->f_flags & O_NONBLOCK) {
+                       retval = -EAGAIN;
+                       goto out;
+               }
+
+               /* Signal pending, try again ! */
+               if (signal_pending(current)) {
+                       retval = -ERESTARTSYS;
+                       goto out;
+               }   
+               
+               if(current->need_resched) 
+                       schedule();
+       } while (1);
+
+       retval = put_user(b, (unsigned char *)buf);
+       if(!retval)
+               retval = 1;
+       else
+               retval = -EFAULT;
+
+ out:
+       return retval;
+}
+
+static int tiser_ioctl(struct inode *inode, struct file *file,
+                      unsigned int cmd, unsigned long arg)
+{
+       unsigned int minor = MINOR(inode->i_rdev) - TISER_MINOR_0;
+
+       int retval = 0;
+
+       if (minor >= tiser_count)
+                return -ENODEV;
+       
+       switch (cmd) {
+       case TISER_DELAY:
+               tiser_dev[minor]->delay = arg;
+                return 0;
+       case TISER_TIMEOUT:
+               tiser_dev[minor]->timeout = arg;
+               return 0;
+       default:
+               retval = -ENOTTY;
+               break;
+       }
+       
+       return retval;
+}
+
+/* ----- kernel module registering ------------------------------------
*/
+
+static struct file_operations tiser_fops = {
+       owner:   THIS_MODULE,
+       llseek:  no_llseek,
+       read:    tiser_read,
+       write:   tiser_write,
+       ioctl:   tiser_ioctl,
+       open:    tiser_open,
+       release: tiser_close,
+};
+
+/* --- initialisation code ------------------------------------- */
+
+#ifndef MODULE
+/*      You must set these - there is no sane way to probe for this
board.
+ *      You can use tiser=timeout,delay to set these now. */
+static int __init tiser_setup (char *str)
+{
+       int ints[2];
+
+        str = get_options (str, ARRAY_SIZE(ints), ints);
+
+        if (ints[0] > 0) {
+                timeout = ints[1];
+                if(ints[0] > 1)        {
+                        delay = ints[2];
+               }
+       }
+       return 1;
+}
+#endif
+
+int __init tiser_init_module(void)
+{
+       char name[8];
+       int nr;
+       
+       printk(KERN_INFO PFX "serial link cable driver, version %s\n",
TISER_VERSION);
+       
+       if (devfs_register_chrdev(TISER_MAJOR, TISER_MODULE_NAME,
&tiser_fops)) {
+               printk(KERN_ERR PFX "unable to get major %d\n",
TISER_MAJOR);
+               return -EIO;
+       }
+
+       for (nr=0; nr<SP_NO; nr++) {
+               /*
+                 if (!request_region(serial_ports[nr], 8,
TISER_MODULE_NAME)) {
+                 printk(KERN_ERR PFX "unable to register port %#x\n",
serial_ports[nr]);
+                 continue;
+                 }*/
+
+               /* allocate and init our device structure */
+               tiser_dev[tiser_count] = kmalloc(sizeof (struct
tiser_dev_t), GFP_KERNEL);
+
+               if (tiser_dev[tiser_count] == NULL) {
+                       printk(KERN_ERR PFX "unable to kmalloc
(OOM?)\n");
+                       continue;
+               }
+               
+               sema_init(&tiser_dev[tiser_count]->open_sem, 1);
+               spin_lock_init(&tiser_dev[tiser_count]->lock);
+               tiser_dev[tiser_count]->port = serial_ports[nr];
+               tiser_dev[tiser_count]->minor = tiser_count;
+               tiser_dev[tiser_count]->delay = delay;
+               tiser_dev[tiser_count]->timeout = timeout;
+               sprintf(tiser_dev[tiser_count]->name, "tiser%d", nr);
+               tiser_count++;
+       }
+
+       if (!tiser_count)
+               goto out_devfs;
+
+       for(nr=0; nr<tiser_count; nr++) {
+               sprintf(name, "%d", nr);
+               devfs_register(devfs_handle, name,
+                              DEVFS_FL_DEFAULT, TISER_MAJOR, nr,
+                              S_IFCHR | S_IRUGO | S_IWUGO,
+                              &tiser_fops, NULL);
+       }
+
+       for(nr=0; nr<SP_NO; nr++) {
+               if(probe_ti_serial(tiser_dev[nr]) != -1)
+                       printk(KERN_INFO "%s: link cable found !\n",
tiser_dev[nr]->name);
+               else
+                       printk(KERN_INFO "%s: link cable not found (did
you plug the cable to calc ?).\n", tiser_dev[nr]->name);
+       }
+  
+       return 0;
+       
+ out_devfs:
+       devfs_unregister_chrdev(TISER_MAJOR, TISER_MODULE_NAME);
+       return -1;
+}
+
+void __exit tiser_cleanup_module(void)
+{
+       int i;
+
+       devfs_unregister(devfs_handle);
+       devfs_unregister_chrdev(TISER_MAJOR, TISER_MODULE_NAME);
+       
+       for(i=0; i<tiser_count; i++) {
+               //release_region(tiser_dev[i]->port, 8);
+               kfree(tiser_dev[i]);
+        }
+       
+       printk(KERN_DEBUG PFX "module unloaded.\n");
+}
+
+__setup("tiser=", tiser_setup);
+module_init(tiser_init_module);
+module_exit(tiser_cleanup_module);
+
+MODULE_AUTHOR("Author/Maintainer: Romain Lievin
<rosm@lpg.ticalc.org>");
+MODULE_DESCRIPTION("Device driver for TI/PC serial link cables");
+MODULE_LICENSE("GPL");
+
+EXPORT_NO_SYMBOLS;
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Timeout (default=1.5 seconds)");
+MODULE_PARM(delay, "i");
+MODULE_PARM_DESC(delay, "Inter-bit delay (default=10 microseconds)");
+
+
--- linux.orig/include/linux/ticable.h  Sat Mar 16 15:35:35 2002
+++ linux/include/linux/ticable.h       Sat Mar 16 15:37:43 2002
@@ -0,0 +1,41 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tipar/tiser/tiglusb - low level driver for handling link cables
+ * designed for Texas Instruments graphing calculators.
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * under the terms of the GNU General Public License.
+ */
+
+#ifndef TICABLE_H 
+#define TICABLE_H 1
+
+/* Internal default constants for the kernel module */
+#define TIMAXTIME 10      /* 1 seconds                         */
+#define IO_DELAY  10      /* 10 micro-seconds  */
+
+/* Major & minor number for character devices */
+#define TIPAR_MAJOR   61
+#define TIPAR_MINOR_0  1
+#define TIPAR_MINOR_1  2
+#define TIPAR_MINOR_2  3
+
+#define TISER_MAJOR   62
+#define TISER_MINOR_0  1
+#define TISER_MINOR_1  2
+#define TISER_MINOR_2  3
+#define TISER_MINOR_3  4
+
+/*
+ * Request values for the 'ioctl' function.
+ * Simply pass the appropriate value as arg of the ioctl call.
+ * These values do not conflict with other ones but they have to be
+ * allocated... (/usr/src/linux/Documentation/ioctl-number.txt).
+ */
+#define TIPAR_DELAY     _IOW('p', 0xa8, int) /* set delay   */
+#define TIPAR_TIMEOUT   _IOW('p', 0xa9, int) /* set timeout */
+
+#define TISER_DELAY     _IOW('p', 0xa0, int) /* set delay   */
+#define TISER_TIMEOUT   _IOW('p', 0xa1, int) /* set timeout */
+
+#endif /* TICABLE_H */

-- 
Romain LIEVIN aka Roms, mail: roms@lpg.ticalc.org
web: http://lpg.ticalc.org/prj_tilp (on www.ticalc.org)
ICQ: 43585029 (GtkIcq0.60/Linux)
