Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWFNOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWFNOBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWFNOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:01:08 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:36267 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964942AbWFNOBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:01:05 -0400
Date: Wed, 14 Jun 2006 16:01:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 9/24] s390: console_unblank woes.
Message-ID: <20060614140105.GJ9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] console_unblank woes.

The software watchdog calls machine_restart from a timer function.
The s390 machine_restart calls console_unblank to flush the console
output. This is needed for panic to get the panic message printed.
If console_unblank is called in interrupt a BUG is triggered in
acquire_console_sem. That makes the software watchdog panic instead
of restarting the machine. To get around this problem the call to
console_unblank is made conditionally on !in_interrupt() ||
oops_in_progress.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-06-14 14:29:10.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-06-14 14:29:42.000000000 +0200
@@ -297,19 +297,34 @@ void (*_machine_power_off)(void) = do_ma
 
 void machine_restart(char *command)
 {
-	console_unblank();
+	if (!in_interrupt() || oops_in_progress)
+		/*
+		 * Only unblank the console if we are called in enabled
+		 * context or a bust_spinlocks cleared the way for us.
+		 */
+		console_unblank();
 	_machine_restart(command);
 }
 
 void machine_halt(void)
 {
-	console_unblank();
+	if (!in_interrupt() || oops_in_progress)
+		/*
+		 * Only unblank the console if we are called in enabled
+		 * context or a bust_spinlocks cleared the way for us.
+		 */
+		console_unblank();
 	_machine_halt();
 }
 
 void machine_power_off(void)
 {
-	console_unblank();
+	if (!in_interrupt() || oops_in_progress)
+		/*
+		 * Only unblank the console if we are called in enabled
+		 * context or a bust_spinlocks cleared the way for us.
+		 */
+		console_unblank();
 	_machine_power_off();
 }
 
