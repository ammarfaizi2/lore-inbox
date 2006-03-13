Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCMSFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCMSFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWCMSEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:04:40 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:14348 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932103AbWCMSEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:04:25 -0500
Date: Mon, 13 Mar 2006 10:04:23 -0800
Message-Id: <200603131804.k2DI4N6s005678@zach-dev.vmware.com>
Subject: [RFC, PATCH 7/24] i386 Vmi memory hole
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:04:24.0135 (UTC) FILETIME=[8F7C9D70:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create a configurable hole in the linear address space at the top
of memory.  A more advanced interface is needed to negotiate how
much space the hypervisor is allowed to steal, but in the end, it
seems most likely that a fixed constant size will be chosen for
the compiled kernel, potentially propagated to an information
page used by paravirtual initialization to determine interface
compatibility.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc3/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc3.orig/arch/i386/Kconfig	2006-02-22 16:09:04.000000000 -0800
+++ linux-2.6.16-rc3/arch/i386/Kconfig	2006-02-22 16:33:27.000000000 -0800
@@ -201,6 +201,15 @@ config VMI_DEBUG
 
 endmenu
 
+config MEMORY_HOLE
+	int "Create hole at top of memory (0-256 MB)"
+	range 0 256
+	default "64" if X86_VMI
+	default "0" if !X86_VMI
+	help
+	   Useful for creating a hole in the top of memory when running
+	   inside of a virtual machine monitor.
+
 config ACPI_SRAT
 	bool
 	default y
Index: linux-2.6.16-rc3/include/asm-i386/fixmap.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/fixmap.h	2006-02-22 15:48:23.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/fixmap.h	2006-02-22 16:33:27.000000000 -0800
@@ -20,7 +20,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+#define __FIXADDR_TOP	0xfffff000-(CONFIG_MEMORY_HOLE << 20)
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
