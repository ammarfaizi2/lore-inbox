Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUK1OFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUK1OFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUK1OFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:05:16 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:61149 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261470AbUK1OFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:05:07 -0500
Message-ID: <41A9E98C.2C1D07EF@tv-sign.ru>
Date: Sun, 28 Nov 2004 18:06:52 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

rcu_check_quiescent_state:
	/*
	 * Races with local timer interrupt - in the worst case
	 * we may miss one quiescent state of that CPU. That is
	 * tolerable. So no need to disable interrupts.
	 */
	if (rdp->qsctr == rdp->last_qsctr)
		return;

Afaics, this comment is misleading. rcu_check_quiescent_state()
is executed in softirq context, while rcu_check_callbacks() checks
in_softirq() before ++qsctr.

Also, replace (1 << HARDIRQ_SHIFT) by HARDIRQ_OFFSET.

On top of the 'rcu: eliminate rcu_ctrlblk.lock', see
http://marc.theaimsgroup.com/?l=linux-kernel&m=110156786721526

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc2/kernel/rcupdate.c~	2004-11-27 21:40:02.000000000 +0300
+++ 2.6.10-rc2/kernel/rcupdate.c	2004-11-28 17:29:19.084446040 +0300
@@ -229,11 +229,6 @@ static void rcu_check_quiescent_state(st
 	if (!rdp->qs_pending)
 		return;
 
-	/* 
-	 * Races with local timer interrupt - in the worst case
-	 * we may miss one quiescent state of that CPU. That is
-	 * tolerable. So no need to disable interrupts.
-	 */
 	if (rdp->qsctr == rdp->last_qsctr)
 		return;
 	rdp->qs_pending = 0;
@@ -358,7 +353,7 @@ void rcu_check_callbacks(int cpu, int us
 {
 	if (user || 
 	    (idle_cpu(cpu) && !in_softirq() && 
-				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
+				hardirq_count() <= HARDIRQ_OFFSET)) {
 		rcu_qsctr_inc(cpu);
 		rcu_bh_qsctr_inc(cpu);
 	} else if (!in_softirq())
