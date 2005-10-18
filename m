Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVJRDml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVJRDml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 23:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVJRDml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 23:42:41 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5760 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932406AbVJRDmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 23:42:40 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation for ramfs, rootfs, initramfs.
Date: Mon, 17 Oct 2005 22:42:08 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172242.08809.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Landley <rob@landley.net>

diff -ru old/Documentation/filesystems/ramfs-rootfs-initramfs.txt new/Documentation/filesystems/ramfs-rootfs-initramfs.txt
--- old/Documentation/filesystems/ramfs-rootfs-initramfs.txt 2005-10-17 22:39:30.194448784 -0500
+++ new/Documentation/filesystems/ramfs-rootfs-initramfs.txt 2005-10-17 22:35:54.000000000 -0500
@@ -0,0 +1,143 @@
+ramfs, rootfs and initramfs
+October 17, 2005
+Rob Landley <rob@landley.net>
+=============================
+
+What is ramfs?
+--------------
+
+Ramfs is a very simple filesystem that exports Linux's disk cacheing
+mechanisms (the page cache and dentry cache) as a dynamically resizable
+ram-based filesystem.
+
+Normally all files are cached in memory by Linux.  Pages of data read from
+backing store (usually the block device the filesystem is mounted on) are kept
+around in case it's needed again, but marked as clean (freeable) in case the
+Virtual Memory system needs the memory for something else.  Similarly, data
+written to files is marked clean as soon soon as it has been written to backing
+store, but kept around for cacheing purposes until the VM reallocates the
+memory.  A similar mechanism (the dentry cache) greatly speeds up access to
+directories.
+
+With ramfs, there is no backing store.  Files written into ramfs allocate
+dentries and page cache as usual, but there's nowhere to write them to.
+This means the pages are never marked clean, so they can't be freed by the
+VM when it's looking to recycle memory.
+
+The amount of code required to implement ramfs is tiny, because all the
+work is done by the existing Linux cacheing infrastructure.  Basically,
+you're mounting the disk cache as a filesystem.  Because of this, ramfs is not
+an optional component removable via menuconfig, since there would be negligible
+space savings.
+
+The older "ram disk" mechanism created a synthetic block device out of
+an area of ram and used it as backing store for a filesystem.  This block
+device was of a fixed size, so the filesystem mounted on it was a fixed
+size.  Using a ram disk also required unnecessarily copying memory from the
+fake block device into the page cache (and copying changes back out), as well
+as creating and destroying dentries.  Plus it needed a filesystem driver
+(such as ext2) to format and interpret this data.  This wastes memory, creates
+unnecessary work for the CPU, wastes memory bus bandwidth, and pollutes the
+CPU caches.  (There are tricks to avoid this copying by playing with the page
+tables, but they're unpleasantly complicated and turn out to be about as
+expensive as the copying anyway.)
+
+More to the point, all the work ramfs is doing has to happen _anyway_,
+since all file access goes through the page and dentry caches.  The ram
+disk is simply unnecessary, ramfs is internally much simpler.
+
+One downside of ramfs is you can keep writing data into it until you fill
+up all memory, and the VM can't free it because the VM thinks that files
+should get written to backing store (rather than swap space), but ramfs hasn't
+got any backing store.  Because of this, only root (or a trusted user) should
+be allowed write access to a ramfs mount.
+
+A ramfs derivative called tmpfs was created to add size limits, and the ability
+to write the data to swap space.  Normal users can be allowed write access to
+tmpfs mounts.  See Documentation/filesystems/tmpfs.txt for more information.
+
+What is rootfs?
+---------------
+
+Rootfs is a special instance of ramfs, which is always present in 2.6
+systems.  (It's used as a placeholder inside the Linux kernel, as the place
+to start and stop searching the doubly-linked list of mount points.)
+
+Most systems just mount another filesystem over it and ignore it.  The
+amount of space an empty instance of ramfs takes up is tiny.
+
+What is initramfs?
+------------------
+
+All 2.6 Linux kernels contain a gzipped "cpio" format archive, which is
+extracted into rootfs when the kernel boots up.  The kernel then checks to
+see if rootfs now contains a file "init", and if so it executes it as PID 1.
+At this point, this init process is responsible for bringing the system the
+rest of the way up, including locating and mounting the real root device (if
+any).  If rootfs does not contain an init program after the embedded cpio
+archive is extracted into it, the kernel will fall through to the older code
+to locate and mount a root partition, then exec some variant of /sbin/init
+out of that.
+
+All this differs from the old initrd in several ways:
+
+  - The old initrd was a separate file, while the initramfs archive is linked
+    into the linux kernel image.  (This archive is always linked into 2.6
+    kernels, but by default it's an empty archive.)
+
+  - The old initrd file was a gzipped filesystem image (in some file format,
+    such as ext2, that had to be built into the kernel), while the new
+    initramfs archive is a gzipped cpio archive (like tar only simpler,
+    see cpio(1) and Documentation/early-userspace/buffer-format.txt).
+
+  - The program run by the old initrd (which was called initrd, not init) did
+    some setup and then returned to the kernel, while the init program from
+    initramfs does not return to the kernel.  (If it needs to hand off control
+    it can overmount / with a new root device and exec another init program.
+    See switch_root, below.)
+
+  - When switching another root device, initrd would pivot_root and then
+    umount the ramdisk.  But initramfs is rootfs: you shouldn't pivot_root
+    rootfs and can't unmount it.  Just delete everything out of it (except
+    the new block device node, if any), overmount /, and exec the new init.
+    (The klibc package contains a helper program in utils/run_init.c to do
+    this for you, and other packages have adopted this as "switch_root".)
+
+The 2.6 kernel build process always creates a gzipped cpio format initramfs
+archive and links it into the resulting kernel binary.  By default, this
+archive is blank.  The config option CONFIG_INITRAMFS_SOURCE (for some
+reason buried under devices->block devices in menuconfig) can be used to
+specify a source for the initramfs archive, which will automatically
+be incorporated into the resulting binary.  This option can point to
+an existing gzipped cpio archive, a directory containing files to be
+archived, or a text file specification such as the following example:
+
+  dir /dev 755 0 0
+  nod /dev/console 644 0 0 c 5 1
+  nod /dev/loop0 644 0 0 b 7 0
+  dir /bin 755 1000 1000
+  slink /bin/sh busybox 777 0 0
+  dir /proc 755 0 0
+  dir /sub 755 0 0
+  file /init initramfs/init.sh 755 0 0
+  file /bin/busybox initramfs/busybox 755 0 0
+
+One advantage of the text file is that root access is not required to
+set permissions or create device nodes in a directory.  (Note that those two
+example "file" entries expect to find files named "init.sh" and "busybox" in
+a directory called "initramfs", under the linux-2.6.* directory.  See
+Documentation/early-userspace/README for more details.)
+
+If you don't already understand what shared libraries, devices, and paths
+you need to get a minimal root filesystem up and running, here are some
+references:
+http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
+http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
+http://www.linuxfromscratch.org/lfs/view/stable/
+
+The "klibc" package (http://www.kernel.org/pub/linux/libs/klibc) is
+designed to be a tiny C library to statically link early userspace
+code against, along with some related utilities.  I use uClibc and busybox
+myself.  (In theory you could use glibc, but that's not well suited for small
+embedded usage.  Also note that glibc dlopens libnss to do name lookups, even
+when otherwise statically linked.)
diff -ru old/Documentation/initrd.txt new/Documentation/initrd.txt
--- old/Documentation/initrd.txt 2005-09-09 21:42:58.000000000 -0500
+++ new/Documentation/initrd.txt 2005-10-17 22:38:41.447859392 -0500
@@ -1,3 +1,6 @@
+NOTE: New systems should probably be using initramfs instead of initrd.  See
+Documentation/filesystems/ramfs-rootfs-initramfs.txt for details.
+
 Using the initial RAM disk (initrd)
 ===================================
 
