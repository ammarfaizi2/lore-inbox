Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWFNOXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWFNOXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFNOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:23:36 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:30808 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964976AbWFNOXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:23:35 -0400
Date: Wed, 14 Jun 2006 16:23:18 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 7/8] lock validator: s390 use raw_spinlock in mcck handler
Message-ID: <20060614142318.GH1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Machine checks on s390 are always enabled (except in the machine check handler
itself). Therefore use a raw_spinlock in the machine check handler to avoid
deadlocks in the lock validator.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/s390mach.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -purN a/drivers/s390/s390mach.c b/drivers/s390/s390mach.c
--- a/drivers/s390/s390mach.c	2006-06-14 13:44:52.000000000 +0200
+++ b/drivers/s390/s390mach.c	2006-06-14 13:45:01.000000000 +0200
@@ -372,7 +372,7 @@ s390_revalidate_registers(struct mci *mc
 void
 s390_do_machine_check(struct pt_regs *regs)
 {
-	static DEFINE_SPINLOCK(ipd_lock);
+	static raw_spinlock_t ipd_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
 	static unsigned long long last_ipd;
 	static int ipd_count;
 	unsigned long long tmp;
@@ -418,7 +418,7 @@ s390_do_machine_check(struct pt_regs *re
 			 * retry this instruction.
 			 */
 
-			spin_lock(&ipd_lock);
+			__raw_spin_lock(&ipd_lock);
 
 			tmp = get_clock();
 
@@ -432,7 +432,7 @@ s390_do_machine_check(struct pt_regs *re
 			if (ipd_count == MAX_IPD_COUNT)
 				s390_handle_damage("too many ipd retries.");
 
-			spin_unlock(&ipd_lock);
+			__raw_spin_unlock(&ipd_lock);
 		}
 		else {
 			/* Processing damage -> stopping machine */
