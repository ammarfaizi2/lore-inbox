Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311315AbSCMU3B>; Wed, 13 Mar 2002 15:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311247AbSCMU2z>; Wed, 13 Mar 2002 15:28:55 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:15085 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S311315AbSCMU2k>; Wed, 13 Mar 2002 15:28:40 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: your mail
Message-ID: <1016051318.3c8fb67699ae8@imp.free.fr>
Date: Wed, 13 Mar 2002 21:28:38 +0100 (MET)
From: =?ISO-8859-1?Q?Romain_Li=E9vin?= <rlievin@free.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16lEeq-0007F3-00@the-village.bc.nu>
In-Reply-To: <E16lEeq-0007F3-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.42
X-Originating-IP: 195.220.37.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

> > It has been tested on x86 for almost 2 years and on Alpha & Sparc too
> with 
> > various calculators.
> 
> One oddity - some other comments
> 
> > +static int tipar_open(struct inode *inode, struct file *file)
> > +{
> > +       unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR_0;
> > +
> > +       if (minor >= PP_NO)
> > +               return -ENXIO;  
> > +       
> > +       init_ti_parallel(minor);
> > +
> > +       MOD_INC_USE_COUNT;
> 
> You should remove these and use in 2.4 + . Also what stops multiple
> simultaneous runs of init_ti_parallel if two people open it at once ?
> 
> 
> > +static unsigned int tipar_poll(struct file *file, poll_table *
> wait)
> > +{
> > +       unsigned int mask=0;
> > +       return mask;
> > +}
> 
> That seems unfinished ??
> 
> > +static int tipar_ioctl(struct inode *inode, struct file *file,
> > +                      unsigned int cmd, unsigned long arg)
> > +       case O_NONBLOCK:
> > +               file->f_flags |= O_NONBLOCK;
> > +               return 0;
> 
> O_NDELAY is set by fcntl - your driver never needs this.
> 
> > +       default:
> > +               retval = -EINVAL;
> 
> SuS says -ENOTTY here (lots of drivers get this wrong still)
> 
> > +static long long tipar_lseek(struct file * file, long long offset,
> int origin)
> > +{
> > +       return -ESPIPE;
> > +}
> 
> There is a generic no_llseek function
> 
> > +/* Major & minor number for character devices */
> > +#define TIPAR_MAJOR   61
> 
> These don't appear to be officially assigned via lanana ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Fixed some stuffs according to your remarks.

Comments are welcome...

=================== [ cuts here ] =====================
--- linux.orig/drivers/char/tipar.c     Wed Mar 13 19:19:10 2002
+++ linux/drivers/char/tipar.c  Wed Mar 13 21:24:51 2002
@@ -0,0 +1,543 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tipar - low level driver for handling a parallel link cable
+ * designed for Texas Instruments graphing calculators.
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * under the terms of the GNU General Public License.
+ */
+
+#define VERSION "1.12"
+
+/* This driver should, in theory, work with any parallel port that has an
+ * appropriate low-level driver; all I/O is done through the parport
+ * abstraction layer.
+ *
+ * If this driver is built into the kernel, you can configure it using the
+ * kernel command-line.  For example:
+ *
+ *      tipar=timeout,delay       (set timeout and delay)
+ *
+ * If the driver is loaded as a module, similar functionality is available
+ * using module parameters.  The equivalent of the above commands would be:
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
+ * This driver, by default, binds tipar devices according to parport and
+ * the minor number.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <asm/io.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/parport.h> /* Our code depend on parport */
+
+/*
+ * TI definitions
+ */
+#include <linux/ticable.h>
+
+/*
+ * Deal with CONFIG_MODVERSIONS
+ */
+#if 0 /* Pb with MODVERSIONS */
+#if CONFIG_MODVERSIONS==1
+#define MODVERSIONS
+#include <linux/modversions.h>
+#endif
+#endif
+
+/* ----- global variables --------------------------------------------- */
+
+struct tipar_struct {
+       struct pardevice *dev;                  /* Parport device entry */
+       int opened;
+};
+
+#define PP_NO 3
+struct tipar_struct  table[PP_NO];
+
+static int delay   = IO_DELAY;      /* inter-bit delay in microseconds */
+static int timeout = TIMAXTIME;     /* timeout in tenth of seconds     */
+
+static devfs_handle_t devfs_handle = NULL;
+static unsigned int tp_count = 0;   /* tipar_count */
+
+/* --- macros for parport access -------------------------------------- */
+
+#define r_dtr(x)        (parport_read_data(table[(x)].dev->port))
+#define r_str(x)        (parport_read_status(table[(x)].dev->port))
+#define w_ctr(x,y)      (parport_write_control(table[(x)].dev->port, (y)))
+#define w_dtr(x,y)      (parport_write_data(table[(x)].dev->port, (y)))
+
+/* --- setting states on the D-bus with the right timing: ------------- */
+
+static inline void outbyte(int value, int minor)
+{
+       w_dtr(minor, value);
+}
+
+static inline int inbyte(int minor)
+{
+       return (r_str(minor) & 0x30);
+}
+
+static inline void init_ti_parallel(int minor)
+{
+       outbyte(3, minor);
+}
+
+/* ----- global defines ----------------------------------------------- */
+
+#define START(x) { max=jiffies+HZ/(timeout/10); }
+#define WAIT(x) { if(!time_before(jiffies, (x))) return -1; schedule(); }
+
+/* ----- D-bus bit-banging functions ---------------------------------- */
+
+/* D-bus protocol:
+                    1                 0                      0
+       _______        ______|______    __________|________    __________
+Red  :        ________      |      ____          |        ____
+       _        ____________|________      ______|__________       _____
+White:  ________            |        ______      |          _______
+*/
+
+/* Try to transmit a byte on the specified port (-1 if error). */
+static int put_ti_parallel(int minor, unsigned char data)
+{
+       int bit, i;
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
+               data >>= 1;
+               for(i=0; i < delay; i++) {
+                       inbyte(minor);
+               }
+               schedule();
+       }
+       
+       return 0;
+}
+
+/* Receive a byte on the specified port or -1 if error. */
+static int get_ti_parallel(int minor)
+{
+       int bit,i;
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
+               for(i=0; i<delay; i++) {
+                       inbyte(minor);
+               }
+               schedule();
+       }
+       return (int)data;
+}
+
+/* Return non zero if both lines are at logical one */
+static int check_ti_parallel(int minor)
+{
+       return ((inbyte(minor) & 0x30) == 0x30);
+}
+
+/* Try to detect a parallel link cable on the specified port */
+static int probe_ti_parallel(int minor)
+{
+       int i, j;
+       int seq[]={ 0x00, 0x20, 0x10, 0x30 };
+       unsigned char data = 0;
+       
+       for(i=3; i>=0; i--) {
+               outbyte(3, minor);
+               outbyte(i, minor);
+               for(j=0; j<delay; j++) data = inbyte(minor);
+               /*printk("Probing -> %i: 0x%02x 0x%02x\n", i, data & 0x30,
seq[i]);*/
+               if( (data & 0x30) != seq[i]) {
+                       outbyte(3, minor);
+                       return -1;
+               }
+       } 
+       outbyte(3, minor);
+       return 0;
+}
+
+/* ----- kernel module functions--------------------------------------- */
+
+static int tipar_open(struct inode *inode, struct file *file)
+{
+       unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR_0;
+
+       if (minor >= PP_NO)
+               return -ENXIO;
+
+       if(table[minor].opened)
+               return -EBUSY;
+
+       table[minor].opened++;
+
+       lp_claim_parport_or_block(table[minor].dev);
+       init_ti_parallel(minor);
+       lp_release_parport(table[minor].dev);
+
+       return 0;
+}
+
+static int tipar_close(struct inode *inode, struct file *file)
+{
+       if (minor >= PP_NO)
+               return -ENXIO;
+
+       if(!table[minor].opened)
+               return -EFAULT;
+
+       table[minor].opened--;
+
+       return 0;
+}
+
+static ssize_t tipar_write(struct file *file,
+                          const char *buf, size_t count, loff_t *ppos)
+{
+       unsigned int minor = minor(file->f_dentry->d_inode->i_rdev) - 
+               TIPAR_MINOR_0;
+       ssize_t n;
+  
+       if (minor >= PP_NO)
+               return -ENXIO;
+
+       if (table[minor].dev == NULL) 
+               return -ENXIO;
+
+       parport_claim_or_block (table[minor].dev);
+       
+       for(n=0; n<count; n++) {
+               unsigned char b;
+               
+               if(get_user(b, buf + n)) {
+                       n = -EFAULT;
+                       goto out;
+               }
+
+               if(put_ti_parallel(minor, b) == -1) {
+                       init_ti_parallel(minor);
+                       n = -ETIMEDOUT;
+                       goto out;
+               }
+       }
+
+ out:
+       parport_release (table[minor].dev);
+       return n;
+}
+
+static ssize_t tipar_read(struct file *file, char *buf, 
+                         size_t count, loff_t *ppos)
+{
+       int b=0;
+       unsigned int minor=minor(file->f_dentry->d_inode->i_rdev) - 
+               TIPAR_MINOR_0;
+       ssize_t retval = 0;
+
+       if(count == 0)
+               return 0;
+
+       if(ppos != &file->f_pos)
+               return -ESPIPE;
+
+       parport_claim_or_block(table[minor].dev);
+  
+       do {
+               b = get_ti_parallel(minor);
+               if(b == -1) {
+                       init_ti_parallel(minor);
+                       retval = -ETIMEDOUT;
+                       goto out;
+               }
+               else
+                       break;
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
+               schedule();
+       } while (1);
+
+       retval = put_user(b, (unsigned char *)buf);
+       if(!retval)
+               retval = 1;
+       else
+               retval = -EFAULT;
+
+ out:
+       parport_release(table[minor].dev);
+       return retval;
+}
+
+static int tipar_ioctl(struct inode *inode, struct file *file,
+                      unsigned int cmd, unsigned long arg)
+{
+       unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR_0;
+       int retval = 0;
+
+       if (minor >= PP_NO) 
+               return -ENODEV;
+
+       switch (cmd) {
+       case 0:
+               break;
+       case TIPAR_DELAY:
+               delay = arg;
+               return 0;
+       case TIPAR_TIMEOUT:
+               timeout = arg;
+               return 0;
+       default:
+               retval = -ENOTTY;
+               break;
+       }
+
+       return retval;
+}
+
+static long long tipar_lseek(struct file * file, long long offset, int origin)
+{
+       return -ESPIPE;
+}
+
+
+/* ----- kernel module registering ------------------------------------ */
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
+/*      You must set these - there is no sane way to probe for this cable.
+ *      You can use tipar=timeout,delay to set these now. */
+static int __init tipar_setup (char *str)
+{
+       int ints[2];
+
+        str = get_options (str, ARRAY_SIZE(ints), ints);
+
+        if (ints[0] > 0) {
+                timeout = ints[1];
+                if(ints[0] > 1) {
+                        delay = ints[2];
+               }
+        }
+        return 1;
+}
+#endif
+
+/*
+ * Register our module into parport.
+ * Pass also 2 callbacks functions to parport: a pre-emptive function and an
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
+       devfs_register(devfs_handle, name,
+                       DEVFS_FL_AUTO_DEVNUM, TIPAR_MAJOR, nr,
+                       S_IFCHR | S_IRUGO | S_IWUGO,
+                       &tipar_fops, NULL);
+
+       /* Display informations */
+       printk(KERN_INFO "tipar%d: using %s (%s).\n", nr, port->name,
+              (port->irq == PARPORT_IRQ_NONE) ? "polling" :
"interrupt-driven");
+
+       if(probe_ti_parallel(nr) != -1)
+               printk("tipar%d: link cable found !\n", nr);
+       else
+               printk("tipar%d: link cable not found (do not plug cable to
calc).\n", nr);
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
+       if (!tipar_register(tp_count, port))
+               tp_count++;
+}
+
+static void tipar_detach (struct parport *port)
+{
+       /* Will be written at some point in the future */
+}
+
+static struct parport_driver tipar_driver = {
+       "tipar",
+       tipar_attach,
+       tipar_detach,
+       NULL
+};
+
+int tipar_init(void)
+{
+       unsigned int i;
+       
+       /* Initialize structure */
+       for (i = 0; i < PP_NO; i++) {
+               table[i].dev = NULL;
+               table[i].opened = 0;
+       }
+
+       /* Register parport device */  
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
+int __init tipar_init_module(void)
+{
+       printk("tipar: parallel link cable driver, version %s\n", VERSION);
+       return tipar_init();
+}
+
+void __exit tipar_cleanup_module(void)
+{
+       unsigned int offset;
+
+       /* Unregistering module */
+       parport_unregister_driver (&tipar_driver);
+
+       devfs_unregister (devfs_handle);
+       devfs_unregister_chrdev(TIPAR_MAJOR, "tipar");  
+
+       for (offset = 0; offset < PP_NO; offset++) {
+               if (table[offset].dev == NULL)
+                       continue;
+               parport_unregister_device(table[offset].dev);
+       }
+}
+
+__setup("tipar=", tipar_setup);
+module_init(tipar_init_module);
+module_exit(tipar_cleanup_module);
+
+MODULE_AUTHOR("Author/Maintainer: Romain Lievin <roms@lpg.ticalc.org>");
+MODULE_DESCRIPTION("Device driver for TI/PC parallel link cables");
+MODULE_LICENSE("GPL");
+
+EXPORT_NO_SYMBOLS;
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Timeout, default=1.5 seconds");
+MODULE_PARM(delay, "i");
+MODULE_PARM_DESC(delay, "Inter-bit delay, default=10 microseconds");
--- linux.orig/include/linux/ticable.h  Wed Mar 13 19:42:30 2002
+++ linux/include/linux/ticable.h       Wed Mar 13 21:25:03 2002
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


Romain.

---
Romain Liévin (aka roms)
http://lpg.ticalc.org/prj_tilp, prj_usb, prj_tidev, prj_gtktiemu
mail: roms@lpg.ticalc.org
