Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUH3FHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUH3FHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 01:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUH3FGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 01:06:47 -0400
Received: from ozlabs.org ([203.10.76.45]:50098 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266888AbUH3FF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 01:05:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16690.46610.830797.583601@cargo.ozlabs.ibm.com>
Date: Mon, 30 Aug 2004 15:07:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: nathanl@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (3/3) Allocate irqstacks only for possible cpus
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With earlier setup of cpu_possible_map the number of irqstacks shrinks
from NR_CPUS to the number of possible cpus.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN akpm-29aug/arch/ppc64/kernel/irq.c akpm/arch/ppc64/kernel/irq.c
--- akpm-29aug/arch/ppc64/kernel/irq.c	2004-08-30 10:55:36.000000000 +1000
+++ akpm/arch/ppc64/kernel/irq.c	2004-08-30 15:02:33.104245224 +1000
@@ -929,7 +929,7 @@
 	struct thread_info *tp;
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
diff -urN akpm-29aug/arch/ppc64/kernel/setup.c akpm/arch/ppc64/kernel/setup.c
--- akpm-29aug/arch/ppc64/kernel/setup.c	2004-08-30 15:02:42.393296512 +1000
+++ akpm/arch/ppc64/kernel/setup.c	2004-08-30 15:02:33.069250544 +1000
@@ -701,7 +701,7 @@
 	int i;
 
 	/* interrupt stacks must be under 256MB, we cannot afford to take SLB misses on them */
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		softirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
 					THREAD_SIZE, 0x10000000));
 		hardirq_ctx[i] = (struct thread_info *)__va(lmb_alloc_base(THREAD_SIZE,
