Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVCXNb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVCXNb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVCXNb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:31:26 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:30647 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262453AbVCXNbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:31:24 -0500
Date: Thu, 24 Mar 2005 14:31:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/9] s390: kernel faults.
Message-ID: <20050324133138.GA5002@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/9] s390: kernel faults.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Correct check for user space faults. If the failing address space is in
the secondary address space and uaccess has been switched to KERNEL_DS
with set_fs, check_user_space() erroneously returns 1.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/fault.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/fault.c	2005-03-24 14:02:59.000000000 +0100
@@ -87,6 +87,7 @@ static int __check_access_register(struc
 	if (areg == 0)
 		/* Access via access register 0 -> kernel address */
 		return 0;
+	save_access_regs(current->thread.acrs);
 	if (regs && areg < NUM_ACRS && current->thread.acrs[areg] <= 1)
 		/*
 		 * access register contains 0 -> kernel address,
@@ -115,11 +116,11 @@ static inline int check_user_space(struc
 	 *   3: Home Segment Table Descriptor
 	 */
 	int descriptor = S390_lowcore.trans_exc_code & 3;
-	if (descriptor == 1) {
-		save_access_regs(current->thread.acrs);
+	if (unlikely(descriptor == 1))
 		return __check_access_register(regs, error_code);
-	}
-	return descriptor >> 1;
+	if (descriptor == 2)
+		return current->thread.mm_segment.ar4;
+	return descriptor != 0;
 }
 
 /*
