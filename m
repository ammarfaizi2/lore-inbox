Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272873AbRIGWPw>; Fri, 7 Sep 2001 18:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272874AbRIGWPr>; Fri, 7 Sep 2001 18:15:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16068 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272873AbRIGWPY>; Fri, 7 Sep 2001 18:15:24 -0400
Date: Fri, 7 Sep 2001 16:15:34 -0600
Message-Id: <200109072215.f87MFYg14896@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFT][PATCH] 2080 SD's and devfs fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Appended is a patch I would really appreciate lots of
people trying out. It adds support for up to 2080 SCSI discs, safely
(i.e. does not re-use assigned majors), as well as fixing a number of
races in the devfs core.

If enough people respond here, and all responses are "it doesn't screw
my data", it might convince Linus that this patch is indeed safe :-)
So please test and report back here. I've been running this patch for
over a month now, and it works fine. Other people have tried it too
and it works fine for them.

The patch was generated against 2.4.10-pre3 but applies cleanly
against 2.4.10-pre4 as well.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.10-pre3/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.10-pre3/Documentation/Configure.help	Sun Sep  2 10:22:26 2001
+++ linux/Documentation/Configure.help	Sun Sep  2 10:23:53 2001
@@ -5453,6 +5453,17 @@
   located on a SCSI disk. In this case, do not compile the driver for
   your SCSI host adapter (below) as a module either.
 
+Many SCSI Discs support
+CONFIG_SD_MANY
+  This allows you to support a very large number of SCSI discs
+  (approximately 2144). You will also need to set CONFIG_DEVFS_FS=y
+  later. This option may consume all unassigned block majors
+  (i.e. those which do not have an allocation in
+  Documentation/devices.txt). Enabling this will consume a few extra
+  kilobytes of kernel memory.
+
+  Unless you have a large storage array, say N.
+
 Extra SCSI Disks
 CONFIG_SD_EXTRA_DEVS
   This controls the amount of additional space allocated in tables for
diff -urN linux-2.4.10-pre3/Documentation/filesystems/devfs/ChangeLog linux/Documentation/filesystems/devfs/ChangeLog
--- linux-2.4.10-pre3/Documentation/filesystems/devfs/ChangeLog	Wed Jul 11 15:55:41 2001
+++ linux/Documentation/filesystems/devfs/ChangeLog	Sun Sep  2 10:23:53 2001
@@ -1675,3 +1675,79 @@
 - Fixed number leak for /dev/cdroms/cdrom%d
 
 - Fixed number leak for /dev/discs/disc%d
+===============================================================================
+Changes for patch v183
+
+- Fixed bug in <devfs_setup> which could hang boot process
+===============================================================================
+Changes for patch v184
+
+- Support large numbers of SCSI discs (~2144)
+
+- Documentation typo fix for fs/devfs/util.c
+
+- Fixed drivers/char/stallion.c for devfs
+
+- Added DEVFSD_NOTIFY_DELETE event
+
+- Updated README from master HTML file
+
+- Removed #include <asm/segment.h> from fs/devfs/base.c
+===============================================================================
+Changes for patch v185
+
+- Made <block_semaphore> and <char_semaphore> in fs/devfs/util.c
+  private
+
+- Fixed inode table races by removing it and using inode->u.generic_ip
+  instead
+
+- Moved <devfs_read_inode> into <get_vfs_inode>
+
+- Moved <devfs_write_inode> into <devfs_notify_change>
+===============================================================================
+Changes for patch v186
+
+- Fixed race in <devfs_do_symlink> for uni-processor
+
+- Fixed drivers/scsi/sd.h for when CONFIG_SD_MANY=n
+
+- Updated README from master HTML file
+===============================================================================
+Changes for patch v187
+
+- Fixed drivers/char/stallion.c for devfs
+
+- Fixed drivers/char/rocket.c for devfs
+
+- Fixed bug in <devfs_alloc_unique_number>: limited to 128 numbers
+===============================================================================
+Changes for patch v188
+
+- Updated major masks in fs/devfs/util.c up to Linus' "no new majors"
+  proclamation. Block: were 126 now 122 free, char: were 26 now 19 free
+
+- Updated README from master HTML file
+
+- Removed remnant of multi-mount support in <devfs_mknod>
+
+- Removed unused DEVFS_FL_SHOW_UNREG flag
+===============================================================================
+Changes for patch v189
+
+- Removed nlink field from struct devfs_inode
+
+- Removed auto-ownership for /dev/pty/* (BSD ptys) and used
+  DEVFS_FL_CURRENT_OWNER|DEVFS_FL_NO_PERSISTENCE for /dev/pty/s* (just
+  like Unix98 pty slaves) and made /dev/pty/m* rw-rw-rw- access
+===============================================================================
+Changes for patch v190
+
+- Updated README from master HTML file
+
+- Replaced BKL with global rwsem to protect symlink data (quick and
+  dirty hack)
+===============================================================================
+Changes for patch v191
+
+- Replaced global rwsem for symlink with per-link refcount
diff -urN linux-2.4.10-pre3/Documentation/filesystems/devfs/README linux/Documentation/filesystems/devfs/README
--- linux-2.4.10-pre3/Documentation/filesystems/devfs/README	Tue Jun 12 11:57:46 2001
+++ linux/Documentation/filesystems/devfs/README	Sun Sep  2 10:23:53 2001
@@ -3,7 +3,7 @@
 
 Linux Devfs (Device File System) FAQ
 Richard Gooch
-26-APR-2001
+23-AUG-2001
 
 -----------------------------------------------------------------------------
 
@@ -18,17 +18,14 @@
 
 http://www.atnf.csiro.au/~rgooch/linux/
 
-NEWSFLASH: The official 2.3.46 kernel has
-included the devfs patch. Future patches will be released which
-build on this. These patches are rolled into Linus' tree from time to
-time.
-
 A mailing list is available which you may subscribe to. Send
 email
 to majordomo@oss.sgi.com with the following line in the
 body of the message:
 subscribe devfs
-The list is archived at
+To unsubscribe, send the message body:
+unsubscribe devfs
+instead. The list is archived at
 
 http://oss.sgi.com/projects/devfs/archive/.
 
@@ -71,6 +68,8 @@
 
 Other resources
 
+Translations of this document
+
 
 -----------------------------------------------------------------------------
 
@@ -82,7 +81,7 @@
 name rather than major and minor numbers. These devices will appear in
 devfs automatically, with whatever default ownership and
 protection the driver specified. A daemon (devfsd) can be used to
-override these defaults.
+override these defaults. Devfs has been in the kernel since 2.3.46.
 
 NOTE that devfs is entirely optional. If you prefer the old
 disc-based device nodes, then simply leave CONFIG_DEVFS_FS=n (the
@@ -604,6 +603,20 @@
 has problems with symbolic links. Append the following lines to your
 /etc/securetty file:
 
+vc/1
+vc/2
+vc/3
+vc/4
+vc/5
+vc/6
+vc/7
+vc/8
+
+This will not weaken security. If you have a version of util-linux
+earlier than 2.10.h, please upgrade to 2.10.h or later. If you
+absolutely cannot upgrade, then also append the following lines to
+your /etc/securetty file:
+
 1
 2
 3
@@ -618,27 +631,13 @@
 are problems with dealing with symlinks, I'm suspicious of the level
 of security offered in any case.
 
-A better solution is to install util-linux-2.10.h or later, which
-fixes a bug with ttyname handling in the login programme. Then append
-the following lines to your /etc/securetty file:
-
-vc/1
-vc/2
-vc/3
-vc/4
-vc/5
-vc/6
-vc/7
-vc/8
-
-This will not weaken security.
-
 XFree86
 While not essential, it's probably a good idea to upgrade to XFree86
 4.0, as patches went in to make it more devfs-friendly. If you don't,
 you'll probably need to apply the following patch to
 /etc/security/console.perms so that ordinary users can run
-startx.
+startx. Note that not all distributions have this file (e.g. Debian),
+so if it's not present, don't worry about it.
 
 --- /etc/security/console.perms.orig    Sat Apr 17 16:26:47 1999 
 +++ /etc/security/console.perms Fri Feb 25 23:53:55 2000 
@@ -691,9 +690,12 @@
 described above.
 
 The Kernel
-Finally, you need to make sure devfs is compiled into your
-kernel. Set CONFIG_DEVFS_FS=y and CONFIG_DEVFS_MOUNT=y and recompile
-your kernel. At boot, devfs will be mounted onto /dev.
+Finally, you need to make sure devfs is compiled into your kernel. Set
+CONFIG_EXPERIMENTAL=y, CONFIG_DEVFS_FS=y and CONFIG_DEVFS_MOUNT=y by
+using favourite configuration tool (i.e. make config or
+make xconfig) and then make dep; make clean and then
+recompile your kernel and modules. At boot, devfs will be mounted onto
+/dev.
 
 If you encounter problems booting (for example if you forgot a
 configuration step), you can pass devfs=nomount at the kernel
@@ -805,8 +807,17 @@
 directory to store the database. The sample /etc/devfsd.conf
 file above may still be used. You will need to create the
 /dev-state directory prior to installing devfsd. If you have
-old permissions in /dev, then just copy the device nodes over
-to the new directory.
+old permissions in /dev, then just copy (or move) the device
+nodes over to the new directory.
+
+Which method is better?
+
+The best method is to have the permissions database stored in the
+mounted-over /dev. This is because you will not need to copy
+device nodes over to /dev-state, and because it allows you to
+switch between devfs and non-devfs kernels, without requiring you to
+copy permissions between /dev-state (for devfs) and
+/dev (for non-devfs).
 
 
 Dealing with drivers without devfs support
@@ -1038,6 +1049,13 @@
 directory tree that reflects the topology of available devices. The
 topological tree is useful for finding how your devices are arranged.
 
+Below is a list of the naming schemes for the most common drivers. A
+list of reserved device names is
+available for reference. Please send email to
+rgooch@atnf.csiro.au to obtain an allocation. Please be
+patient (the maintainer is busy). An alternative name may be allocated
+instead of the requested name, at the discretion of the maintainer.
+
 Disc Devices
 
 All discs, whether SCSI, IDE or whatever, are placed under the
@@ -1486,6 +1504,47 @@
 namespace, but have had no response.
 
 
+How can I test if I have devfs compiled into my kernel?
+
+All filesystems built-in or currently loaded are listed in
+/proc/filesystems. If you see a devfs entry, then
+you know that devfs was compiled into your kernel. If you have
+correctly configured and rebuilt your kernel, then devfs will be
+built-in. If you think you've configured it in, but
+/proc/filesystems doesn't show it, you've made a mistake.
+Common mistakes include:
+
+Using a 2.2.x kernel without applying the devfs patch (if you
+don't know how to patch your kernel, use 2.4.x instead, don't bother
+asking me how to patch)
+Forgetting to set CONFIG_EXPERIMENTAL=y
+Forgetting to set CONFIG_DEVFS_FS=y
+Forgetting to set CONFIG_DEVFS_MOUNT=y (if you want devfs
+to be automatically mounted at boot)
+Editing your .config manually, instead of using make
+config or make xconfig
+Forgetting to run make dep; make clean after changing the
+configuration and before compiling
+Forgetting to compile your kernel and modules
+Forgetting to install your kernel
+Forgetting to install your modules
+
+Please check twice that you've done all these steps before sending in
+a bug report.
+
+
+
+How can I test if devfs is mounted on /dev?
+
+The device filesystem will always create an entry called
+".devfsd", which is used to communicate with the daemon. Even
+if the daemon is not running, this entry will exist. Testing for the
+existence of this entry is the approved method of determining if devfs
+is mounted or not. Note that the type of entry (i.e. regular file,
+character device, named pipe, etc.) may change without notice. Only
+the existence of the entry should be relied upon.
+
+
 
 
 
@@ -1713,6 +1772,23 @@
 
 2nd Annual Storage Management Workshop held in Miamia, Florida,
 U.S.A. in October 2000.
+
+
+
+
+-----------------------------------------------------------------------------
+
+
+Translations of this document
+
+This document has been translated into other languages.
+
+
+
+
+A Korean translation by viatoris@nownuri.net is available at
+
+http://home.nownuri.net/~viatoris/devfs/devfs.html 
 
 
 
diff -urN linux-2.4.10-pre3/Documentation/filesystems/devfs/boot-options linux/Documentation/filesystems/devfs/boot-options
--- linux-2.4.10-pre3/Documentation/filesystems/devfs/boot-options	Mon May  8 23:00:41 2000
+++ linux/Documentation/filesystems/devfs/boot-options	Sun Sep  2 10:23:53 2001
@@ -4,7 +4,7 @@
 
 		Richard Gooch <rgooch@atnf.csiro.au>
 
-			      30-APR-2000
+			      18-AUG-2001
 
 
 When CONFIG_DEVFS_DEBUG is enabled, you can pass several boot options
@@ -19,6 +19,8 @@
 
 devfs=dmod,dreg
 
+You may prefix "no" to any option. This will invert the option.
+
 
 Debugging Options
 =================
@@ -42,11 +44,11 @@
 
 dilookup	print inode lookup requests
 
-diread		print inode reads
+diget		print VFS inode allocations
 
 diunlink	print inode unlinks
 
-diwrite		print inode writes
+dichange	print inode changes
 
 dimknod		print calls to mknod(2)
 
@@ -58,10 +60,6 @@
 
 These control the default behaviour of devfs. The options are:
 
-show		show unregistered devices by default
-
 mount		mount devfs onto /dev at boot time
-
-nomount		do not mount devfs onto /dev at boot time
 
 only		disable non-devfs device nodes for devfs-capable drivers
diff -urN linux-2.4.10-pre3/drivers/char/pty.c linux/drivers/char/pty.c
--- linux-2.4.10-pre3/drivers/char/pty.c	Thu Jun 29 19:25:50 2000
+++ linux/drivers/char/pty.c	Sun Sep  2 10:23:53 2001
@@ -334,7 +334,8 @@
 	/*  Register a slave for the master  */
 	if (tty->driver.major == PTY_MASTER_MAJOR)
 		tty_register_devfs(&tty->link->driver,
-				   DEVFS_FL_AUTO_OWNER | DEVFS_FL_WAIT,
+				   DEVFS_FL_CURRENT_OWNER |
+				   DEVFS_FL_NO_PERSISTENCE | DEVFS_FL_WAIT,
 				   tty->link->driver.minor_start +
 				   MINOR(tty->device)-tty->driver.minor_start);
 	retval = 0;
diff -urN linux-2.4.10-pre3/drivers/char/rocket.c linux/drivers/char/rocket.c
--- linux-2.4.10-pre3/drivers/char/rocket.c	Mon Jul  2 14:56:41 2001
+++ linux/drivers/char/rocket.c	Sun Sep  2 10:23:53 2001
@@ -2185,7 +2185,11 @@
 	 */
 	memset(&rocket_driver, 0, sizeof(struct tty_driver));
 	rocket_driver.magic = TTY_DRIVER_MAGIC;
+#ifdef CONFIG_DEVFS_FS
+	rocket_driver.name = "tts/R%d";
+#else
 	rocket_driver.name = "ttyR";
+#endif
 	rocket_driver.major = TTY_ROCKET_MAJOR;
 	rocket_driver.minor_start = 0;
 	rocket_driver.num = MAX_RP_PORTS;
@@ -2227,7 +2231,11 @@
 	 * the minor number and the subtype code.
 	 */
 	callout_driver = rocket_driver;
+#ifdef CONFIG_DEVFS_FS
+	callout_driver.name = "cua/R%d";
+#else
 	callout_driver.name = "cur";
+#endif
 	callout_driver.major = CUA_ROCKET_MAJOR;
 	callout_driver.minor_start = 0;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
diff -urN linux-2.4.10-pre3/drivers/char/stallion.c linux/drivers/char/stallion.c
--- linux-2.4.10-pre3/drivers/char/stallion.c	Fri Mar  2 12:12:07 2001
+++ linux/drivers/char/stallion.c	Sun Sep  2 10:23:53 2001
@@ -139,8 +139,13 @@
 static char	*stl_drvtitle = "Stallion Multiport Serial Driver";
 static char	*stl_drvname = "stallion";
 static char	*stl_drvversion = "5.6.0";
+#ifdef CONFIG_DEVFS_FS
+static char	*stl_serialname = "tts/E%d";
+static char	*stl_calloutname = "cua/E%d";
+#else
 static char	*stl_serialname = "ttyE";
 static char	*stl_calloutname = "cue";
+#endif
 
 static struct tty_driver	stl_serial;
 static struct tty_driver	stl_callout;
diff -urN linux-2.4.10-pre3/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux-2.4.10-pre3/drivers/char/tty_io.c	Sun Aug 12 18:36:24 2001
+++ linux/drivers/char/tty_io.c	Sun Sep  2 10:23:53 2001
@@ -2021,7 +2021,7 @@
 			break;
 		default:
 			if (driver->major == PTY_MASTER_MAJOR)
-				flags |= DEVFS_FL_AUTO_OWNER;
+				mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
 			break;
 	}
 	if ( (minor <  driver->minor_start) || 
diff -urN linux-2.4.10-pre3/drivers/scsi/Config.in linux/drivers/scsi/Config.in
--- linux-2.4.10-pre3/drivers/scsi/Config.in	Thu Jul  5 12:28:16 2001
+++ linux/drivers/scsi/Config.in	Sun Sep  2 10:23:53 2001
@@ -3,7 +3,8 @@
 dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
 
 if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
-   int  'Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
+   bool '    Many (~2144) SCSI discs support (requires devfs)' CONFIG_SD_MANY
+   int  '    Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
 fi
 
 dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
diff -urN linux-2.4.10-pre3/drivers/scsi/hosts.h linux/drivers/scsi/hosts.h
--- linux-2.4.10-pre3/drivers/scsi/hosts.h	Wed Aug 15 15:23:11 2001
+++ linux/drivers/scsi/hosts.h	Sun Sep  2 10:23:53 2001
@@ -506,9 +506,8 @@
     const char * tag;
     struct module * module;	  /* Used for loadable modules */
     unsigned char scsi_type;
-    unsigned int major;
-    unsigned int min_major;      /* Minimum major in range. */ 
-    unsigned int max_major;      /* Maximum major in range. */
+    unsigned int *majors;         /* Array of majors used by driver */
+    unsigned int num_majors;      /* Number of majors used by driver */
     unsigned int nr_dev;	  /* Number currently attached */
     unsigned int dev_noticed;	  /* Number of devices detected. */
     unsigned int dev_max;	  /* Current size of arrays */
diff -urN linux-2.4.10-pre3/drivers/scsi/osst.c linux/drivers/scsi/osst.c
--- linux-2.4.10-pre3/drivers/scsi/osst.c	Thu Jul 19 22:18:15 2001
+++ linux/drivers/scsi/osst.c	Sun Sep  2 10:23:53 2001
@@ -160,7 +160,6 @@
        name:		"OnStream tape",
        tag:		"osst",
        scsi_type:	TYPE_TAPE,
-       major:		OSST_MAJOR,
        detect:		osst_detect,
        init:		osst_init,
        attach:		osst_attach,
diff -urN linux-2.4.10-pre3/drivers/scsi/scsi_lib.c linux/drivers/scsi/scsi_lib.c
--- linux-2.4.10-pre3/drivers/scsi/scsi_lib.c	Sun Aug 12 11:51:42 2001
+++ linux/drivers/scsi/scsi_lib.c	Sun Sep  2 10:23:53 2001
@@ -788,25 +788,10 @@
 		 * Search for a block device driver that supports this
 		 * major.
 		 */
-		if (spnt->blk && spnt->major == major) {
-			return spnt;
-		}
-		/*
-		 * I am still not entirely satisfied with this solution,
-		 * but it is good enough for now.  Disks have a number of
-		 * major numbers associated with them, the primary
-		 * 8, which we test above, and a secondary range of 7
-		 * different consecutive major numbers.   If this ever
-		 * becomes insufficient, then we could add another function
-		 * to the structure, and generalize this completely.
-		 */
-		if( spnt->min_major != 0 
-		    && spnt->max_major != 0
-		    && major >= spnt->min_major
-		    && major <= spnt->max_major )
-		{
-			return spnt;
-		}
+		int i;
+		if (!spnt->blk || !spnt->majors) continue;
+		for (i = 0; i < spnt->num_majors; ++i)
+			if (spnt->majors[i] == major) return spnt;
 	}
 	return NULL;
 }
diff -urN linux-2.4.10-pre3/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- linux-2.4.10-pre3/drivers/scsi/sd.c	Sun Sep  2 10:22:27 2001
+++ linux/drivers/scsi/sd.c	Sun Sep  2 10:23:53 2001
@@ -28,6 +28,8 @@
  *	
  *	 Modified by Alex Davis <letmein@erols.com>
  *       Fix problem where removable media could be ejected after sd_open.
+ *
+ *       Modified by Richard Gooch rgooch@atnf.csiro.au to support >128 discs.
  */
 
 #include <linux/config.h>
@@ -65,7 +67,7 @@
  *  static const char RCSid[] = "$Header:";
  */
 
-#define SD_MAJOR(i) (!(i) ? SCSI_DISK0_MAJOR : SCSI_DISK1_MAJOR-1+(i))
+#define SD_MAJOR(i) sd_template.majors[(i)]
 
 #define SCSI_DISKS_PER_MAJOR	16
 #define SD_MAJOR_NUMBER(i)	SD_MAJOR((i) >> 8)
@@ -108,12 +110,6 @@
 	name:"disk",
 	tag:"sd",
 	scsi_type:TYPE_DISK,
-	major:SCSI_DISK0_MAJOR,
-        /*
-         * Secondary range of majors that this driver handles.
-         */
-	min_major:SCSI_DISK1_MAJOR,
-	max_major:SCSI_DISK7_MAJOR,
 	blk:1,
 	detect:sd_detect,
 	init:sd_init,
@@ -123,6 +119,19 @@
 	init_command:sd_init_command,
 };
 
+#ifdef CONFIG_SD_MANY
+static inline int sd_devnum_to_index (int devnum)
+{
+    int i, major = MAJOR (devnum);
+
+    for (i = 0; i < sd_template.num_majors; ++i)
+    {
+        if (sd_template.majors[i] != major) continue;
+        return (i << 4) | (MINOR (devnum) >> 4);
+    }
+    return -ENODEV;
+}
+#endif
 
 static void rw_intr(Scsi_Cmnd * SCpnt);
 
@@ -1054,6 +1063,43 @@
 	return i;
 }
 
+static int sd_alloc_majors (void)
+/*  Allocate as many majors as required
+ */
+{
+	int i, major;
+
+	if ( ( sd_template.majors =
+	       kmalloc (sizeof *sd_template.majors * N_USED_SD_MAJORS,
+			GFP_KERNEL) ) == NULL ) {
+		printk ("sd.c: unable to allocate major array\n");
+		return -ENOMEM;
+	}
+	sd_template.majors[0] = SCSI_DISK0_MAJOR;
+	for (i = 1; (i < N_USED_SD_MAJORS) && (i <N_SD_PREASSIGNED_MAJORS);++i)
+		sd_template.majors[i] = SCSI_DISK1_MAJOR + i - 1;
+	for (; (i >= N_SD_PREASSIGNED_MAJORS) && (i < N_USED_SD_MAJORS); ++i) {
+		if ( ( major = devfs_alloc_major (DEVFS_SPECIAL_BLK) ) < 0 ) {
+			printk (KERN_WARNING __FUNCTION__ "() major[%d] allocation failed\n", i);
+			break;
+		}
+		sd_template.majors[i] = major;
+	}
+	sd_template.dev_max = i * SCSI_DISKS_PER_MAJOR;
+	sd_template.num_majors = i;
+	return 0;
+}	/*  End Function sd_alloc_majors  */
+
+static void sd_dealloc_majors (void)
+/*  Deallocate all the allocated majors
+ */
+{
+	int i;
+
+	for (i = sd_template.num_majors - 1; i >= N_SD_PREASSIGNED_MAJORS; --i)
+		devfs_dealloc_major (DEVFS_SPECIAL_BLK, sd_template.majors[i]);
+}	/*  End Function sd_dealloc_majors  */
+
 /*
  * The sd_init() function looks at all SCSI drives present, determines
  * their size, and reads partition table entries for them.
@@ -1068,16 +1114,20 @@
 	if (sd_template.dev_noticed == 0)
 		return 0;
 
-	if (!rscsi_disks)
+	if (!rscsi_disks) {
+		if ( in_interrupt () ) {
+			printk (__FUNCTION__ "(): called from interrupt\n");
+			return 1;
+		}
 		sd_template.dev_max = sd_template.dev_noticed + SD_EXTRA_DEVS;
-
-	if (sd_template.dev_max > N_SD_MAJORS * SCSI_DISKS_PER_MAJOR)
-		sd_template.dev_max = N_SD_MAJORS * SCSI_DISKS_PER_MAJOR;
+		if ( sd_alloc_majors() ) return 1;
+	}
 
 	if (!sd_registered) {
 		for (i = 0; i < N_USED_SD_MAJORS; i++) {
 			if (devfs_register_blkdev(SD_MAJOR(i), "sd", &sd_fops)) {
 				printk("Unable to get major %d for SCSI disk\n", SD_MAJOR(i));
+				sd_dealloc_majors();
 				return 1;
 			}
 		}
@@ -1087,22 +1137,22 @@
 	if (rscsi_disks)
 		return 0;
 
-	rscsi_disks = kmalloc(sd_template.dev_max * sizeof(Scsi_Disk), GFP_ATOMIC);
+	rscsi_disks = vmalloc(sd_template.dev_max * sizeof(Scsi_Disk));
 	if (!rscsi_disks)
 		goto cleanup_devfs;
 	memset(rscsi_disks, 0, sd_template.dev_max * sizeof(Scsi_Disk));
 
 	/* for every (necessary) major: */
-	sd_sizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_sizes = vmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_sizes)
 		goto cleanup_disks;
 	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(int));
 
-	sd_blocksizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_blocksizes = vmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_blocksizes)
 		goto cleanup_sizes;
 	
-	sd_hardsizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	sd_hardsizes = vmalloc((sd_template.dev_max << 4) * sizeof(int));
 	if (!sd_hardsizes)
 		goto cleanup_blocksizes;
 
@@ -1115,9 +1165,7 @@
 		blksize_size[SD_MAJOR(i)] = sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR << 4);
 		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << 4);
 	}
-	sd = kmalloc((sd_template.dev_max << 4) *
-					  sizeof(struct hd_struct),
-					  GFP_ATOMIC);
+	sd = vmalloc((sd_template.dev_max << 4) * sizeof(struct hd_struct));
 	if (!sd)
 		goto cleanup_sd;
 	memset(sd, 0, (sd_template.dev_max << 4) * sizeof(struct hd_struct));
@@ -1164,19 +1212,20 @@
 	}
 	kfree(sd_gendisks);
 cleanup_sd_gendisks:
-	kfree(sd);
+	vfree(sd);
 cleanup_sd:
-	kfree(sd_hardsizes);
+	vfree(sd_hardsizes);
 cleanup_blocksizes:
-	kfree(sd_blocksizes);
+	vfree(sd_blocksizes);
 cleanup_sizes:
-	kfree(sd_sizes);
+	vfree(sd_sizes);
 cleanup_disks:
-	kfree(rscsi_disks);
+	vfree(rscsi_disks);
 cleanup_devfs:
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 	}
+	sd_dealloc_majors();
 	sd_registered--;
 	return 1;
 }
@@ -1384,6 +1433,7 @@
 
 	scsi_unregister_module(MODULE_SCSI_DEV, &sd_template);
 
+	sd_dealloc_majors();
 	for (i = 0; i < N_USED_SD_MAJORS; i++)
 		devfs_unregister_blkdev(SD_MAJOR(i), "sd");
 
diff -urN linux-2.4.10-pre3/drivers/scsi/sd.h linux/drivers/scsi/sd.h
--- linux-2.4.10-pre3/drivers/scsi/sd.h	Wed Aug 15 15:23:15 2001
+++ linux/drivers/scsi/sd.h	Sun Sep  2 10:23:53 2001
@@ -42,10 +42,14 @@
  */
 extern kdev_t sd_find_target(void *host, int tgt);
 
-#define N_SD_MAJORS	8
+#define N_SD_PREASSIGNED_MAJORS	8
 
-#define SD_MAJOR_MASK	(N_SD_MAJORS - 1)
+#ifdef CONFIG_SD_MANY
+#define SD_PARTITION(i)		((sd_devnum_to_index((i)) << 4) | ((i)&0x0f))
+#else
+#define SD_MAJOR_MASK	(N_SD_PREASSIGNED_MAJORS - 1)
 #define SD_PARTITION(i)		(((MAJOR(i) & SD_MAJOR_MASK) << 8) | (MINOR(i) & 255))
+#endif
 
 #endif
 
diff -urN linux-2.4.10-pre3/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-2.4.10-pre3/drivers/scsi/sg.c	Wed Jul  4 16:39:28 2001
+++ linux/drivers/scsi/sg.c	Sun Sep  2 10:23:53 2001
@@ -123,7 +123,6 @@
 {
       tag:"sg",
       scsi_type:0xff,
-      major:SCSI_GENERIC_MAJOR,
       detect:sg_detect,
       init:sg_init,
       finish:sg_finish,
diff -urN linux-2.4.10-pre3/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- linux-2.4.10-pre3/drivers/scsi/sr.c	Sun Sep  2 10:22:27 2001
+++ linux/drivers/scsi/sr.c	Sun Sep  2 10:23:53 2001
@@ -69,12 +69,15 @@
 
 static int sr_init_command(Scsi_Cmnd *);
 
+static unsigned int sr_major = SCSI_CDROM_MAJOR;
+
 static struct Scsi_Device_Template sr_template =
 {
 	name:"cdrom",
 	tag:"sr",
 	scsi_type:TYPE_ROM,
-	major:SCSI_CDROM_MAJOR,
+	majors:&sr_major,
+	num_majors:1,
 	blk:1,
 	detect:sr_detect,
 	init:sr_init,
diff -urN linux-2.4.10-pre3/drivers/scsi/st.c linux/drivers/scsi/st.c
--- linux-2.4.10-pre3/drivers/scsi/st.c	Sun Aug 12 12:21:47 2001
+++ linux/drivers/scsi/st.c	Sun Sep  2 10:23:53 2001
@@ -166,7 +166,6 @@
 	name:"tape", 
 	tag:"st", 
 	scsi_type:TYPE_TAPE,
-	major:SCSI_TAPE_MAJOR, 
 	detect:st_detect, 
 	init:st_init,
 	attach:st_attach, 
diff -urN linux-2.4.10-pre3/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.4.10-pre3/fs/devfs/base.c	Wed Jul 11 15:55:41 2001
+++ linux/fs/devfs/base.c	Sun Sep  2 10:23:53 2001
@@ -388,7 +388,7 @@
 	       Work sponsored by SGI.
   v0.83
     19991107   Richard Gooch <rgooch@atnf.csiro.au>
-	       Added DEVFS_ FL_WAIT flag.
+	       Added DEVFS_FL_WAIT flag.
 	       Work sponsored by SGI.
   v0.84
     19991107   Richard Gooch <rgooch@atnf.csiro.au>
@@ -511,6 +511,37 @@
 	       Removed broken devnum allocation and use <devfs_alloc_devnum>.
 	       Fixed old devnum leak by calling new <devfs_dealloc_devnum>.
   v0.107
+    20010712   Richard Gooch <rgooch@atnf.csiro.au>
+	       Fixed bug in <devfs_setup> which could hang boot process.
+  v0.108
+    20010730   Richard Gooch <rgooch@atnf.csiro.au>
+	       Added DEVFSD_NOTIFY_DELETE event.
+    20010801   Richard Gooch <rgooch@atnf.csiro.au>
+	       Removed #include <asm/segment.h>.
+  v0.109
+    20010807   Richard Gooch <rgooch@atnf.csiro.au>
+	       Fixed inode table races by removing it and using
+	       inode->u.generic_ip instead.
+	       Moved <devfs_read_inode> into <get_vfs_inode>.
+	       Moved <devfs_write_inode> into <devfs_notify_change>.
+  v0.110
+    20010808   Richard Gooch <rgooch@atnf.csiro.au>
+	       Fixed race in <devfs_do_symlink> for uni-processor.
+  v0.111
+    20010818   Richard Gooch <rgooch@atnf.csiro.au>
+	       Removed remnant of multi-mount support in <devfs_mknod>.
+               Removed unused DEVFS_FL_SHOW_UNREG flag.
+  v0.112
+    20010820   Richard Gooch <rgooch@atnf.csiro.au>
+	       Removed nlink field from struct devfs_inode.
+  v0.113
+    20010823   Richard Gooch <rgooch@atnf.csiro.au>
+	       Replaced BKL with global rwsem to protect symlink data (quick
+	       and dirty hack).
+  v0.114
+    20010827   Richard Gooch <rgooch@atnf.csiro.au>
+	       Replaced global rwsem for symlink with per-link refcount.
+  v0.115
 */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -533,21 +564,20 @@
 #include <linux/smp_lock.h>
 #include <linux/smp.h>
 #include <linux/version.h>
+#include <linux/rwsem.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
-#define DEVFS_VERSION            "0.107 (20010709)"
+#define DEVFS_VERSION            "0.115 (20010827)"
 
 #define DEVFS_NAME "devfs"
 
-#define INODE_TABLE_INC 250
 #define FIRST_INODE 1
 
 #define STRING_LENGTH 256
@@ -557,7 +587,7 @@
 #  define FALSE 0
 #endif
 
-#define IS_HIDDEN(de) (( ((de)->hide && !is_devfsd_or_child(fs_info)) || (!(de)->registered&& !(de)->show_unreg)))
+#define IS_HIDDEN(de) (( ((de)->hide && !is_devfsd_or_child(fs_info)) || !(de)->registered))
 
 #define DEBUG_NONE         0x00000
 #define DEBUG_MODULE_LOAD  0x00001
@@ -567,8 +597,8 @@
 #define DEBUG_S_PUT        0x00010
 #define DEBUG_I_LOOKUP     0x00020
 #define DEBUG_I_CREATE     0x00040
-#define DEBUG_I_READ       0x00080
-#define DEBUG_I_WRITE      0x00100
+#define DEBUG_I_GET        0x00080
+#define DEBUG_I_CHANGE     0x00100
 #define DEBUG_I_UNLINK     0x00200
 #define DEBUG_I_RLINK      0x00400
 #define DEBUG_I_FLINK      0x00800
@@ -577,16 +607,12 @@
 #define DEBUG_D_DELETE     0x04000
 #define DEBUG_D_RELEASE    0x08000
 #define DEBUG_D_IPUT       0x10000
-#define DEBUG_ALL          (DEBUG_MODULE_LOAD | DEBUG_REGISTER | \
-			    DEBUG_SET_FLAGS | DEBUG_I_LOOKUP |   \
-			    DEBUG_I_UNLINK | DEBUG_I_MKNOD |     \
-			    DEBUG_D_RELEASE | DEBUG_D_IPUT)
+#define DEBUG_ALL          0xfffff
 #define DEBUG_DISABLED     DEBUG_NONE
 
 #define OPTION_NONE             0x00
-#define OPTION_SHOW             0x01
-#define OPTION_MOUNT            0x02
-#define OPTION_ONLY             0x04
+#define OPTION_MOUNT            0x01
+#define OPTION_ONLY             0x02
 
 #define OOPS(format, args...) {printk (format, ## args); \
                                printk ("Forcing Oops\n"); \
@@ -630,8 +656,10 @@
 
 struct symlink_type
 {
-    unsigned int length;  /*  Not including the NULL-termimator  */
-    char *linkname;       /*  This is NULL-terminated            */
+    atomic_t refcount;           /*  When this drops to zero, it's unused    */
+    rwlock_t lock;               /*  Lock around the registered flag         */
+    unsigned int length;         /*  Not including the NULL-termimator       */
+    char *linkname;              /*  This is NULL-terminated                 */
 };
 
 struct fifo_type
@@ -650,7 +678,6 @@
     umode_t mode;
     uid_t uid;
     gid_t gid;
-    nlink_t nlink;
 };
 
 struct devfs_entry
@@ -672,7 +699,6 @@
     umode_t mode;
     unsigned short namelen;  /*  I think 64k+ filenames are a way off...  */
     unsigned char registered:1;
-    unsigned char show_unreg:1;
     unsigned char hide:1;
     unsigned char no_persistence:1;
     char name[1];            /*  This is just a dummy: the allocated array is
@@ -693,9 +719,6 @@
 
 struct fs_info      /*  This structure is for the mounted devfs  */
 {
-    unsigned int num_inodes;    /*  Number of inodes created         */
-    unsigned int table_size;    /*  Size of the inode pointer table  */
-    struct devfs_entry **table;
     struct super_block *sb;
     volatile struct devfsd_buf_entry *devfsd_buffer;
     spinlock_t devfsd_buffer_lock;
@@ -765,7 +788,7 @@
 						    unsigned int namelen,
 						    int traverse_symlink)
 {
-    struct devfs_entry *curr;
+    struct devfs_entry *curr, *retval;
 
     if ( !S_ISDIR (parent->mode) )
     {
@@ -781,48 +804,41 @@
     if (curr == NULL) return NULL;
     if (!S_ISLNK (curr->mode) || !traverse_symlink) return curr;
     /*  Need to follow the link: this is a stack chomper  */
-    return search_for_entry (parent,
-			     curr->u.symlink.linkname, curr->u.symlink.length,
-			     FALSE, FALSE, NULL, TRUE);
+    read_lock (&curr->u.symlink.lock);
+    if (!curr->registered)
+    {
+	read_unlock (&curr->u.symlink.lock);
+	return NULL;
+    }
+    atomic_inc (&curr->u.symlink.refcount);
+    read_unlock (&curr->u.symlink.lock);
+    retval = search_for_entry (parent, curr->u.symlink.linkname,
+			       curr->u.symlink.length, FALSE, FALSE, NULL,
+			       TRUE);
+    if ( atomic_dec_and_test (&curr->u.symlink.refcount) )
+	kfree (curr->u.symlink.linkname);
+    return retval;
 }   /*  End Function search_for_entry_in_dir  */
 
 static struct devfs_entry *create_entry (struct devfs_entry *parent,
 					 const char *name,unsigned int namelen)
 {
-    struct devfs_entry *new, **table;
+    struct devfs_entry *new;
+    static unsigned long inode_counter = FIRST_INODE;
+    static spinlock_t counter_lock = SPIN_LOCK_UNLOCKED;
 
-    /*  First ensure table size is enough  */
-    if (fs_info.num_inodes >= fs_info.table_size)
-    {
-	if ( ( table = kmalloc (sizeof *table *
-				(fs_info.table_size + INODE_TABLE_INC),
-				GFP_KERNEL) ) == NULL ) return NULL;
-	fs_info.table_size += INODE_TABLE_INC;
-#ifdef CONFIG_DEVFS_DEBUG
-	if (devfs_debug & DEBUG_I_CREATE)
-	    printk ("%s: create_entry(): grew inode table to: %u entries\n",
-		    DEVFS_NAME, fs_info.table_size);
-#endif
-	if (fs_info.table)
-	{
-	    memcpy (table, fs_info.table, sizeof *table *fs_info.num_inodes);
-	    kfree (fs_info.table);
-	}
-	fs_info.table = table;
-    }
     if ( name && (namelen < 1) ) namelen = strlen (name);
     if ( ( new = kmalloc (sizeof *new + namelen, GFP_KERNEL) ) == NULL )
 	return NULL;
     /*  Magic: this will set the ctime to zero, thus subsequent lookups will
 	trigger the call to <update_devfs_inode_from_entry>  */
     memset (new, 0, sizeof *new + namelen);
+    spin_lock (&counter_lock);
+    new->inode.ino = inode_counter++;
+    spin_unlock (&counter_lock);
     new->parent = parent;
     if (name) memcpy (new->name, name, namelen);
     new->namelen = namelen;
-    new->inode.ino = fs_info.num_inodes + FIRST_INODE;
-    new->inode.nlink = 1;
-    fs_info.table[fs_info.num_inodes] = new;
-    ++fs_info.num_inodes;
     if (parent == NULL) return new;
     new->prev = parent->u.dir.last;
     /*  Insert into the parent directory's list of children  */
@@ -1083,14 +1099,10 @@
 							   int do_check)
 {
     struct devfs_entry *de;
-    struct fs_info *fs_info;
 
     if (inode == NULL) return NULL;
-    if (inode->i_ino < FIRST_INODE) return NULL;
-    fs_info = inode->i_sb->u.generic_sbp;
-    if (fs_info == NULL) return NULL;
-    if (inode->i_ino - FIRST_INODE >= fs_info->num_inodes) return NULL;
-    de = fs_info->table[inode->i_ino - FIRST_INODE];
+    de = inode->u.generic_ip;
+    if (!de) printk (__FUNCTION__ "(): NULL de for inode %ld\n", inode->i_ino);
     if (do_check && de && !de->registered) de = NULL;
     return de;
 }   /*  End Function get_devfs_entry_from_vfs_inode  */
@@ -1342,12 +1354,12 @@
 	    return NULL;
 	}
     }
-    de->u.fcb.autogen = 0;
+    de->u.fcb.autogen = FALSE;
     if ( S_ISCHR (mode) || S_ISBLK (mode) )
     {
 	de->u.fcb.u.device.major = major;
 	de->u.fcb.u.device.minor = minor;
-	de->u.fcb.autogen = (devnum == NODEV) ? 0 : 1;
+	de->u.fcb.autogen = (devnum == NODEV) ? FALSE : TRUE;
     }
     else if ( S_ISREG (mode) ) de->u.fcb.u.file.size = 0;
     else
@@ -1377,8 +1389,6 @@
 	++de->parent->u.dir.num_removable;
     }
     de->u.fcb.open = FALSE;
-    de->show_unreg = ( (boot_options & OPTION_SHOW)
-			|| (flags & DEVFS_FL_SHOW_UNREG) ) ? TRUE : FALSE;
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
     de->no_persistence = (flags & DEVFS_FL_NO_PERSISTENCE) ? TRUE : FALSE;
     de->registered = TRUE;
@@ -1418,13 +1428,16 @@
 				   MKDEV (de->u.fcb.u.device.major,
 					  de->u.fcb.u.device.minor) );
 	}
-	de->u.fcb.autogen = 0;
+	de->u.fcb.autogen = FALSE;
 	return;
     }
     if (S_ISLNK (de->mode) && de->registered)
     {
+	write_lock (&de->u.symlink.lock);
 	de->registered = FALSE;
-	kfree (de->u.symlink.linkname);
+	write_unlock (&de->u.symlink.lock);
+	if ( atomic_dec_and_test (&de->u.symlink.refcount) )
+	    kfree (de->u.symlink.linkname);
 	return;
     }
     if ( S_ISFIFO (de->mode) )
@@ -1475,7 +1488,7 @@
 {
     int is_new;
     unsigned int linklength;
-    char *newname;
+    char *newlink;
     struct devfs_entry *de;
 
     if (handle != NULL) *handle = NULL;
@@ -1494,49 +1507,32 @@
 	return -EINVAL;
     }
     linklength = strlen (link);
-    de = search_for_entry (dir, name, strlen (name), TRUE, TRUE, &is_new,
-			   FALSE);
-    if (de == NULL) return -ENOMEM;
-    if (!S_ISLNK (de->mode) && de->registered)
+    if ( ( newlink = kmalloc (linklength + 1, GFP_KERNEL) ) == NULL )
+	return -ENOMEM;
+    memcpy (newlink, link, linklength);
+    newlink[linklength] = '\0';
+    if ( ( de = search_for_entry (dir, name, strlen (name), TRUE, TRUE,
+				  &is_new, FALSE) ) == NULL )
     {
-	printk ("%s: devfs_do_symlink(): non-link entry already exists\n",
-		DEVFS_NAME);
+	kfree (newlink);
+	return -ENOMEM;
+    }
+    if (de->registered)
+    {
+	kfree (newlink);
+	printk ("%s: devfs_do_symlink(%s): entry already exists\n",
+		DEVFS_NAME, name);
 	return -EEXIST;
     }
-    if (handle != NULL) *handle = de;
     de->mode = S_IFLNK | S_IRUGO | S_IXUGO;
     de->info = info;
-    de->show_unreg = ( (boot_options & OPTION_SHOW)
-		       || (flags & DEVFS_FL_SHOW_UNREG) ) ? TRUE : FALSE;
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
-    /*  Note there is no need to fiddle the dentry cache if the symlink changes
-	as the symlink follow method is called every time it's needed  */
-    if ( de->registered && (linklength == de->u.symlink.length) )
-    {
-	/*  New link is same length as old link  */
-	if (memcmp (link, de->u.symlink.linkname, linklength) == 0) return 0;
-	return -EEXIST;  /*  Contents would change  */
-    }
-    /*  Have to create/update  */
-    if (de->registered) return -EEXIST;
-    if ( ( newname = kmalloc (linklength + 1, GFP_KERNEL) ) == NULL )
-    {
-	struct devfs_entry *parent = de->parent;
-
-	if (!is_new) return -ENOMEM;
-	/*  Have to clean up  */
-	if (de->prev == NULL) parent->u.dir.first = de->next;
-	else de->prev->next = de->next;
-	if (de->next == NULL) parent->u.dir.last = de->prev;
-	else de->next->prev = de->prev;
-	kfree (de);
-	return -ENOMEM;
-    }
-    de->u.symlink.linkname = newname;
-    memcpy (de->u.symlink.linkname, link, linklength);
-    de->u.symlink.linkname[linklength] = '\0';
+    de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
+    atomic_set (&de->u.symlink.refcount, 1);
+    rwlock_init (&de->u.symlink.lock);
     de->registered = TRUE;
+    if (handle != NULL) *handle = de;
     return 0;
 }   /*  End Function devfs_do_symlink  */
 
@@ -1621,7 +1617,6 @@
     de->mode = S_IFDIR | S_IRUGO | S_IXUGO;
     de->info = info;
     if (!de->registered) de->u.dir.num_removable = 0;
-    de->show_unreg = (boot_options & OPTION_SHOW) ? TRUE : FALSE;
     de->hide = FALSE;
     de->registered = TRUE;
     return de;
@@ -1674,7 +1669,6 @@
 
     if (de == NULL) return -EINVAL;
     if (!de->registered) return -ENODEV;
-    if (de->show_unreg) fl |= DEVFS_FL_SHOW_UNREG;
     if (de->hide) fl |= DEVFS_FL_HIDE;
     if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
     {
@@ -1704,7 +1698,6 @@
 	printk ("%s: devfs_set_flags(): de->name: \"%s\"\n",
 		DEVFS_NAME, de->name);
 #endif
-    de->show_unreg = (flags & DEVFS_FL_SHOW_UNREG) ? TRUE : FALSE;
     de->hide = (flags & DEVFS_FL_HIDE) ? TRUE : FALSE;
     if ( S_ISCHR (de->mode) || S_ISBLK (de->mode) || S_ISREG (de->mode) )
     {
@@ -2053,16 +2046,16 @@
 	{"dmod",      DEBUG_MODULE_LOAD,  &devfs_debug_init},
 	{"dreg",      DEBUG_REGISTER,     &devfs_debug_init},
 	{"dunreg",    DEBUG_UNREGISTER,   &devfs_debug_init},
-	{"diread",    DEBUG_I_READ,       &devfs_debug_init},
+	{"diget",     DEBUG_I_GET,        &devfs_debug_init},
 	{"dchange",   DEBUG_SET_FLAGS,    &devfs_debug_init},
-	{"diwrite",   DEBUG_I_WRITE,      &devfs_debug_init},
+	{"dichange",  DEBUG_I_CHANGE,     &devfs_debug_init},
 	{"dimknod",   DEBUG_I_MKNOD,      &devfs_debug_init},
 	{"dilookup",  DEBUG_I_LOOKUP,     &devfs_debug_init},
 	{"diunlink",  DEBUG_I_UNLINK,     &devfs_debug_init},
 #endif  /*  CONFIG_DEVFS_DEBUG  */
-	{"show",      OPTION_SHOW,        &boot_options},
 	{"only",      OPTION_ONLY,        &boot_options},
 	{"mount",     OPTION_MOUNT,       &boot_options},
+	{NULL,        0,                  NULL}
     };
 
     while ( (*str != '\0') && !isspace (*str) )
@@ -2074,7 +2067,7 @@
 	    invert = 1;
 	    str += 2;
 	}
-	for (i = 0; i < sizeof (devfs_options_tab); i++)
+	for (i = 0; devfs_options_tab[i].name != NULL; i++)
 	{
 	    int len = strlen (devfs_options_tab[i].name);
 
@@ -2247,121 +2240,36 @@
 static struct file_operations devfs_dir_fops;
 static struct inode_operations devfs_symlink_iops;
 
-static void devfs_read_inode (struct inode *inode)
-{
-    struct devfs_entry *de;
-
-    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
-    if (de == NULL)
-    {
-	printk ("%s: read_inode(%d): VFS inode: %p  NO devfs_entry\n",
-		DEVFS_NAME, (int) inode->i_ino, inode);
-	return;
-    }
-#ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_I_READ)
-	printk ("%s: read_inode(%d): VFS inode: %p  devfs_entry: %p\n",
-		DEVFS_NAME, (int) inode->i_ino, inode, de);
-#endif
-    inode->i_blocks = 0;
-    inode->i_blksize = 1024;
-    inode->i_op = &devfs_iops;
-    inode->i_fop = &devfs_fops;
-    inode->i_rdev = NODEV;
-    if ( S_ISCHR (de->inode.mode) )
-    {
-	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
-			       de->u.fcb.u.device.minor);
-	inode->i_cdev = cdget (kdev_t_to_nr(inode->i_rdev));
-    }
-    else if ( S_ISBLK (de->inode.mode) )
-    {
-	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
-			       de->u.fcb.u.device.minor);
-	inode->i_bdev = bdget (kdev_t_to_nr(inode->i_rdev));
-	if (inode->i_bdev)
-	{
-	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)
-		inode->i_bdev->bd_op = de->u.fcb.ops;
-	}
-	else printk ("%s: read_inode(%d): no block device from bdget()\n",
-		     DEVFS_NAME, (int) inode->i_ino);
-    }
-    else if ( S_ISFIFO (de->inode.mode) ) inode->i_fop = &def_fifo_fops;
-    else if ( S_ISREG (de->inode.mode) ) inode->i_size = de->u.fcb.u.file.size;
-    else if ( S_ISDIR (de->inode.mode) )
-    {
-	inode->i_op = &devfs_dir_iops;
-    	inode->i_fop = &devfs_dir_fops;
-    }
-    else if ( S_ISLNK (de->inode.mode) )
-    {
-	inode->i_op = &devfs_symlink_iops;
-	inode->i_size = de->u.symlink.length;
-    }
-    inode->i_mode = de->inode.mode;
-    inode->i_uid = de->inode.uid;
-    inode->i_gid = de->inode.gid;
-    inode->i_atime = de->inode.atime;
-    inode->i_mtime = de->inode.mtime;
-    inode->i_ctime = de->inode.ctime;
-    inode->i_nlink = de->inode.nlink;
-#ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_I_READ)
-	printk ("%s:   mode: 0%o  uid: %d  gid: %d\n",
-		DEVFS_NAME, (int) inode->i_mode,
-		(int) inode->i_uid, (int) inode->i_gid);
-#endif
-}   /*  End Function devfs_read_inode  */
-
-static void devfs_write_inode (struct inode *inode, int wait)
+static int devfs_notify_change (struct dentry *dentry, struct iattr *iattr)
 {
-    int index;
+    int retval;
     struct devfs_entry *de;
+    struct inode *inode = dentry->d_inode;
     struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
 
-    if (inode->i_ino < FIRST_INODE) return;
-    index = inode->i_ino - FIRST_INODE;
-    lock_kernel ();
-    if (index >= fs_info->num_inodes)
-    {
-	printk ("%s: writing inode: %lu for which there is no entry!\n",
-		DEVFS_NAME, inode->i_ino);
-        unlock_kernel ();
-	return;
-    }
-    de = fs_info->table[index];
+    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
+    if (de == NULL) return -ENODEV;
+    retval = inode_change_ok (inode, iattr);
+    if (retval != 0) return retval;
+    inode_setattr (inode, iattr);
 #ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_I_WRITE)
+    if (devfs_debug & DEBUG_I_CHANGE)
     {
-	printk ("%s: write_inode(%d): VFS inode: %p  devfs_entry: %p\n",
+	printk ("%s: notify_change(%d): VFS inode: %p  devfs_entry: %p\n",
 		DEVFS_NAME, (int) inode->i_ino, inode, de);
 	printk ("%s:   mode: 0%o  uid: %d  gid: %d\n",
 		DEVFS_NAME, (int) inode->i_mode,
 		(int) inode->i_uid, (int) inode->i_gid);
     }
 #endif
+    /*  Inode is not on hash chains, thus must save permissions here rather
+	than in a write_inode() method  */
     de->inode.mode = inode->i_mode;
     de->inode.uid = inode->i_uid;
     de->inode.gid = inode->i_gid;
     de->inode.atime = inode->i_atime;
     de->inode.mtime = inode->i_mtime;
     de->inode.ctime = inode->i_ctime;
-    unlock_kernel ();
-}   /*  End Function devfs_write_inode  */
-
-static int devfs_notify_change (struct dentry *dentry, struct iattr *iattr)
-{
-    int retval;
-    struct devfs_entry *de;
-    struct inode *inode = dentry->d_inode;
-    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
-
-    de = get_devfs_entry_from_vfs_inode (inode, TRUE);
-    if (de == NULL) return -ENODEV;
-    retval = inode_change_ok (inode, iattr);
-    if (retval != 0) return retval;
-    inode_setattr (inode, iattr);
     if ( iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID) )
 	devfsd_notify_one (de, DEVFSD_NOTIFY_CHANGE, inode->i_mode,
 			   inode->i_uid, inode->i_gid, fs_info);
@@ -2381,8 +2289,7 @@
 
 static struct super_operations devfs_sops =
 { 
-    read_inode:    devfs_read_inode,
-    write_inode:   devfs_write_inode,
+    put_inode:     force_delete,
     statfs:        devfs_statfs,
 };
 
@@ -2411,8 +2318,68 @@
 	printk ("  old inode: %p\n", de->inode.dentry->d_inode);
 	return NULL;
     }
-    if ( ( inode = iget (sb, de->inode.ino) ) == NULL ) return NULL;
+    if ( ( inode = new_inode (sb) ) == NULL )
+    {
+	printk ("%s: get_vfs_inode(%s): new_inode() failed, de: %p\n",
+		DEVFS_NAME, de->name, de);
+	return NULL;
+    }
     de->inode.dentry = dentry;
+    inode->u.generic_ip = de;
+    inode->i_ino = de->inode.ino;
+#ifdef CONFIG_DEVFS_DEBUG
+    if (devfs_debug & DEBUG_I_GET)
+	printk ("%s: get_vfs_inode(%d): VFS inode: %p  devfs_entry: %p\n",
+		DEVFS_NAME, (int) inode->i_ino, inode, de);
+#endif
+    inode->i_blocks = 0;
+    inode->i_blksize = 1024;
+    inode->i_op = &devfs_iops;
+    inode->i_fop = &devfs_fops;
+    inode->i_rdev = NODEV;
+    if ( S_ISCHR (de->inode.mode) )
+    {
+	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
+			       de->u.fcb.u.device.minor);
+	inode->i_cdev = cdget (kdev_t_to_nr(inode->i_rdev));
+    }
+    else if ( S_ISBLK (de->inode.mode) )
+    {
+	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
+			       de->u.fcb.u.device.minor);
+	inode->i_bdev = bdget (kdev_t_to_nr(inode->i_rdev));
+	if (inode->i_bdev)
+	{
+	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)
+		inode->i_bdev->bd_op = de->u.fcb.ops;
+	}
+	else printk ("%s: get_vfs_inode(%d): no block device from bdget()\n",
+		     DEVFS_NAME, (int) inode->i_ino);
+    }
+    else if ( S_ISFIFO (de->inode.mode) ) inode->i_fop = &def_fifo_fops;
+    else if ( S_ISREG (de->inode.mode) ) inode->i_size = de->u.fcb.u.file.size;
+    else if ( S_ISDIR (de->inode.mode) )
+    {
+	inode->i_op = &devfs_dir_iops;
+    	inode->i_fop = &devfs_dir_fops;
+    }
+    else if ( S_ISLNK (de->inode.mode) )
+    {
+	inode->i_op = &devfs_symlink_iops;
+	inode->i_size = de->u.symlink.length;
+    }
+    inode->i_mode = de->inode.mode;
+    inode->i_uid = de->inode.uid;
+    inode->i_gid = de->inode.gid;
+    inode->i_atime = de->inode.atime;
+    inode->i_mtime = de->inode.mtime;
+    inode->i_ctime = de->inode.ctime;
+#ifdef CONFIG_DEVFS_DEBUG
+    if (devfs_debug & DEBUG_I_GET)
+	printk ("%s:   mode: 0%o  uid: %d  gid: %d\n",
+		DEVFS_NAME, (int) inode->i_mode,
+		(int) inode->i_uid, (int) inode->i_gid);
+#endif
     return inode;
 }   /*  End Function get_vfs_inode  */
 
@@ -2725,14 +2692,14 @@
     memcpy (txt, dentry->d_name.name,
 	    (dentry->d_name.len >= STRING_LENGTH) ?
 	    (STRING_LENGTH - 1) : dentry->d_name.len);
-#ifdef CONFIG_DEVFS_DEBUG
-    if (devfs_debug & DEBUG_I_LOOKUP)
-	printk ("%s: lookup(%s): dentry: %p by: \"%s\"\n",
-		DEVFS_NAME, txt, dentry, current->comm);
-#endif
     fs_info = dir->i_sb->u.generic_sbp;
     /*  First try to get the devfs entry for this directory  */
     parent = get_devfs_entry_from_vfs_inode (dir, TRUE);
+#ifdef CONFIG_DEVFS_DEBUG
+    if (devfs_debug & DEBUG_I_LOOKUP)
+	printk ("%s: lookup(%s): dentry: %p parent: %p by: \"%s\"\n",
+		DEVFS_NAME, txt, dentry, parent, current->comm);
+#endif
     if (parent == NULL) return ERR_PTR (-ENOENT);
     /*  Try to reclaim an existing devfs entry  */
     de = search_for_entry_in_dir (parent,
@@ -2823,6 +2790,7 @@
 static int devfs_unlink (struct inode *dir, struct dentry *dentry)
 {
     struct devfs_entry *de;
+    struct inode *inode = dentry->d_inode;
 
 #ifdef CONFIG_DEVFS_DEBUG
     char txt[STRING_LENGTH];
@@ -2838,9 +2806,18 @@
 
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
     if (de == NULL) return -ENOENT;
-    de->registered = FALSE;
+    devfsd_notify_one (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+		       inode->i_uid, inode->i_gid, dir->i_sb->u.generic_sbp);
+    if ( S_ISLNK (de->mode) )
+    {
+	write_lock (&de->u.symlink.lock);
+	de->registered = FALSE;
+	write_unlock (&de->u.symlink.lock);
+	if ( atomic_dec_and_test (&de->u.symlink.refcount) )
+	    kfree (de->u.symlink.linkname);
+    }
+    else de->registered = FALSE;
     de->hide = TRUE;
-    if ( S_ISLNK (de->mode) ) kfree (de->u.symlink.linkname);
     free_dentries (de);
     return 0;
 }   /*  End Function devfs_unlink  */
@@ -2954,6 +2931,8 @@
 	}
     }
     if (has_children) return -ENOTEMPTY;
+    devfsd_notify_one (de, DEVFSD_NOTIFY_DELETE, inode->i_mode,
+		       inode->i_uid, inode->i_gid, fs_info);
     de->hide = TRUE;
     de->registered = FALSE;
     free_dentries (de);
@@ -2989,29 +2968,29 @@
     de = search_for_entry (parent, dentry->d_name.name, dentry->d_name.len,
 			   FALSE, TRUE, &is_new, FALSE);
     if (de == NULL) return -ENOMEM;
-    if (!de->registered)
+    if (de->registered)
     {
-	/*  Since we created the devfs entry we get to choose things  */
-	de->info = NULL;
-	de->mode = mode;
-	if ( S_ISBLK (mode) || S_ISCHR (mode) )
-	{
-	    de->u.fcb.u.device.major = MAJOR (rdev);
-	    de->u.fcb.u.device.minor = MINOR (rdev);
-	    de->u.fcb.default_uid = current->euid;
-	    de->u.fcb.default_gid = current->egid;
-	    de->u.fcb.ops = NULL;
-	    de->u.fcb.auto_owner = FALSE;
-	    de->u.fcb.aopen_notify = FALSE;
-	    de->u.fcb.open = FALSE;
-	}
-	else if ( S_ISFIFO (mode) )
-	{
-	    de->u.fifo.uid = current->euid;
-	    de->u.fifo.gid = current->egid;
-	}
+	printk ("%s: mknod(): existing entry\n", DEVFS_NAME);
+	return -EEXIST;
+    }
+    de->info = NULL;
+    de->mode = mode;
+    if ( S_ISBLK (mode) || S_ISCHR (mode) )
+    {
+	de->u.fcb.u.device.major = MAJOR (rdev);
+	de->u.fcb.u.device.minor = MINOR (rdev);
+	de->u.fcb.default_uid = current->euid;
+	de->u.fcb.default_gid = current->egid;
+	de->u.fcb.ops = NULL;
+	de->u.fcb.auto_owner = FALSE;
+	de->u.fcb.aopen_notify = FALSE;
+	de->u.fcb.open = FALSE;
+    }
+    else if ( S_ISFIFO (mode) )
+    {
+	de->u.fifo.uid = current->euid;
+	de->u.fifo.gid = current->egid;
     }
-    de->show_unreg = FALSE;
     de->hide = FALSE;
     de->inode.mode = mode;
     de->inode.uid = current->euid;
@@ -3038,11 +3017,19 @@
     int err;
     struct devfs_entry *de;
 
-    lock_kernel ();
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
-    err = de ? vfs_readlink (dentry, buffer, buflen,
-			     de->u.symlink.linkname) : -ENODEV;
-    unlock_kernel ();
+    if (!de) return -ENODEV;
+    read_lock (&de->u.symlink.lock);
+    if (!de->registered)
+    {
+	read_unlock (&de->u.symlink.lock);
+	return -ENODEV;
+    }
+    atomic_inc (&de->u.symlink.refcount);
+    read_unlock (&de->u.symlink.lock);
+    err = vfs_readlink (dentry, buffer, buflen, de->u.symlink.linkname);
+    if ( atomic_dec_and_test (&de->u.symlink.refcount) )
+	kfree (de->u.symlink.linkname);
     return err;
 }   /*  End Function devfs_readlink  */
 
@@ -3051,10 +3038,19 @@
     int err;
     struct devfs_entry *de;
 
-    lock_kernel ();
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
-    err = de ? vfs_follow_link (nd, de->u.symlink.linkname) : -ENODEV;
-    unlock_kernel ();
+    if (!de) return -ENODEV;
+    read_lock (&de->u.symlink.lock);
+    if (!de->registered)
+    {
+	read_unlock (&de->u.symlink.lock);
+	return -ENODEV;
+    }
+    atomic_inc (&de->u.symlink.refcount);
+    read_unlock (&de->u.symlink.lock);
+    err = vfs_follow_link (nd, de->u.symlink.linkname);
+    if ( atomic_dec_and_test (&de->u.symlink.refcount) )
+	kfree (de->u.symlink.linkname);
     return err;
 }   /*  End Function devfs_follow_link  */
 
diff -urN linux-2.4.10-pre3/fs/devfs/util.c linux/fs/devfs/util.c
--- linux-2.4.10-pre3/fs/devfs/util.c	Wed Jul 11 15:55:41 2001
+++ linux/fs/devfs/util.c	Sun Sep  2 10:23:53 2001
@@ -39,6 +39,15 @@
                Created <devfs_*alloc_major> and <devfs_*alloc_devnum>.
     20010710   Richard Gooch <rgooch@atnf.csiro.au>
                Created <devfs_*alloc_unique_number>.
+    20010730   Richard Gooch <rgooch@atnf.csiro.au>
+               Documentation typo fix.
+    20010806   Richard Gooch <rgooch@atnf.csiro.au>
+               Made <block_semaphore> and <char_semaphore> private.
+    20010813   Richard Gooch <rgooch@atnf.csiro.au>
+               Fixed bug in <devfs_alloc_unique_number>: limited to 128 numbers
+    20010818   Richard Gooch <rgooch@atnf.csiro.au>
+               Updated major masks up to Linus' "no new majors" proclamation.
+	       Block: were 126 now 122 free, char: were 26 now 19 free.
 */
 #include <linux/module.h>
 #include <linux/init.h>
@@ -181,15 +190,15 @@
 };
 
 /*  Block majors already assigned:
-    0-3, 7-9, 11-12, 13-63, 65-93, 95-99, 101, 103-111, 120-127, 199, 201,
-    240-255
+    0-3, 7-9, 11-63, 65-99, 101-113, 120-127, 199, 201, 240-255
+    Total free: 122
 */
 static struct major_list block_major_list =
 {SPIN_LOCK_UNLOCKED,
     {0xfffffb8f,  /*  Majors 0   to 31   */
      0xffffffff,  /*  Majors 32  to 63   */
-     0xbffffffe,  /*  Majors 64  to 95   */
-     0xff00ffaf,  /*  Majors 96  to 127  */
+     0xfffffffe,  /*  Majors 64  to 95   */
+     0xff03ffef,  /*  Majors 96  to 127  */
      0x00000000,  /*  Majors 128 to 159  */
      0x00000000,  /*  Majors 160 to 191  */
      0x00000280,  /*  Majors 192 to 223  */
@@ -197,7 +206,8 @@
 };
 
 /*  Char majors already assigned:
-    0-7, 9-151, 154-158, 160-195, 198-211, 216-221, 224-225, 240-255
+    0-7, 9-151, 154-158, 160-211, 216-221, 224-230, 240-255
+    Total free: 19
 */
 static struct major_list char_major_list =
 {SPIN_LOCK_UNLOCKED,
@@ -207,14 +217,14 @@
      0xffffffff,  /*  Majors 96  to 127  */
      0x7cffffff,  /*  Majors 128 to 159  */
      0xffffffff,  /*  Majors 160 to 191  */
-     0x3f0fffcf,  /*  Majors 192 to 223  */
-     0xffff0003}  /*  Majors 224 to 255  */
+     0x3f0fffff,  /*  Majors 192 to 223  */
+     0xffff007f}  /*  Majors 224 to 255  */
 };
 
 
 /**
  *	devfs_alloc_major - Allocate a major number.
- *	@type: The type of the major (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLOCK)
+ *	@type: The type of the major (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK)
 
  *	Returns the allocated major, else -1 if none are available.
  *	This routine is thread safe and does not block.
@@ -238,7 +248,7 @@
 
 /**
  *	devfs_dealloc_major - Deallocate a major number.
- *	@type: The type of the major (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLOCK)
+ *	@type: The type of the major (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK)
  *	@major: The major number.
  *	This routine is thread safe and does not block.
  */
@@ -273,16 +283,16 @@
     int none_free;
 };
 
-DECLARE_MUTEX (block_semaphore);
+static DECLARE_MUTEX (block_semaphore);
 static struct device_list block_list;
 
-DECLARE_MUTEX (char_semaphore);
+static DECLARE_MUTEX (char_semaphore);
 static struct device_list char_list;
 
 
 /**
  *	devfs_alloc_devnum - Allocate a device number.
- *	@type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLOCK).
+ *	@type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK).
  *
  *	Returns the allocated device number, else NODEV if none are available.
  *	This routine is thread safe and may block.
@@ -347,7 +357,7 @@
 
 /**
  *	devfs_dealloc_devnum - Dellocate a device number.
- *	@type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLOCK).
+ *	@type: The type (DEVFS_SPECIAL_CHR or DEVFS_SPECIAL_BLK).
  *	@devnum: The device number.
  *
  *	This routine is thread safe and does not block.
@@ -437,6 +447,7 @@
 	space->length = length;
     }
     number = find_first_zero_bit (space->bits, space->length << 3);
+    --space->num_free;
     __set_bit (number, space->bits);
     up (&space->semaphore);
     return number;
diff -urN linux-2.4.10-pre3/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.4.10-pre3/include/linux/blk.h	Wed Aug 15 15:21:32 2001
+++ linux/include/linux/blk.h	Sun Sep  2 10:23:53 2001
@@ -144,7 +144,11 @@
 
 #define DEVICE_NAME "scsidisk"
 #define TIMEOUT_VALUE (2*HZ)
+#ifdef CONFIG_SD_MANY
+#define DEVICE_NR(device) sd_devnum_to_index((device))
+#else
 #define DEVICE_NR(device) (((MAJOR(device) & SD_MAJOR_MASK) << (8 - 4)) + (MINOR(device) >> 4))
+#endif
 
 /* Kludge to use the same number for both char and block major numbers */
 #elif  (MAJOR_NR == MD_MAJOR) && defined(MD_DRIVER)
diff -urN linux-2.4.10-pre3/include/linux/devfs_fs.h linux/include/linux/devfs_fs.h
--- linux-2.4.10-pre3/include/linux/devfs_fs.h	Wed Feb 16 16:42:06 2000
+++ linux/include/linux/devfs_fs.h	Sun Sep  2 10:23:53 2001
@@ -20,6 +20,7 @@
 #define DEVFSD_NOTIFY_LOOKUP        4
 #define DEVFSD_NOTIFY_CHANGE        5
 #define DEVFSD_NOTIFY_CREATE        6
+#define DEVFSD_NOTIFY_DELETE        7
 
 #define DEVFS_PATHLEN               1024  /*  Never change this otherwise the
 					      binary interface will change   */
diff -urN linux-2.4.10-pre3/include/linux/devfs_fs_kernel.h linux/include/linux/devfs_fs_kernel.h
--- linux-2.4.10-pre3/include/linux/devfs_fs_kernel.h	Wed Aug 15 15:21:30 2001
+++ linux/include/linux/devfs_fs_kernel.h	Sun Sep  2 10:23:53 2001
@@ -30,17 +30,15 @@
 					 is closed, ownership reverts back to
 					 <<uid>> and <<gid>> and the protection
 					 is set to read-write for all        */
-#define DEVFS_FL_SHOW_UNREG     0x002 /* Show unregistered entries in
-					 directory listings                  */
-#define DEVFS_FL_HIDE           0x004 /* Do not show entry in directory list */
-#define DEVFS_FL_AUTO_DEVNUM    0x008 /* Automatically generate device number
+#define DEVFS_FL_HIDE           0x002 /* Do not show entry in directory list */
+#define DEVFS_FL_AUTO_DEVNUM    0x004 /* Automatically generate device number
 				       */
-#define DEVFS_FL_AOPEN_NOTIFY   0x010 /* Asynchronously notify devfsd on open
+#define DEVFS_FL_AOPEN_NOTIFY   0x008 /* Asynchronously notify devfsd on open
 				       */
-#define DEVFS_FL_REMOVABLE      0x020 /* This is a removable media device    */
-#define DEVFS_FL_WAIT           0x040 /* Wait for devfsd to finish           */
-#define DEVFS_FL_NO_PERSISTENCE 0x080 /* Forget changes after unregister     */
-#define DEVFS_FL_CURRENT_OWNER  0x100 /* Set initial ownership to current    */
+#define DEVFS_FL_REMOVABLE      0x010 /* This is a removable media device    */
+#define DEVFS_FL_WAIT           0x020 /* Wait for devfsd to finish           */
+#define DEVFS_FL_NO_PERSISTENCE 0x040 /* Forget changes after unregister     */
+#define DEVFS_FL_CURRENT_OWNER  0x080 /* Set initial ownership to current    */
 #define DEVFS_FL_DEFAULT        DEVFS_FL_NONE
 
 
