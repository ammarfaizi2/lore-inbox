Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVC1NmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVC1NmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVC1NmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:42:03 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:24250 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261781AbVC1N0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:26:50 -0500
Subject: [RFC/PATCH 8/17][Kdump] Retrieve saved max pfn
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-FlwLNB0twL1fYzQ8WiX9"
Date: Mon, 28 Mar 2005 18:56:48 +0530
Message-Id: <1112016408.4001.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FlwLNB0twL1fYzQ8WiX9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-FlwLNB0twL1fYzQ8WiX9
Content-Disposition: attachment; filename=crashdump-x86-retrieve-max-pfn.patch
Content-Type: message/rfc822; name=crashdump-x86-retrieve-max-pfn.patch

From: 
Date: Mon, 28 Mar 2005 17:39:11 +0530
Subject: No Subject
Message-Id: <1112011751.4001.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o This patch retrieves the max_pfn being used by previous kernel and stores
  it in a safe location (saved_max_pfn) before it is overwritten due to user
  defined memory map. This pfn is used to make sure that user does not try to
  read the physical memory beyond saved_max_pfn.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm1-1M-root/arch/i386/kernel/setup.c |   12 ++++++++++++
 linux-2.6.12-rc1-mm1-1M-root/include/linux/bootmem.h  |    4 ++++
 linux-2.6.12-rc1-mm1-1M-root/mm/bootmem.c             |    8 ++++++++
 3 files changed, 24 insertions(+)

diff -puN arch/i386/kernel/setup.c~crashdump-x86-retrieve-max-pfn arch/i386/kernel/setup.c
--- linux-2.6.12-rc1-mm1-1M/arch/i386/kernel/setup.c~crashdump-x86-retrieve-max-pfn	2005-03-22 15:47:33.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/arch/i386/kernel/setup.c	2005-03-22 15:47:33.000000000 +0530
@@ -57,6 +57,9 @@
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
+/* Forward Declaration. */
+void __init find_max_pfn(void);
+
 /* This value is set up by the early boot code to point to the value
    immediately after the boot time page tables.  It contains a *physical*
    address, and must not be in the .bss segment! */
@@ -715,6 +718,15 @@ static void __init parse_cmdline_early (
 			if (to != command_line)
 				to--;
 			if (!memcmp(from+7, "exactmap", 8)) {
+#ifdef CONFIG_CRASH_DUMP
+				/* If we are doing a crash dump, we
+				 * still need to know the real mem
+				 * size before original memory map is
+				 * reset.
+				 */
+				find_max_pfn();
+				saved_max_pfn = max_pfn;
+#endif
 				from += 8+7;
 				e820.nr_map = 0;
 				userdef = 1;
diff -puN include/linux/bootmem.h~crashdump-x86-retrieve-max-pfn include/linux/bootmem.h
--- linux-2.6.12-rc1-mm1-1M/include/linux/bootmem.h~crashdump-x86-retrieve-max-pfn	2005-03-22 15:47:33.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/include/linux/bootmem.h	2005-03-22 15:47:33.000000000 +0530
@@ -22,6 +22,10 @@ extern unsigned long min_low_pfn;
  */
 extern unsigned long max_pfn;
 
+#ifdef CONFIG_CRASH_DUMP
+extern unsigned long saved_max_pfn;
+#endif
+
 /*
  * node_bootmem_map is a map pointer - the bits represent all physical 
  * memory pages (including holes) on the node.
diff -puN mm/bootmem.c~crashdump-x86-retrieve-max-pfn mm/bootmem.c
--- linux-2.6.12-rc1-mm1-1M/mm/bootmem.c~crashdump-x86-retrieve-max-pfn	2005-03-22 15:47:33.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/mm/bootmem.c	2005-03-22 15:47:33.000000000 +0530
@@ -33,6 +33,14 @@ EXPORT_SYMBOL(max_pfn);		/* This is expo
 				 * dma_get_required_mask(), which uses
 				 * it, can be an inline function */
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * If we have booted due to a crash, max_pfn will be a very low value. We need
+ * to know the amount of memory that the previous kernel used.
+ */
+unsigned long saved_max_pfn;
+#endif
+
 /* return the number of _pages_ that will be allocated for the boot bitmap */
 unsigned long __init bootmem_bootmap_pages (unsigned long pages)
 {
_

--=-FlwLNB0twL1fYzQ8WiX9--

