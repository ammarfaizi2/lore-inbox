Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVGKQmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVGKQmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGKQkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:40:24 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:55686 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262140AbVGKQh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:37:58 -0400
Date: Mon, 11 Jul 2005 18:37:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 11/12] s390: cpu timer reset in machine check handler.
Message-ID: <20050711163757.GK10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 11/12] s390: cpu timer reset in machine check handler.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix wrong move direction of timer values for cpu accounting
in case of a machine check that indicates a broken cpu timer.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/entry.S   |    6 +++---
 arch/s390/kernel/entry64.S |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2005-07-11 17:37:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-07-11 17:37:50.000000000 +0200
@@ -727,9 +727,9 @@ mcck_int_handler:
 	jo	0f
 	spt	__LC_LAST_UPDATE_TIMER
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_EXIT_TIMER
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
+	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
+	mvc	__LC_EXIT_TIMER(8),__LC_LAST_UPDATE_TIMER
 0:	tm	__LC_MCCK_CODE+2,0x08	# mwp of old psw valid?
 	jno	mcck_no_vtime		# no -> no timer update
 	tm      __LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2005-07-11 17:37:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2005-07-11 17:37:50.000000000 +0200
@@ -690,9 +690,9 @@ mcck_int_handler:
 	bo	BASED(0f)
 	spt	__LC_LAST_UPDATE_TIMER	# revalidate cpu timer
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_ASYNC_ENTER_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_EXIT_TIMER
+	mvc	__LC_ASYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
+	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_LAST_UPDATE_TIMER
+	mvc	__LC_EXIT_TIMER(8),__LC_LAST_UPDATE_TIMER
 0:	tm	__LC_MCCK_CODE+2,0x08   # mwp of old psw valid?
 	bno	BASED(mcck_no_vtime)	# no -> skip cleanup critical
 	tm	__LC_MCK_OLD_PSW+1,0x01 # interrupting from user ?
