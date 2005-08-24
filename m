Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVHXSpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVHXSpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbVHXSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:45:05 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:7172 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751391AbVHXSpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:45:02 -0400
Date: Wed, 24 Aug 2005 11:45:18 -0700
Message-Id: <200508241845.j7OIjIeM001900@zach-dev.vmware.com>
Subject: [PATCH 5/5] Create a hole in high linear address space
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Virtualization Mailing List <virtualization@lists.osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
To: Pratap Subrahmanyam <pratap@vmware.com>
To: Christopher Li <chrisl@vmware.com>
To: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Aug 2005 18:45:00.0265 (UTC) FILETIME=[EE80CD90:01C5A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow compile time creation of a hole at the high end of linear address space.
This makes accomodating a hypervisor a much more tractable problem by giving
it ample playground to live in.  Currently, the hole size is fixed at config
time; I have experimented with dynamically sized holes, and have a later
patch that developes this potential, but it becomes much more useful once
the exact negotiation of linear address space with the hypervisor is defined.

The fixed compile time solution is sufficient for now.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/Kconfig
===================================================================
--- linux-2.6.13.orig/arch/i386/Kconfig	2005-08-24 09:30:49.000000000 -0700
+++ linux-2.6.13/arch/i386/Kconfig	2005-08-24 09:58:56.000000000 -0700
@@ -803,6 +803,14 @@ config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SPARSEMEM_ENABLE
 
+config MEMORY_HOLE
+	int "Create hole at top of memory (0-512 MB)"
+	range 0 512
+	default "0"
+	help
+	   Useful for creating a hole in the top of memory when running
+	   inside of a virtual machine monitor.
+
 source "mm/Kconfig"
 
 config HAVE_ARCH_EARLY_PFN_TO_NID
Index: linux-2.6.13/include/asm-i386/fixmap.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/fixmap.h	2005-08-24 09:30:43.000000000 -0700
+++ linux-2.6.13/include/asm-i386/fixmap.h	2005-08-24 10:04:42.000000000 -0700
@@ -20,7 +20,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+#define __FIXADDR_TOP	(0xfffff000-(CONFIG_MEMORY_HOLE << 20))
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
