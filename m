Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUK1QrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUK1QrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUK1Qp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:45:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:4064 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261520AbUK1Qh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:37:58 -0500
Message-ID: <41AA0D5F.21CB9ED3@tv-sign.ru>
Date: Sun, 28 Nov 2004 20:39:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rcu: eliminate rcu_data.last_qsctr
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

last_qsctr is used in rcu_check_quiescent_state() exclusively.
We can reset qsctr at the start of the grace period, and then
just test qsctr against 0.

On top of the 'rcu: eliminate rcu_ctrlblk.lock', see
http://marc.theaimsgroup.com/?l=linux-kernel&m=110156786721526

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc2/include/linux/rcupdate.h~	2004-11-27 21:32:49.000000000 +0300
+++ 2.6.10-rc2/include/linux/rcupdate.h	2004-11-28 23:15:20.510856936 +0300
@@ -88,8 +88,6 @@ struct rcu_data {
 	/* 1) quiescent state handling : */
 	long		quiescbatch;     /* Batch # for grace period */
 	long		qsctr;		 /* User-mode/idle loop etc. */
-	long            last_qsctr;	 /* value of qsctr at beginning */
-					 /* of rcu grace period */
 	int		qs_pending;	 /* core waits for quiesc state */
 
 	/* 2) batch handling */
--- 2.6.10-rc2/kernel/rcupdate.c~	2004-11-28 23:13:03.324712400 +0300
+++ 2.6.10-rc2/kernel/rcupdate.c	2004-11-28 23:15:20.511856784 +0300
@@ -215,9 +215,9 @@ static void rcu_check_quiescent_state(st
 			struct rcu_state *rsp, struct rcu_data *rdp)
 {
 	if (rdp->quiescbatch != rcp->cur) {
-		/* new grace period: record qsctr value. */
+		/* new grace period: reset qsctr value. */
 		rdp->qs_pending = 1;
-		rdp->last_qsctr = rdp->qsctr;
+		rdp->qsctr = 0;
 		rdp->quiescbatch = rcp->cur;
 		return;
 	}
@@ -229,12 +229,7 @@ static void rcu_check_quiescent_state(st
 	if (!rdp->qs_pending)
 		return;
 
-	/* 
-	 * Races with local timer interrupt - in the worst case
-	 * we may miss one quiescent state of that CPU. That is
-	 * tolerable. So no need to disable interrupts.
-	 */
-	if (rdp->qsctr == rdp->last_qsctr)
+	if (rdp->qsctr == 0)
 		return;
 	rdp->qs_pending = 0;
