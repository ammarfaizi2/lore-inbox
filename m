Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVIOOxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVIOOxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVIOOxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:53:05 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:51906 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030453AbVIOOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:53:04 -0400
Date: Thu, 15 Sep 2005 16:53:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch] s390: kernel stack corruption.
Message-ID: <20050915145303.GA5959@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Peter discoverd another rather critical bug in entry.S.
This should go into 2.6.14 if possible.

blue skies,
  Martin.

---

[patch] s390: kernel stack corruption.

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

When an asynchronous interruption occurs during the execution
of the 'critical section' within the generic interruption
handling code (entry.S), a faulty check for a userspace PSW may
result in a corrupted kernel stack pointer which subsequently
triggers a stack overflow check.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S   |    2 +-
 arch/s390/kernel/entry64.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-09-15 15:31:03.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-09-15 15:31:26.000000000 +0200
@@ -101,7 +101,7 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 	clc	\psworg+8(8),BASED(.Lcritical_start)
 	jl	0f
 	brasl	%r14,cleanup_critical
-	tm	0(%r12),0x01		# retest problem state after cleanup
+	tm	1(%r12),0x01		# retest problem state after cleanup
 	jnz	1f
 0:	lg	%r14,__LC_ASYNC_STACK	# are we already on the async. stack ?
 	slgr	%r14,%r15
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2005-09-15 15:31:03.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2005-09-15 15:31:26.000000000 +0200
@@ -108,7 +108,7 @@ STACK_SIZE  = 1 << STACK_SHIFT
 	bl	BASED(0f)
 	l	%r14,BASED(.Lcleanup_critical)
 	basr	%r14,%r14
-	tm	0(%r12),0x01		# retest problem state after cleanup
+	tm	1(%r12),0x01		# retest problem state after cleanup
 	bnz	BASED(1f)
 0:	l	%r14,__LC_ASYNC_STACK	# are we already on the async stack ?
 	slr	%r14,%r15
