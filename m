Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbULPWpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbULPWpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbULPWok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:44:40 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:14516 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262057AbULPWmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:42:32 -0500
Subject: [PATCH] collect page_states only from online cpus
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-ia64@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Thu, 16 Dec 2004 15:42:23 -0700
Message-Id: <1103236943.8653.26.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I noticed the function __read_page_state() curiously high in a
q-tools profile of a write to a software raid0 device.  Seems this is
because we're checking page_states for all possible cpus and we have
NR_CPUS possible when CONFIG_HOTPLUG_CPU=y.  The default config for ia64
is now NR_CPUS=512, so on a little 8-way box, this is a significant
waste of time.  The patch below updates __read_page_state() and
__get_page_state() to only count page_state info for online cpus.  To
keep the stats consistent, the page_alloc notifier is updated to move
page_states off of the cpu going offline.  On my profile, this dropped
__read_page_state() back into the noise and boosted block write
performance by 5% (as measured by spew - http://spew.berlios.de).
Thanks,

	Alex

-- 
Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== mm/page_alloc.c 1.241 vs edited =====
--- 1.241/mm/page_alloc.c	2004-11-15 20:29:07 -07:00
+++ edited/mm/page_alloc.c	2004-12-16 14:10:59 -07:00
@@ -914,18 +914,18 @@
 	int cpu = 0;
 
 	memset(ret, 0, sizeof(*ret));
+
+	cpu = first_cpu(cpu_online_map);
 	while (cpu < NR_CPUS) {
 		unsigned long *in, *out, off;
 
-		if (!cpu_possible(cpu)) {
-			cpu++;
-			continue;
-		}
-
 		in = (unsigned long *)&per_cpu(page_states, cpu);
-		cpu++;
-		if (cpu < NR_CPUS && cpu_possible(cpu))
+		
+		cpu = next_cpu(cpu, cpu_online_map);
+
+		if (cpu < NR_CPUS)
 			prefetch(&per_cpu(page_states, cpu));
+
 		out = (unsigned long *)ret;
 		for (off = 0; off < nr; off++)
 			*out++ += *in++;
@@ -952,12 +952,9 @@
 	unsigned long ret = 0;
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_online_cpu(cpu) {
 		unsigned long in;
 
-		if (!cpu_possible(cpu))
-			continue;
-
 		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
 		ret += *((unsigned long *)in);
 	}
@@ -1795,8 +1792,9 @@
 static int page_alloc_cpu_notify(struct notifier_block *self,
 				 unsigned long action, void *hcpu)
 {
-	int cpu = (unsigned long)hcpu;
+	int i, cpu = (unsigned long)hcpu;
 	long *count;
+	unsigned long *src, *dest;
 
 	if (action == CPU_DEAD) {
 		/* Drain local pagecache count. */
@@ -1805,6 +1803,18 @@
 		*count = 0;
 		local_irq_disable();
 		__drain_pages(cpu);
+
+		/* Add dead cpu's page_states to our own. */
+		dest = (unsigned long *)&__get_cpu_var(page_states);
+		src = (unsigned long *)&per_cpu(page_states, cpu);
+
+		i = sizeof(struct page_state) / sizeof(unsigned long);
+		do {
+			i--;
+			dest[i] += src[i];
+			src[i] = 0;
+		} while (i > 0);
+
 		local_irq_enable();
 	}
 	return NOTIFY_OK;


