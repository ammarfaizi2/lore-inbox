Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273003AbTG3Qpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273004AbTG3Qpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:45:42 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:4820 "HELO
	develer.com") by vger.kernel.org with SMTP id S273003AbTG3Qpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:45:38 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase (PATCH)
Date: Wed, 30 Jul 2003 18:45:27 +0200
User-Agent: KMail/1.5.9
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200307232046.46990.bernie@develer.com> <200307300449.37692.bernie@develer.com> <20030730153527.GB27214@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030730153527.GB27214@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307301845.27401.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 17:35, Tom Rini wrote:

> > I tried stripping sysfs away. I just saved 7KB and got a kernel that
> > couldn't boot because root device translation depends on sysfs ;-)
>
> Now that someone has gone down the path (and, thanks for doing it), we
> know how much is saved and what needs to be done to get it to work.
> Lets just hope it doesn't grow that much more.

Here's the patch, in case someone cares trying it.
Please DON'T apply as-is to shipping kernels: as I was saying,
removing sysfs like this makes the system unable to boot.

---------------------------------------------------------------------------

Make sysfs optional for embedded systems.

Applies as-is to 2.6.0-test1.

diff -Nru linux-2.6.0-test1-with_elevator_patch/init/Kconfig linux-2.6.0-test1/init/Kconfig
--- linux-2.6.0-test1-with_elevator_patch/init/Kconfig	2003-07-26 14:25:48.000000000 +0200
+++ linux-2.6.0-test1/init/Kconfig	2003-07-26 16:02:01.000000000 +0200
@@ -141,6 +141,13 @@
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
+config SYS_FS
+	bool "/sys file system support" if EMBEDDED
+	default y
+	help
+	  Disabling this option will cause the kernel to be built without
+	  sysfs, which is mostly needed for power management and hot-plug support.
+
 source "drivers/block/Kconfig.iosched"
 
 endmenu		# General setup
diff -Nru linux-2.6.0-test1-with_elevator_patch/fs/Makefile linux-2.6.0-test1/fs/Makefile
--- linux-2.6.0-test1-with_elevator_patch/fs/Makefile	2003-07-14 05:34:42.000000000 +0200
+++ linux-2.6.0-test1/fs/Makefile	2003-07-26 01:03:59.000000000 +0200
@@ -43,7 +43,7 @@
 
 obj-$(CONFIG_PROC_FS)		+= proc/
 obj-y				+= partitions/
-obj-y				+= sysfs/
+obj-$(CONFIG_SYS_FS)		+= sysfs/
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
@@ -74,7 +74,7 @@
 obj-$(CONFIG_NLS)		+= nls/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_SMB_FS)		+= smbfs/
-obj-$(CONFIG_CIFS)             += cifs/
+obj-$(CONFIG_CIFS)              += cifs/
 obj-$(CONFIG_NCP_FS)		+= ncpfs/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
diff -Nru linux-2.6.0-test1-with_elevator_patch/fs/namespace.c linux-2.6.0-test1/fs/namespace.c
--- linux-2.6.0-test1-with_elevator_patch/fs/namespace.c	2003-07-14 05:35:52.000000000 +0200
+++ linux-2.6.0-test1/fs/namespace.c	2003-07-26 15:39:05.000000000 +0200
@@ -1154,7 +1154,11 @@
 		d++;
 		i--;
 	} while (i);
+
+#ifdef CONFIG_SYSFS
 	sysfs_init();
+#endif /* CONFIG_SYSFS */
+
 	init_rootfs();
 	init_mount_tree();
 }
diff -Nru linux-2.6.0-test1-with_elevator_patch/include/linux/sysfs.h linux-2.6.0-test1/include/linux/sysfs.h
--- linux-2.6.0-test1-with_elevator_patch/include/linux/sysfs.h	2003-07-14 05:32:44.000000000 +0200
+++ linux-2.6.0-test1/include/linux/sysfs.h	2003-07-26 15:28:12.000000000 +0200
@@ -25,36 +25,101 @@
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 };
 
-int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
-int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
-
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
 };
 
+#ifdef CONFIG_SYS_FS
+
 extern int
-sysfs_create_dir(struct kobject *);
+sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
+extern int
+sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
+extern int
+sysfs_create_dir(struct kobject * kobj);
 
 extern void
-sysfs_remove_dir(struct kobject *);
+sysfs_remove_dir(struct kobject * kobj);
 
 extern void
-sysfs_rename_dir(struct kobject *, char *new_name);
+sysfs_rename_dir(struct kobject * kobj, char *new_name);
 
 extern int
-sysfs_create_file(struct kobject *, struct attribute *);
+sysfs_create_file(struct kobject * kobj, struct attribute * attr);
 
 extern int
-sysfs_update_file(struct kobject *, struct attribute *);
+sysfs_update_file(struct kobject * kobj, struct attribute * attr);
 
 extern void
-sysfs_remove_file(struct kobject *, struct attribute *);
+sysfs_remove_file(struct kobject * kobj, struct attribute * attr);
 
 extern int 
 sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name);
 
 extern void
-sysfs_remove_link(struct kobject *, char * name);
+sysfs_remove_link(struct kobject * kobj, char * name);
+
+#else /* !CONFIG_SYS_FS */
+
+static inline int
+sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr)
+{
+	return 0;
+}
+
+static inline int
+sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr)
+{
+	return 0;
+}
+
+static inline int
+sysfs_create_dir(struct kobject * kobj)
+{
+	return 0;
+}
+
+static inline void
+sysfs_remove_dir(struct kobject * kobj)
+{
+}
+
+static inline void
+sysfs_rename_dir(struct kobject * kobj, char *new_name)
+{
+}
+
+static inline int
+sysfs_create_file(struct kobject * kobj, struct attribute * attr)
+{
+	return 0;
+}
+
+static inline int
+sysfs_update_file(struct kobject * kobj, struct attribute * attr)
+{
+	return 0;
+}
+
+static inline void
+sysfs_remove_file(struct kobject * kobj, struct attribute * attr)
+{
+}
+
+static inline int 
+sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
+{
+	return 0;
+}
+
+static inline void
+sysfs_remove_link(struct kobject * kobj, char * name)
+{
+}
+
+#endif /* !CONFIG_SYS_FS */
 
 #endif /* _SYSFS_H_ */


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


