Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUHQMG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUHQMG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUHQMG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:06:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:49309 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268184AbUHQMFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:05:47 -0400
Date: Tue, 17 Aug 2004 17:35:31 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][1/6]Documentation
Message-ID: <20040817120531.GB3916@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20040817120239.GA3916@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-doc-268.patch"



This patch contains the documentation for the kexec based crash dump tool.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>



---

 linux-2.6.8.1-hari/Documentation/kdump.txt |  101 +++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+)

diff -puN /dev/null Documentation/kdump.txt
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8.1-hari/Documentation/kdump.txt	2004-08-17 17:03:19.000000000 +0530
@@ -0,0 +1,101 @@
+Documentation for kdump - the kexec based crash dumping solution
+================================================================
+
+DESIGN
+======
+
+We use kexec to reboot to a second kernel whenever a dump needs to be taken.
+This second kernel is booted with with very little memory (current
+implementation has this at 16MB). The contents of the 16MB of memory that
+the second kernel uses is copied onto a reserved area, before rebooting. So,
+we have the entire memory image of the previous kernel preserved.
+
+In the second kernel, this "old memory" can be accessed in two ways. The
+first one is through a device interface. We can create a /dev/hmem or
+whatever and write out the memory in raw format. The second interface is
+through /proc/vmcore. This exports the dump as an ELF format file which
+can be written out using any file copy command (cp, scp, etc). Further, gdb
+can be used to perform some minimal debugging on the dump file.
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
+   and also saves the first 16MB of memory into a backup area
+3) kd-copy-<version>.patch - This contains the code for reading the dump pages
+   in the second kernel.
+4) kd-reg-<version>.patch - This patch is for snapshotting the register contents
+   of all processors on to the backup area before rebooting.
+5) kd-elf-<version>.patch - This patch provides an ELF format interface to
+   the dump, post-reboot.
+6) kd-hmem-<version>.patch - This patch contains the code to access the dump as
+   an /dev/hmem.
+
+SETUP
+=====
+
+1) Apply the kexec patch on to the appropriate vanilla kernel tree.
+   The latest version of the kexec patch can be obtained from
+   http://www.xmission.com/~ebiederm/files/kexec/2.6.8-rc1-kexec1/
+   This patch should apply on 2.6.8-rc4 as well.
+   Older kexec patches can be found at
+   http://developer.osdl.org/rddunlap/kexec/
+
+2) Apply the crash dump patches.
+
+3) Ensure you have chosen the "kernel crash dumps" option under "Processor
+   type and features" and also the kexec syscall option under kernel hacking
+
+4) Load the second kernel to be booted using
+
+   kexec -l <kernel> --append="root=<root-dev> mem=16M dump init 1"
+
+5) System reboots into the second kernel when a panic occurs.
+   You could write a module to call panic, for testing purposes.
+
+6) Write out the dump file using
+
+   cp /proc/vmcore <dump-file>
+
+You can also access the dump as a device for a linear/raw view. To do this,
+you will need the kd-hmem-<version>.patch built into the kernel. To create
+the device, type
+
+  mknod /dev/hmem c 1 12
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

--/04w6evG8XlLl3ft--
