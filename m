Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVGFCC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVGFCC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVGFCC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:02:58 -0400
Received: from natfrord.rzone.de ([81.169.145.161]:12419 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S261994AbVGFCCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:02:49 -0400
Message-ID: <42CB3BC6.2070705@man-made.de>
Date: Wed, 06 Jul 2005 04:02:46 +0200
From: Frank Schruefer <kernel@man-made.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: [PATCH] update( Documentation -> vfs.txt -> file_system_type );
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy,

The current description was tagged as of kernel 2.1.99 - so whatever story
I'll write here should be more truthful than that fossil ;-)


Stone:/usr/src # diff -r -u linux-2.6.13-rc1.UNTOUCHED linux-2.6.13-rc1
------------------------------SNIPON-----------------------------------
diff -r -u linux-2.6.13-rc1.UNTOUCHED/Documentation/filesystems/vfs.txt linux-2.6.13-rc1/Documentation/filesystems/vfs.txt
--- linux-2.6.13-rc1.UNTOUCHED/Documentation/filesystems/vfs.txt        2005-06-30 01:00:53.000000000 +0200
+++ linux-2.6.13-rc1/Documentation/filesystems/vfs.txt  2005-07-06 03:36:23.000000000 +0200
@@ -126,46 +126,53 @@
  struct file_system_type                                               <section>
  =======================

-This describes the filesystem. As of kernel 2.1.99, the following
+This describes the filesystem. As of kernel 2.6.13, the following
  members are defined:

  struct file_system_type {
-       const char *name;
-       int fs_flags;
-       struct super_block *(*read_super) (struct super_block *, void *, int);
-       struct file_system_type * next;
-};
-
-  name: the name of the filesystem type, such as "ext2", "iso9660",
-       "msdos" and so on
-
-  fs_flags: various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
-
-  read_super: the method to call when a new instance of this
-       filesystem should be mounted
-
-  next: for internal VFS use: you should initialise this to NULL
-
-The read_super() method has the following arguments:
-
-  struct super_block *sb: the superblock structure. This is partially
-       initialised by the VFS and the rest must be initialised by the
-       read_super() method
-
-  void *data: arbitrary mount options, usually comes as an ASCII
-       string
+        const char *name;
+        int fs_flags;
+        struct super_block *(*get_sb)
+               (struct file_system_type *, int, const char *, void *);
+        void (*kill_sb) (struct super_block *);
+        struct module *owner;
+        struct file_system_type * next;
+        struct list_head fs_supers;
+       };
+
+  name: The name of the filesystem type, such as "ext2", "iso9660",
+       "msdos" and so on.
+
+  fs_flags: A combination of: FS_REQUIRES_DEV, FS_BINARY_MOUNTDATA,
+       FS_REVAL_DOT, FS_ODD_RENAME (deprecated). See include/linux/fs.h.
+
+  get_sb: The function responsible for returning the super_block structure
+       containing the filesystems blocksize, it's super block,
+       super operations struct s_op (which is the most interesting field
+       filled by this method and a pointer to struct super_operations
+       which describes the next level of the filesystem implementation),
+       the magic byte and max filesize and the like.
+       It is called when a new instance of this filesystem is mounted and
+       replaces the read_super function of former kernels (see porting).
+       As an example of what to do here please look at one of the default
+       functions in the kernel code named 'get_sb_nodev'.
+       The get_sb_nodev functions last parameter is a pointer to a function
+       which would act like the former read_super function just mentioned.
+       The data parameter contains arbitrary mount options passed by the
+       unix mount program, it usually comes as an ASCII string but can
+       be set to come as binary (now please don't ask me where I saw this
+       flag, look at the source, Mr. Skywalker ;-).
+       Return value: New super block on success, ERR_PTR if failed.
+
+  kill_sb: the function which gets called when the sb needs to be destroyed.
+       One generic function for this is 'kill_anon_super', look there for
+       more inspiration.

-  int silent: whether or not to be silent on error
+  owner: This is usually set to the macro 'THIS_MODULE'.

-The read_super() method must determine if the block device specified
-in the superblock contains a filesystem of the type the method
-supports. On success the method returns the superblock pointer, on
-failure it returns NULL.
+  next: Managed by the kernel. Please leave it as NULL.

-The most interesting member of the superblock structure that the
-read_super() method fills in is the "s_op" field. This is a pointer to
-a "struct super_operations" which describes the next level of the
-filesystem implementation.
+  fs_supers: Managed by the kernel. Please leave it as NULL.


  struct super_operations                                               <section>
------------------------------SNIPOFF----------------------------------
Stone:/usr/src #

-- 

Thanks,
    Frank Schruefer
    SITEFORUM Software Europe GmbH
    Germany (Thuringia)

