Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVHXVAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVHXVAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVHXVAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:00:07 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:63684 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932207AbVHXVAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:00:06 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 24 Aug 2005 13:59:44 -0700
From: Chris Wedgwood <cw@f00f.org>
To: robotti@godmail.com, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050824205944.GA32599@taniwha.stupidest.org>
References: <200508232205.j7NM5l1g018046@ms-smtp-01.rdc-nyc.rr.com> <20050824025740.GA3361@taniwha.stupidest.org> <20050824205237.GB14136@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824205237.GB14136@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 04:52:37PM -0400, Wakko Warner wrote:

> Care to send me the patch?

Heh.  Not really as I don't really know if people should be using it
in it's current state --- the shmem init is very very hacky and I have
other changes I've not had a chance to do.

Anyhow, here is an older version of it.  It's from some old internal
embedded tree but should be trivial to shoehorn into anything recent.

If people really do like or want this I would like to know and maybe
something more elegant can be worked out.



Index: linux/init/main.c
===================================================================
--- linux/init/main.c	(revision 51)
+++ linux/init/main.c	(working copy)
@@ -689,6 +689,49 @@
 #endif
 }
 
+/* If we want the rootfs on initramfs so we mount initramfs over the
+ * rootfs before we unpack it.  The little dance we do by creating a
+ * pivot point and moving the root to that is in fact necessary
+ * because lookups of "." don't resolve mountpoints.
+ */
+static inline void __init overmount_rootfs(void)
+{
+#ifdef CONFIG_EARLYUSERSPACE_ON_TMPFS
+	int init_tmpfs(void);
+	int (*initfunc)(void) = init_tmpfs;
+	mm_segment_t oldfs;
+	char pivot[] = "/pivot";
+
+	/* Explicitly go and init the overmount fs early (long-term
+	 * the need for this will probably go away. */
+
+	if (initfunc())
+		goto err;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (sys_mkdir(pivot, 0700) < 0)
+		goto err;
+	if (sys_mount("tmpfs", pivot, "tmpfs", 0, NULL))
+		goto err;
+
+	/* Below here errors are unlikely and icky to deal with. */
+	sys_chdir(pivot);
+	sys_mount(".", "/", NULL, MS_MOVE, NULL);
+	sys_chdir(".");
+	sys_chroot(".");
+	printk(KERN_INFO "Overmounted tmpfs\n");
+	goto out;
+
+ err:
+	printk(KERN_ERR "Overmount error\n");
+
+ out:
+	set_fs(oldfs);
+#endif /* CONFIG_EARLYUSERSPACE_ON_TMPFS */
+}
+
 static int init(void * unused)
 {
 	lock_kernel();
@@ -715,6 +758,7 @@
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
 	 */
+	overmount_rootfs();
 	populate_rootfs();
 
 	do_basic_setup();
Index: linux/fs/Kconfig
===================================================================
--- linux/fs/Kconfig	(revision 51)
+++ linux/fs/Kconfig	(working copy)
@@ -951,6 +951,18 @@
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config EARLYUSERSPACE_ON_TMPFS
+	bool "Unpack the early userspace onto tmpfs"
+	depends TMPFS
+	default y
+	help
+	  Use this to have your early userspace placed (decompressed)
+	  onto tmpfs as opposed ramfs.  This will allow you to
+	  restrict the size of your root-filesystem and it will also
+	  be swappable.
+
+	  If unsure, say Y.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
Index: linux/mm/shmem.c
===================================================================
--- linux/mm/shmem.c	(revision 51)
+++ linux/mm/shmem.c	(working copy)
@@ -2206,7 +2206,7 @@
 };
 static struct vfsmount *shm_mnt;
 
-static int __init init_tmpfs(void)
+int __init init_tmpfs(void)
 {
 	int error;
 
@@ -2239,7 +2239,12 @@
 	shm_mnt = ERR_PTR(error);
 	return error;
 }
+/* Don't do this if we are calling it early explicity */
+#ifndef CONFIG_EARLYUSERSPACE_ON_TMPFS
+/* Iff CONFIG_EARLYUSERSPACE_ON_TMPFS is set then we will interpose
+ * ramfs so this will get called explicitly and early */
 module_init(init_tmpfs)
+#endif /* !CONFIG_EARLYUSERSPACE_ON_TMPFS */
 
 /*
  * shmem_file_setup - get an unlinked file living in tmpfs
