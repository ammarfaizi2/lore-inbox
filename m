Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWEKSxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWEKSxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWEKSxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:53:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:40616 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750703AbWEKSxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:53:32 -0400
Message-ID: <4463921D.4050402@us.ibm.com>
Date: Thu, 11 May 2006 12:35:57 -0700
From: David Wilder <dwilder@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation update for kdump
Content-Type: multipart/mixed;
 boundary="------------030607010205040005070201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030607010205040005070201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch contains a re-write of the kdump documentation (kdump.txt).
We have updated much of the document to reflect the current state of 
kdump and reformatted the document for readability.

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------030607010205040005070201
Content-Type: text/x-patch;
 name="k-dump-documentation-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k-dump-documentation-update.patch"

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 212cf3c..43e02e1 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -1,155 +1,325 @@
-Documentation for kdump - the kexec-based crash dumping solution
-================================================================
-
-DESIGN
-======
-
-Kdump uses kexec to reboot to a second kernel whenever a dump needs to be
-taken. This second kernel is booted with very little memory. The first kernel
-reserves the section of memory that the second kernel uses. This ensures that
-on-going DMA from the first kernel does not corrupt the second kernel.
-
-All the necessary information about Core image is encoded in ELF format and
-stored in reserved area of memory before crash. Physical address of start of
-ELF header is passed to new kernel through command line parameter elfcorehdr=.
-
-On i386, the first 640 KB of physical memory is needed to boot, irrespective
-of where the kernel loads. Hence, this region is backed up by kexec just before
-rebooting into the new kernel.
-
-In the second kernel, "old memory" can be accessed in two ways.
-
-- The first one is through a /dev/oldmem device interface. A capture utility
-  can read the device file and write out the memory in raw format. This is raw
-  dump of memory and analysis/capture tool should be intelligent enough to
-  determine where to look for the right information. ELF headers (elfcorehdr=)
-  can become handy here.
-
-- The second interface is through /proc/vmcore. This exports the dump as an ELF
-  format file which can be written out using any file copy command
-  (cp, scp, etc). Further, gdb can be used to perform limited debugging on
-  the dump file. This method ensures methods ensure that there is correct
-  ordering of the dump pages (corresponding to the first 640 KB that has been
-  relocated).
-
-SETUP
-=====
-
-1) Download the upstream kexec-tools userspace package from
-   http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz.
-
-   Apply the latest consolidated kdump patch on top of kexec-tools-1.101
-   from http://lse.sourceforge.net/kdump/. This arrangment has been made
-   till all the userspace patches supporting kdump are integrated with
-   upstream kexec-tools userspace.
-
-2) Download and build the appropriate (2.6.13-rc1 onwards) vanilla kernels.
-   Two kernels need to be built in order to get this feature working.
-   Following are the steps to properly configure the two kernels specific
-   to kexec and kdump features:
-
-  A) First kernel or regular kernel:
-  ----------------------------------
-   a) Enable "kexec system call" feature (in Processor type and features).
-      CONFIG_KEXEC=y
-   b) Enable "sysfs file system support" (in Pseudo filesystems).
-      CONFIG_SYSFS=y
-   c) make
-   d) Boot into first kernel with the command line parameter "crashkernel=Y@X".
-      Use appropriate values for X and Y. Y denotes how much memory to reserve
-      for the second kernel, and X denotes at what physical address the
-      reserved memory section starts. For example: "crashkernel=64M@16M".
-
-
-  B) Second kernel or dump capture kernel:
-  ---------------------------------------
-   a) For i386 architecture enable Highmem support
-      CONFIG_HIGHMEM=y
-   b) Enable "kernel crash dumps" feature (under "Processor type and features")
-      CONFIG_CRASH_DUMP=y
-   c) Make sure a suitable value for "Physical address where the kernel is
-      loaded" (under "Processor type and features"). By default this value
-      is 0x1000000 (16MB) and it should be same as X (See option d above),
-      e.g., 16 MB or 0x1000000.
-      CONFIG_PHYSICAL_START=0x1000000
-   d) Enable "/proc/vmcore support" (Optional, under "Pseudo filesystems").
-      CONFIG_PROC_VMCORE=y
-
-3) After booting to regular kernel or first kernel, load the second kernel
-   using the following command:
-
-   kexec -p <second-kernel> --args-linux --elf32-core-headers
-   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
-
-   Notes:
-   ======
-     i) <second-kernel> has to be a vmlinux image ie uncompressed elf image.
-        bzImage will not work, as of now.
-    ii) --args-linux has to be speicfied as if kexec it loading an elf image,
-        it needs to know that the arguments supplied are of linux type.
-   iii) By default ELF headers are stored in ELF64 format to support systems
-        with more than 4GB memory. Option --elf32-core-headers forces generation
-        of ELF32 headers. The reason for this option being, as of now gdb can
-        not open vmcore file with ELF64 headers on a 32 bit systems. So ELF32
-        headers can be used if one has non-PAE systems and hence memory less
-        than 4GB.
-    iv) Specify "irqpoll" as command line parameter. This reduces driver
-         initialization failures in second kernel due to shared interrupts.
-     v) <root-dev> needs to be specified in a format corresponding to the root
-        device name in the output of mount command.
-    vi) If you have built the drivers required to mount root file system as
-        modules in <second-kernel>, then, specify
-        --initrd=<initrd-for-second-kernel>.
-   vii) Specify maxcpus=1 as, if during first kernel run, if panic happens on
-        non-boot cpus, second kernel doesn't seem to be boot up all the cpus.
-        The other option is to always built the second kernel without SMP
-        support ie CONFIG_SMP=n
-
-4) After successfully loading the second kernel as above, if a panic occurs
-   system reboots into the second kernel. A module can be written to force
-   the panic or "ALT-SysRq-c" can be used initiate a crash dump for testing
-   purposes.
-
-5) Once the second kernel has booted, write out the dump file using
-
-   cp /proc/vmcore <dump-file>
-
-   Dump memory can also be accessed as a /dev/oldmem device for a linear/raw
-   view.  To create the device, type:
-
-   mknod /dev/oldmem c 1 12
-
-   Use "dd" with suitable options for count, bs and skip to access specific
-   portions of the dump.
-
-   Entire memory:  dd if=/dev/oldmem of=oldmem.001
-
-
-ANALYSIS
-========
-Limited analysis can be done using gdb on the dump file copied out of
-/proc/vmcore. Use vmlinux built with -g and run
-
-  gdb vmlinux <dump-file>
-
-Stack trace for the task on processor 0, register display, memory display
-work fine.
-
-Note: gdb cannot analyse core files generated in ELF64 format for i386.
-
-Latest "crash" (crash-4.0-2.18) as available on Dave Anderson's site
-http://people.redhat.com/~anderson/ works well with kdump format.
-
-
-TODO
-====
-1) Provide a kernel pages filtering mechanism so that core file size is not
-   insane on systems having huge memory banks.
-2) Relocatable kernel can help in maintaining multiple kernels for crashdump
-   and same kernel as the first kernel can be used to capture the dump.
-
-
-CONTACT
-=======
-Vivek Goyal (vgoyal@in.ibm.com)
-Maneesh Soni (maneesh@in.ibm.com)
+================================================================
+Documentation for Kdump - The kexec-based Crash Dumping Solution
+================================================================
+
+This document includes overview, setup and installation, and analysis
+information.
+
+Overview
+========
+
+Kdump uses kexec to quickly boot to a dump-capture kernel whenever a
+dump of the system kernel's memory needs to be taken (for example, when
+the system panics). The system kernel's memory image is preserved across
+the reboot and is accessible to the dump-capture kernel.
+
+You can use common Linux commands, such as cp and scp, to copy the
+memory image to a dump file on the local disk, or across the network to
+a remote system.
+
+Kdump and kexec are currently supported on the x86, x86_64, and ppc64
+architectures.
+
+When the system kernel boots, it reserves a small section of memory for
+the dump-capture kernel. This ensures that ongoing Direct Memory Access
+(DMA) from the system kernel does not corrupt the dump-capture kernel.
+The kexec -p command loads the dump-capture kernel into this reserved
+memory.
+
+On x86 machines, the first 640 KB of physical memory is needed to boot,
+regardless of where the kernel loads. Therefore, kexec backs up this
+region just before rebooting into the dump-capture kernel.
+
+All of the necessary information about the system kernel's core image is
+encoded in the ELF format, and stored in a reserved area of memory
+before a crash. The physical address of the start of the ELF header is
+passed to the dump-capture kernel through the elfcorehdr= boot
+parameter.
+
+With the dump-capture kernel, you can access the memory image, or "old
+memory," in two ways:
+
+- Through a /dev/oldmem device interface. A capture utility can read the
+  device file and write out the memory in raw format. This is a raw dump
+  of memory. Analysis and capture tools must be intelligent enough to
+  determine where to look for the right information.
+
+- Through /proc/vmcore. This exports the dump as an ELF-format file that
+  you can write out using file copy commands such as cp or scp. Further,
+  you can use analysis tools such as the GNU Debugger (GDB) and the Crash
+  tool to debug the dump file. This method ensures that the dump pages are
+  correctly ordered.
+
+
+Setup and Installation
+======================
+
+Install kexec-tools and the Kdump patch
+---------------------------------------
+
+1) Login as the root user.
+
+2) Download the kexec-tools user-space package from the following URL:
+
+   http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz
+
+3) Unpack the tarball with the tar command, as follows:
+
+   tar xvpzf kexec-tools-1.101.tar.gz
+
+4) Download the latest consolidated Kdump patch from the following URL:
+
+   http://lse.sourceforge.net/kdump/
+   
+   (This location is being used until all the user-space Kdump patches
+   are integrated with the kexec-tools package.)
+   
+5) Change to the kexec-tools-1.101 directory, as follows:
+
+   cd kexec-tools-1.101
+
+6) Apply the consolidated patch to the kexec-tools-1.101 source tree
+   with the patch command, as follows. (Modify the path to the downloaded
+   patch as necessary.)
+   
+   patch -p1 < /path-to-kdump-patch/kexec-tools-1.101-kdump.patch
+
+7) Configure the package, as follows:
+
+   ./configure
+
+8) Compile the package, as follows:
+
+   make
+
+9) Install the package, as follows:
+
+   make install
+
+
+Download and build the system and dump-capture kernels
+------------------------------------------------------
+
+Download the mainline (vanilla) kernel source code (2.6.13-rc1 or newer)
+from http://www.kernel.org. Two kernels must be built: a system kernel
+and a dump-capture kernel. Use the following steps to configure these
+kernels with the necessary kexec and Kdump features:
+
+System kernel
+-------------
+
+1) Enable "kexec system call" in "Processor type and features."
+
+   CONFIG_KEXEC=y
+
+2) Enable "sysfs file system support" in "Filesystem" -> "Pseudo
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
+3) Enable "Compile the kernel with debug info" in "Kernel hacking."
+
+   CONFIG_DEBUG_INFO=Y
+
+   This causes the kernel to be built with debug symbols. The dump
+   analysis tools require a vmlinux with debug symbols in order to read
+   and analyze a dump file.
+           
+4) Make and install the kernel and its modules. Update the boot loader
+   (such as grub, yaboot, or lilo) configuration files as necessary.
+
+5) Boot the system kernel with the boot parameter "crashkernel=Y@X",
+   where Y specifies how much memory to reserve for the dump-capture kernel
+   and X specifies the beginning of this reserved memory. For example,
+   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
+   starting at physical address 0x01000000 for the dump-capture kernel.
+
+   On x86 and x86_64, use "crashkernel=64M@16M".
+
+   On ppc64, use "crashkernel=128M@32M".
+
+
+The dump-capture kernel
+-----------------------
+
+1) Under "General setup," append "-kdump" to the current string in
+   "Local version."
+
+2) On x86, enable high memory support under "Processor type and
+   features":
+
+   CONFIG_HIGHMEM64G=y
+   or
+   CONFIG_HIGHMEM4G
+
+3) On x86 and x86_64, disable symmetric multi-processing support
+   under "Processor type and features":
+   
+   CONFIG_SMP=n
+   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
+   when loading the dump-capture kernel, see section "Load the Dump-capture
+   Kernel".)
+
+4) On ppc64, disable NUMA support and enable EMBEDDED support:
+   
+   CONFIG_NUMA=n
+   CONFIG_EMBEDDED=y
+   CONFIG_EEH=N for the dump-capture kernel
+
+5) Enable "kernel crash dumps" support under "Processor type and
+   features":
+
+   CONFIG_CRASH_DUMP=y
+
+6) Use a suitable value for "Physical address where the kernel is
+   loaded" (under "Processor type and features"). This only appears when
+   "kernel crash dumps" is enabled. By default this value is 0x1000000
+   (16MB). It should be the same as X in the "crashkernel=Y@X" boot
+   parameter discussed above.
+
+   On x86 and x86_64, use "CONFIG_PHYSICAL_START=0x1000000".
+      
+   On ppc64 the value is automatically set at 32MB when
+   CONFIG_CRASH_DUMP is set.
+
+6) Optionally enable "/proc/vmcore support" under "Filesystems" ->
+   "Pseudo filesystems".
+
+   CONFIG_PROC_VMCORE=y
+   (CONFIG_PROC_VMCORE is set by default when CONFIG_CRASH_DUMP is selected.)
+      
+7) Make and install the kernel and its modules. DO NOT add this kernel
+   to the boot loader configuration files.
+   
+
+Load the Dump-capture Kernel
+============================
+
+After booting to the system kernel, load the dump-capture kernel using
+the following command:
+
+   kexec -p <dump-capture-kernel> \
+   --initrd=<initrd-for-dump-capture-kernel> --args-linux \
+   --append="root=<root-dev> init 1 irqpoll"
+
+
+Notes on loading the dump-capture kernel:
+
+* <dump-capture-kernel> must be a vmlinux image (that is, an
+  uncompressed ELF image). bzImage does not work at this time.
+
+* By default, the ELF headers are stored in ELF64 format to support
+  systems with more than 4GB memory. The --elf32-core-headers option can
+  be used to force the generation of ELF32 headers. This is necessary
+  because GDB currently cannot open vmcore files with ELF64 headers on
+  32-bit systems. ELF32 headers can be used on non-PAE systems (that is,
+  less than 4GB of memory).
+		 
+* The "irqpoll" boot parameter reduces driver initialization failures
+  due to shared interrupts in the dump-capture kernel.
+		  
+* You must specify <root-dev> in the format corresponding to the root
+  device name in the output of mount command.
+
+* "init 1" boots the dump-capture kernel into single-user mode without
+  networking. If you want networking, use "init 3."
+
+
+Kernel Panic
+============
+
+After successfully loading the dump-capture kernel as previously
+described, the system will reboot into the dump-capture kernel if a
+system crash is triggered.  Trigger points are located in panic(),
+die(), die_nmi() and in the sysrq handler (ALT-SysRq-c). 
+
+The following conditions will execute a crash trigger point:
+
+If a hard lockup is detected and "NMI watchdog" is configured, the system
+will boot into the dump-capture kernel ( die_nmi() ).
+
+If die() is called, and it happens to be a thread with pid 0 or 1, or die()
+is called inside interrupt context or die() is called and panic_on_oops is set,
+the system will boot into the dump-capture kernel.
+
+On powererpc systems when a soft-reset is generated, die() is called by all cpus and the system system will boot into the dump-capture kernel.
+
+For testing purposes, you can trigger a crash by using "ALT-SysRq-c",
+"echo c > /proc/sysrq-trigger or write a module to force the panic.
+
+Write Out the Dump File
+=======================
+
+After the dump-capture kernel is booted, write out the dump file with
+the following command:
+
+   cp /proc/vmcore <dump-file>
+
+You can also access dumped memory as a /dev/oldmem device for a linear
+and raw view. To create the device, use the following command:
+
+    mknod /dev/oldmem c 1 12
+
+Use the dd command with suitable options for count, bs, and skip to
+access specific portions of the dump.
+
+To see the entire memory, use the following command:
+   
+   dd if=/dev/oldmem of=oldmem.001
+
+
+Analysis
+========
+
+Before analyzing the dump image, you should reboot into a stable kernel.
+
+You can do limited analysis using GDB on the dump file copied out of
+/proc/vmcore. Use the debug vmlinux built with -g and run the following
+command:
+
+   gdb vmlinux <dump-file>
+
+Stack trace for the task on processor 0, register display, and memory
+display work fine.
+
+Note: GDB cannot analyze core files generated in ELF64 format for x86.
+On systems with a maximum of 4GB of memory, you can generate
+ELF32-format headers using the --elf32-core-headers kernel option on the
+dump kernel.
+
+You can also use the Crash utility to analyze dump files in Kdump
+format. Crash is available on Dave Anderson's site at the following URL:
+
+   http://people.redhat.com/~anderson/
+
+
+To Do
+=====
+
+1) Provide a kernel pages filtering mechanism, so core file size is not
+   extreme on systems with huge memory banks.
+
+2) Relocatable kernel can help in maintaining multiple kernels for
+   crash_dump, and the same kernel as the system kernel can be used to
+   capture the dump.
+
+
+Contact
+=======
+
+Vivek Goyal (vgoyal@in.ibm.com)
+Maneesh Soni (maneesh@in.ibm.com)
+
+
+Trademark
+=========
+
+Linux is a trademark of Linus Torvalds in the United States, other
+countries, or both.

--------------030607010205040005070201--
