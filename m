Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUIOMwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUIOMwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIOMwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:52:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34962 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263100AbUIOMvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:51:50 -0400
Date: Wed, 15 Sep 2004 18:21:45 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: [PATCH][1/6]Documentation
Message-ID: <20040915125145.GB15450@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20040915125041.GA15450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-doc-269rc1-mm5.patch"



This patch contains the documentation for the kexec based crash dump tool.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>



---

 linux-2.6.9-rc1-hari/Documentation/kdump.txt |  133 +++++++++++++++++++++++++++
 1 files changed, 133 insertions(+)

diff -puN /dev/null Documentation/kdump.txt
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/Documentation/kdump.txt	2004-09-15 17:36:25.000000000 +0530
@@ -0,0 +1,133 @@
+Documentation for kdump - the kexec based crash dumping solution
+================================================================
+
+DESIGN
+======
+
+We use kexec to reboot to a second kernel whenever a dump needs to be taken.
+This second kernel is booted with with very little memory (configurable
+at compile time). The first kernel reserves the section of memory that the
+second kernel uses. This ensures that on-going DMA from the first kernel
+does not corrupt the second kernel. The first 640k of physical memory is
+needed irrespective of where the kernel loads at. Hence, this region is
+backed up before reboot.
+
+In the second kernel, "old memory" can be accessed in two ways. The
+first one is through a device interface. We can create a /dev/oldmem or
+whatever and write out the memory in raw format. The second interface is
+through /proc/vmcore. This exports the dump as an ELF format file which
+can be written out using any file copy command (cp, scp, etc). Further, gdb
+can be used to perform some minimal debugging on the dump file. Both these
+methods ensure that there is correct ordering of the dump pages (corresponding
+to the first 640k that has been relocated).
+
+Note that the two approaches are independent and the patches
+can be used depending on the functionality needed. More details on the
+patches below.
+
+PATCHES
+=======
+
+We currently have 6 patches.
+
+1) kd-doc-<version>.patch - Contains basic documentation (this document!!)
+2) kd-reb-<version>.patch - This patch ensures we do a kexec reboot upon panic
+   and also saves the necessary regions of  memory into a backup area
+3) kd-copy-<version>.patch - This contains the code for reading the dump pages
+   in the second kernel.
+4) kd-reg-<version>.patch - This patch is for snapshotting the register contents
+   of all processors on to the backup area before rebooting.
+5) kd-elf-<version>.patch - This patch provides an ELF format interface to
+   the dump, post-reboot.
+6) kd-oldmem-<version>.patch - This patch contains the code to access the dump as
+   an /dev/oldmem.
+
+SETUP
+=====
+
+1) Apply the appropriate -mm patch on to the vanilla kernel tree. The -mm
+   tree has the kexec patches included.
+
+2) In order to enable the kernel to boot from a non-default location, the
+   following patches (by Eric Biederman) needs to be applied.
+
+   http://www.xmission.com/~ebiederm/files/kexec/2.6.8.1-kexec3/
+	broken-out/highbzImage.i386.patch
+   http://www.xmission.com/~ebiederm/files/kexec/2.6.8.1-kexec3/
+	broken-out/vmlinux-lds.i386.patch
+
+3) Apply the crash dump patches.
+
+4) Two kernels need to be built in order to get this feature working.
+
+   For the first kernel, choose the default values for the following options.
+
+   a) Physical address where the kernel expects to be loaded
+   b) kexec system call
+   c) kernel crash dumps
+
+   All the options are under "Processor type and features"
+
+   For the second kernel, change (a) to 16MB. If you want to choose another
+   value here, ensure "location of the crash dumps backup region" under (c)
+   reflects the same value.
+
+   Also ensure you have CONFIG_HIGHMEM on.
+
+5) Boot into the first kernel. You are now ready to try out kexec based crash
+   dumps.
+
+5) Load the second kernel to be booted using
+
+   kexec -l <second-kernel> --args-linux --append="root=<root-dev> dump
+   init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"
+
+   Note that <second-kernel> has to be a vmlinux image. bzImage will not
+   work, as of now.
+
+6) Enable kexec based dumping by
+
+   echo 1 > /proc/kexec-dump
+
+7) System reboots into the second kernel when a panic occurs.
+   You could write a module to call panic, for testing purposes.
+
+8) Write out the dump file using
+
+   cp /proc/vmcore <dump-file>
+
+You can also access the dump as a device for a linear/raw view. To do this,
+you will need the kd-oldmem-<version>.patch built into the kernel. To create
+the device, type
+
+  mknod /dev/oldmem c 1 12
+
+Use "dd" with suitable options for count, bs and skip to access specific
+portions of the dump.
+
+ANALYSIS
+========
+
+You can run gdb on the dump file copied out of /proc/vmcore. Use vmlinux built
+with -g and run
+
+  gdb vmlinux <dump-file>
+
+Stack trace for the task on processor 0, register display, memory display
+work fine.
+
+TODO
+====
+
+1) Provide a kernel-pages only view for the dump. This could possibly turn up
+   as /proc/vmcore-kern.
+2) Provide register contents of all processors (similar to what multi-threaded
+   core dumps does).
+3) Modify "crash" to make it recognize this dump.
+4) Make the i386 kernel boot from any location so we can run the second kernel
+   from the reserved location instead of the current approach.
+
+CONTACT
+=======
+
+Hariprasad Nellitheertha - hari at in dot ibm dot com

_

--82I3+IH0IqGh5yIs--
