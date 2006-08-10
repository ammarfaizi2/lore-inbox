Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWHJToZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWHJToZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWHJTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:43:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15852 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932661AbWHJTha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:30 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [129/145] x86_64: Auto size the per cpu area.
Message-Id: <20060810193728.DE4BC13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:28 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: ebiederm@xmission.com (Eric W. Biederman)

Now for a completely different but trivial approach.
I just boot tested it with 255 CPUS and everything worked.

Currently everything (except module data) we place in
the per cpu area we know about at compile time.  So
instead of allocating a fixed size for the per_cpu area
allocate the number of bytes we need plus a fixed constant
for to be used for modules.

It isn't perfect but it is much less of a pain to
work with than what we are doing now.

AK: fixed warning

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/setup64.c |    7 ++-----
 include/asm-x86_64/percpu.h  |   10 ++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

Index: linux/arch/x86_64/kernel/setup64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup64.c
+++ linux/arch/x86_64/kernel/setup64.c
@@ -95,12 +95,9 @@ void __init setup_per_cpu_areas(void)
 #endif
 
 	/* Copy section for each CPU (we discard the original) */
-	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
+	size = PERCPU_ENOUGH_ROOM;
 
+	printk(KERN_INFO "PERCPU: Allocating %lu bytes of per cpu data\n", size);
 	for_each_cpu_mask (i, cpu_possible_map) {
 		char *ptr;
 
Index: linux/include/asm-x86_64/percpu.h
===================================================================
--- linux.orig/include/asm-x86_64/percpu.h
+++ linux/include/asm-x86_64/percpu.h
@@ -11,6 +11,16 @@
 
 #include <asm/pda.h>
 
+#ifdef CONFIG_MODULES
+# define PERCPU_MODULE_RESERVE 8192
+#else
+# define PERCPU_MODULE_RESERVE 0
+#endif
+
+#define PERCPU_ENOUGH_ROOM \
+	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
+	 PERCPU_MODULE_RESERVE)
+
 #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
 #define __my_cpu_offset() read_pda(data_offset)
 
