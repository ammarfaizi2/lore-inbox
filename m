Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993134AbWJUQv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993134AbWJUQv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993138AbWJUQv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:26 -0400
Received: from ns.suse.de ([195.135.220.2]:39580 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993134AbWJUQvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:25 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: keith mannthey <kmannth@us.ibm.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [3/19] x86_64: x86_64 hot-add memory srat.c fix
Message-Id: <20061021165122.C8F9213C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: keith mannthey <kmannth@us.ibm.com>

  This patch corrects the logic used in srat.c to figure out what
parsing what action to take when registering hot-add areas.  Hot-add
areas should only be added to the node information for the
MEMORY_HOTPLUG_RESERVE case.  When booting MEMORY_HOTPLUG_SPARSE hot-add
areas on everything but the last node are getting include in the node
data and during kernel boot the pages are setup then the kernel dies
when the pages are used. This patch fixes this issue.  

Signed-off-by: Keith Mannthey <kmannth@us.ibm.com> 
Signed-off-by: Andi Kleen <ak@suse.de>

---
srat.c |    4 ++--
 arch/x86_64/mm/srat.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- linux.orig/arch/x86_64/mm/srat.c
+++ linux/arch/x86_64/mm/srat.c
@@ -207,7 +207,7 @@ static inline int save_add_info(void)
 	return hotadd_percent > 0;
 }
 #else
-int update_end_of_memory(unsigned long end) {return 0;}
+int update_end_of_memory(unsigned long end) {return -1;}
 static int hotadd_enough_memory(struct bootnode *nd) {return 1;}
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static inline int save_add_info(void) {return 1;}
@@ -337,7 +337,7 @@ acpi_numa_memory_affinity_init(struct ac
 	push_node_boundaries(node, nd->start >> PAGE_SHIFT,
 						nd->end >> PAGE_SHIFT);
 
- 	if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 0) {
+ 	if (ma->flags.hot_pluggable && (reserve_hotadd(node, start, end) < 0)) {
 		/* Ignore hotadd region. Undo damage */
 		printk(KERN_NOTICE "SRAT: Hotplug region ignored\n");
 		*nd = oldnode;
