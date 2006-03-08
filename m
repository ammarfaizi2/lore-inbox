Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752098AbWCHNmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbWCHNmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCHNlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:41:51 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43930 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751834AbWCHNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:41:47 -0500
Date: Wed, 08 Mar 2006 22:41:44 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 005/017](RFC) Memory hotplug for new nodes v.3. (generic refresh NODE_DATA())
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212759.002C.Y-GOTO@jp.fujitsu.com>
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

Index: pgdat6/include/linux/memory_hotplug.h
===================================================================
--- pgdat6.orig/include/linux/memory_hotplug.h	2006-03-06 19:42:21.000000000 +0900
+++ pgdat6/include/linux/memory_hotplug.h	2006-03-06 19:42:30.000000000 +0900
@@ -87,10 +87,13 @@ static inline int arch_nid_probe(u64 sta
  */
 extern struct pglist_data * arch_alloc_nodedata(int nid);
 extern void arch_free_nodedata(pg_data_t *pgdat);
+extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
 
 #else /* !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 #define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
 #define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
+#define arch_refresh_nodedata(nid, pgdat)	\
+				generic_refresh_nodedata(nid, pgdat)
 
 #ifdef CONFIG_NUMA
 /*
@@ -109,6 +112,11 @@ static inline void generic_free_nodedata
 	kfree(pgdat);
 }
 
+static inline void generic_refresh_nodedata(int nid, struct pglist_data *pgdat)
+{
+	NODE_DATA(nid) = pgdat;
+}
+
 #else /* !CONFIG_NUMA */
 /* never called */
 static inline struct pglist_data *generic_alloc_nodedata(int nid)
@@ -119,6 +127,9 @@ static inline struct pglist_data *generi
 static inline void generic_free_nodedata(struct pglist_data *pgdat)
 {
 }
+static inline void generic_refresh_nodedata(int nid, struct pglist_data *pgdat)
+{
+}
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 

-- 
Yasunori Goto 


