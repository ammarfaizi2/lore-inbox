Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267944AbTBRRmh>; Tue, 18 Feb 2003 12:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267945AbTBRRmh>; Tue, 18 Feb 2003 12:42:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:50158 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267944AbTBRRmg>;
	Tue, 18 Feb 2003 12:42:36 -0500
Message-ID: <3E5272A0.80803@us.ibm.com>
Date: Tue, 18 Feb 2003 09:51:28 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix kirq code for clustered mode
Content-Type: multipart/mixed;
 boundary="------------050604080001000905070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604080001000905070301
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The new kirq code breaks clustered apic mode.  This 2-liner fixes it.
It should compile down to the same thing, unless you're using a
clustered apic sub-arch.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------050604080001000905070301
Content-Type: text/plain;
 name="kirq-apicid-fix-2.5.62-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kirq-apicid-fix-2.5.62-2.patch"

diff -ru linux-2.5.62-clean/arch/i386/kernel/io_apic.c linux-2.5.62-kirqfix/arch/i386/kernel/io_apic.c
--- linux-2.5.62-clean/arch/i386/kernel/io_apic.c	Mon Feb 17 14:56:10 2003
+++ linux-2.5.62-kirqfix/arch/i386/kernel/io_apic.c	Tue Feb 18 09:44:22 2003
@@ -441,7 +441,7 @@
 		Dprintk("irq = %d moved to cpu = %d\n", selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock(&desc->lock);
-		irq_balance_mask[selected_irq] = target_cpu_mask;
+		irq_balance_mask[selected_irq] = cpu_to_logical_apicid(min_loaded);
 		spin_unlock(&desc->lock);
 		/* Since we made a change, come back sooner to 
 		 * check for more variation.
@@ -515,7 +515,7 @@
 	
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++)
-		irq_balance_mask[i] = 1 << 0;
+		irq_balance_mask[i] = cpu_to_logical_apicid(0);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
Only in linux-2.5.62-kirqfix/arch/i386/kernel: io_apic.c~

--------------050604080001000905070301--

