Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWCYQ0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWCYQ0A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWCYQ0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:26:00 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:7306 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750823AbWCYQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:25:59 -0500
Subject: [patch 2 of 4] Introduce e820_all_mapped
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <1143303796.2898.6.camel@laptopd505.fenrus.org>
References: <1143303796.2898.6.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Mar 2006 17:24:04 +0100
Message-Id: <1143303845.2898.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a e820_all_mapped() function which checks if the entire
range <start,end> is mapped with type. This is done by moving the local
start variable to the end of each known-good region; if at the end
of the function the start address is still before end, there must be
a part that's not of the correct type; otherwise it's a good region.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/kernel/e820.c |   32 ++++++++++++++++++++++++++++++++
 include/asm-x86_64/e820.h |    1 +
 2 files changed, 33 insertions(+)

Index: linux-2.6.16-mmconfig/arch/x86_64/kernel/e820.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/x86_64/kernel/e820.c
+++ linux-2.6.16-mmconfig/arch/x86_64/kernel/e820.c
@@ -80,6 +80,9 @@ static inline int bad_addr(unsigned long
 	return 0;
 } 
 
+/*
+ * This function checks if any part of the range <start,end> is mapped with type.
+ */
 int __init e820_any_mapped(unsigned long start, unsigned long end, unsigned type)
 { 
 	int i;
@@ -94,6 +97,35 @@ int __init e820_any_mapped(unsigned long
 	return 0;
 }
 
+/*
+ * This function checks if the entire range <start,end> is mapped with type.
+ *
+ * Note: this function only works correct if the e820 table is sorted and
+ * not-overlapping, which is the case
+ */
+int __init e820_all_mapped(unsigned long start, unsigned long end, unsigned type)
+{
+	int i;
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		if (type && ei->type != type)
+			continue;
+		/* is the region (part) in overlap with the current region ?*/
+		if (ei->addr >= end || ei->addr + ei->size <= start)
+			continue;
+
+		/* if the region is at the beginning of <start,end> we move
+		 * start to the end of the region since it's ok until there
+		 */
+		if (ei->addr <= start)
+			start = ei->addr + ei->size;
+		/* if start is now at or beyond end, we're done, full coverage */
+		if (start >= end)
+			return 1; /* we're done */
+	}
+	return 0;
+}
+
 /* 
  * Find a free area in a specific range. 
  */ 
Index: linux-2.6.16-mmconfig/include/asm-x86_64/e820.h
===================================================================
--- linux-2.6.16-mmconfig.orig/include/asm-x86_64/e820.h
+++ linux-2.6.16-mmconfig/include/asm-x86_64/e820.h
@@ -48,6 +48,7 @@ extern unsigned long e820_end_of_ram(voi
 extern void e820_reserve_resources(void);
 extern void e820_print_map(char *who);
 extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
+extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
 
 extern void e820_bootmem_free(pg_data_t *pgdat, unsigned long start,unsigned long end);
 extern void e820_setup_gap(void);

