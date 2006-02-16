Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWBPHSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWBPHSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWBPHSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:18:21 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40604 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932487AbWBPHSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:18:20 -0500
Date: Thu, 16 Feb 2006 08:18:08 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nathan Lynch <nathanl@austin.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/4] s390: fix preempt_count of idle thread with cpu hotplug
Message-ID: <20060216071808.GE9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Set preempt_count of idle_thread to zero before switching off cpu.
Otherwise the preempt_count will be wrong if the cpu is switched on again
since the thread will be reused.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Looks to me like at least powerpc seems to have the same problem.

 arch/s390/kernel/process.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2006-02-16 07:29:46.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/process.c	2006-02-16 07:30:06.000000000 +0100
@@ -128,8 +128,10 @@ void default_idle(void)
 	__ctl_set_bit(8, 15);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	if (cpu_is_offline(cpu))
+	if (cpu_is_offline(cpu)) {
+		preempt_enable_no_resched();
 		cpu_die();
+	}
 #endif
 
 	local_mcck_disable();
