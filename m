Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVF2L6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVF2L6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVF2L6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:58:54 -0400
Received: from mail.renesas.com ([202.234.163.13]:35580 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262561AbVF2L6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:58:48 -0400
Date: Wed, 29 Jun 2005 20:58:45 +0900 (JST)
Message-Id: <20050629.205845.945132624.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-mm2] m32r: build fix for spinlock_t update
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a build error of arch/m32r/kernel/smp.c in 2.6.12-mm2.
It is because that spinlock_t type was revised in the latest -mm tree.
(Re: [patch] spinlock consolidation, v2
 http://www.ussg.iu.edu/hypermail/linux/kernel/0506.0/1119.html)

Here is a patch to fix the build error.
Please apply.

	* arch/m32r/kernel/smp.c (send_IPI_mask_phys):
          - Update for the spinlock consolidation, v2.
          - Change asm portion to C code for good maintainability.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/smp.c |   48 ++++++++++++------------------------------------
 1 files changed, 12 insertions(+), 36 deletions(-)

Index: linux-2.6.12-mm2/arch/m32r/kernel/smp.c
===================================================================
--- linux-2.6.12-mm2.orig/arch/m32r/kernel/smp.c	2005-06-28 10:54:48.000000000 +0900
+++ linux-2.6.12-mm2/arch/m32r/kernel/smp.c	2005-06-28 12:06:33.000000000 +0900
@@ -892,7 +892,6 @@ unsigned long send_IPI_mask_phys(cpumask
 	int try)
 {
 	spinlock_t *ipilock;
-	unsigned long flags = 0;
 	volatile unsigned long *ipicr_addr;
 	unsigned long ipicr_val;
 	unsigned long my_physid_mask;
@@ -916,50 +915,27 @@ unsigned long send_IPI_mask_phys(cpumask
 	 * write IPICRi (send IPIi)
 	 * unlock ipi_lock[i]
 	 */
+	spin_lock(ipilock);
 	__asm__ __volatile__ (
-		";; LOCK ipi_lock[i]		\n\t"
+		";; CHECK IPICRi == 0		\n\t"
 		".fillinsn			\n"
 		"1:				\n\t"
-		"mvfc	%1, psw 		\n\t"
-		"clrpsw	#0x40 -> nop		\n\t"
-		DCACHE_CLEAR("r4", "r5", "%2")
-		"lock	r4, @%2			\n\t"
-		"addi	r4, #-1			\n\t"
-		"unlock	r4, @%2			\n\t"
-		"mvtc	%1, psw			\n\t"
-		"bnez	r4, 2f			\n\t"
-		LOCK_SECTION_START(".balign 4 \n\t")
-		".fillinsn			\n"
-		"2:				\n\t"
-		"ld	r4, @%2			\n\t"
-		"blez	r4, 2b			\n\t"
+		"ld	%0, @%1			\n\t"
+		"and	%0, %4			\n\t"
+		"beqz	%0, 2f			\n\t"
+		"bnez	%3, 3f			\n\t"
 		"bra	1b			\n\t"
-		LOCK_SECTION_END
-		";; CHECK IPICRi == 0		\n\t"
-		".fillinsn			\n"
-		"3:				\n\t"
-		"ld	%0, @%3			\n\t"
-		"and	%0, %6			\n\t"
-		"beqz	%0, 4f			\n\t"
-		"bnez	%5, 5f			\n\t"
-		"bra	3b			\n\t"
 		";; WRITE IPICRi (send IPIi)	\n\t"
 		".fillinsn			\n"
-		"4:				\n\t"
-		"st	%4, @%3			\n\t"
-		";; UNLOCK ipi_lock[i]		\n\t"
+		"2:				\n\t"
+		"st	%2, @%1			\n\t"
 		".fillinsn			\n"
-		"5:				\n\t"
-		"ldi	r4, #1			\n\t"
-		"st	r4, @%2			\n\t"
+		"3:				\n\t"
 		: "=&r"(ipicr_val)
-		: "r"(flags), "r"(&ipilock->slock), "r"(ipicr_addr),
-		  "r"(mask), "r"(try), "r"(my_physid_mask)
-		: "memory", "r4"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r5"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
+		: "r"(ipicr_addr), "r"(mask), "r"(try), "r"(my_physid_mask)
+		: "memory"
 	);
+	spin_unlock(ipilock);
 
 	return ipicr_val;
 }

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
