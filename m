Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVHHN5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVHHN5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVHHN5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:57:19 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:39231 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750900AbVHHN5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:57:19 -0400
Date: Mon, 8 Aug 2005 15:59:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Cc: klibc@zytor.com
Subject: [PATCH - RFC] Move initramfs configuration to "General setup"
Message-ID: <20050808135936.GA9057@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At present the configuration items for initramfs is located in:
Device drivers | Block Drivers | xxx

This is maybe not the most natural place to have it.
So with the following patch it is moved below "General setup",
and relevant config items are collected in a file with a new
home in usr/.

The original reason why I looked into this is the upcoming merge of klibc
and I missed a good place to include the KLIBC relevant config options.
With the Kconfig file added to usr/ is will be a simple menuconfig
in here for all the KLIBC relevant config options.

Any comments?

	Sam

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -408,48 +408,6 @@ config BLK_DEV_INITRD
 	  "real" root file system, etc. See <file:Documentation/initrd.txt>
 	  for details.
 
-config INITRAMFS_SOURCE
-	string "Initramfs source file(s)"
-	default ""
-	help
-	  This can be either a single cpio archive with a .cpio suffix or a
-	  space-separated list of directories and files for building the
-	  initramfs image.  A cpio archive should contain a filesystem archive
-	  to be used as an initramfs image.  Directories should contain a
-	  filesystem layout to be included in the initramfs image.  Files
-	  should contain entries according to the format described by the
-	  "usr/gen_init_cpio" program in the kernel tree.
-
-	  When multiple directories and files are specified then the
-	  initramfs image will be the aggregate of all of them.
-
-	  See <file:Documentation/early-userspace/README for more details.
-
-	  If you are not sure, leave it blank.
-
-config INITRAMFS_ROOT_UID
-	int "User ID to map to 0 (user root)"
-	depends on INITRAMFS_SOURCE!=""
-	default "0"
-	help
-	  This setting is only meaningful if the INITRAMFS_SOURCE is
-	  contains a directory.  Setting this user ID (UID) to something
-	  other than "0" will cause all files owned by that UID to be
-	  owned by user root in the initial ramdisk image.
-
-	  If you are not sure, leave it set to "0".
-
-config INITRAMFS_ROOT_GID
-	int "Group ID to map to 0 (group root)"
-	depends on INITRAMFS_SOURCE!=""
-	default "0"
-	help
-	  This setting is only meaningful if the INITRAMFS_SOURCE is
-	  contains a directory.  Setting this group ID (GID) to something
-	  other than "0" will cause all files owned by that GID to be
-	  owned by group root in the initial ramdisk image.
-
-	  If you are not sure, leave it set to "0".
 
 #XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
 #for instance.
diff --git a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -238,6 +238,8 @@ config CPUSETS
 
 	  Say N if unsure.
 
+source "usr/Kconfig"
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
diff --git a/usr/Kconfig b/usr/Kconfig
new file mode 100644
--- /dev/null
+++ b/usr/Kconfig
@@ -0,0 +1,46 @@
+#
+# Configuration for initramfs
+#
+
+config INITRAMFS_SOURCE
+	string "Initramfs source file(s)"
+	default ""
+	help
+	  This can be either a single cpio archive with a .cpio suffix or a
+	  space-separated list of directories and files for building the
+	  initramfs image.  A cpio archive should contain a filesystem archive
+	  to be used as an initramfs image.  Directories should contain a
+	  filesystem layout to be included in the initramfs image.  Files
+	  should contain entries according to the format described by the
+	  "usr/gen_init_cpio" program in the kernel tree.
+
+	  When multiple directories and files are specified then the
+	  initramfs image will be the aggregate of all of them.
+
+	  See <file:Documentation/early-userspace/README for more details.
+
+	  If you are not sure, leave it blank.
+
+config INITRAMFS_ROOT_UID
+	int "User ID to map to 0 (user root)"
+	depends on INITRAMFS_SOURCE!=""
+	default "0"
+	help
+	  This setting is only meaningful if the INITRAMFS_SOURCE is
+	  contains a directory.  Setting this user ID (UID) to something
+	  other than "0" will cause all files owned by that UID to be
+	  owned by user root in the initial ramdisk image.
+
+	  If you are not sure, leave it set to "0".
+
+config INITRAMFS_ROOT_GID
+	int "Group ID to map to 0 (group root)"
+	depends on INITRAMFS_SOURCE!=""
+	default "0"
+	help
+	  This setting is only meaningful if the INITRAMFS_SOURCE is
+	  contains a directory.  Setting this group ID (GID) to something
+	  other than "0" will cause all files owned by that GID to be
+	  owned by group root in the initial ramdisk image.
+
+	  If you are not sure, leave it set to "0".
