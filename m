Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVAPMAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVAPMAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVAPMAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:00:22 -0500
Received: from verein.lst.de ([213.95.11.210]:50141 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262487AbVAPL7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:59:04 -0500
Date: Sun, 16 Jan 2005 12:58:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kill softirq_pending()
Message-ID: <20050116115857.GC13716@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no more users left, time to kill the various implementations


--- 1.19/include/asm-ia64/hardirq.h	2004-11-16 20:10:08 +01:00
+++ edited/include/asm-ia64/hardirq.h	2005-01-07 13:21:28 +01:00
@@ -19,7 +19,6 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define softirq_pending(cpu)		(cpu_data(cpu)->softirq_pending)
 #define local_softirq_pending()		(local_cpu_data->softirq_pending)
 
 #define HARDIRQ_BITS	14
===== include/asm-s390/hardirq.h 1.17 vs edited =====
--- 1.17/include/asm-s390/hardirq.h	2005-01-05 03:48:11 +01:00
+++ edited/include/asm-s390/hardirq.h	2005-01-07 13:21:28 +01:00
@@ -27,15 +27,6 @@
 
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
 
-/* this is always called with cpu == smp_processor_id() at the moment */
-static inline __u32
-softirq_pending(unsigned int cpu)
-{
-	if (cpu == smp_processor_id())
-		return local_softirq_pending();
-	return lowcore_ptr[cpu]->softirq_pending;
-}
-
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
 
===== include/linux/irq_cpustat.h 1.11 vs edited =====
--- 1.11/include/linux/irq_cpustat.h	2004-02-04 06:29:31 +01:00
+++ edited/include/linux/irq_cpustat.h	2005-01-07 13:21:28 +01:00
@@ -23,8 +23,8 @@
 #endif
 
   /* arch independent irq_stat fields */
-#define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
-#define local_softirq_pending()	softirq_pending(smp_processor_id())
+#define local_softirq_pending() \
+	__IRQ_STAT(smp_processor_id(), __softirq_pending)
 
   /* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
