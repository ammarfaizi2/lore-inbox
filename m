Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFASgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFASgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFASGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:06:02 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33534 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261520AbVFASDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:03:24 -0400
Date: Wed, 1 Jun 2005 20:03:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/11] s390: in_interrupt vs. in_atomic.
Message-ID: <20050601180323.GF6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/11] s390: in_interrupt vs. in_atomic.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The condition for no context in do_exception checks for hard and
soft interrupts by using in_interrupt() but not for preemption.
This is bad for the users of __copy_from/to_user_inatomic because
the fault handler might call schedule although the preemption
count is != 0. Use in_atomic() instead in_interrupt().

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/fault.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2005-06-01 19:42:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/fault.c	2005-06-01 19:43:18.000000000 +0200
@@ -207,7 +207,7 @@ do_exception(struct pt_regs *regs, unsig
 	 * we are not in an interrupt and that there is a 
 	 * user context.
 	 */
-        if (user_address == 0 || in_interrupt() || !mm)
+        if (user_address == 0 || in_atomic() || !mm)
                 goto no_context;
 
 	/*
