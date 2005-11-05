Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVKEQkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVKEQkG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKEQeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:60396 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932104AbVKEQdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:35 -0500
Message-Id: <20051105162719.641432000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:12 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, rmk+serial@arm.linux.org.uk,
       linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 22/25] serial: move ioctl32 code to tty_io.c
Content-Disposition: inline; filename=serial-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All driver implementing TIOCGSERIAL are tty drivers, so
the conversion handler can be part of tty_compat_ioctl.

In a perfect world, this would live in serial_core.c, but
there are still a number of drivers that are not moved
over to use that yet. If it were in serial_core, it
could also live without the get_fs/set_fs hacks.

CC: rmk+serial@arm.linux.org.uk
CC: linux-serial@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/char/tty_io.c
===================================================================
--- linux-cg.orig/drivers/char/tty_io.c	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/drivers/char/tty_io.c	2005-11-05 15:42:22.000000000 +0100
@@ -104,7 +104,6 @@
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/devfs_fs_kernel.h>
-
 #include <linux/kmod.h>
 
 #undef TTY_DEBUG_HANGUP
@@ -153,7 +152,7 @@
 static int tty_release(struct inode *, struct file *);
 int tty_ioctl(struct inode * inode, struct file * file,
 	      unsigned int cmd, unsigned long arg);
-long tty_compat_ioctl(struct file * file, unsigned int cmd, unsigned long arg);
+static long tty_compat_ioctl(struct file * file, unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
 static void release_mem(struct tty_struct *tty, int idx);
 
@@ -2437,7 +2436,75 @@
 
 
 #ifdef CONFIG_COMPAT
-long tty_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+#include <linux/serial.h>
+
+struct serial_struct32 {
+	compat_int_t type;
+	compat_int_t line;
+	compat_uint_t port;
+	compat_int_t irq;
+	compat_int_t flags;
+	compat_int_t xmit_fifo_size;
+	compat_int_t custom_divisor;
+	compat_int_t baud_base;
+	unsigned short close_delay;
+	char io_type;
+	char reserved_char[1];
+	compat_int_t hub6;
+	unsigned short closing_wait;	/* time to wait before closing */
+	unsigned short closing_wait2;	/* no longer used... */
+	compat_uint_t iomem_base;
+	unsigned short iomem_reg_shift;
+	unsigned int port_high;
+	/* compat_ulong_t  iomap_base FIXME */
+	compat_int_t reserved[1];
+};
+
+static int serial_struct_ioctl(struct inode *inode, struct file *file,
+				unsigned cmd, unsigned long arg)
+{
+	typedef struct serial_struct SS;
+	typedef struct serial_struct32 SS32;
+	struct serial_struct32 __user *ss32 = compat_ptr(arg);
+	int err;
+	struct serial_struct ss;
+	mm_segment_t oldseg = get_fs();
+	__u32 udata;
+
+	if (cmd == TIOCSSERIAL) {
+		if (!access_ok(VERIFY_READ, ss32, sizeof(SS32)))
+			return -EFAULT;
+		if (__copy_from_user
+		    (&ss, ss32, offsetof(SS32, iomem_base)))
+			return -EFAULT;
+		__get_user(udata, &ss32->iomem_base);
+		ss.iomem_base = compat_ptr(udata);
+		__get_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
+		__get_user(ss.port_high, &ss32->port_high);
+		ss.iomap_base = 0UL;
+	}
+	set_fs(KERNEL_DS);
+	lock_kernel();
+	err = tty_ioctl(inode, file, cmd, (unsigned long) (&ss));
+	unlock_kernel();
+	set_fs(oldseg);
+	if (cmd == TIOCGSERIAL && err >= 0) {
+		if (!access_ok(VERIFY_WRITE, ss32, sizeof(SS32)))
+			return -EFAULT;
+		if (__copy_to_user(ss32, &ss, offsetof(SS32, iomem_base)))
+			return -EFAULT;
+		__put_user((unsigned long) ss.iomem_base >> 32 ?
+			   0xffffffff : (unsigned) (unsigned long) ss.
+			   iomem_base, &ss32->iomem_base);
+		__put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
+		__put_user(ss.port_high, &ss32->port_high);
+
+	}
+	return err;
+}
+
+static long tty_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct tty_struct *tty;
@@ -2499,6 +2566,14 @@
 	/* enter the native code path for those numbers known
 	 * to be compatible */
 	switch (cmd) {
+	case TIOCGSERIAL:
+	case TIOCSSERIAL:
+		ret = serial_struct_ioctl(inode, file, cmd, arg);
+		break;
+#ifdef TIOCGLTC
+	case TIOCGLTC:
+	case TIOCSLTC:
+#endif
 	case TCFLSH:
 	case TCGETA:
 	case TCGETS:
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 14:47:57.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 15:46:46.000000000 +0100
@@ -356,67 +356,6 @@
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
-struct serial_struct32 {
-        compat_int_t    type;
-        compat_int_t    line;
-        compat_uint_t   port;
-        compat_int_t    irq;
-        compat_int_t    flags;
-        compat_int_t    xmit_fifo_size;
-        compat_int_t    custom_divisor;
-        compat_int_t    baud_base;
-        unsigned short  close_delay;
-        char    io_type;
-        char    reserved_char[1];
-        compat_int_t    hub6;
-        unsigned short  closing_wait; /* time to wait before closing */
-        unsigned short  closing_wait2; /* no longer used... */
-        compat_uint_t   iomem_base;
-        unsigned short  iomem_reg_shift;
-        unsigned int    port_high;
-     /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved[1];
-};
-
-static int serial_struct_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
-{
-        typedef struct serial_struct SS;
-        typedef struct serial_struct32 SS32;
-        struct serial_struct32 __user *ss32 = compat_ptr(arg);
-        int err;
-        struct serial_struct ss;
-        mm_segment_t oldseg = get_fs();
-        __u32 udata;
-
-        if (cmd == TIOCSSERIAL) {
-                if (!access_ok(VERIFY_READ, ss32, sizeof(SS32)))
-                        return -EFAULT;
-                if (__copy_from_user(&ss, ss32, offsetof(SS32, iomem_base)))
-			return -EFAULT;
-                __get_user(udata, &ss32->iomem_base);
-                ss.iomem_base = compat_ptr(udata);
-                __get_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
-                __get_user(ss.port_high, &ss32->port_high);
-                ss.iomap_base = 0UL;
-        }
-        set_fs(KERNEL_DS);
-                err = sys_ioctl(fd,cmd,(unsigned long)(&ss));
-        set_fs(oldseg);
-        if (cmd == TIOCGSERIAL && err >= 0) {
-                if (!access_ok(VERIFY_WRITE, ss32, sizeof(SS32)))
-                        return -EFAULT;
-                if (__copy_to_user(ss32,&ss,offsetof(SS32,iomem_base)))
-			return -EFAULT;
-                __put_user((unsigned long)ss.iomem_base  >> 32 ?
-                            0xffffffff : (unsigned)(unsigned long)ss.iomem_base,
-                            &ss32->iomem_base);
-                __put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
-                __put_user(ss.port_high, &ss32->port_high);
-
-        }
-        return err;
-}
-
 #undef CODE
 #endif
 
@@ -425,13 +364,5 @@
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
-/* Serial */
-HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
-HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
-#ifdef TIOCGLTC
-COMPATIBLE_IOCTL(TIOCGLTC)
-COMPATIBLE_IOCTL(TIOCSLTC)
-#endif
-
 #undef DECLARES
 #endif

--

