Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312372AbSCaUa3>; Sun, 31 Mar 2002 15:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312395AbSCaUaN>; Sun, 31 Mar 2002 15:30:13 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:54684 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S312372AbSCaU3x>; Sun, 31 Mar 2002 15:29:53 -0500
Message-ID: <3CA7721B.6D28983D@free.fr>
Date: Sun, 31 Mar 2002 22:31:23 +0200
From: Romain =?iso-8859-1?Q?Li=E9vin?= <rlievin@free.fr>
Reply-To: roms@lpg.ticalc.org
Organization: LPG (Linux Programmer Group) on ticalc.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subject: kernel 2.5.7, tiusb: SilverLink cable driver for TI 
 graphing calculators
In-Reply-To: <3CA6E759.CE70B34D@free.fr> <20020331180800.GE26801@kroah.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > this is a new driver for handling a TI-GRAPH LINK USB (aka SilverLink)
> > cable
> > designed to connect a Texas Instruments graphing calculators to a
> > computer/workstation through USB.
> >
> > This driver has an official device number.
> 
> Do you want to add this driver to the drivers/usb/ directory with the
> rest of the kernel USB drivers?  If so, please send me a patch.

Yes, I would like to add it. You will find the complete patch below.
BTW, I recently requested device numbers to John Cagle for 3 TI related
modules. The USB module shares its major with the others.

> 115 char        TI link cable devices (115 was formerly the console driver speaker)
>                   0 = /dev/tipar0    Parallel cable on first parallel port
>                   ...
>                   7 = /dev/tipar7    Parallel cable on seventh parallel port
> 
>                   8 = /dev/tiser0    Serial cable on first serial port
>                   ...
>                  15 = /dev/tiser7    Serial cable on seventh serial port
> 
>                  16 = /dev/tiusb0    First USB cable
>                   ...
>                  47 = /dev/tiusb31   32nd USB cable

I do not know whether it's the best thing to do. The 2 others use the
same bit-banging scheme and could be grouped under a sub-system (such as
I2C). The USB module is different. Maybe it's better to register it
under the USB sub-system...

Thanks, Romain.


==============================[ cut here ]==============================
--- linux.orig/drivers/usb/tiglusb.c    Sun Mar 31 22:02:56 2002
+++ linux/drivers/usb/tiglusb.c Sun Mar 31 22:05:05 2002
@@ -0,0 +1,524 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tiglusb -- Texas Instruments' USB GraphLink (aka SilverLink) driver.
+ * Target: Texas Instruments graphing calculators
(http://lpg.ticalc.org).
+ *      
+ * Copyright (C) 2001-2002: 
+ *   Romain Lievin <roms@lpg.ticalc.org>
+ *   Julien BLACHE <jb@technologeek.org>
+ * under the terms of the GNU General Public License.
+ *
+ * Based on dabusb.c, printer.c & scanner.c
+ *
+ * Please see the file: linux/Documentation/usb/SilverLink.txt 
+ * and the website at:  http://lpg.ticalc.org/prj_usb/
+ * for more info.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/socket.h>
+#include <linux/miscdevice.h>
+#include <linux/list.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+#include <linux/delay.h>
+#include <linux/usb.h>
+#include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
+
+#include <linux/ticable.h>
+#include "tiglusb.h"
+
+/*
+ * Version Information
+ */
+#define DRIVER_VERSION "1.02"
+#define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org> & Julien
Blache <jb@jblache.org>"
+#define DRIVER_DESC    "TI-GRAPH LINK USB (aka SilverLink) driver"
+#define DRIVER_LICENSE "GPL"
+
+#define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
+#if LINUX_VERSION_CODE < VERSION(2,5,0)
+# define minor(x) MINOR(x)
+#endif
+
+/* ----- global variables ---------------------------------------------
*/
+
+static tiglusb_t tiglusb[MAXTIGL];
+static int timeout = TIMAXTIME;     /* timeout in tenth of seconds    
*/
+
+static devfs_handle_t devfs_handle;
+
+/*---------- misc functions
-----------------------------------------------*/
+
+/* Unregister device */
+static void usblp_cleanup (tiglusb_t *s)
+{
+       devfs_unregister (s->devfs);
+       //memset(tiglusb[s->minor], 0, sizeof(tiglusb_t));
+       info ("tiglusb%d removed", s->minor);
+}
+
+/* Re-initialize device */
+static int clear_device(struct usb_device *dev)
+{
+       if (usb_set_configuration (dev,
dev->config[0].bConfigurationValue) < 0)
+       {
+               printk("tiglusb: clear_device failed\n");
+               return -1;
+       }
+       
+       return 0;
+}
+
+/* Clear input & output pipes (endpoints) */
+static int clear_pipes(struct usb_device *dev)
+{
+       unsigned int pipe;
+       
+       pipe = usb_sndbulkpipe (dev, 1);
+       if(usb_clear_halt(dev, usb_pipeendpoint(pipe))) {
+               printk("tiglusb: clear_pipe (r), request failed\n");
+               return -1;
+       }
+  
+       pipe = usb_sndbulkpipe (dev, 2);
+       if(usb_clear_halt(dev, usb_pipeendpoint(pipe))) {
+               printk("tiglusb: clear_pipe (w), request failed\n");
+               return -1;
+       }
+       
+       return 0;
+}
+
+/* ----- kernel module functions---------------------------------------
*/
+
+// ok
+static int tiglusb_open(struct inode *inode, struct file *file)
+{
+       int devnum = minor(inode->i_rdev);
+       ptiglusb_t s;
+
+       if (devnum < TIUSB_MINOR || devnum >= (TIUSB_MINOR + MAXTIGL))
+               return -EIO;
+       
+       s = &tiglusb[devnum - TIUSB_MINOR];
+
+       down(&s->mutex);
+
+       while (!s->dev || s->opened) {
+               up (&s->mutex);
+               
+               if (file->f_flags & O_NONBLOCK) {
+                       return -EBUSY;
+               }
+               schedule_timeout (HZ / 2);
+               
+               if (signal_pending (current)) {
+                       return -EAGAIN;
+               }
+               down (&s->mutex);
+       }
+
+       s->opened = 1;
+       up(&s->mutex);
+       
+       file->f_pos = 0;
+       file->private_data = s;
+
+       return 0;
+}
+
+//ok
+static int tiglusb_release(struct inode *inode, struct file *file)
+{
+       ptiglusb_t s = (ptiglusb_t) file->private_data;
+       
+       lock_kernel();
+       down (&s->mutex);
+       s->state = _stopped;
+       up (&s->mutex);
+
+       if (!s->remove_pending)
+               clear_device(s->dev);
+       else
+               wake_up (&s->remove_ok);
+
+       s->opened = 0;
+       unlock_kernel();
+
+       return 0;
+}
+
+//
+static ssize_t tiglusb_read(struct file *file, char *buf, 
+                           size_t count, loff_t * ppos)
+{
+       ptiglusb_t s = (ptiglusb_t) file->private_data;
+       ssize_t ret = 0;
+       int bytes_to_read = 0;
+       int bytes_read = 0;
+       int result = 0;
+       char buffer[BULK_RCV_MAX];
+       unsigned int pipe;
+
+       if (*ppos)
+               return -ESPIPE;
+       
+       if (s->remove_pending)
+               return -EIO;
+       
+       if (!s->dev)
+               return -EIO;
+       
+       bytes_to_read = (count >= BULK_RCV_MAX) ? BULK_RCV_MAX : count;
+
+       pipe = usb_rcvbulkpipe (s->dev, 1);
+        result = usb_bulk_msg(s->dev, pipe, buffer, bytes_to_read, 
+                             &bytes_read, HZ/(timeout/10));
+       if (result == -ETIMEDOUT) { /* NAK */
+               ret = result;
+               if(!bytes_read) {
+                       printk("quirk !\n");
+               }
+               warn("tiglusb_read, NAK received.");
+               goto out;
+       } 
+       else if (result == -EPIPE) { /* STALL -- shouldn't happen */
+               warn("CLEAR_FEATURE request to remove STALL
condition.\n");
+                if(usb_clear_halt(s->dev, usb_pipeendpoint(pipe)))
+                        warn("send_packet, request failed\n");
+                //clear_device(s->dev);
+               ret = result;
+               goto out;
+       }
+       else if (result < 0) { /* We should not get any I/O errors */
+               warn("funky result: %d. Please notify maintainer.",
result);
+               ret = -EIO;
+               goto out;
+       }
+
+       if (copy_to_user(buf, buffer, bytes_read)) {
+               ret = -EFAULT;
+               goto out;
+       }
+  
+ out:
+       return ret ? ret : bytes_read; 
+}
+
+//
+static ssize_t tiglusb_write(struct file *file, const char *buf, 
+                            size_t count, loff_t * ppos)
+{
+       ptiglusb_t s = (ptiglusb_t) file->private_data;
+       ssize_t ret = 0;
+       int bytes_to_write = 0;
+       int bytes_written = 0;
+       int result = 0;
+       char buffer[BULK_SND_MAX];
+       unsigned int pipe;
+       
+       if (*ppos)
+               return -ESPIPE;
+       
+       if (s->remove_pending)
+               return -EIO;
+       
+       if (!s->dev)
+               return -EIO;
+       
+       bytes_to_write = (count >= BULK_SND_MAX) ? BULK_SND_MAX : count;
+       if (copy_from_user(buffer, buf, bytes_to_write)) {
+               ret = -EFAULT;
+               goto out;
+       }
+       
+       pipe = usb_sndbulkpipe (s->dev, 2);
+        result = usb_bulk_msg(s->dev, pipe, buffer, bytes_to_write, 
+                             &bytes_written, HZ/(timeout/10));
+
+       if (result == -ETIMEDOUT) { /* NAK */
+               warn("tiglusb_write, NAK received.");
+               ret = result;
+               goto out;
+       }
+       else if (result == -EPIPE) { /* STALL -- shouldn't happen */
+                warn("CLEAR_FEATURE request to remove STALL
condition.\n");
+                if(usb_clear_halt(s->dev, usb_pipeendpoint(pipe)))
+                        warn("send_packet, request failed\n");
+               //clear_device(s->dev);
+               ret = result;
+               goto out;
+       }
+       else if (result < 0) { /* We should not get any I/O errors */
+               warn("funky result: %d. Please notify maintainer.",
result);
+               ret = -EIO;
+               goto out;
+       }
+       
+       if (bytes_written != bytes_to_write) {
+               ret = -EIO;
+               goto out;
+       } 
+       
+ out:
+       return ret ? ret : bytes_written;
+}
+
+//ok
+static int tiglusb_ioctl(struct inode *inode, struct file *file,
+                             unsigned int cmd, unsigned long arg)
+{
+       ptiglusb_t s = (ptiglusb_t) file->private_data;
+       int ret = 0;    
+
+       if (s->remove_pending)
+               return -EIO;
+       
+       down (&s->mutex);
+
+       if (!s->dev) {
+               up (&s->mutex);
+               return -EIO;
+       }
+       
+       switch (cmd)
+       {
+       case IOCTL_TIUSB_TIMEOUT:
+               timeout = arg ; // timeout value is passed in tenth of
seconds
+               break;
+       case IOCTL_TIUSB_RESET_DEVICE:
+               printk(KERN_DEBUG "IOCTL_TIGLUSB_RESET_DEVICE\n");
+               if(clear_device(s->dev))
+                       ret = -EIO;
+               break;
+       case IOCTL_TIUSB_RESET_PIPES:
+               printk(KERN_DEBUG "IOCTL_TIGLUSB_RESET_PIPES\n");
+               if(clear_pipes(s->dev))
+                       ret = -EIO;
+               break;
+       default:
+               ret = -ENOTTY;
+               break;
+       }
+       
+       up (&s->mutex);
+       

+       return ret;
+}
+
+/* ----- kernel module registering ------------------------------------
*/
+
+static struct file_operations tiglusb_fops =
+{
+       owner:   THIS_MODULE,
+       llseek:  no_llseek,
+       read:    tiglusb_read,
+       write:   tiglusb_write,
+       ioctl:   tiglusb_ioctl,
+       open:    tiglusb_open,
+       release: tiglusb_release,
+};
+
+//ok
+static int tiglusb_find_struct (void)
+{
+       int u;
+       
+       for (u=0; u<MAXTIGL; u++) 
+       {
+               ptiglusb_t s = &tiglusb[u];
+               if (!s->dev)
+                       return u;
+       }
+       
+       return -1;
+}
+
+/* --- initialisation code ------------------------------------- */
+
+//ok
+static void *tiglusb_probe (struct usb_device *dev, unsigned int ifnum,
+                           const struct usb_device_id *id)
+{
+       int minor;
+       ptiglusb_t s;
+       char name[8];
+       
+       printk("tiglusb: probing vendor id 0x%x, device id 0x%x
ifnum:%d\n",
+              dev->descriptor.idVendor, dev->descriptor.idProduct,
ifnum);
+       
+       /* 
+        * We don't handle multiple configurations. As of version 0x0103
of 
+        * the TIGL hardware, there's only 1 configuration. 
+        */
+       
+       if (dev->descriptor.bNumConfigurations != 1)
+               return NULL;
+       
+       if ((dev->descriptor.idProduct != 0xe001) && 
+           (dev->descriptor.idVendor != 0x451))
+               return NULL;
+       
+       if (usb_set_configuration (dev,
dev->config[0].bConfigurationValue) < 0) {
+               printk("tiglusb_probe: set_configuration failed\n");
+               return NULL;
+       }
+       
+       minor = tiglusb_find_struct ();
+       if (minor == -1)
+               return NULL;
+       
+       s = &tiglusb[minor];
+
+       down (&s->mutex);
+       s->remove_pending = 0;
+       s->dev = dev;    
+       up (&s->mutex);
+       dbg("bound to interface: %d", ifnum);
+       
+       sprintf(name, "%d", s->minor);
+       printk("tiglusb: registering to devfs : major = %d, minor = %d,
node = %s\n", TIUSB_MAJOR, (TIUSB_MINOR + s->minor), name);  
+       s->devfs = devfs_register(devfs_handle, name,
+                                 DEVFS_FL_DEFAULT, TIUSB_MAJOR,
+                                 TIUSB_MINOR + s->minor,
+                                 S_IFCHR | S_IRUGO | S_IWUGO,
+                                 &tiglusb_fops, NULL);
+       
+       /* Display firmware version */
+       printk("tiglusb: link cable version %i.%02x\n",
+              dev->descriptor.bcdDevice >> 8,
+              dev->descriptor.bcdDevice & 0xff);
+       
+       return s;
+}
+
+//ok
+static void tiglusb_disconnect (struct usb_device *dev, void
*drv_context)
+{
+       ptiglusb_t s = (ptiglusb_t) drv_context;
+       
+       if (!s || !s->dev) 
+               printk("bogus disconnect");
+       
+       s->remove_pending = 1;
+       wake_up (&s->wait);
+       if (s->state == _started)
+               sleep_on (&s->remove_ok);
+       s->dev = NULL;
+       s->opened = 0;
+       
+       /* cleanup now or later, on close*/
+       if (!s->opened)
+               usblp_cleanup (s);
+       else
+               up (&s->mutex);
+       
+       /* unregister device */
+       devfs_unregister(s->devfs); s->devfs = NULL;
+       printk("tiglusb: device disconnected\n");
+}
+
+static struct usb_device_id tiglusb_ids [] = {
+       { USB_DEVICE(0x0451, 0xe001) },
+       { }
+};
+
+MODULE_DEVICE_TABLE (usb, tiglusb_ids);
+
+static struct usb_driver tiglusb_driver =
+{
+       name:       "tiglusb",
+       probe:      tiglusb_probe,
+       disconnect: tiglusb_disconnect,
+       fops:       &tiglusb_fops,
+       minor:      TIUSB_MINOR,
+       id_table:   tiglusb_ids,
+};
+
+/* --- initialisation code ------------------------------------- */
+
+#ifndef MODULE
+/*      You must set these - there is no sane way to probe for this
cable.
+ *      You can use 'tipar=timeout,delay' to set these now. */
+static int __init tiglusb_setup (char *str)
+{
+        int ints[2];
+
+        str = get_options (str, ARRAY_SIZE(ints), ints);
+
+        if (ints[0] > 0) {
+                timeout = ints[1];
+        }
+
+        return 1;
+}
+#endif
+
+static int __init tiglusb_init (void)
+{
+       unsigned u;
+       int result;
+
+       /* initialize struct */
+       for (u = 0; u < MAXTIGL; u++)
+       {
+               ptiglusb_t s = &tiglusb[u];
+               memset (s, 0, sizeof (tiglusb_t));
+               init_MUTEX (&s->mutex);
+               s->dev = NULL;
+               s->minor = u;
+               s->opened = 0;
+               init_waitqueue_head (&s->wait);
+               init_waitqueue_head (&s->remove_ok);
+       }
+
+       /* register device */
+       if (devfs_register_chrdev (TIUSB_MAJOR, "tiglusb",
&tiglusb_fops)) {
+           printk("tiglusb: unable to get major %d\n", TIUSB_MAJOR);
+           return -EIO;
+        }
+
+       /* Use devfs, tree: /dev/ticables/usb/[0..3]*/
+        devfs_handle = devfs_mk_dir(NULL, "ticables/usb", NULL);
+       
+       /* register USB module */
+       result = usb_register(&tiglusb_driver);
+       if (result < 0) {
+           devfs_unregister_chrdev(TIUSB_MAJOR, "tiglusb");
+           return -1;
+       }
+       
+       info(DRIVER_DESC ", " DRIVER_VERSION);
+
+       return 0;
+}
+
+static void __exit tiglusb_cleanup (void)
+{
+       usb_deregister (&tiglusb_driver);
+       devfs_unregister (devfs_handle);
+        devfs_unregister_chrdev(TIUSB_MAJOR, "tiglusb");
+}
+
+/*
--------------------------------------------------------------------- */
+
+__setup("tipar=", tiglusb_setup);
+module_init(tiglusb_init);
+module_exit(tiglusb_cleanup);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE(DRIVER_LICENSE);
+
+EXPORT_NO_SYMBOLS;
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Timeout (default=1.5 seconds)");
+
+/*
--------------------------------------------------------------------- */
--- linux.orig/drivers/usb/tiglusb.h    Sun Mar 31 22:02:57 2002
+++ linux/drivers/usb/tiglusb.h Sun Mar 31 22:05:05 2002
@@ -0,0 +1,58 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tiglusb - low level driver for SilverLink cable
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * under the terms of the GNU General Public License.
+ *
+ * Redistribution of this file is permitted under the terms of the GNU
+ * Public License (GPL)
+ */
+
+#ifndef _TIGLUSB_H
+#define _TIGLUSB_H
+
+/*
+ * Max. number of devices supported
+ */
+#define MAXTIGL 16
+
+/*
+ * Max. packetsize for IN and OUT pipes
+ */
+#define BULK_RCV_MAX 32
+#define BULK_SND_MAX 32
+
+/*
+ * The driver context...
+ */
+
+typedef enum { _stopped=0, _started } driver_state_t;
+
+typedef struct
+{
+       struct usb_device *dev;        /* USB device handle */
+       struct semaphore  mutex;       /* locks this struct */
+       struct semaphore  sem;
+       
+       wait_queue_head_t wait;        /* for timed waits */
+       wait_queue_head_t remove_ok;   
+       
+       int minor;                     /* which minor dev #? */
+       devfs_handle_t devfs;          /* devfs device */
+
+       driver_state_t state;          /* started/stopped */
+       int opened;                    /* tru if open */
+       int remove_pending;            
+
+       struct urb readurb, writeurb;  /* The urbs */
+       int wcomplete, rcomplete;      /* R/W is complete */
+
+       char rd_buf[BULK_RCV_MAX];     /* read  buffer */
+       char wr_buf[BULK_SND_MAX];     /* write buffer */
+       
+} tiglusb_t, *ptiglusb_t;
+
+extern devfs_handle_t usb_devfs_handle;                 /* /dev/usb
dir. */
+
+#endif
--- linux.orig/include/linux/ticable.h  Sun Mar 31 22:05:42 2002
+++ linux/include/linux/ticable.h       Sun Mar 31 22:05:53 2002
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
+++ linux/MAINTAINERS   Sun Mar 31 22:01:20 2002
@@ -1502,6 +1502,13 @@
 M:     hch@infradead.org
 S:     Maintained
 
+TI GRAPH LINK USB (SilverLink) CABLE DRIVER
+P:     Romain Lievin
+M:     roms@lpg.ticalc.org
+P:     Julien Blache
+M:     jb@technologeek.org
+S:     Maintained
+
 TLAN NETWORK DRIVER
 P:     Torben Mathiasen
 M:     torben.mathiasen@compaq.com
--- linux.orig/drivers/usb/Config.help  Mon Mar 18 21:37:13 2002
+++ linux/drivers/usb/Config.help       Sun Mar 31 22:09:36 2002
@@ -626,3 +626,21 @@
   The module will be called bluetooth.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_USB_TIGL
+  If you own a Texas Instruments graphing calculator and use a 
+  TI-GRAPH LINK USB cable (aka SilverLink), then you might be 
+  interested in this driver.
+
+  If you enable this driver, you will be able to communicate with
+  your calculator through a set of device nodes under /dev.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called tiglusb.o. If you want to compile it as a
+  module, say M here and read Documentation/modules.txt.
+
+  If you don't know what the SilverLink cable is or what a Texas
+  Instruments graphing calculator is, then you probably don't need this
+  driver.
+
+  If unsure, say N.
\ No newline at end of file
--- linux.orig/drivers/usb/Config.in    Mon Mar 18 21:37:13 2002
+++ linux/drivers/usb/Config.in Sun Mar 31 22:00:49 2002
@@ -101,6 +101,7 @@
    comment 'USB Miscellaneous drivers'
    dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)'
CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Auerswald ISDN support (EXPERIMENTAL)'
CONFIG_USB_AUERSWALD $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate 'Texas Instruments Graph Link USB (aka SilverLink)
cable support' CONFIG_USB_TIGL $CONFIG_USB
 
 fi
 endmenu
--- linux.orig/drivers/usb/Makefile     Mon Mar 18 21:37:18 2002
+++ linux/drivers/usb/Makefile  Sun Mar 31 22:01:46 2002
@@ -86,6 +86,7 @@
 obj-$(CONFIG_USB_BLUETOOTH)    += bluetooth.o
 obj-$(CONFIG_USB_USBNET)       += usbnet.o
 obj-$(CONFIG_USB_AUERSWALD)    += auerswald.o
+obj-$(CONFIG_USB_TIGL)          += tiglusb.o
 
 # Object files in subdirectories
 mod-subdirs    := serial hcd
--- linux.orig/Documentation/usb/silverlink.txt Sun Mar 31 22:02:45 2002
+++ linux/Documentation/usb/silverlink.txt      Sun Mar 31 22:07:08 2002
@@ -0,0 +1,80 @@
+-------------------------------------------------------------------------
+Readme for Linux device driver for the Texas Instruments SilverLink
cable
+-------------------------------------------------------------------------
+
+Author: Romain Liévin & Julien Blache
+Homepage: http://lpg.ticalc.org/prj_usb
+
+INTRODUCTION:
+
+This is a driver for the TI-GRAPH LINK USB (aka SilverLink) cable, a
cable 
+designed by TI for connecting their TI8x/9x calculators to a computer 
+(PC or Mac usually).
+
+If you need more information, please visit the 'SilverLink drivers'
homepage 
+at the above URL.
+
+WHAT YOU NEED:
+
+A TI calculator of course and a program capable to communicate with
your 
+calculator.
+TiLP will work for sure (since I am his developer !). yal92 may be able
to use
+it by changing tidev for tiglusb (may require some hacking...).
+
+HOW TO USE IT:
+
+You must have first compiled USB support, support for your specific USB
host
+controller (UHCI or OHCI).
+
+Next, (as root) from your appropriate modules directory
(lib/modules/2.5.XX):
+
+       insmod usb/usbcore.o
+       insmod usb/usb-uhci.o  <OR>  insmod usb/ohci-hcd.o
+       insmod tiglusb.o
+
+If it is not already there (it usually is), create the device:
+
+       mknod /dev/tiglusb0 c 115 16
+
+You will have to set permissions on this device to allow you to
read/write
+from it:
+
+       chmod 666 /dev/tiglusb0
+       
+Now you are ready to run a linking program such as TiLP. Be sure to
configure 
+it properly (RTFM).
+       
+MODULE PARAMETERS:
+
+  You can set these with:  insmod tiglusb NAME=VALUE
+  There is currently no way to set these on a per-cable basis.
+
+  NAME: timeout
+  TYPE: integer
+  DEFAULT: 15
+  DESC: Timeout value in tenth of seconds. If no data is available once
this 
+       time has expired then the driver will return with a timeout
error.
+
+QUIRKS:
+
+The following problem seems to be specific to the link cable since it
appears 
+on all platforms (Linux, Windows, Mac OS-X). 
+
+In some very particular cases, the driver returns with success but
+without any data. The application should retry a read operation at
least once.
+
+HOW TO CONTACT US:
+
+You can email me at roms@lpg.ticalc.org. Please prefix the subject line
+with "TIGLUSB: " so that I am certain to notice your message.
+You can also mail JB at jb@jblache.org: he has written the first
release of 
+this driver but he better knows the Mac OS-X driver.
+
+CREDITS:
+
+The code is based on dabusb.c, printer.c and scanner.c !
+The driver has been developed independantly of Texas Instruments.
