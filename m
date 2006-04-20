Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDTKK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDTKK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDTKK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:10:56 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8338 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750824AbWDTKKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:10:55 -0400
Date: Thu, 20 Apr 2006 19:10:16 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch: 004/006] pgdat allocation for new node add (refresh node_data[])
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
References: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060420190618.EE50.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function refresh NODE_DATA() for generic archs.
In this case, NODE_DATA(nid) == node_data[nid].
node_data[] is array of address of pgdat.
So, refresh is quite simple.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 arch/ia64/Kconfig              |    4 ++++
 include/linux/memory_hotplug.h |   12 ++++++++++++
 2 files changed, 16 insertions(+)

Index: pgdat11/include/linux/memory_hotplug.h
===================================================================
--- pgdat11.orig/include/linux/memory_hotplug.h	2006-04-20 11:00:23.000000000 +0900
+++ pgdat11/include/linux/memory_hotplug.h	2006-04-20 11:00:28.000000000 +0900
@@ -91,6 +91,9 @@ static inline pg_data_t * arch_alloc_nod
 static inline void arch_free_nodedata(pg_data_t *pgdat)
 {
 }
+static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+}
 
 #else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
@@ -114,6 +117,12 @@ static inline void arch_free_nodedata(pg
  */
 #define generic_free_nodedata(pgdat)	kfree(pgdat)
 
+extern pg_data_t *node_data[];
+static inline void generic_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+	node_data[nid] = pgdat;
+}
+
 #else /* !CONFIG_NUMA */
 
 /* never called */
@@ -125,6 +134,9 @@ static inline pg_data_t *generic_alloc_n
 static inline void generic_free_nodedata(pg_data_t *pgdat)
 {
 }
+static inline void generic_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+}
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
Index: pgdat11/arch/ia64/Kconfig
===================================================================
--- pgdat11.orig/arch/ia64/Kconfig	2006-04-20 11:00:04.000000000 +0900
+++ pgdat11/arch/ia64/Kconfig	2006-04-20 11:00:28.000000000 +0900
@@ -374,6 +374,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config HAVE_ARCH_NODEDATA_EXTENSION
+	def_bool y
+	depends on NUMA
+
 config IA32_SUPPORT
 	bool "Support for Linux/x86 binaries"
 	help

-- 
Yasunori Goto 


