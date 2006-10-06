Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWJFWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWJFWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422721AbWJFWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:53:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11219 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422720AbWJFWxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:53:53 -0400
Subject: [Patch] x86_64 hot-add memroy srat.c fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: andrew <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Konrad redhat <konradr@redhat.com>,
       dzickus@redhat.com, lhms-devel <lhms-devel@lists.sourceforge.net>,
       Andi Kleen <ak@suse.de>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Fri, 06 Oct 2006 15:53:49 -0700
Message-Id: <1160175229.5663.23.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch corrects the logic used in srat.c to figure out what
parsing what action to take when registering hot-add areas.  Hot-add
areas should only be added to the node information for the
MEMORY_HOTPLGU_RESERVE case.  When booting MEMORY_HOTPLUG_SPARSE hot-add
areas on everything but the last node are getting include in the node
data and during kernel boot the pages are setup then the kernel dies
when the pages are used. This patch fixes this issue.  It is based
against 2.6.19-rc1.  

Signed-off-by: Keith Mannthey <kmannth@us.ibm.com> 
---
srat.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.6.18/arch/x86_64/mm/srat.c linux-2.6.18-rc1/arch/x86_64/mm/srat.c
--- linux-2.6.18/arch/x86_64/mm/srat.c	2006-10-06 17:17:04.000000000 -0400
+++ linux-2.6.18-rc1/arch/x86_64/mm/srat.c	2006-10-06 16:29:59.000000000 -0400
@@ -207,7 +207,7 @@
 	return hotadd_percent > 0;
 }
 #else
-int update_end_of_memory(unsigned long end) {return 0;}
+int update_end_of_memory(unsigned long end) {return -1;}
 static int hotadd_enough_memory(struct bootnode *nd) {return 1;}
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static inline int save_add_info(void) {return 1;}
@@ -337,7 +337,7 @@
 	push_node_boundaries(node, nd->start >> PAGE_SHIFT,
 						nd->end >> PAGE_SHIFT);
 
- 	if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 0) {
+ 	if (ma->flags.hot_pluggable && (reserve_hotadd(node, start, end) < 0)) {
 		/* Ignore hotadd region. Undo damage */
 		printk(KERN_NOTICE "SRAT: Hotplug region ignored\n");
 		*nd = oldnode;


