Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVC1NoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVC1NoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVC1Nno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:43:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:49129 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261779AbVC1N0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:26:45 -0500
Subject: [RFC/PATCH 7/17][Kdump] Documentation for Kdump
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-GnVLAxUYgCcK5cK3sO8C"
Date: Mon, 28 Mar 2005 18:56:41 +0530
Message-Id: <1112016401.4001.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GnVLAxUYgCcK5cK3sO8C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-GnVLAxUYgCcK5cK3sO8C
Content-Disposition: attachment; filename=crashdump-documentation.patch
Content-Type: message/rfc822; name=crashdump-documentation.patch

From: 
Date: Mon, 28 Mar 2005 17:37:11 +0530
Subject: No Subject
Message-Id: <1112011631.4001.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o Updated the documentation.

From: "Eric W. Biederman" <ebiederm@xmission.com>

I have addressed the worst of the documentation changes that come about from
the current refacatoring.

From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch contains the documentation for the kexec based crash dump tool.
Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed-off-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm1-16M-root/Documentation/00-INDEX  |    2 
 linux-2.6.12-rc1-mm1-16M-root/Documentation/kdump.txt |  118 ++++++++++++++++++
 2 files changed, 120 insertions(+)

diff -puN Documentation/00-INDEX~crashdump-documentation Documentation/00-INDEX
--- linux-2.6.12-rc1-mm1-16M/Documentation/00-INDEX~crashdump-documentation	2005-03-22 16:24:17.000000000 +0530
+++ linux-2.6.12-rc1-mm1-16M-root/Documentation/00-INDEX	2005-03-22 16:24:16.000000000 +0530
@@ -140,6 +140,8 @@ java.txt
 	- info on the in-kernel binary support for Java(tm).
 kbuild/
 	- directory with info about the kernel build process.
+kdumpt.txt
+       - mini HowTo on getting the crash dump code to work.
 kernel-doc-nano-HOWTO.txt
 	- mini HowTo on generation and location of kernel documentation files.
 kernel-docs.txt
diff -puN /dev/null Documentation/kdump.txt
--- /dev/null	2004-02-24 02:32:56.000000000 +0530
+++ linux-2.6.12-rc1-mm1-16M-root/Documentation/kdump.txt	2005-03-22 18:19:43.000000000 +0530
@@ -0,0 +1,118 @@
+Documentation for kdump - the kexec based crash dumping solution
+================================================================
+
+DESIGN
+======
+
+Kdump uses kexec to reboot to a second kernel whenever a dump needs to be taken.
+This second kernel is booted with very little memory. The first kernel reserves
+the section of memory that the second kernel uses. This ensures that on-going
+DMA from the first kernel does not corrupt the second kernel.
+
+All the necessary information about Core image is encoded in ELF format and
+stored in reserved area of memory before crash. Physical address of start of
+elf header is passed to new kernel through command line parameter elfcorehdr=.
+
+On i386, first 640k of physical memory is needed to boot, irrespctive of where
+the kernel loads at. Hence, this region is backed up by kexec just before
+rebooting into the new kernel.
+
+In the second kernel, "old memory" can be accessed in two ways.
+
+- The first one is through a /dev/oldmem device interface. A capture utility
+  can read the device file and write out the memory in raw format. This is raw
+  dump of memory and analysis/capture tool should be intelligent enough to
+  determine where to look for the right information. Elf headers (elfcorehdr=)
+  can become handy here.
+
+- The second interface is through /proc/vmcore. This exports the dump as an ELF
+  format file which can be written out using any file copy command
+  (cp, scp, etc). Further, gdb can be used to perform limited debugging on
+  the dump file. This method ensures methods ensure that there is correct
+  ordering of the dump pages (corresponding to the first 640k that has been
+  relocated).
+
+SETUP
+=====
+
+1) Obtain the appropriate -mm tree patch and apply it on to the vanilla
+   kernel tree.
+
+2) Obtain appropriate version of kexec-tools.
+
+3) Two kernels need to be built in order to get this feature working.
+
+   First kernel:
+   a) Enable "kexec system call" feature.
+   b) Enable "sysfs file system support" (Pseudo filesystems).
+   c) Boot into first kernel with command line "crashkernel=Y@X".  Put
+      appropriate values for X and Y. Y denotes, how much memory to reserve for
+      second kernel, and X denotes at what physical address reserved memory
+      section starts. For example, crashkernel=48M@16M.
+
+   Second kernel:
+   a) Enable "kernel crash dumps" feature.
+   b) Specifiy a suitable value for "Physical address where the kernel is
+      loaded". Typically this value should be same as X (See option c) above).
+   c) Enable "/proc/vmcore support" (Optional).
+
+      Note: Option a) and b) depend upon "Configure standard kernel feature
+            (for small systems)".
+	    Option a) also depends on CONFIG_HIGHMEM.
+	    Both option a) and b) are under "Processor Types and Features"
+
+3) Boot into the first kernel. You are now ready to try out kexec based crash
+   dumps.
+
+4) Load the second kernel to be booted using
+
+   kexec -p <second-kernel> --crash-dump --args-linux --append="root=<root-dev>
+   maxcpus=1 init 1"
+
+   Note: i) <second-kernel> has to be a vmlinux image. bzImage will not work,
+	    as of now.
+	ii) By default elf headers are stored in ELF32 format(for i386). This is
+	    sufficient to represent the physical memory up to 4GB. To store
+	    headers in ELF64 format, specifiy "--elf64-core-headers" on kexec
+	    command line additionally.
+
+5) System reboots into the second kernel when a panic occurs. A module can be
+   written to force the panic, for testing purposes.
+
+6) Write out the dump file using
+
+   cp /proc/vmcore <dump-file>
+
+   Dump can also be accessed as a /dev/oldmem device for a linear/raw view.
+   To create the device, type
+
+   mknod /dev/oldmem c 1 12
+
+   Use "dd" with suitable options for count, bs and skip to access specific
+   portions of the dump.
+
+ANALYSIS
+========
+
+Limited analysis can be done using gdb on the dump file copied out of
+/proc/vmcore. Use vmlinux built with -g and run
+
+  gdb vmlinux <dump-file>
+
+Stack trace for the task on processor 0, register display, memory display
+work fine.
+
+Note: gdb can not analyse core files generated in ELF64 format for i386.
+
+TODO
+====
+
+1) Provide a kernel pages filtering mechanism so that core file size is not
+   insane on systems having huge memory banks.
+2) Modify "crash" tool to make it recognize this dump.
+
+CONTACT
+=======
+
+Hariprasad Nellitheertha - hari at in dot ibm dot com
+Vivek Goyal (vgoyal@in.ibm.com)
_

--=-GnVLAxUYgCcK5cK3sO8C--

