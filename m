Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVFLLWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVFLLWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVFLLWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:22:17 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6116 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261944AbVFLLRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:17:48 -0400
Date: Sun, 12 Jun 2005 13:17:42 +0200 (MEST)
Message-Id: <200506121117.j5CBHgoj019701@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 2/9] gcc4: fix static-vs-nonstatic redefinition errors
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates lots of compile-time errors like:

init/do_mounts.c:54: error: static declaration of 'root_device_name' follows non-static declaration
/tmp/linux-2.4.31/include/linux/fs.h:1562: error: previous declaration of 'root_device_name' was here
make: *** [init/do_mounts.o] Error 1

In most cases this is caused by extern declarations being followed by
static definitions. The fixes in most cases is to drop redundant extern
declarations, or to reorder declarations.

arch/ppc/kernel/time.c has a private 'time_offset' variable with the same
name as a global one (in kernel/timer.c). The fix in this case is to
rename ppc's variable.

sound_firmware.c has a private 'errno' variable with the same name as
a global one (lib/errno.c). This is because it does system calls from
within the kernel, but wishes to not clobber the global errno. The fix
is to rename its own errno, and to redirect the syscall wrappers to
the local version via macro abuse. (Eliminating its abuse of system calls
would be a cleaner but much less trivial fix.)

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/ppc/kernel/open_pic_defs.h          |    3 ---
 arch/ppc/kernel/time.c                   |   10 +++++-----
 drivers/sound/sound_firmware.c           |    5 +++--
 drivers/usb/inode.c                      |    3 +++
 include/linux/fs.h                       |    1 -
 include/linux/netfilter_ipv4/ip_tables.h |    2 --
 include/linux/ufs_fs.h                   |    1 -
 include/linux/usbdevice_fs.h             |    2 --
 8 files changed, 11 insertions(+), 16 deletions(-)

diff -rupN linux-2.4.31/arch/ppc/kernel/open_pic_defs.h linux-2.4.31.gcc4-static-redef-errors/arch/ppc/kernel/open_pic_defs.h
--- linux-2.4.31/arch/ppc/kernel/open_pic_defs.h	2003-06-14 13:30:19.000000000 +0200
+++ linux-2.4.31.gcc4-static-redef-errors/arch/ppc/kernel/open_pic_defs.h	2005-06-12 11:42:41.000000000 +0200
@@ -172,9 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC *OpenPIC;
-
-
     /*
      *  Current Task Priority Register
      */
diff -rupN linux-2.4.31/arch/ppc/kernel/time.c linux-2.4.31.gcc4-static-redef-errors/arch/ppc/kernel/time.c
--- linux-2.4.31/arch/ppc/kernel/time.c	2005-06-01 18:02:21.000000000 +0200
+++ linux-2.4.31.gcc4-static-redef-errors/arch/ppc/kernel/time.c	2005-06-12 11:42:41.000000000 +0200
@@ -84,7 +84,7 @@ unsigned tb_last_stamp;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
+static long ppc_time_offset;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
@@ -187,7 +187,7 @@ int timer_interrupt(struct pt_regs * reg
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + ppc_time_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -297,7 +297,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                ppc_time_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -344,9 +344,9 @@ void __init time_init(void)
 	/* If platform provided a timezone (pmac), we correct the time
 	 * using do_sys_settimeofday() which in turn calls warp_clock()
 	 */
-        if (time_offset) {
+        if (ppc_time_offset) {
         	struct timezone tz;
-        	tz.tz_minuteswest = -time_offset / 60;
+        	tz.tz_minuteswest = -ppc_time_offset / 60;
         	tz.tz_dsttime = 0;
         	do_sys_settimeofday(NULL, &tz);
         }
diff -rupN linux-2.4.31/drivers/sound/sound_firmware.c linux-2.4.31.gcc4-static-redef-errors/drivers/sound/sound_firmware.c
--- linux-2.4.31/drivers/sound/sound_firmware.c	2001-02-22 15:23:46.000000000 +0100
+++ linux-2.4.31.gcc4-static-redef-errors/drivers/sound/sound_firmware.c	2005-06-12 11:42:41.000000000 +0200
@@ -4,10 +4,11 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/unistd.h>
+static int my_errno;
+#define errno my_errno
+#include <asm/unistd.h>
 #include <asm/uaccess.h>
 
-static int errno;
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
 	int fd;
diff -rupN linux-2.4.31/drivers/usb/inode.c linux-2.4.31.gcc4-static-redef-errors/drivers/usb/inode.c
--- linux-2.4.31/drivers/usb/inode.c	2004-02-18 15:16:23.000000000 +0100
+++ linux-2.4.31.gcc4-static-redef-errors/drivers/usb/inode.c	2005-06-12 11:42:41.000000000 +0200
@@ -41,6 +41,9 @@
 #include <linux/usbdevice_fs.h>
 #include <asm/uaccess.h>
 
+static struct inode_operations usbdevfs_bus_inode_operations;
+static struct file_operations usbdevfs_bus_file_operations;
+
 /* --------------------------------------------------------------------- */
 
 /*
diff -rupN linux-2.4.31/include/linux/fs.h linux-2.4.31.gcc4-static-redef-errors/include/linux/fs.h
--- linux-2.4.31/include/linux/fs.h	2005-04-04 19:56:05.000000000 +0200
+++ linux-2.4.31.gcc4-static-redef-errors/include/linux/fs.h	2005-06-12 11:42:41.000000000 +0200
@@ -1559,7 +1559,6 @@ static inline int is_mounted(kdev_t dev)
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
-extern char root_device_name[];
 
 
 extern void show_buffers(void);
diff -rupN linux-2.4.31/include/linux/netfilter_ipv4/ip_tables.h linux-2.4.31.gcc4-static-redef-errors/include/linux/netfilter_ipv4/ip_tables.h
--- linux-2.4.31/include/linux/netfilter_ipv4/ip_tables.h	2005-04-04 19:56:05.000000000 +0200
+++ linux-2.4.31.gcc4-static-redef-errors/include/linux/netfilter_ipv4/ip_tables.h	2005-06-12 11:42:41.000000000 +0200
@@ -283,8 +283,6 @@ struct ipt_get_entries
 	struct ipt_entry entrytable[0];
 };
 
-extern struct semaphore ipt_mutex;
-
 /* Standard return verdict, or do jump. */
 #define IPT_STANDARD_TARGET ""
 /* Error verdict. */
diff -rupN linux-2.4.31/include/linux/ufs_fs.h linux-2.4.31.gcc4-static-redef-errors/include/linux/ufs_fs.h
--- linux-2.4.31/include/linux/ufs_fs.h	2001-11-23 22:40:15.000000000 +0100
+++ linux-2.4.31.gcc4-static-redef-errors/include/linux/ufs_fs.h	2005-06-12 11:42:41.000000000 +0200
@@ -555,7 +555,6 @@ extern struct buffer_head * ufs_bread (s
 extern struct file_operations ufs_dir_operations;
         
 /* super.c */
-extern struct file_system_type ufs_fs_type;
 extern void ufs_warning (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
 extern void ufs_error (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
 extern void ufs_panic (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
diff -rupN linux-2.4.31/include/linux/usbdevice_fs.h linux-2.4.31.gcc4-static-redef-errors/include/linux/usbdevice_fs.h
--- linux-2.4.31/include/linux/usbdevice_fs.h	2003-11-29 00:28:14.000000000 +0100
+++ linux-2.4.31.gcc4-static-redef-errors/include/linux/usbdevice_fs.h	2005-06-12 11:42:41.000000000 +0200
@@ -185,8 +185,6 @@ extern struct file_operations usbdevfs_d
 extern struct file_operations usbdevfs_devices_fops;
 extern struct file_operations usbdevfs_device_file_operations;
 extern struct inode_operations usbdevfs_device_inode_operations;
-extern struct inode_operations usbdevfs_bus_inode_operations;
-extern struct file_operations usbdevfs_bus_file_operations;
 extern void usbdevfs_conn_disc_event(void);
 
 #endif /* __KERNEL__ */
