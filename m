Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWADXGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWADXGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWADXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:06:53 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:45282 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751187AbWADXGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:06:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC/RFT][PATCH -mm 5/5] swsusp: userland interface documentation and config
Date: Wed, 4 Jan 2006 23:56:50 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200601042340.42118.rjw@sisk.pl>
In-Reply-To: <200601042340.42118.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042356.51239.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Documentation/power/userland-swsusp.txt |  120 ++++++++++++++++++++++++++++++++
 kernel/power/Kconfig                    |   74 +++++++++++++------
 kernel/power/Makefile                   |    6 +
 kernel/power/disk.c                     |    1 
 kernel/power/power.h                    |    2 
 kernel/power/swsusp.c                   |    2 
 6 files changed, 179 insertions(+), 26 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/Kconfig
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/Kconfig	2006-01-04 20:26:57.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/Kconfig	2006-01-04 20:28:29.000000000 +0100
@@ -42,27 +42,65 @@ config SOFTWARE_SUSPEND
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
 
-	  It creates an image which is saved in your active swap. Upon next
-	  boot, pass the 'resume=/dev/swappartition' argument to the kernel to
-	  have it detect the saved image, restore memory state from it, and
-	  continue to run as before. If you do not want the previous state to
-	  be reloaded, then use the 'noresume' kernel argument. However, note
-	  that your partitions will be fsck'd and you must re-mkswap your swap
-	  partitions. It does not work with swap files.
+if SOFTWARE_SUSPEND
 
-	  Right now you may boot without resuming and then later resume but
+config USERLAND_SUSPEND
+	bool "User interface for software suspend"
+	depends on SOFTWARE_SUSPEND
+	default y
+	---help---
+	  Enable the interface allowing user space processes to handle the suspend
+	  and resume of the system.
+
+	  If this interface is used for suspend, the kernel creates a snapshot of
+	  the system memory that may be encrypted, compressed, etc. and has to be
+	  written to a storage by a user space utility.  On resume the image
+	  is read, uncompressed, decrypted, etc. by a user space utility and
+	  transferred to the kernel which restores the system memory state from
+	  it.
+
+	  This is the recommended way of handling software suspend and the
+	  future development will be focused on it, so if you enable software
+	  suspend, you should say Y here.
+
+	  Of course special user space utilities are necessary to use it.
+
+	  For more information please read <file:Documentation/power/userland-swsusp.txt>.
+
+config SWAP_SUSPEND
+	bool "Legacy swap suspend"
+	depends on SOFTWARE_SUSPEND
+	default y
+	---help---
+	  Enable the built-in legacy swap suspend.
+
+	  It allows you to suspend the machine by 'echo disk > /sys/power/state'
+	  or 'shutdown -z <time>' (patch for sysvinit needed).
+
+	  It creates an image which is saved in the swap partition specified
+	  with the 'resume=/dev/swappartition' kernel command line argument.
+
+	  On the next boot, the 'resume=/dev/swappartition' command line argument
+	  causes the kernel to look for the saved image, restore memory state from it,
+	  and continue to run as before. If you do not want the previous state to
+	  be reloaded, then use the 'noresume' kernel argument.  However, note
+	  that your partitions will be fsck'd and you must re-mkswap your resume
+	  partition.  It does not work with swap files.
+
+	  In principle you may boot without resuming and then later resume but
 	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
+	  involved in suspending.  Also in this case there is a risk that buffers
 	  on disk won't match with saved ones.
 
+	  You may want to say Y here if your distribution contains power management
+	  utilities that assume this feature to be present.
+
 	  For more information take a look at <file:Documentation/power/swsusp.txt>.
 
 config PM_STD_PARTITION
 	string "Default resume partition"
-	depends on SOFTWARE_SUSPEND
+	depends on SWAP_SUSPEND
 	default ""
 	---help---
 	  The default resume partition is the partition that the suspend-
@@ -82,17 +120,7 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
-config SWSUSP_ENCRYPT
-	bool "Encrypt suspend image"
-	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y || CRYPTO_AES_X86_64=y)
-	default ""
-	---help---
-	  To prevent data gathering from swap after resume you can encrypt
-	  the suspend image with a temporary key that is deleted on
-	  resume.
-
-	  Note that the temporary key is stored unencrypted on disk while the
-	  system is suspended.
+endif # SOFTWARE_SUSPEND
 
 config SUSPEND_SMP
 	bool
Index: linux-2.6.15-rc5-mm3/kernel/power/Makefile
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/Makefile	2006-01-04 20:28:29.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/Makefile	2006-01-04 20:28:29.000000000 +0100
@@ -5,7 +5,11 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o user.o swap.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o snapshot.o
+
+obj-$(CONFIG_USERLAND_SUSPEND)	+= user.o
+
+obj-$(CONFIG_SWAP_SUSPEND)	+= disk.o swap.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.15-rc5-mm3/kernel/power/disk.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/disk.c	2006-01-04 20:26:57.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/disk.c	2006-01-04 20:28:29.000000000 +0100
@@ -35,7 +35,6 @@ extern int swsusp_resume(void);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
-dev_t swsusp_resume_device;
 
 /**
  *	power_down - Shut machine down for hibernate.
Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2006-01-04 20:28:29.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2006-01-04 20:28:29.000000000 +0100
@@ -62,6 +62,8 @@ unsigned int image_size = 500;
 
 int in_suspend __nosavedata = 0;
 
+dev_t swsusp_resume_device;
+
 #ifdef CONFIG_HIGHMEM
 static unsigned int count_highmem_pages(void)
 {
Index: linux-2.6.15-rc5-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/power.h	2006-01-04 20:28:29.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/power.h	2006-01-04 20:28:29.000000000 +0100
@@ -20,7 +20,7 @@ struct swsusp_info {
 
 
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_SWAP_SUSPEND
 extern int pm_suspend_disk(void);
 
 #else
Index: linux-2.6.15-rc5-mm3/Documentation/power/userland-swsusp.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm3/Documentation/power/userland-swsusp.txt	2006-01-04 20:34:11.000000000 +0100
@@ -0,0 +1,120 @@
+Documentation for userland software suspend interface
+	(C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+
+First, the warnings at the beginning of swsusp.txt still apply.
+
+Second, you should read the FAQ in swsusp.txt _now_ if you have not
+done it already.
+
+Now, to use the userland interface for software suspend you need special
+utilities that will read/write the system memory snapshot from/to the
+kernel.  Such utilities are available, for example, from
+<http://www.sisk.pl/kernel/utilities/suspend>.  You may want to have
+a look at them if you are going to develop your own suspend/resume
+utilities.
+
+The interface consists of a character device providing the open(),
+release(), read(), and write() operations as well as several ioctl()
+commands defined in kernel/power/power.h.
+
+Currently the device's major number is allocated dynamically, so the
+major:minor pair is exported via sysfs, as the /sys/power/snapshot attribute.
+
+The device can be open either for reading or for writing.  If open for
+reading, it is considered to be in the suspend mode.  Otherwise it is
+assumed to be in the resume mode.  The device cannot be open
+for reading and writing.  It is also imposiible to have the device open
+more than once at a time.
+
+The ioctl() commands recognized by the device are:
+
+SNAPSHOT_IOCFREEZE - freeze user space processes (the current process is
+	not frozen); this is required for SNAPSHOT_IOCATOMIC_SNAPSHOT
+	and SNAPSHOT_IOCATOMIC_RESTORE to succeed
+
+SNAPSHOT_IOCUNFREEZE - thaw user space processes frozen by SNAPSHOT_IOCFREEZE
+
+SNAPSHOT_IOCATOMIC_SNAPSHOT - create a snapshot of the system memory; the
+	last argument of ioctl() should be a pointer to an int variable,
+	the value of which will indicate whether the call returned after
+	creating the snapshot (1) or after restoring the system memory state
+	from it (0) (after resume the system finds itself finishing the
+	SNAPSHOT_IOCATOMIC_SNAPSHOT ioctl() again); after the snapshot
+	has been created the read() operation can be used to transfer
+	it out of the kernel
+
+SNAPSHOT_IOCATOMIC_RESTORE - restore the system memory state from the
+	uploaded snapshot image; before calling it you should transfer
+	the systme memory snapshot back to the kernel using the write()
+	operation; this call will not succeed if the snapshot
+	image is not available to the kernel
+
+SNAPSHOT_IOCFREE - free memory allocated for the snapshot image
+
+SNAPSHOT_IOCSET_IMAGE_SIZE - set the preferred maximum size of the image
+	(the kernel will do its best to ensure the image size will not exceed
+	this number, but if it turns out to be impossible, the kernel will
+	create the smallest image possible)
+
+SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
+	should be a pointer to an unsigned int variable that will contain
+	the result if the call is successful)
+
+SNAPSHOT_IOCGET_SWAP_PAGE - allocate a swap page from the resume partition
+	(the last argument should be a pointer to an unsigned int variable that
+	will contain the swap page offset if the call is successful)
+
+SNAPSHOT_IOCFREE_SWAP_PAGES - free all swap pages allocated with
+	SNAPSHOT_IOCGET_SWAP_PAGE
+
+SNAPSHOT_IOCSET_SWAP_FILE - set the resume partition (the last ioctl() argument
+	should specify the device's major and minor numbers in the old
+	two-byte format, as returned by the stat() function in the .st_rdev
+	member of the stat structure); it is recommended to always use this
+	call, because the other code the could have set the resume partition
+	need not be present in the kernel
+
+The device's read() operation can be used to transfer the snapshot image from
+the kernel.  It has the following limitations:
+- you cannot read() more than one virtual memory page at a time
+- read()s accross page boundaries are impossible (ie. if ypu read() 1/2 of
+	a page in the previous call, you will only be able to read()
+	_at_ _most_ 1/2 of the page in the next call)
+
+The device's write() operation is used for uploading the system memory snapshot
+into the kernel.  It has the same limitations as the read() operation.
+
+The release() operation frees all memory allocated for the snapshot image
+and all swap pages allocated with SNAPSHOT_IOCGET_SWAP_PAGE (if any).
+Thus it is not necessary to use either SNAPSHOT_IOCFREE or
+SNAPSHOT_IOCFREE_SWAP_PAGES before closing the device (in fact it will also
+unfreeze user space processes frozen by SNAPSHOT_IOCUNFREEZE if they are
+still frozen when the device is being closed).
+
+Currently it is assumed that the userland utilities reading/writing the
+snapshot image from/to the kernel will use a swap parition, called the resume
+partition, as storage space.  However, this is not really required, as they
+can use, for example, a special (blank) suspend partition or a file on a partition
+that is unmounted before SNAPSHOT_IOCATOMIC_SNAPSHOT and mounted afterwards.
+
+These utilities SHOULD NOT make any assumptions regarding the ordering of
+data within the snapshot image, except for the image header that MAY be
+assumed to start with an swsusp_info structure, as specified in
+kernel/power/power.h.  This structure MAY be used by the userland utilities
+to obtain some information about the snapshot image, such as the total
+number of the image pages, including the metadata and the header itself,
+contained in the .pages member of swsusp_info.
+
+The snapshot image MUST be written to the kernel unaltered (ie. all of the image
+data, metadata and header MUST be written in _exactly_ the same amount, form
+and order in which they have been read).  Otherwise, the behavior of the
+resumed system may be totally unpredictable.
+
+While executing SNAPSHOT_IOCATOMIC_RESTORE the kernel checks if the
+structure of the snapshot image is consistent with the information stored
+in the image header.  If any inconsistencies are detected,
+SNAPSHOT_IOCATOMIC_RESTORE will not succeed.  Still, this is not a fool-proof
+mechanism and the userland utilities using the interface SHOULD use additional
+means, such as checksums, to ensure the integrity of the snapshot image.
+
+For details, please refer to the source code.
