Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbSJBWAa>; Wed, 2 Oct 2002 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbSJBWAa>; Wed, 2 Oct 2002 18:00:30 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:64691 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262652AbSJBWAY>; Wed, 2 Oct 2002 18:00:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: EVMS Submission for 2.5
Date: Wed, 2 Oct 2002 16:33:20 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <02100216332002.18102@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On behalf of the EVMS team, I'd like to submit the Enterprise Volume
Management System for inclusion in the 2.5 Linux kernel tree.

To make this as simple as possible for you, there is a Bitkeeper
tree available with the latest EVMS source code, located at:
http://evms.bkbits.net/linux-2.5
This tree is sync'd with the linux-2.5 tree on linux.bkbits.net
as of about noon today (Oct 2).

EVMS provides a new, stand-alone subsystem to the kernel. Two new
subdirectories were created: drivers/evms/ for the main source code,
and include/linux/evms/ for the header files. There is no functional
affect on the existing kernel, and users can of course choose to
enable or disable EVMS when configuring their kernel.

In addition to the actual EVMS code, a handful of existing kernel
files were modified to allow EVMS to build and run correctly. I have
included below a patch (against 2.5.40) with these changes for you
to inspect. These changes are obviously also part of the Bitkeeper
tree above. Here are the changes in a nutshell:
- Add our contact info to the MAINTAINERS file.
- Add config options for EVMS to the config.in files for i386, ia64,
  parisc, ppc, ppc64, s390, s390x, and x86_64.
- Add evms to the list of build directories in drivers/Makefile
- Add a function, walk_gendisk(), to drivers/block/genhd.c to allow
  EVMS to get information about the disks on the system from the
  gendisk list in a safe manner.
- Add function prototyes to fs.h and genhd.h
- Add the EVMS assigned major number (117) to major.h
- Add entries to sysctl.h to allow access to some EVMS internal
  variables.
- Add a table entry and a short function to init/do_mounts.c to
  allow an EVMS volume to be specified as the root filesystem with
  the kernel command line option "root="

EVMS 1.0 was officially released in March of this year and is
building a strong base of users. Just this week, the new 1.2
version of EVMS was released. EVMS has been accepted into the
Debian (Woody and Sid versions) and UnitedLinux distributions,
well as a number of smaller distros. EVMS is actively undergoing
improvements and upgrades, and if it is accepted into the kernel,
we will serve as the active maintainers.

If you are interested in other information about EVMS, or would
like to obtain the user-space administration tools, please visit
our website at http://evms.sourceforge.net/.

Thank you very much for taking the time to consider this
submission. If you have any questions or comments, please email
us at any time. We will be happy to do whatever is necessary to
make EVMS acceptable for inclusion in the 2.5 tree.

Thank you,

Kevin Corry
corryk@us.ibm.com

Mark Peloquin
peloquin@us.ibm.com

Steve Pratt
slpratt@us.ibm.com

diff -Naur linux-2002-10-01/MAINTAINERS evms-2002-10-01/MAINTAINERS
--- linux-2002-10-01/MAINTAINERS	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/MAINTAINERS	Tue Oct  1 15:18:41 2002
@@ -556,6 +556,13 @@
 W:	http://opensource.creative.com/
 S:	Maintained
 
+ENTERPRISE VOLUME MANAGEMENT SYSTEM (EVMS)
+P:	Mark Peloquin, Steve Pratt, Kevin Corry
+M:	peloquin@us.ibm.com, slpratt@us.ibm.com, corryk@us.ibm.com
+L:	evms-devel@lists.sourceforge.net
+W:	http://www.sourceforge.net/projects/evms/
+S:	Supported
+
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	Philip.Blundell@pobox.com
diff -Naur linux-2002-10-01/arch/i386/config.in evms-2002-10-01/arch/i386/config.in
--- linux-2002-10-01/arch/i386/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/i386/config.in	Tue Oct  1 15:18:41 2002
@@ -368,6 +368,8 @@
 fi
 endmenu
 
+source drivers/evms/Config.in
+
 source drivers/md/Config.in
 
 source drivers/message/fusion/Config.in
diff -Naur linux-2002-10-01/arch/ia64/config.in evms-2002-10-01/arch/ia64/config.in
--- linux-2002-10-01/arch/ia64/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/ia64/config.in	Mon Sep 23 08:23:50 2002
@@ -146,6 +146,7 @@
   source drivers/block/Config.in
   source drivers/ieee1394/Config.in
   source drivers/message/i2o/Config.in
+  source drivers/evms/Config.in
   source drivers/md/Config.in
   source drivers/message/fusion/Config.in
 
diff -Naur linux-2002-10-01/arch/parisc/config.in evms-2002-10-01/arch/parisc/config.in
--- linux-2002-10-01/arch/parisc/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/parisc/config.in	Wed Aug 28 08:47:38 2002
@@ -90,6 +90,8 @@
 
 source drivers/block/Config.in
 
+source drivers/evms/Config.in
+
 mainmenu_option next_comment
 comment 'SCSI support'
 
diff -Naur linux-2002-10-01/arch/ppc/config.in evms-2002-10-01/arch/ppc/config.in
--- linux-2002-10-01/arch/ppc/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/ppc/config.in	Fri Sep 20 12:59:51 2002
@@ -409,6 +409,7 @@
 source drivers/mtd/Config.in
 source drivers/pnp/Config.in
 source drivers/block/Config.in
+source drivers/evms/Config.in
 source drivers/md/Config.in
 
 mainmenu_option next_comment
diff -Naur linux-2002-10-01/arch/ppc64/config.in evms-2002-10-01/arch/ppc64/config.in
--- linux-2002-10-01/arch/ppc64/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/ppc64/config.in	Mon Sep 16 08:19:02 2002
@@ -107,6 +107,8 @@
 fi
 endmenu
 
+source drivers/evms/Config.in
+
 source drivers/md/Config.in
 
 source drivers/message/fusion/Config.in
diff -Naur linux-2002-10-01/arch/s390/config.in evms-2002-10-01/arch/s390/config.in
--- linux-2002-10-01/arch/s390/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/s390/config.in	Thu Aug  8 09:39:50 2002
@@ -59,6 +59,8 @@
 
 source drivers/s390/Config.in
 
+source drivers/evms/Config.in
+
 if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
diff -Naur linux-2002-10-01/arch/s390x/config.in evms-2002-10-01/arch/s390x/config.in
--- linux-2002-10-01/arch/s390x/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/s390x/config.in	Thu Aug  8 09:39:55 2002
@@ -62,6 +62,8 @@
 
 source drivers/s390/Config.in
 
+source drivers/evms/Config.in
+
 if [ "$CONFIG_NET" = "y" ]; then
   source net/Config.in
 fi
diff -Naur linux-2002-10-01/arch/x86_64/config.in evms-2002-10-01/arch/x86_64/config.in
--- linux-2002-10-01/arch/x86_64/config.in	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/arch/x86_64/config.in	Wed Aug 28 08:48:31 2002
@@ -117,6 +117,8 @@
 
 source drivers/block/Config.in
 
+source drivers/evms/Config.in
+
 source drivers/md/Config.in
 
 mainmenu_option next_comment
diff -Naur linux-2002-10-01/drivers/Makefile evms-2002-10-01/drivers/Makefile
--- linux-2002-10-01/drivers/Makefile	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/drivers/Makefile	Thu Aug  8 09:40:35 2002
@@ -41,5 +41,6 @@
 obj-$(CONFIG_BLUEZ)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_EVMS)		+= evms/
 
 include $(TOPDIR)/Rules.make
diff -Naur linux-2002-10-01/drivers/block/genhd.c evms-2002-10-01/drivers/block/genhd.c
--- linux-2002-10-01/drivers/block/genhd.c	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/drivers/block/genhd.c	Tue Oct  1 15:19:36 2002
@@ -137,6 +137,37 @@
 
 EXPORT_SYMBOL(get_gendisk);
 
+/**
+ * walk_gendisk - issue a command for every registered gendisk
+ * @walk: user-specified callback
+ * @data: opaque data for the callback
+ *
+ * This function walks through the gendisk chain and calls back
+ * into @walk for every element.
+ */
+int
+walk_gendisk(int (*walk)(struct gendisk *, void *), void *data)
+{
+	struct gendisk *disk;
+	struct list_head *p;
+	int i, error = 0;
+
+	read_lock(&gendisk_lock);
+	for (i = 0; i < MAX_BLKDEV; i++) {
+		list_for_each(p, &gendisks[i].list) {
+			disk = list_entry(p, struct gendisk, list);
+			if ((error = walk(disk, data)))
+				goto out;
+		}
+	}
+
+out:
+	read_unlock(&gendisk_lock);
+	return error;
+}
+
+EXPORT_SYMBOL(walk_gendisk);
+
 #ifdef CONFIG_PROC_FS
 /* iterator */
 static void *part_start(struct seq_file *part, loff_t *pos)
diff -Naur linux-2002-10-01/include/linux/fs.h evms-2002-10-01/include/linux/fs.h
--- linux-2002-10-01/include/linux/fs.h	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/include/linux/fs.h	Fri Sep 20 12:59:51 2002
@@ -1284,6 +1284,7 @@
 extern struct super_block *get_super(struct block_device *);
 extern struct super_block *user_get_super(dev_t);
 extern void drop_super(struct super_block *sb);
+extern void get_root_device_name( char * root_name );
 
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
diff -Naur linux-2002-10-01/include/linux/genhd.h evms-2002-10-01/include/linux/genhd.h
--- linux-2002-10-01/include/linux/genhd.h	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/include/linux/genhd.h	Tue Oct  1 15:19:47 2002
@@ -95,6 +95,7 @@
 extern void del_gendisk(struct gendisk *gp);
 extern void unlink_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *part);
+extern int walk_gendisk(int (*walk)(struct gendisk *, void *), void *data);
 static inline unsigned long get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
diff -Naur linux-2002-10-01/include/linux/major.h evms-2002-10-01/include/linux/major.h
--- linux-2002-10-01/include/linux/major.h	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/include/linux/major.h	Wed Jul 10 08:27:47 2002
@@ -140,6 +140,8 @@
 
 #define LVM_CHAR_MAJOR	109	/* Logical Volume Manager */
 
+#define EVMS_MAJOR	117	/* Enterprise Volume Management System */
+
 #define RTF_MAJOR	150
 #define RAW_MAJOR	162
 
diff -Naur linux-2002-10-01/include/linux/sysctl.h evms-2002-10-01/include/linux/sysctl.h
--- linux-2002-10-01/include/linux/sysctl.h	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/include/linux/sysctl.h	Fri Sep 20 12:59:51 2002
@@ -578,7 +578,8 @@
 	DEV_HWMON=2,
 	DEV_PARPORT=3,
 	DEV_RAID=4,
-	DEV_MAC_HID=5
+	DEV_MAC_HID=5,
+	DEV_EVMS=6
 };
 
 /* /proc/sys/dev/cdrom */
@@ -594,6 +595,18 @@
 /* /proc/sys/dev/parport */
 enum {
 	DEV_PARPORT_DEFAULT=-3
+};
+
+/* /proc/sys/dev/evms */
+enum {
+	DEV_EVMS_INFO_LEVEL=1,
+	DEV_EVMS_MD=2
+};
+
+/* /proc/sys/dev/evms/raid */
+enum {
+	DEV_EVMS_MD_SPEED_LIMIT_MIN=1,
+	DEV_EVMS_MD_SPEED_LIMIT_MAX=2
 };
 
 /* /proc/sys/dev/raid */
diff -Naur linux-2002-10-01/init/do_mounts.c evms-2002-10-01/init/do_mounts.c
--- linux-2002-10-01/init/do_mounts.c	Tue Oct  1 15:20:49 2002
+++ evms-2002-10-01/init/do_mounts.c	Tue Sep 10 10:54:14 2002
@@ -213,6 +213,7 @@
 	{ "ftlc", 0x2c10 },
 	{ "ftld", 0x2c18 },
 	{ "mtdblock", 0x1f00 },
+	{ "evms", 0x7500 },
 	{ NULL, 0 }
 };
 
@@ -728,6 +729,11 @@
 	}
 #endif
 	mount_block_root("/dev/root", root_mountflags);
+}
+
+void get_root_device_name( char * root_name )
+{
+	strncpy(root_name, root_device_name, 63);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
