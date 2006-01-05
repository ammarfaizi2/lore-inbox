Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWAEVIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWAEVIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWAEVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:08:17 -0500
Received: from [213.13.124.66] ([213.13.124.66]:35742 "EHLO mail.paradigma.pt")
	by vger.kernel.org with ESMTP id S932192AbWAEVIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:08:15 -0500
Date: Thu, 5 Jan 2006 21:07:51 +0000
From: Nuno Monteiro <nuno+lkml@itsari.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
Message-ID: <20060105210751.GC4332@hobbes.itsari.org>
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch> <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr> <43BD146B.2010308@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43BD146B.2010308@drugphish.ch> (from ratz@drugphish.ch on Thu, Jan 05, 2006 at 12:43:23 +0000)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006.01.05 12:43, Roberto Nibali wrote:
> I'll let you know if I need it; I reckon it might not be too 
> difficult to backport it anyway, so I can also do it myself ;).
> 

Hi,

I stumbled upon ttyrpld a couple weeks ago and thought it was pretty 
useful, to keep track of all actions performed on a couple of machines 
where only the admins have local accounts. Since I'm running a (heavily 
modified) custom 2.4.22 kernel, I took the version Jan offered for 
2.4.29 (in ttyrpld-2.03.5) and synced it up with the work he did on 
later versions. I think it's identical, functionality wise, to the 
patch he offered on ttyrpld 2.10. I also massaged it a bit so it would 
build statically into the kernel (my boxes don't have module support) 
and to get rid of the extra fluff -- the dependency on moduleparm.h 
which doesn't exit in 2.4.22, the BSD defines, the 2.6 defines, etc. 
Also, if built as a module, it'll be called 'rpl' instead of 'rpldev'.

I'm running it now on a couple boxes, with the latest userspace bits 
(libHX 1.74 and ttyrpld 2.10), and It Works For Me (tm). So, with that 
disclaimer out of the way, here's the patch. It's diffed against my 
custom 2.4.22 kernel, but should apply fairly well to any 2.4.

Regards,

		Nuno
-- 
Nuno Monteiro <nuno+spamtrap@itsari.org> pgp key 8DEF0334



diff -pruN a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	2006-01-04 23:54:15.000000000 +0000
+++ b/Documentation/Configure.help	2006-01-04 23:50:41.000000000 +0000
@@ -17464,6 +17464,19 @@ CONFIG_VT
   If unsure, say Y, or else you won't be able to do much with your new
   shiny Linux system :-)
 
+TTY logging via rpldev
+CONFIG_TTY_LOGGING
+   This allows you to log any traffic running over the TTY
+   driver. It is very useful because it cannot be fooled by empty
+   or bogus .bash_history entries, or even an SSH encrypted channel.
+
+   Saying yes to this option alone won't do you any good, though, as
+   it will only activate the kernel-side hooks & capture driver. You'll
+   also need the userspace bits, which are available at
+   http://ttyrpld.sourceforge.net
+
+   If unsure, say N.
+
 Support for console on virtual terminal
 CONFIG_VT_CONSOLE
   The system console is the device which receives all kernel messages
diff -pruN a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	2003-08-25 12:44:41.000000000 +0100
+++ b/drivers/char/Config.in	2006-01-05 00:10:29.000000000 +0000
@@ -11,6 +11,10 @@ if [ "$CONFIG_VT" = "y" ]; then
       bool '    Support for Lasi/Dino PS2 port' CONFIG_GSC_PS2
    fi
 fi
+tristate 'TTY logging via rpldev' CONFIG_TTY_LOGGING
+if [ "$CONFIG_TTY_LOGGING" = "y" -o "$CONFIG_TTY_LOGGING" = "m" ]; then
+    define_bool CONFIG_TTY_RPL y
+fi
 tristate 'Standard/generic (8250/16550 and compatible UARTs) serial support' CONFIG_SERIAL
 if [ "$CONFIG_SERIAL" = "y" ]; then
    bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
diff -pruN a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	2003-08-25 12:44:41.000000000 +0100
+++ b/drivers/char/Makefile	2006-01-05 09:59:57.000000000 +0000
@@ -303,6 +303,11 @@ obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_AMD7XX_TCO) += amd7xx_tco.o
 
+subdir-$(CONFIG_TTY_LOGGING) += rpl
+ifeq ($(CONFIG_TTY_LOGGING),y)
+  obj-y += rpl/rpl.o
+endif
+
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
   obj-y += mwave/mwave.o
diff -pruN a/drivers/char/rpl/Makefile b/drivers/char/rpl/Makefile
--- a/drivers/char/rpl/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/char/rpl/Makefile	2006-01-05 09:55:59.000000000 +0000
@@ -0,0 +1,18 @@
+#
+# Makefile for rpldev.
+#
+# This file is GPL. See other files for the full Blurb. I'm lazy today. 
+#
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile...
+
+O_TARGET := rpl.o
+
+obj-y   := rpldev.o
+obj-m   := $(O_TARGET)
+
+include $(TOPDIR)/Rules.make
diff -pruN a/drivers/char/rpl/rpldev.c b/drivers/char/rpl/rpldev.c
--- a/drivers/char/rpl/rpldev.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/char/rpl/rpldev.c	2006-01-05 16:35:19.000000000 +0000
@@ -0,0 +1,562 @@
+/*=============================================================================
+ttyrpld - TTY replay daemon
+kernel/rpldev.c - Kernel interface for RPLD
+  Copyright © Jan Engelhardt <jengelh [at] linux01 gwdg de>, 2004 - 2005
+  -- License restrictions apply (GPL v2)
+
+  This file is part of ttyrpld.
+  ttyrpld is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by
+  the Free Software Foundation; however ONLY version 2 of the License.
+
+  ttyrpld is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program kit; if not, write to:
+  Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
+  Boston, MA  02110-1301  USA
+
+  -- For details, see the file named "LICENSE.GPL2"
+=============================================================================*/
+#include <asm/byteorder.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/tty.h>
+#include <linux/wait.h>
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/km_rpldev.h>
+#include "rpl_ioctl.h"
+#include "rpl_packet.h"
+
+#ifndef __user
+#define __user
+#endif
+
+#define PREFIX "rpldev: "
+#define MAXFNLEN 256
+
+#define IS_PTY_MASTER(tty) \
+      (((tty)->driver.major >= UNIX98_PTY_MASTER_MAJOR && \
+      (tty)->driver.major < UNIX98_PTY_MASTER_MAJOR + \
+      UNIX98_PTY_MAJOR_COUNT) || (tty)->driver.major == PTY_MASTER_MAJOR)
+#define TTY_DEVNR(tty) \
+      cpu_to_le32(mkdev_26(MAJOR(tty->device), MINOR(tty->device)))
+#ifndef SEEK_SET
+#define SEEK_SET 0
+#endif
+#ifndef SEEK_CUR
+#define SEEK_CUR 1
+#endif
+#ifndef SEEK_END
+#define SEEK_END 2
+#endif
+#define SKIP_PTM(tty)   if(IS_PTY_MASTER(tty)) return 0;
+
+// Stage 2 functions
+static int krpl_init(struct tty_struct *, struct tty_struct *, struct file *);
+static int krpl_open(struct tty_struct *, struct tty_struct *, struct file *);
+static int krpl_read(const char __user *, size_t, struct tty_struct *);
+static int krpl_write(const char __user *, size_t, struct tty_struct *);
+/*static int krpl_ioctl(struct tty_struct *, struct tty_struct *, unsigned int,
+  unsigned long);*/
+static int krpl_close(struct tty_struct *, struct tty_struct *);
+static int krpl_deinit(struct tty_struct *, struct tty_struct *);
+
+// Stage 3 functions
+static int     urpl_open(struct inode *, struct file *);
+static ssize_t urpl_read(struct file *, char __user *, size_t, loff_t *);
+static loff_t  urpl_seek(struct file *, loff_t, int);
+static int     urpl_ioctl(struct inode *, struct file *, unsigned int,
+                          unsigned long);
+static unsigned int urpl_poll(struct file *, poll_table *);
+static int          urpl_close(struct inode *, struct file *);
+
+// Local functions
+static inline ssize_t avail_R(void);
+static inline ssize_t avail_W(void);
+static inline void fill_time(struct timeval *);
+static inline unsigned int min_uint(unsigned int, unsigned int);
+static inline uint32_t mkdev_26(unsigned long, unsigned long);
+static int mv_buffer(struct rpldev_packet *, const void *, size_t);
+static inline void mv_buffer2(const void *, size_t);
+static inline int mv_to_user(char __user *, size_t);
+
+// Variables
+static DECLARE_WAIT_QUEUE_HEAD(Pull_queue);
+static DECLARE_MUTEX(Buffer_lock);
+static DECLARE_MUTEX(Open_lock);
+static char *Buffer = NULL, *BufRP = NULL, *BufWP = NULL;
+static size_t Bufsize = 32 * 1024;
+static int Minor_nr = MISC_DYNAMIC_MINOR, Open_count = 0;
+
+// Kernel module info (kmi) stuff
+static struct file_operations kmi_fops = {
+    .open    = urpl_open,
+    .read    = urpl_read,
+    .llseek  = urpl_seek,
+    .ioctl   = urpl_ioctl,
+    .poll    = urpl_poll,
+    .release = urpl_close,
+    .owner   = THIS_MODULE,
+};
+static struct miscdevice kmi_miscinfo = {
+    .minor = MISC_DYNAMIC_MINOR,
+    .name  = "rpl",
+    .fops  = &kmi_fops,
+};
+
+MODULE_DESCRIPTION("ttyrpld Kernel interface");
+MODULE_AUTHOR("Jan Engelhardt <jengelh [at] linux01 gwdg de>");
+MODULE_LICENSE("GPL v2");
+MODULE_PARM_DESC(Bufsize, "Buffer size (default 32K)");
+MODULE_PARM_DESC(Minor_nr, "Minor number to use (default: 255(=DYNAMIC))");
+MODULE_PARM(Bufsize, "i");
+MODULE_PARM(Minor_nr, "i");
+EXPORT_NO_SYMBOLS;
+
+//-----------------------------------------------------------------------------
+__init extern int rpl_init_module(void) {
+    int eax;
+    kmi_miscinfo.minor = Minor_nr;
+    if((eax = misc_register(&kmi_miscinfo)) != 0)
+        return eax;
+    Minor_nr = kmi_miscinfo.minor; // give minor back to sysfs
+    printk(KERN_DEBUG PREFIX "registered at minor %d\n", Minor_nr);
+    return 0;
+}
+
+__exit extern void rpl_cleanup_module(void) {
+    misc_deregister(&kmi_miscinfo);
+    return;
+}
+
+module_init(rpl_init_module);
+module_exit(rpl_cleanup_module);
+
+//-----------------------------------------------------------------------------
+static int krpl_init(struct tty_struct *tty, struct tty_struct *ctl,
+ struct file *filp)
+{
+    /* Called from drivers/char/tty_io.c:init_dev() when the refcount of a tty
+    raises from zero to one. Usually, an EVT_OPEN follows an EVT_INIT. */
+    struct rpldev_packet p;
+    char dev[MAXFNLEN], *full_dev;
+    int len;
+
+    SKIP_PTM(tty);
+
+    p.dev   = TTY_DEVNR(tty);
+    p.event = EVT_INIT;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+
+    /* "/dev/tty" is an evil case, because its ownership is not the same as
+    that of a better node, e.g. /dev/tty1. Do not pass it to userspace. */
+    if(filp->f_dentry->d_inode->i_rdev == MKDEV(TTYAUX_MAJOR, 0) ||
+     IS_ERR(full_dev = d_path(filp->f_dentry, filp->f_vfsmnt,
+     dev, sizeof(dev)))) {
+        p.size = 0;
+        return mv_buffer(&p, NULL, 0);
+    }
+
+    p.size = cpu_to_le16(len = strlen(full_dev));
+    return mv_buffer(&p, full_dev, len);
+}
+
+static int krpl_open(struct tty_struct *tty, struct tty_struct *ctl,
+ struct file *filp)
+{
+    /* Called from drivers/char/tty_io.c:tty_open() whenever an open() on a
+    tty succeeds. */
+    struct rpldev_packet p;
+    char dev[MAXFNLEN], *full_dev;
+    int len;
+
+    SKIP_PTM(tty);
+
+    p.dev   = TTY_DEVNR(tty);
+    p.event = EVT_OPEN;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+
+    if(filp->f_dentry->d_inode->i_rdev == MKDEV(TTYAUX_MAJOR, 0) ||
+     IS_ERR(full_dev = d_path(filp->f_dentry, filp->f_vfsmnt,
+     dev, sizeof(dev)))) {
+        p.size = 0;
+        return mv_buffer(&p, NULL, 0);
+    }
+
+    p.size = cpu_to_le16(len = strlen(full_dev));
+    return mv_buffer(&p, full_dev, len);
+}
+
+static int krpl_read(const char __user *buf, size_t count,
+ struct tty_struct *tty)
+{
+    /* The data flow is a bit weird at first. krpl_read() gets the data on its
+    way between ttyDriver(master) -> /dev/stdin(slave), meaning this function
+    is called when you hit the keyboard. _Even_ if you do not see any text
+    onscreen. */
+    struct rpldev_packet p;
+
+    SKIP_PTM(tty);
+    if(count == 0) return 0;
+
+    p.dev   = TTY_DEVNR(tty);
+    p.size  = cpu_to_le16(count);
+    p.event = EVT_READ;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+    return mv_buffer(&p, buf, count);
+}
+
+static int krpl_write(const char __user *buf, size_t count,
+ struct tty_struct *tty)
+{
+    /* Data flow: /dev/stdout(slave) -> tty driver(master).
+    There are two ways an application can use a tty:
+
+    1. noecho mode (the case with interactive shells)
+       Shells print chars as they see fit, thus generating EVT_READ for you
+       hitting a key, and EVT_WRITE for the shell displaying it.
+
+    2. echo mode (cat waiting for EOF on stdin)
+       The _tty driver_ echoes _single_ chars back. This generates EVT_READ for
+       your keyboard interaction, plus _one_ EVT_WRITE when an end-of-line is
+       received.
+
+    Sounds familiar? Anyway, don't care, we log it all in userspace. You can
+    use the "E" key during ttyreplay which shows EVT_READ events which is all
+    you need if the EVT_WRITE packets do not suffice. */
+    struct rpldev_packet p;
+
+    SKIP_PTM(tty);
+    if(count == 0) return 0;
+
+    p.dev   = TTY_DEVNR(tty);
+    p.size  = cpu_to_le16(count);
+    p.event = EVT_WRITE;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+    return mv_buffer(&p, buf, count);
+}
+
+/*
+static int krpl_ioctl(struct tty_struct *tty, struct tty_struct *ctl,
+ unsigned int cmd, unsigned long arg)
+{
+    struct rpld_packet p;
+    uint32_t cmd32;
+
+    SKIP_PTM(tty);
+
+    cmd32   = cmd;
+    p.dev   = TTY_DEVNR(tty);
+    p.size  = cpu_to_le16(sizeof(cmd32));
+    p.event = EVT_IOCTL;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+    return mv_buffer(&p, &cmd32, sizeof(cmd32));
+}
+*/
+
+static int krpl_close(struct tty_struct *tty, struct tty_struct *other) {
+    struct rpldev_packet p;
+
+    SKIP_PTM(tty);
+
+    p.dev   = TTY_DEVNR(tty);
+    p.size  = 0;
+    p.event = EVT_CLOSE;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+    return mv_buffer(&p, NULL, 0);
+}
+
+static int krpl_deinit(struct tty_struct *tty, struct tty_struct *other) {
+    struct rpldev_packet p;
+
+    if(IS_PTY_MASTER(tty)) tty = other;
+
+    p.dev   = TTY_DEVNR(tty);
+    p.size  = 0;
+    p.event = EVT_DEINIT;
+    p.magic = MAGIC_SIG;
+    fill_time(&p.time);
+    return mv_buffer(&p, NULL, 0);
+}
+
+//-----------------------------------------------------------------------------
+static int urpl_open(struct inode *inode, struct file *filp) {
+    // This one is called when the device node has been opened.
+    if(inode != NULL) {
+        inode->i_mtime = CURRENT_TIME;
+        inode->i_mode &= ~(S_IWUGO | S_IXUGO);
+    }
+
+    /* The RPL device should only be opened once, since otherwise, different
+    packets could go to different readers. */
+    down(&Open_lock);
+    if(Open_count) {
+        up(&Open_lock);
+        return -EBUSY;
+    }
+    ++Open_count;
+    up(&Open_lock);
+
+    down(&Buffer_lock);
+    Buffer = __vmalloc(Bufsize, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+    if(Buffer == NULL) {
+        up(&Buffer_lock);
+        up(&Open_lock);
+        return -ENOMEM;
+    }
+    BufRP = BufWP = Buffer;
+
+    /* Update links. I do it here 'cause I do not want memory copying (from the
+    tty driver to the buffer) when there is no one to read. */
+    rpl_qinit   = krpl_init;
+    rpl_qopen   = krpl_open;
+    rpl_qread   = krpl_read;
+    rpl_qwrite  = krpl_write;
+    //rpl_qioctl  = krpl_ioctl;
+    rpl_qclose  = krpl_close;
+    rpl_qdeinit = krpl_deinit;
+    up(&Buffer_lock);
+
+    /* The inode's times are changed as follows:
+            Access Time: if data is read from the device
+      Inode Change Time: when the device is successfully opened
+      Modification Time: whenever the device is opened
+    */
+    if(inode != NULL)
+        inode->i_ctime = CURRENT_TIME;
+    return 0;
+}
+
+static ssize_t urpl_read(struct file *filp, char __user *buf, size_t count,
+ loff_t *ppos)
+{
+    int eax;
+
+    // Nothing read, nothing done
+    if(count == 0) return 0;
+
+    // Must sleep as long as there is no data
+    if(down_interruptible(&Buffer_lock))
+        return -ERESTARTSYS;
+
+    while(BufRP == BufWP) {
+        up(&Buffer_lock);
+        if(filp->f_flags & O_NONBLOCK)
+            return -EAGAIN;
+        if(wait_event_interruptible(Pull_queue, (BufRP != BufWP)))
+            return -ERESTARTSYS;
+        if(down_interruptible(&Buffer_lock))
+            return -ERESTARTSYS;
+    }
+
+    // Data is available, so give it to the user
+    count = min_uint(count, avail_R());
+    eax   = mv_to_user(buf, count);
+
+    up(&Buffer_lock);
+    filp->f_dentry->d_inode->i_atime = CURRENT_TIME;
+    return (eax != 0) ? eax : count;
+}
+
+static loff_t urpl_seek(struct file *filp, loff_t offset, int origin) {
+    /* Since you can not seek in the circular buffer, the only purpose of
+    seek() is to skip some bytes and "manually" advance the read pointer RP
+    (BufRP). Thus, the only accepted origin is SEEK_CUR, or SEEK_END
+    with offset == 0. */
+
+    if(origin == SEEK_END && offset == 0) {
+        if(down_interruptible(&Buffer_lock))
+            return -ERESTARTSYS;
+        BufRP = BufWP;
+        up(&Buffer_lock);
+        filp->f_dentry->d_inode->i_atime = CURRENT_TIME;
+        return 0;
+    }
+
+    if(origin != SEEK_CUR) return -ESPIPE;
+    if(offset == 0) return 0;
+
+    if(down_interruptible(&Buffer_lock))
+        return -ERESTARTSYS;
+    BufRP = Buffer + (BufRP - Buffer + min_uint(offset, avail_R())) % Bufsize;
+    if(BufRP >= Buffer + Bufsize) { 
+        WARN_ON(1);
+        BufRP = BufWP = 0;
+    }
+
+    up(&Buffer_lock);
+    filp->f_dentry->d_inode->i_atime = CURRENT_TIME;
+    return 0;
+}
+
+static int urpl_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
+ unsigned long arg)
+{
+    if(_IOC_TYPE(cmd) != RPL_IOC_MAGIC)
+        return -ENOTTY; /* ENAUGHTY */
+
+    switch(cmd) {
+        case RPL_IOC_GETBUFSIZE:
+            return Bufsize;
+        case RPL_IOC_GETRAVAIL:
+            return avail_R();
+        case RPL_IOC_GETWAVAIL:
+            return avail_W();
+        case RPL_IOC_IDENTIFY:
+            return 0xC0FFEE;
+        case RPL_IOC_SEEK:
+            return urpl_seek(filp, arg, SEEK_CUR);
+        case RPL_IOC_FLUSH:
+            return urpl_seek(filp, 0, SEEK_END);
+    }
+
+    return -ENOTTY;
+}
+
+static unsigned int urpl_poll(struct file *filp, poll_table *wait) {
+    poll_wait(filp, &Pull_queue, wait);
+    return POLLIN | POLLRDNORM;
+}
+
+static int urpl_close(struct inode *inode, struct file *filp) {
+    rpl_qinit   = NULL;
+    rpl_qopen   = NULL;
+    rpl_qread   = NULL;
+    rpl_qwrite  = NULL;
+    rpl_qioctl  = NULL;
+    rpl_qclose  = NULL;
+    rpl_qdeinit = NULL;
+    down(&Buffer_lock);
+    vfree(Buffer);
+    Buffer = NULL;
+    up(&Buffer_lock);
+    --Open_count;
+    return 0;
+}
+
+//-----------------------------------------------------------------------------
+static inline ssize_t avail_R(void) {
+    // Return the number of available bytes to read
+    if(BufWP >= BufRP)
+        return BufWP - BufRP;
+    return BufWP + Bufsize - BufRP;
+}
+
+static inline ssize_t avail_W(void) {
+    // Return the number of available bytes to write
+    if(BufWP >= BufRP)
+        return BufRP + Bufsize - BufWP - 1;
+    return BufRP - BufWP - 1;
+}
+
+static inline void fill_time(struct timeval *tv) {
+    do_gettimeofday(tv);
+
+    /* The following code all gets optimized away on LE, yay! And even on BE,
+    it is reduced by 50%. Just think of how ugly a #if-#endif wrappage
+    would be. :-) */
+    if(sizeof(tv->tv_sec) == sizeof(uint32_t))
+        tv->tv_sec = cpu_to_le32(tv->tv_sec);
+    else if(sizeof(tv->tv_sec) == sizeof(uint64_t))
+        tv->tv_sec = cpu_to_le64(tv->tv_sec);
+
+    if(sizeof(tv->tv_usec) == sizeof(uint32_t))
+        tv->tv_usec = cpu_to_le32(tv->tv_usec);
+    else if(sizeof(tv->tv_usec) == sizeof(uint64_t))
+        tv->tv_usec = cpu_to_le64(tv->tv_usec);
+
+    return;
+}
+
+static inline unsigned int min_uint(unsigned int a, unsigned int b) {
+    return (a < b) ? a : b;
+}
+
+static inline uint32_t mkdev_26(unsigned long maj, unsigned long min) {
+    /* Enforce the in-2.6-kernel scheme on userspace. That's because computing
+    the compatibility scheme (minor:12,major:12,minor:8) takes longer to
+    compute. See the optimization statement at the top. */
+    return (maj << 20) | (min & 0xFFFFF);
+}
+
+static int mv_buffer(struct rpldev_packet *p, const void *buf, size_t count) {
+    /* Copy the contents the tty driver received to our circulary buffer and
+    also add a header (rpld_packet) to it so that the userspace daemon can
+    recognize the type. */
+    if(down_interruptible(&Buffer_lock))
+        return -ERESTARTSYS;
+    if(avail_W() < sizeof(struct rpldev_packet) + count) {
+        up(&Buffer_lock);
+        return -ENOSPC;
+    }
+
+    mv_buffer2(p, sizeof(struct rpldev_packet));
+    if(count > 0)
+        mv_buffer2(buf, count);
+
+    up(&Buffer_lock);
+    wake_up(&Pull_queue);
+    return count;
+}
+
+static inline void mv_buffer2(const void *src, size_t count) {
+    /* This function is responsible for copying (a specific amount of
+    arbitrary data) into the circulary buffer. (Taking the wrappage into
+    account!) The parent function -- mv_buffer() in this case -- must make sure
+    there is enough room. */
+    size_t x = Buffer + Bufsize - BufWP;
+
+    if(count < x) {
+        memcpy(BufWP, src, count);
+        BufWP += count;
+    } else {
+        memcpy(BufWP, src, x);
+        memcpy(Buffer, src + x, count - x);
+        BufWP = Buffer + count - x;
+    }
+
+    return;
+}
+
+static inline int mv_to_user(char __user *dest, size_t count) {
+    /* mv_to_user() reads COUNT bytes from the circulary buffer and puts it
+    into userspace memory. The caller must make sure that COUNT is at most
+    avail_R(). */
+    size_t x = Buffer + Bufsize - BufRP;
+    int eax  = 0;
+
+    /* Since this operation might block due to userspace page faults, the
+    userspace daemon should really have DEST memory-locked. */
+    if(count < x) {
+        if((eax = copy_to_user(dest, BufRP, count)) == 0)
+            BufRP += count;
+    } else {
+        if((eax = copy_to_user(dest, BufRP, x)) == 0 &&
+         (eax = copy_to_user(dest + x, Buffer, count - x)) == 0)
+            BufRP = Buffer + count - x;
+    }
+
+    return eax;
+}
+
+//=============================================================================
diff -pruN a/drivers/char/rpl/rpl_ioctl.h b/drivers/char/rpl/rpl_ioctl.h
--- a/drivers/char/rpl/rpl_ioctl.h	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/char/rpl/rpl_ioctl.h	2006-01-05 16:19:06.000000000 +0000
@@ -0,0 +1,45 @@
+/*=============================================================================
+ttyrpld - TTY replay daemon
+include/rpl_ioctl.h - IOCTL numbers for RPLDEV
+  Copyright © Jan Engelhardt <jengelh [at] linux01 gwdg de>, 2004 - 2005
+  -- License restrictions apply (GPL v2)
+
+  This file is part of ttyrpld.
+  ttyrpld is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by
+  the Free Software Foundation; however ONLY version 2 of the License.
+
+  ttyrpld is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program kit; if not, write to:
+  Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
+  Boston, MA  02110-1301  USA
+
+  -- For details, see the file named "LICENSE.GPL2"
+=============================================================================*/
+#ifndef RPL_IOCTL_H
+#define RPL_IOCTL_H 1
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+enum {
+    /* Some weird *BSD scheme makes me use IOWR, otherwise readin the pointer
+    within kernel space does not seem to work. */
+    RPL_IOC_MAGIC      = 0xB7,
+    RPL_IOC_GETBUFSIZE = _IOWR(RPL_IOC_MAGIC, 1, size_t),
+    RPL_IOC_GETRAVAIL  = _IOWR(RPL_IOC_MAGIC, 2, size_t),
+    RPL_IOC_GETWAVAIL  = _IOWR(RPL_IOC_MAGIC, 3, size_t),
+    RPL_IOC_IDENTIFY   = _IOWR(RPL_IOC_MAGIC, 4, size_t),
+    RPL_IOC_SEEK       = _IOWR(RPL_IOC_MAGIC, 5, size_t),
+    RPL_IOC_FLUSH      = _IOWR(RPL_IOC_MAGIC, 6, size_t),
+    RPL_IOC__MAXNUM    = _IOWR(RPL_IOC_MAGIC, 7, size_t),
+};
+
+#endif // RPL_IOCTL_H
+
+//=============================================================================
diff -pruN a/drivers/char/rpl/rpl_packet.h b/drivers/char/rpl/rpl_packet.h
--- a/drivers/char/rpl/rpl_packet.h	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/char/rpl/rpl_packet.h	2006-01-05 16:19:06.000000000 +0000
@@ -0,0 +1,62 @@
+/*=============================================================================
+ttyrpld - TTY replay daemon
+include/rpl_packet.h - Packet definitions for RPLD and RPLDEV
+  Copyright © Jan Engelhardt <jengelh [at] linux01 gwdg de>, 2004 - 2005
+  -- License restrictions apply (GPL v2)
+
+  This file is part of ttyrpld.
+  ttyrpld is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by
+  the Free Software Foundation; however ONLY version 2 of the License.
+
+  ttyrpld is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program kit; if not, write to:
+  Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
+  Boston, MA  02110-1301  USA
+
+  -- For details, see the file named "LICENSE.GPL2"
+=============================================================================*/
+#ifndef RPL_PACKET_H
+#define RPL_PACKET_H 1
+
+#define __PACKED __attribute__((packed))
+
+#include <linux/time.h>
+#include <linux/types.h>
+
+enum {
+    EVT_NONE = 0,
+    EVT_OPEN,
+    EVT_READ,
+    EVT_WRITE,
+    EVT_IOCTL,
+    EVT_CLOSE,
+    EVT_INIT    = 0x69,
+    EVT_DEINIT  = 0x64,
+    EVT_ID_PROG = 0xF0,
+    EVT_ID_DEVPATH,
+    EVT_max,
+    MAGIC_SIG = 0xEE,
+};
+
+struct rpldev_packet {
+    uint32_t dev;
+    uint16_t size;
+    uint8_t event, magic;
+    struct timeval time;
+} __PACKED;
+
+struct rpldsk_packet {
+    uint16_t size;
+    uint8_t event, magic;
+    struct timeval time;
+} __PACKED;
+
+#endif // RPL_PACKET_H
+
+//=============================================================================
diff -pruN a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	2006-01-04 23:54:16.000000000 +0000
+++ b/drivers/char/tty_io.c	2006-01-05 16:38:21.000000000 +0000
@@ -113,6 +113,25 @@ extern void disable_early_printk(void);
 #define SYSCONS_DEV MKDEV(TTYAUX_MAJOR,1)
 #define PTMX_DEV MKDEV(TTYAUX_MAJOR,2)
 
+#ifdef CONFIG_TTY_RPL
+#include <linux/km_rpldev.h>
+int (*rpl_qinit)(struct tty_struct *, struct tty_struct *, struct file *) = NULL;
+int (*rpl_qopen)(struct tty_struct *, struct tty_struct *, struct file *) = NULL;
+int (*rpl_qread)(const char *, size_t, struct tty_struct *) = NULL;
+int (*rpl_qwrite)(const char *, size_t, struct tty_struct *) = NULL;
+int (*rpl_qclose)(struct tty_struct *, struct tty_struct *) = NULL;
+int (*rpl_qdeinit)(struct tty_struct *, struct tty_struct *) = NULL;
+int (*rpl_qioctl)(struct tty_struct *, struct tty_struct *, unsigned int,
+  unsigned long) = NULL;
+EXPORT_SYMBOL(rpl_qinit);
+EXPORT_SYMBOL(rpl_qopen);
+EXPORT_SYMBOL(rpl_qread);
+EXPORT_SYMBOL(rpl_qwrite);
+EXPORT_SYMBOL(rpl_qclose);
+EXPORT_SYMBOL(rpl_qdeinit);
+EXPORT_SYMBOL(rpl_qioctl);
+#endif
+
 #undef TTY_DEBUG_HANGUP
 
 #define TTY_PARANOIA_CHECK 1
@@ -1001,8 +1020,13 @@ static ssize_t tty_read(struct file * fi
 		i = -EIO;
 	tty_ldisc_deref(ld);
 	unlock_kernel();
-	if (i > 0)
-		inode->i_atime = CURRENT_TIME;
+        if(i > 0) {
+            inode->i_atime = CURRENT_TIME;
+#ifdef CONFIG_TTY_RPL
+            if(rpl_qread != NULL)
+		    rpl_qread(buf, i, tty);
+#endif
+        }
 	return i;
 }
 
@@ -1056,6 +1080,10 @@ static inline ssize_t do_tty_write(
 	if (written) {
 		file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
 		ret = written;
+#ifdef CONFIG_TTY_RPL
+                if(rpl_qwrite != NULL)
+			rpl_qwrite(buf - ret, ret, tty);
+#endif
 	}
 	up(&tty->atomic_write);
 	return ret;
@@ -1149,7 +1177,8 @@ static void release_mem(struct tty_struc
  * really quite straightforward.  The semaphore locking can probably be
  * relaxed for the (most common) case of reopening a tty.
  */
-static int init_dev(kdev_t device, struct tty_struct **ret_tty)
+static int init_dev(kdev_t device, struct tty_struct **ret_tty,
+		    struct file *filp)
 {
 	struct tty_struct *tty, *o_tty;
 	struct termios *tp, **tp_loc, *o_tp, **o_tp_loc;
@@ -1294,6 +1323,10 @@ static int init_dev(kdev_t device, struc
 		tty_ldisc_enable(o_tty);
 	}
 	tty_ldisc_enable(tty);
+#ifdef CONFIG_TTY_RPL
+        if(rpl_qinit != NULL)
+		rpl_qinit(tty, o_tty, filp);
+#endif
 	goto success;
 
 	/*
@@ -1588,6 +1621,11 @@ static void release_dev(struct file * fi
 		read_unlock(&tasklist_lock);
 	}
 
+#ifdef CONFIG_TTY_RPL
+        if(rpl_qclose != NULL)
+		rpl_qclose(tty, o_tty);
+#endif
+
 	/* check whether both sides are closing ... */
 	if (!tty_closing || (o_tty && !o_tty_closing))
 		return;
@@ -1596,6 +1634,11 @@ static void release_dev(struct file * fi
 	printk(KERN_DEBUG "freeing tty structure...");
 #endif
 
+#ifdef CONFIG_TTY_RPL
+        if(rpl_qdeinit != NULL)
+		rpl_qdeinit(tty, o_tty);
+#endif
+
 	/*
 	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
 	 * kill any delayed work. As this is the final close it does not
@@ -1722,7 +1765,8 @@ retry_open:
 			     minor < driver->minor_start + driver->num ;
 			     minor++) {
 				device = MKDEV(driver->major, minor);
-				if (!init_dev(device, &tty)) goto ptmx_found; /* ok! */
+				if (!init_dev(device, &tty, filp))
+					goto ptmx_found; /* ok! */
 			}
 		}
 		return -EIO; /* no free ptys */
@@ -1742,7 +1786,7 @@ retry_open:
 #endif  /* CONFIG_UNIX_98_PTYS */
 	}
 
-	retval = init_dev(device, &tty);
+	retval = init_dev(device, &tty, filp);
 	if (retval)
 		return retval;
 
@@ -1809,6 +1853,11 @@ init_dev_done:
 			nr_warns++;
 		}
 	}
+
+#ifdef CONFIG_TTY_RPL
+        if(rpl_qopen != NULL)
+		rpl_qopen(tty, current->tty, filp);
+#endif
 	return 0;
 }
 
@@ -2096,6 +2145,11 @@ int tty_ioctl(struct inode * inode, stru
 	    tty->driver.subtype == PTY_TYPE_MASTER)
 		real_tty = tty->link;
 
+#ifdef CONFIG_TTY_RPL
+        if(rpl_qioctl != NULL)
+		rpl_qioctl(tty, real_tty, cmd, arg);
+#endif
+
 	/*
 	 * Break handling by driver
 	 */
diff -pruN a/include/linux/km_rpldev.h b/include/linux/km_rpldev.h
--- a/include/linux/km_rpldev.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/km_rpldev.h	2006-01-04 13:58:01.000000000 +0000
@@ -0,0 +1,41 @@
+/*=============================================================================
+ttyrpld - TTY replay daemon
+include/linux/rpl.h - Stage 1 RPL interface
+  Copyright © Jan Engelhardt <jengelh [at] linux01 gwdg de>, 2004 - 2005
+  -- License restrictions apply (GPL v2)
+
+  This file is part of ttyrpld.
+  ttyrpld is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by
+  the Free Software Foundation; however ONLY version 2 of the License.
+
+  ttyrpld is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program kit; if not, write to:
+  Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
+  Boston, MA  02110-1301  USA
+
+  -- For details, see the file named "LICENSE.GPL2"
+=============================================================================*/
+#ifndef _LINUX_KM_RPLDEV_H
+#define _LINUX_KM_RPLDEV_H 1
+
+struct file;
+struct tty_struct;
+
+extern int (*rpl_qinit)(struct tty_struct *, struct tty_struct *, struct file *);
+extern int (*rpl_qopen)(struct tty_struct *, struct tty_struct *, struct file *);
+extern int (*rpl_qread)(const char *, size_t, struct tty_struct *);
+extern int (*rpl_qwrite)(const char *, size_t, struct tty_struct *);
+extern int (*rpl_qclose)(struct tty_struct *, struct tty_struct *);
+extern int (*rpl_qdeinit)(struct tty_struct *, struct tty_struct *);
+extern int (*rpl_qioctl)(struct tty_struct *, struct tty_struct *,
+  unsigned int, unsigned long);
+
+#endif // _LINUX_KM_RPLDEV_H
+
+//=============================================================================
