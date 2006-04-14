Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWDNVTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWDNVTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWDNVTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:19:14 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18594 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965169AbWDNVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:19:11 -0400
Subject: [PATCH 01/05] percpu main.c setup
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 17:19:03 -0400
Message-Id: <1145049543.1336.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the __per_cpu_offset array into the per_cpu_offset__##var variables.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/init/main.c
===================================================================
--- linux-2.6.17-rc1.orig/init/main.c	2006-04-13 22:37:57.000000000 -0400
+++ linux-2.6.17-rc1/init/main.c	2006-04-14 11:46:51.000000000 -0400
@@ -324,9 +324,11 @@ static inline void smp_prepare_cpus(unsi
 
 #ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
-
 EXPORT_SYMBOL(__per_cpu_offset);
 
+extern unsigned long *__per_cpu_offset_start,
+		*__per_cpu_offset_end;
+
 static void __init setup_per_cpu_areas(void)
 {
 	unsigned long size, i;
@@ -335,12 +337,18 @@ static void __init setup_per_cpu_areas(v
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
 	ptr = alloc_bootmem(size * nr_possible_cpus);
 
+#ifdef CONFIG_MODULES
+	{
+		unsigned long **offsets = &__per_cpu_offset_start;
+		printk("setting up percpu from %p to %p with %p\n",
+		       &__per_cpu_offset_start, &__per_cpu_offset_end,
+		       &__per_cpu_offset[0]);
+		for ( ; offsets < &__per_cpu_offset_end; offsets++)
+			*offsets = &__per_cpu_offset[0];
+	}
+#endif
 	for_each_possible_cpu(i) {
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);


