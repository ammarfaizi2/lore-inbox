Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310864AbSCaLiu>; Sun, 31 Mar 2002 06:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312525AbSCaLio>; Sun, 31 Mar 2002 06:38:44 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:44708 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S310864AbSCaLig>; Sun, 31 Mar 2002 06:38:36 -0500
Message-ID: <3CA6E751.F80F677F@free.fr>
Date: Sun, 31 Mar 2002 12:39:13 +0200
From: Romain =?iso-8859-1?Q?Li=E9vin?= <rlievin@free.fr>
Reply-To: roms@lpg.ticalc.org
Organization: LPG (Linux Programmer Group) on ticalc.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] kernel 2.5.7-pre2, tipar: TI graphing calculators
In-Reply-To: <E16mIFr-0006nb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Alan Cox wrote:
> 
> > according to various remarks, I improved the source code.
> > I submit it again for new comments & suggestions...
> 
> Looks good to me
> 
> > I mailed lanana on Thursday but no answer yet.
> 
> Ok

I got official device numbers for my modules. I think that's all right
for including this module in the current Linux kernel.
Patch is provided below.

Romain.

==============================[ cut here ]==============================
--- linux.orig/drivers/char/tipar.c     Sun Mar 31 11:14:04 2002
+++ linux/drivers/char/tipar.c  Sun Mar 31 12:06:41 2002
@@ -0,0 +1,513 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tipar - low level driver for handling a parallel link cable designed
+ * for Texas Instruments graphing calculators (http://lpg.ticalc.org).
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * under the terms of the GNU General Public License.
+ *
+ * Various fixes & clean-up from the Linux Kernel Mailing List
+ * (Alan Cox, Richard B. Johnson, Christoph Hellwig).
+ */
+
+/* This driver should, in theory, work with any parallel port that has
an
+ * appropriate low-level driver; all I/O is done through the parport
+ * abstraction layer.
+ *
+ * If this driver is built into the kernel, you can configure it using
the
+ * kernel command-line.  For example:
+ *
+ *      tipar=timeout,delay       (set timeout and delay)
+ *
+ * If the driver is loaded as a module, similar functionality is
available
+ * using module parameters.  The equivalent of the above commands would
be:
+ *
+ *      # insmod tipar.o tipar=15,10
+ */
+
+/* COMPATIBILITY WITH OLD KERNELS
+ *
+ * Usually, parallel cables were bound to ports at
+ * particular I/O addresses, as follows:
+ *
+ *      tipar0             0x378
+ *      tipar1             0x278
+ *      tipar2             0x3bc
+ *
+ *
+ * This driver, by default, binds tipar devices according to parport
and
+ * the minor number.
+ *
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
+#include <linux/parport.h>         /* Our code depend on parport */
+
+/*
+ * TI definitions
+ */
+#include "ticable.h" //#include <linux/ticable.h>
+
+/*
+ * Version Information
+ */
+#define DRIVER_VERSION "1.14"
+#define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org>"
+#define DRIVER_DESC    "Device driver for TI/PC parallel link cables"
+#define DRIVER_LICENSE "GPL"
+
+/* ----- global variables ---------------------------------------------
*/
+
+struct tipar_struct {
+       struct pardevice *dev;                  /* Parport device entry
*/
+};
+
+#define PP_NO 3
+static struct tipar_struct  table[PP_NO];
+
+static int delay   = IO_DELAY;      /* inter-bit delay in microseconds
*/
+static int timeout = TIMAXTIME;     /* timeout in tenth of seconds    
*/
+
+static devfs_handle_t devfs_handle;
+static unsigned int tp_count;       /* tipar count */
+static unsigned long opened;        /* opened devices */
+
+/* --- macros for parport access --------------------------------------
*/
+
+#define r_dtr(x)        (parport_read_data(table[(x)].dev->port))
+#define r_str(x)        (parport_read_status(table[(x)].dev->port))
+#define w_ctr(x,y)      (parport_write_control(table[(x)].dev->port,
(y)))
+#define w_dtr(x,y)      (parport_write_data(table[(x)].dev->port, (y)))
+
+/* --- setting states on the D-bus with the right timing: -------------
*/
+
+static inline void outbyte(int value, int minor)
+{
+       w_dtr(minor, value);
+}
+
+static inline int inbyte(int minor)
+{
+       return (r_str(minor));
+}
+
+static inline void init_ti_parallel(int minor)
+{
+       outbyte(3, minor);
+}
+
+/* ----- global defines -----------------------------------------------
*/
+
+#define START(x) { x=jiffies+HZ/(timeout/10); }
+#define WAIT(x)  { \
+  if (time_before((x), jiffies)) return -1; \
+  if (current->need_resched) schedule(); }
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
+static int put_ti_parallel(int minor, unsigned char data)
+{
+       int bit;
+       unsigned long max;
+       
+       for (bit=0; bit<8; bit++) {
+               if (data & 1) {
+                       outbyte(2, minor);
+                       START(max); 
+                       do {
+                               WAIT(max);
+                       } while (inbyte(minor) & 0x10);
+                       
+                       outbyte(3, minor);
+                       START(max);
+                       do {
+                               WAIT(max);
+                       } while (!(inbyte(minor) & 0x10));
+               } else {
+                       outbyte(1, minor);
+                       START(max);
+                       do {
+                               WAIT(max);
+                       } while (inbyte(minor) & 0x20);
+
+                       outbyte(3, minor);
+                       START(max);
+                       do {
+                               WAIT(max);
+                       } while (!(inbyte(minor) & 0x20));
+               }
+
+               data >>= 1;
+               udelay(delay);
+               
+               if(current->need_resched)
+                       schedule();
+       }
+       
+       return 0;
+}
+
+/* Receive a byte on the specified port or -1 if error. */
+static int get_ti_parallel(int minor)
+{
+       int bit;
+       unsigned char v, data=0;
+       unsigned long max;
+
+       for (bit=0; bit<8; bit++) {
+               START(max); 
+               do {
+                       WAIT(max);
+               } while ((v=inbyte(minor) & 0x30) == 0x30);
+      
+               if (v == 0x10) { 
+                       data=(data>>1) | 0x80;
+                       outbyte(1, minor);
+                       START(max);
+                       do {
+                               WAIT(max);
+                       } while (!(inbyte(minor) & 0x20));
+                       outbyte(3, minor);
+               } else {
+                       data=data>>1;
+                       outbyte(2, minor);
+                       START(max);
+                       do {
+                               WAIT(max);
+                       } while (!(inbyte(minor) & 0x10));
+                       outbyte(3, minor);
+               }
+
+               udelay(delay);          
+               if(current->need_resched)
+                        schedule();
+       }
+       
+       return (int)data;
+}
+
+/* Try to detect a parallel link cable on the specified port */
+static int probe_ti_parallel(int minor)
+{
+       int i;
+       int seq[]={ 0x00, 0x20, 0x10, 0x30 };
+       
+       for(i=3; i>=0; i--) {
+               outbyte(3, minor);
+               outbyte(i, minor);
+               udelay(delay);
+               /*printk(KERN_DEBUG "Probing -> %i: 0x%02x 0x%02x\n", i,
data & 0x30, seq[i]);*/
+               if ( (inbyte(minor) & 0x30) != seq[i]) {
+                       outbyte(3, minor);
+                       return -1;
+               }
+       } 
+       outbyte(3, minor);
+       return 0;
+}
+
+/* ----- kernel module functions---------------------------------------
*/
+
+static int tipar_open(struct inode *inode, struct file *file)
+{
+       unsigned int minor = MINOR(inode->i_rdev) - TIPAR_MINOR;
+
+       if (minor > tp_count-1)
+               return -ENXIO;  
+
+       if(test_and_set_bit(minor, &opened))
+               return -EBUSY;
+
+       parport_claim_or_block (table[minor].dev);
+       init_ti_parallel (minor);
+       parport_release (table[minor].dev);
+       
+       return 0;
+}
+
+static int tipar_close(struct inode *inode, struct file *file)
+{
+       unsigned int minor = MINOR(inode->i_rdev) - TIPAR_MINOR;
+
+       if (minor > tp_count-1)
+               return -ENXIO;
+
+       clear_bit(minor, &opened);
+       
+       return 0;
+}
+
+static ssize_t tipar_write(struct file *file,
+                          const char *buf, size_t count, loff_t *ppos)
+{
+       unsigned int
minor=MINOR(file->f_dentry->d_inode->i_rdev)-TIPAR_MINOR;
+       ssize_t n;
+  
+       parport_claim_or_block (table[minor].dev);
+       
+       for(n=0; n<count; n++) {
+               unsigned char b;
+               
+               if (get_user(b, buf + n)) {
+                       n = -EFAULT;
+                       goto out;
+               }
+
+               if (put_ti_parallel(minor, b) == -1) {
+                       init_ti_parallel(minor);
+                       n = -ETIMEDOUT;
+                       goto out;
+               }
+       }
+ out:
+       parport_release (table[minor].dev);
+       return n;
+}
+
+static ssize_t tipar_read(struct file *file, char *buf, 
+                         size_t count, loff_t *ppos)
+{
+       int b=0;
+       unsigned int
minor=MINOR(file->f_dentry->d_inode->i_rdev)-TIPAR_MINOR;
+       ssize_t retval = 0;
+       ssize_t n = 0;
+
+       if (count == 0)
+               return 0;
+
+       if (ppos != &file->f_pos)
+               return -ESPIPE;
+
+       parport_claim_or_block(table[minor].dev);
+  
+       while(n < count) {
+               b = get_ti_parallel(minor);
+               if (b == -1) {
+                       init_ti_parallel(minor);
+                       retval = -ETIMEDOUT;
+                       goto out;
+               }
+               else {
+                       if(put_user(b, ((unsigned char *)buf)+n)) {
+                               retval = -EFAULT;
+                               break;
+                       } else retval = n;
+               }
+      
+               /* Non-blocking mode: try again ! */
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
+               n++;
+               if(current->need_resched)
+                        schedule();
+       }
+
+ out:
+       parport_release(table[minor].dev);
+       return retval;
+}
+
+static int tipar_ioctl(struct inode *inode, struct file *file,
+                      unsigned int cmd, unsigned long arg)
+{
+       int retval = 0;
+
+       switch (cmd) {
+       case IOCTL_TIPAR_DELAY:
+               get_user(delay, &arg);
+               break;
+       case IOCTL_TIPAR_TIMEOUT:
+               get_user(timeout, &arg);
+               break;
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
+static struct file_operations tipar_fops = {
+       owner:   THIS_MODULE,
+       llseek:  no_llseek,
+       read:    tipar_read,
+       write:   tipar_write,
+       ioctl:   tipar_ioctl,
+       open:    tipar_open,
+       release: tipar_close,
+};
+
+/* --- initialisation code ------------------------------------- */
+
+#ifndef MODULE
+/*      You must set these - there is no sane way to probe for this
cable.
+ *      You can use 'tipar=timeout,delay' to set these now. */
+static int __init tipar_setup (char *str)
+{
+       int ints[2];
+       
+        str = get_options (str, ARRAY_SIZE(ints), ints);
+       
+        if (ints[0] > 0) {
+                timeout = ints[1];
+                if (ints[0] > 1) {
+                        delay = ints[2];
+               }
+        }
+       
+        return 1;
+}
+#endif
+
+/*
+ * Register our module into parport.
+ * Pass also 2 callbacks functions to parport: a pre-emptive function
and an
+ * interrupt handler function (unused).
+ * Display a message such "tipar0: using parport0 (polling)".
+ */
+static int tipar_register(int nr, struct parport *port)
+{
+       char name[8];
+       
+       /* Register our module into parport */
+       table[nr].dev = parport_register_device(port, "tipar",
+                                               NULL, NULL, NULL, 0,
+                                               (void *) &table[nr]);
+       
+       if (table[nr].dev == NULL)
+               return 1;
+ 
+       /* Use devfs, tree: /dev/ticables/par/[0..2] */
+       sprintf(name, "%d", nr);
+       printk("tipar: registering to devfs : major = %d, minor = %d,
node = %s\n", TISER_MAJOR, (TIPAR_MINOR + nr), name);
+       devfs_register(devfs_handle, name,
+                       DEVFS_FL_DEFAULT, TIPAR_MAJOR, TIPAR_MINOR + nr,
+                       S_IFCHR | S_IRUGO | S_IWUGO,
+                       &tipar_fops, NULL);
+
+       /* Display informations */
+       printk(KERN_INFO "tipar%d: using %s (%s).\n", nr, port->name,
+              (port->irq == PARPORT_IRQ_NONE) ? "polling" :
"interrupt-driven");
+
+       if (probe_ti_parallel(nr) != -1)
+               printk("tipar%d: link cable found !\n", nr);
+       else
+               printk("tipar%d: link cable not found.\n", nr);
+
+       return 0;
+}
+
+static void tipar_attach (struct parport *port)
+{
+       if (tp_count == PP_NO) {
+               printk("tipar: ignoring parallel port (max. %d)\n", 
+                      PP_NO);
+               return;
+       }
+
+       if (!tipar_register(tp_count, port))
+               tp_count++;
+}
+
+static void tipar_detach (struct parport *port)
+{
+       /* Nothing to do */
+}
+
+static struct parport_driver tipar_driver = {
+       "tipar",
+       tipar_attach,
+       tipar_detach,
+       NULL
+};
+
+int __init tipar_init_module(void)
+{
+       printk("tipar: parallel link cable driver, version %s\n",
DRIVER_VERSION);
+       
+       if (devfs_register_chrdev (TIPAR_MAJOR, "tipar", &tipar_fops)) {
+               printk("tipar: unable to get major %d\n", TIPAR_MAJOR);
+               return -EIO;
+       }
+
+       /* Use devfs with tree: /dev/ticables/par/[0..2] */
+       devfs_handle = devfs_mk_dir (NULL, "ticables/par", NULL);
+
+       if (parport_register_driver (&tipar_driver)) {
+               printk ("tipar: unable to register with parport\n");
+               return -EIO;
+       }
+
+       return 0;
+}
+
+void __exit tipar_cleanup_module(void)
+{
+       unsigned int i;
+
+       /* Unregistering module */
+       parport_unregister_driver (&tipar_driver);
+
+       devfs_unregister (devfs_handle);
+       devfs_unregister_chrdev(TIPAR_MAJOR, "tipar");  
+
+       for (i = 0; i < PP_NO; i++) {
+               if (table[i].dev == NULL)
+                       continue;
+               parport_unregister_device(table[i].dev);
+       }
+
+       printk("tipar: module unloaded !\n");
+}
+
+/*
--------------------------------------------------------------------- */
+
+__setup("tipar=", tipar_setup);
+module_init(tipar_init_module);
+module_exit(tipar_cleanup_module);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE(DRIVER_LICENSE);
+
+EXPORT_NO_SYMBOLS;
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Timeout (default=1.5 seconds)");
+MODULE_PARM(delay, "i");
+MODULE_PARM_DESC(delay, "Inter-bit delay (default=10 microseconds)");
--- linux.orig/include/linux/ticable.h  Sun Mar 31 11:14:23 2002
+++ linux/include/linux/ticable.h       Sun Mar 31 12:06:18 2002
@@ -0,0 +1,42 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tipar/tiser/tiusb - low level driver for handling link cables
+ * designed for Texas Instruments graphing calculators.
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ *
+ * Redistribution of this file is permitted under the terms of the GNU
+ * Public License (GPL)
+ */
+
+#ifndef _TICABLE_H 
+#define _TICABLE_H 1
+
+/* Internal default constants for the kernel module */
+#define TIMAXTIME 15      /* 1.5 seconds       */
+#define IO_DELAY  10      /* 10 micro-seconds  */
+
+/* Major & minor number for character devices */
+#define TIPAR_MAJOR  115 /* 0 to 7 */
+#define TIPAR_MINOR    0
+
+#define TISER_MAJOR  115 /* 8 to 15 */
+#define TISER_MINOR    8
+
+#define TIUSB_MAJOR  115  /* 16 to 31 */
+#define TIUSB_MINOR   16
+
+/*
+ * Request values for the 'ioctl' function.
+ */
+#define IOCTL_TIPAR_DELAY     _IOW('p', 0xa8, int) /* set delay   */
+#define IOCTL_TIPAR_TIMEOUT   _IOW('p', 0xa9, int) /* set timeout */
+
+#define IOCTL_TISER_DELAY     _IOW('p', 0xa0, int) /* set delay   */
+#define IOCTL_TISER_TIMEOUT   _IOW('p', 0xa1, int) /* set timeout */
+
+#define IOCTL_TIUSB_TIMEOUT        _IOW('N', 0x20, int) /* set timeout
*/
+#define IOCTL_TIUSB_RESET_DEVICE   _IOW('N', 0x21, int) /* reset device
*/
+#define IOCTL_TIUSB_RESET_PIPES    _IOW('N', 0x22, int) /* reset both
pipes*/
+
+#endif /* TICABLE_H */
--- linux.orig/MAINTAINERS      Mon Mar 18 21:37:04 2002
+++ linux/MAINTAINERS   Sun Mar 31 12:08:26 2002
@@ -1502,6 +1502,13 @@
 M:     hch@infradead.org
 S:     Maintained
 
+TI PARALLEL LINK CABLE DRIVER
+P:     Romain Lievin
+M:     roms@lpg.ticalc.org
+P:     Julien Blache
+M:     jb@technologeek.org
+S:     Maintained
+
 TLAN NETWORK DRIVER
 P:     Torben Mathiasen
 M:     torben.mathiasen@compaq.com
--- linux.orig/drivers/char/Config.help Mon Mar 18 21:37:13 2002
+++ linux/drivers/char/Config.help      Sun Mar 31 12:04:16 2002
@@ -595,6 +595,27 @@
 
   If unsure, say N.
 
+CONFIG_TIPAR
+  If you own a Texas Instruments graphing calculator and use a
+  parallel link cable, then you might be interested in this driver.
+
+  If you enable this driver, you will be able to communicate with
+  your calculator through a set of device nodes under /dev. The
+  main advantage of this driver is that you don't have to be root
+  to use this precise link cable (depending on the permissions on
+  the device nodes, though).
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called tipar.o. If you want to compile it as a
+  module, say M here and read Documentation/modules.txt.
+
+  If you don't know what a parallel link cable is or what a Texas
+  Instruments graphing calculator is, then you probably don't need this
+  driver.
+
+  If unsure, say N.
+
 CONFIG_BUSMOUSE
   Say Y here if your machine has a bus mouse as opposed to a serial
   mouse. Most people have a regular serial MouseSystem or
--- linux.orig/drivers/char/Config.in   Mon Mar 18 21:37:08 2002
+++ linux/drivers/char/Config.in        Sun Mar 31 12:04:56 2002
@@ -103,6 +103,7 @@
       bool '  Support for console on line printer' CONFIG_LP_CONSOLE
    fi
    dep_tristate 'Support for user-space parallel port device drivers'
CONFIG_PPDEV $CONFIG_PARPORT
+   dep_tristate 'Texas Instruments parallel link cable support'
CONFIG_TIPAR $CONFIG_PARPORT
 fi
 
 source drivers/i2c/Config.in
--- linux.orig/drivers/char/Makefile    Mon Mar 18 21:37:13 2002
+++ linux/drivers/char/Makefile Sun Mar 31 12:29:52 2002
@@ -208,6 +208,7 @@
 obj-$(CONFIG_DZ) += dz.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
+obj-$(CONFIG_TIPAR) += tipar.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
