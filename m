Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVC1NjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVC1NjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVC1NiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:38:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:17643 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261794AbVC1N11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:27 -0500
Subject: [RFC/PATCH 13/17][Kdump] Retrieve elfcorehdr address from command
	line
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-+fi17ngxx2x4oOlSx3du"
Date: Mon, 28 Mar 2005 18:57:23 +0530
Message-Id: <1112016443.4001.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+fi17ngxx2x4oOlSx3du
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-+fi17ngxx2x4oOlSx3du
Content-Disposition: attachment; filename=crashdump-x86-retrieve-elfcorehdr-addr.patch
Content-Type: message/rfc822; name=crashdump-x86-retrieve-elfcorehdr-addr.patch

From: 
Date: Mon, 28 Mar 2005 17:51:36 +0530
Subject: No Subject
Message-Id: <1112012496.4001.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o This patch adds support for retrieving the address of elf core header if one
  is passed in command line.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm1-1M-root/Documentation/kernel-parameters.txt |    4 ++++
 linux-2.6.12-rc1-mm1-1M-root/arch/i386/kernel/setup.c            |    8 ++++++++
 linux-2.6.12-rc1-mm1-1M-root/include/linux/crash_dump.h          |    1 +
 linux-2.6.12-rc1-mm1-1M-root/kernel/crash_dump.c                 |    3 +++
 4 files changed, 16 insertions(+)

diff -puN arch/i386/kernel/setup.c~crashdump-x86-retrieve-elfcorehdr-addr arch/i386/kernel/setup.c
--- linux-2.6.12-rc1-mm1-1M/arch/i386/kernel/setup.c~crashdump-x86-retrieve-elfcorehdr-addr	2005-03-22 16:17:00.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/arch/i386/kernel/setup.c	2005-03-22 16:17:00.000000000 +0530
@@ -42,6 +42,7 @@
 #include <linux/edd.h>
 #include <linux/nodemask.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include <video/edid.h>
 
@@ -860,6 +861,13 @@ static void __init parse_cmdline_early (
 			}
 		}
 #endif
+#ifdef CONFIG_CRASH_DUMP
+		/* elfcorehdr= specifies the location of elf core header
+		 * stored by the crashed kernel.
+		 */
+		else if (!memcmp(from, "elfcorehdr=", 11))
+			elfcorehdr_addr = memparse(from+11, &from);
+#endif
 
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
diff -puN Documentation/kernel-parameters.txt~crashdump-x86-retrieve-elfcorehdr-addr Documentation/kernel-parameters.txt
--- linux-2.6.12-rc1-mm1-1M/Documentation/kernel-parameters.txt~crashdump-x86-retrieve-elfcorehdr-addr	2005-03-22 16:17:00.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/Documentation/kernel-parameters.txt	2005-03-22 16:17:00.000000000 +0530
@@ -455,6 +455,10 @@ running once the system is up.
 			Format: {"as"|"cfq"|"deadline"|"noop"}
 			See Documentation/block/as-iosched.txt
 			and Documentation/block/deadline-iosched.txt for details.
+	elfcorehdr=	[IA-32]
+			Specifies physical address of start of kernel core image
+			elf header.
+			See Documentation/kdump.txt for details.
 
 	enforcing	[SELINUX] Set initial enforcing status.
 			Format: {"0" | "1"}
diff -puN include/linux/crash_dump.h~crashdump-x86-retrieve-elfcorehdr-addr include/linux/crash_dump.h
--- linux-2.6.12-rc1-mm1-1M/include/linux/crash_dump.h~crashdump-x86-retrieve-elfcorehdr-addr	2005-03-22 16:17:00.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/include/linux/crash_dump.h	2005-03-22 16:17:00.000000000 +0530
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/proc_fs.h>
 
+extern unsigned long long elfcorehdr_addr;
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
 #endif /* CONFIG_CRASH_DUMP */
diff -puN kernel/crash_dump.c~crashdump-x86-retrieve-elfcorehdr-addr kernel/crash_dump.c
--- linux-2.6.12-rc1-mm1-1M/kernel/crash_dump.c~crashdump-x86-retrieve-elfcorehdr-addr	2005-03-22 16:17:00.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/kernel/crash_dump.c	2005-03-22 16:17:00.000000000 +0530
@@ -15,6 +15,9 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
+/* Stores the physical address of elf header of crash image. */
+unsigned long long elfcorehdr_addr;
+
 /*
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
_

--=-+fi17ngxx2x4oOlSx3du--

