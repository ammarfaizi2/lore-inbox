Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWDXPGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWDXPGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDXPGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:06:03 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:40527 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750872AbWDXPFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:05:42 -0400
Date: Mon, 24 Apr 2006 17:05:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com
Subject: [patch 11/13] s390: instruction processing damage handling.
Message-ID: <20060424150544.GL15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch 11/13] s390: instruction processing damage handling.

In case of an instruction processing damage (IPD) machine check in
kernel mode the resulting action is always to stop the kernel.
This is not necessarily the best solution since a retry of the
failing instruction might succeed. Add logic to retry the instruction
if no more than 30 instruction processing damage checks occured in
the last 5 minutes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/s390mach.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390mach.c	2006-04-24 16:47:28.000000000 +0200
@@ -362,12 +362,19 @@ s390_revalidate_registers(struct mci *mc
 	return kill_task;
 }
 
+#define MAX_IPD_COUNT	29
+#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
+
 /*
  * machine check handler.
  */
 void
 s390_do_machine_check(struct pt_regs *regs)
 {
+	static DEFINE_SPINLOCK(ipd_lock);
+	static unsigned long long last_ipd;
+	static int ipd_count;
+	unsigned long long tmp;
 	struct mci *mci;
 	struct mcck_struct *mcck;
 	int umode;
@@ -404,11 +411,27 @@ s390_do_machine_check(struct pt_regs *re
 				s390_handle_damage("processing backup machine "
 						   "check with damage.");
 			}
-			if (!umode)
-				s390_handle_damage("processing backup machine "
-						   "check in kernel mode.");
-			mcck->kill_task = 1;
-			mcck->mcck_code = *(unsigned long long *) mci;
+
+			/*
+			 * Nullifying exigent condition, therefore we might
+			 * retry this instruction.
+			 */
+
+			spin_lock(&ipd_lock);
+
+			tmp = get_clock();
+
+			if (((tmp - last_ipd) >> 12) < MAX_IPD_TIME)
+				ipd_count++;
+			else
+				ipd_count = 1;
+
+			last_ipd = tmp;
+
+			if (ipd_count == MAX_IPD_COUNT)
+				s390_handle_damage("too many ipd retries.");
+
+			spin_unlock(&ipd_lock);
 		}
 		else {
 			/* Processing damage -> stopping machine */
