Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUILLiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUILLiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUILLdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:33:15 -0400
Received: from verein.lst.de ([213.95.11.210]:51114 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268681AbUILL3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:29:02 -0400
Date: Sun, 12 Sep 2004 13:28:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] <asm/softirq.h> crept back in h8300 and sh64
Message-ID: <20040912112851.GA32624@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<asm/softirq.h> went away in 2.5, but new ports keep adding instances
again and again.


--- 1.1/include/asm-h8300/softirq.h	2003-02-17 01:01:58 +01:00
+++ edited/include/asm-h8300/softirq.h	2004-09-12 13:28:27 +02:00
@@ -1,20 +0,0 @@
-#ifndef __ASM_SOFTIRQ_H
-#define __ASM_SOFTIRQ_H
-
-#include <linux/preempt.h>
-#include <asm/hardirq.h>
-
-#define local_bh_disable() \
-		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
-#define __local_bh_enable() \
-		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
-
-#define local_bh_enable()						\
-do {									\
-	__local_bh_enable();						\
-	if (unlikely(!in_interrupt() && softirq_pending(smp_processor_id()))) \
-		do_softirq();						\
-	preempt_check_resched();					\
-} while (0)
-
-#endif	/* __ASM_SOFTIRQ_H */
--- 1.1/include/asm-sh64/softirq.h	2004-06-29 16:44:46 +02:00
+++ edited/include/asm-sh64/softirq.h	2004-09-12 13:28:36 +02:00
@@ -1,30 +0,0 @@
-#ifndef __ASM_SH_SOFTIRQ_H
-#define __ASM_SH_SOFTIRQ_H
-
-#include <asm/atomic.h>
-#include <asm/hardirq.h>
-
-#define local_bh_disable()			\
-do {						\
-	local_bh_count(smp_processor_id())++;	\
-	barrier();				\
-} while (0)
-
-#define __local_bh_enable()			\
-do {						\
-	barrier();				\
-	local_bh_count(smp_processor_id())--;	\
-} while (0)
-
-#define local_bh_enable()				\
-do {							\
-	barrier();					\
-	if (!--local_bh_count(smp_processor_id())	\
-	    && softirq_pending(smp_processor_id())) {	\
-		do_softirq();				\
-	}						\
-} while (0)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
-
-#endif /* __ASM_SH_SOFTIRQ_H */
