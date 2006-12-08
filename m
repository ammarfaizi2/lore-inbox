Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424858AbWLHHDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424858AbWLHHDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424859AbWLHHDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:03:47 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:33062 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424858AbWLHHDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:03:46 -0500
Date: Fri, 8 Dec 2006 16:07:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: [RFC] [PATCH] virtual memmap on sparsemem v3 [3/4] static virtual
 mem_map
Message-Id: <20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for statically allocated virtual mem_map.
(means virtual address of mem_map array is defined statically.)
This removes reference to *(&mem_map).

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: devel-2.6.19/include/linux/mmzone.h
===================================================================
--- devel-2.6.19.orig/include/linux/mmzone.h	2006-12-08 15:04:30.000000000 +0900
+++ devel-2.6.19/include/linux/mmzone.h	2006-12-08 15:05:18.000000000 +0900
@@ -618,8 +618,13 @@
 #if (((BITS_PER_LONG/4) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
 #error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
 #endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_STATIC
+#include <linux/mm_types.h>
+extern struct page mem_map[];
+#else
 extern struct page* mem_map;
 #endif
+#endif
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
Index: devel-2.6.19/mm/Kconfig
===================================================================
--- devel-2.6.19.orig/mm/Kconfig	2006-12-08 15:05:10.000000000 +0900
+++ devel-2.6.19/mm/Kconfig	2006-12-08 15:05:18.000000000 +0900
@@ -121,6 +121,10 @@
 	  But this consumes huge amount of virtual memory(not physical).
 	  This option is selectable only if your arch supports it.
 
+config SPARSEMEM_VMEMMAP_STATIC
+	def_bool y
+	depends on ARCH_SPARSEMEM_VMEMMAP_STATIC
+
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
Index: devel-2.6.19/mm/memory.c
===================================================================
--- devel-2.6.19.orig/mm/memory.c	2006-12-08 15:03:02.000000000 +0900
+++ devel-2.6.19/mm/memory.c	2006-12-08 15:09:00.000000000 +0900
@@ -71,7 +71,9 @@
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /* for the virtual mem_map */
+#ifndef CONFIG_SPARSEMEM_VMEMMAP_STATIC
 struct page *mem_map;
+#endif
 EXPORT_SYMBOL(mem_map);
 #endif
 

