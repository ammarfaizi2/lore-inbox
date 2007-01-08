Return-Path: <linux-kernel-owner+w=401wt.eu-S1161174AbXAHH6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbXAHH6M (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 02:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbXAHH6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 02:58:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:38552 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161174AbXAHH6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 02:58:11 -0500
Date: Mon, 8 Jan 2007 13:28:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Horms <horms@verge.net.au>
Subject: [PATCH] Kdump documentation update for 2.6.20
Message-ID: <20070108075803.GB7889@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o Kdump documentation update.
	- Update details for using relocatable kernel.
	- Start using kexec-tools-testing release as it is latest and old
	  kexec-tools can't load relocatable bzImage file.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 Documentation/kdump/kdump.txt |  160 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 130 insertions(+), 30 deletions(-)

diff -puN Documentation/kdump/kdump.txt~kdump-documentation-update Documentation/kdump/kdump.txt
--- linux-2.6.20-rc2-mm1-reloc/Documentation/kdump/kdump.txt~kdump-documentation-update	2007-01-08 10:01:50.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/Documentation/kdump/kdump.txt	2007-01-08 11:51:49.000000000 +0530
@@ -54,56 +54,68 @@ memory," in two ways:
 Setup and Installation
 ======================
 
-Install kexec-tools and the Kdump patch
----------------------------------------
+Install kexec-tools
+-------------------
 
 1) Login as the root user.
 
 2) Download the kexec-tools user-space package from the following URL:
 
-   http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz
+http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing-20061214.tar.gz
 
-3) Unpack the tarball with the tar command, as follows:
-
-   tar xvpzf kexec-tools-1.101.tar.gz
-
-4) Download the latest consolidated Kdump patch from the following URL:
-
-   http://lse.sourceforge.net/kdump/
+Note: Latest kexec-tools-testing git tree is available at
 
-   (This location is being used until all the user-space Kdump patches
-   are integrated with the kexec-tools package.)
+git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
+or
+http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=summary
 
-5) Change to the kexec-tools-1.101 directory, as follows:
+3) Unpack the tarball with the tar command, as follows:
 
-   cd kexec-tools-1.101
+   tar xvpzf kexec-tools-testing-20061214.tar.gz
 
-6) Apply the consolidated patch to the kexec-tools-1.101 source tree
-   with the patch command, as follows. (Modify the path to the downloaded
-   patch as necessary.)
+4) Change to the kexec-tools-1.101 directory, as follows:
 
-   patch -p1 < /path-to-kdump-patch/kexec-tools-1.101-kdump.patch
+   cd kexec-tools-testing-20061214
 
-7) Configure the package, as follows:
+5) Configure the package, as follows:
 
    ./configure
 
-8) Compile the package, as follows:
+6) Compile the package, as follows:
 
    make
 
-9) Install the package, as follows:
+7) Install the package, as follows:
 
    make install
 
 
 Download and build the system and dump-capture kernels
 ------------------------------------------------------
+There are two possible methods of using Kdump.
+
+	1) Build a separate custom dump-capture kernel for capturing the
+	   kernel core dump.
+
+	2) Use system kernel itself as dump-capture kernel and there is
+	   no need to build a separate dump-capture kernel. (Only for
+	   i386 architecture kernel version 2.6.20 onwards)
+
+For i386, second method is recommended, as it takes away the need to build
+additional kernel.
+
+If you decide to use second option (Relocatable kernel), then directly jump to
+the section "Method 2".
+
+Method 1:
+--------
 
 Download the mainline (vanilla) kernel source code (2.6.13-rc1 or newer)
-from http://www.kernel.org. Two kernels must be built: a system kernel
-and a dump-capture kernel. Use the following steps to configure these
-kernels with the necessary kexec and Kdump features:
+from http://www.kernel.org.
+
+Two kernels must be built: a system kernel and a dump-capture kernel.
+Use the following steps to configure these kernels with the necessary kexec
+and Kdump features:
 
 System kernel
 -------------
@@ -198,22 +210,110 @@ The dump-capture kernel
 7) Make and install the kernel and its modules. DO NOT add this kernel
    to the boot loader configuration files.
 
+Skip following section and directly jump to "Load the Dump-capture Kernel"
+section.
+
+Method 2:
+--------
+
+Build Relocatable bzImage for dump-capture kernel (i386 only)
+------------------------------------------------------------
+Kernel version 2.6.20 onwards, i386 kernel bzImage has become relocatable.
+That means, same kernel binary bzImage can be run from any physical address.
+This takes away the limitation of building a special dump-capture kernel
+compiled for a specific memory location for capturing the dump. Now one
+has the flexibility of using the system kernel itself as the dump capture
+kernel for i386.
+
+Download the mainline (vanilla) kernel source code (2.6.20-rc1 or newer)
+from http://www.kernel.org.
+
+1) Enable "kexec system call" in "Processor type and features."
+
+   CONFIG_KEXEC=y
+
+2) Enable "kernel crash dumps" support under "Processor type and
+   features"
+
+   CONFIG_CRASH_DUMP=y
+
+   Leave "Physical address where the kernel is loaded" unchanged. By
+   default it is set to 0x100000 (1MB).
+
+3) Enable "Build a relocatable kernel" support under "Processor type and
+   features"
+
+   CONFIG_RELOCATABLE=y
+
+4) Enable "/proc/vmcore support" under "Filesystems" -> "Pseudo filesystems".
+
+   CONFIG_PROC_VMCORE=y
+   (CONFIG_PROC_VMCORE is set by default when CONFIG_CRASH_DUMP is selected.)
+
+5) On x86, enable high memory support under "Processor type and
+   features":
+
+   CONFIG_HIGHMEM64G=y
+   or
+   CONFIG_HIGHMEM4G
+
+6) Enable "Compile the kernel with debug info" in "Kernel hacking."
+
+   CONFIG_DEBUG_INFO=Y
+
+   This causes the kernel to be built with debug symbols. The dump
+   analysis tools require a vmlinux with debug symbols in order to read
+   and analyze a dump file.
+
+7) Enable "sysfs file system support" in "Filesystem" -> "Pseudo
+   filesystems." This is usually enabled by default.
+
+   CONFIG_SYSFS=y
+
+   Note that "sysfs file system support" might not appear in the "Pseudo
+   filesystems" menu if "Configure standard kernel features (for small
+   systems)" is not enabled in "General Setup." In this case, check the
+   .config file itself to ensure that sysfs is turned on, as follows:
+
+   grep 'CONFIG_SYSFS' .config
+
+8) Make and install the kernel and its modules. Update the boot loader
+   (such as grub, yaboot, or lilo) configuration files as necessary.
+
+9) Boot the system kernel with the boot parameter "crashkernel=Y@X",
+   where Y specifies how much memory to reserve for the dump-capture kernel
+   and X specifies the beginning of this reserved memory. For example,
+   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
+   starting at physical address 0x01000000 for the dump-capture kernel.
+
+   On x86 and x86_64, use "crashkernel=64M@16M".
 
 Load the Dump-capture Kernel
 ============================
 
-After booting to the system kernel, load the dump-capture kernel using
-the following command:
+After booting to the system kernel, dump-capture kernel needs to be
+loaded.
 
-   kexec -p <dump-capture-kernel> \
+If you are using a separate dump capture kernel (method 1) then use
+following command to load dump-capture kernel.
+
+   kexec -p <dump-capture-kernel-vmlinux-image> \
    --initrd=<initrd-for-dump-capture-kernel> --args-linux \
-   --append="root=<root-dev> init 1 irqpoll"
+   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
+
+If you are using a relocatable kernel (method 2), then use
+following command.
 
+   kexec -p <bzImage-of-relocatable-kernel> \
+   --initrd=<initrd-for-relocatable-kernel> \
+   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
 
 Notes on loading the dump-capture kernel:
 
-* <dump-capture-kernel> must be a vmlinux image (that is, an
-  uncompressed ELF image). bzImage does not work at this time.
+* For method 1, <dump-capture-kernel> must be a vmlinux image.
+  (that is, an uncompressed ELF image). bzImage does not work at
+  this time. Using bzImage for dump capture kernel works only for
+  Relocatable kernel (method 2)
 
 * By default, the ELF headers are stored in ELF64 format to support
   systems with more than 4GB memory. The --elf32-core-headers option can
_
