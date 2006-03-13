Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWCMSEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCMSEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWCMSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:04:20 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:9484 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751451AbWCMSED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:04:03 -0500
Date: Mon, 13 Mar 2006 10:03:36 -0800
Message-Id: <200603131803.k2DI3adh005672@zach-dev.vmware.com>
Subject: [RFC, PATCH 6/24] i386 Vmi magic fixes
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
X-OriginalArrivalTime: 13 Mar 2006 18:03:36.0871 (UTC) FILETIME=[7350B370:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linker changes to add the VMI MACH_TEXT area into the kernel text
section.  This area layout is heavily influenced by magic to overlap
exactly with the 32-byte VMI ROM entry points, allowing the kernel
to copy the VMI ROM over the native section.  As use of magic is
on the decline, this approach is being phased out in favor of the
more modern approach of the inline implementation.  The translation
and annotation sections are used to store the annotation information
which may be used to enlighten the hypervisor about code locations
and local conditions of virtualization relevant system operations.

Bottom line - MACH_TEXT and the dependence on exact layout of the
ROM image are hideous and are going away.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc3/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.16-rc3.orig/arch/i386/kernel/vmlinux.lds.S	2006-02-24 13:48:54.000000000 -0800
+++ linux-2.6.16-rc3/arch/i386/kernel/vmlinux.lds.S	2006-02-24 13:49:20.000000000 -0800
@@ -4,7 +4,7 @@
 
 #define LOAD_OFFSET __PAGE_OFFSET
 
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 
@@ -23,6 +23,7 @@ SECTIONS
 	SCHED_TEXT
 	LOCK_TEXT
 	KPROBES_TEXT
+  	MACH_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
@@ -36,6 +37,21 @@ SECTIONS
 
   RODATA
 
+#ifdef CONFIG_X86_VMI
+  __vmi_translation = .;
+  .vmi.translation : AT(ADDR(.vmi.translation) - LOAD_OFFSET) {
+	*(.vmi.translation)
+  }
+  __vmi_translation_end = .; 
+
+  . = ALIGN(16);
+  .vmi.annotation : AT(ADDR(.vmi.annotation) - LOAD_OFFSET) {
+	__vmi_annotation = .;
+	*(.vmi.annotation)
+	__vmi_annotation_end = .; 
+  }
+#endif
+
   /* writeable */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
@@ -142,6 +158,7 @@ SECTIONS
   /* Sections to be discarded */
   /DISCARD/ : {
 	*(.exitcall.exit)
+	*(.vmi.native)
 	}
 
   STABS_DEBUG
Index: linux-2.6.16-rc3/include/asm-i386/vmlinux.lds.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/vmlinux.lds.h	2006-02-24 13:49:20.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/vmlinux.lds.h	2006-02-24 13:49:20.000000000 -0800
@@ -0,0 +1,2 @@
+#include <asm-generic/vmlinux.lds.h>
+#include <mach-vmlinux.lds.h>
Index: linux-2.6.16-rc3/include/asm-i386/mach-vmi/mach-vmlinux.lds.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/mach-vmi/mach-vmlinux.lds.h	2006-02-24 13:49:20.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/mach-vmi/mach-vmlinux.lds.h	2006-02-24 13:49:20.000000000 -0800
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#include <vmiCalls.h>
+
+#define VDEF(name) \
+	. = __VMI_NEXT; \
+	__VMI_NEXT = . + 32; \
+	*(.text.VMI_##name);
+			 
+#define MACH_TEXT \
+. = ALIGN(4096); \
+__VMI_START = .; \
+__VMI_NEXT = .;  \
+__VMI_END = . + 16384; \
+VMI_CALLS  \
+. = __VMI_END; \
+. = ALIGN(4096);
Index: linux-2.6.16-rc3/include/asm-i386/mach-default/mach-vmlinux.lds.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-i386/mach-default/mach-vmlinux.lds.h	2006-02-24 13:49:20.000000000 -0800
+++ linux-2.6.16-rc3/include/asm-i386/mach-default/mach-vmlinux.lds.h	2006-02-24 13:49:20.000000000 -0800
@@ -0,0 +1 @@
+#define MACH_TEXT /* nothing */
