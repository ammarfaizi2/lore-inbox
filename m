Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUJTHgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUJTHgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270064AbUJTHcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:32:52 -0400
Received: from ozlabs.org ([203.10.76.45]:3505 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269883AbUJTHFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:05:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
Date: Wed, 20 Oct 2004 17:08:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: [PATCH] Fix PREEMPT_ACTIVE definition
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the generic IRQ stuff went in, it seems that HARDIRQ_BITS got
bumped from 9 (for ppc64) up to 12.  Consequently, the PREEMPT_ACTIVE
bit is now within HARDIRQ_MASK, and I get in_interrupt() falsely
returning true when PREEMPT_ACTIVE is set, and thus a BUG_ON tripping
in arch/ppc64/mm/tlb.c.

The patch below fixes this by changing PREEMPT_ACTIVE to 0x10000000.
I have changed the PREEMPT_ACTIVE definitions for each of the
architectures that define CONFIG_GENERIC_HARDIRQS (i386, ppc, ppc64,
x86_64) and fixed the comment in include/linux/hardirq.h.  We could
perhaps move the PREEMPT_ACTIVE definition to include/linux/hardirq.h
- I don't know why it is still per-arch.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-i386/thread_info.h akpm/include/asm-i386/thread_info.h
--- linux-2.5/include/asm-i386/thread_info.h	2004-08-24 07:22:48.000000000 +1000
+++ akpm/include/asm-i386/thread_info.h	2004-10-20 16:45:48.035497384 +1000
@@ -51,7 +51,7 @@
 
 #endif
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 #ifdef CONFIG_4KSTACKS
 #define THREAD_SIZE            (4096)
 #else
diff -urN linux-2.5/include/asm-ppc/thread_info.h akpm/include/asm-ppc/thread_info.h
--- linux-2.5/include/asm-ppc/thread_info.h	2004-08-24 07:22:48.000000000 +1000
+++ akpm/include/asm-ppc/thread_info.h	2004-10-20 16:45:50.920591472 +1000
@@ -65,7 +65,7 @@
  */
 #define THREAD_SIZE		8192	/* 2 pages */
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 
 /*
  * thread information flag bit numbers
diff -urN linux-2.5/include/asm-ppc64/thread_info.h test/include/asm-ppc64/thread_info.h
--- linux-2.5/include/asm-ppc64/thread_info.h	2004-06-18 19:06:50.000000000 +1000
+++ test/include/asm-ppc64/thread_info.h	2004-10-20 16:45:50.930589952 +1000
@@ -82,7 +82,7 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 
 /*
  * thread information flag bit numbers
diff -urN linux-2.5/include/asm-x86_64/thread_info.h test/include/asm-x86_64/thread_info.h
--- linux-2.5/include/asm-x86_64/thread_info.h	2004-04-13 09:25:10.000000000 +1000
+++ test/include/asm-x86_64/thread_info.h	2004-10-20 16:45:51.005578552 +1000
@@ -125,7 +125,7 @@
 /* work to do on any return to user space */
 #define _TIF_ALLWORK_MASK 0x0000FFFF	
 
-#define PREEMPT_ACTIVE     0x4000000
+#define PREEMPT_ACTIVE     0x10000000
 
 /*
  * Thread-synchronous status.
diff -urN linux-2.5/include/linux/hardirq.h test/include/linux/hardirq.h
--- linux-2.5/include/linux/hardirq.h	2004-10-20 08:16:49.000000000 +1000
+++ test/include/linux/hardirq.h	2004-10-20 16:45:06.096615640 +1000
@@ -14,7 +14,7 @@
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
  * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
  *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
+ * - ( bit 28 is the PREEMPT_ACTIVE flag. )
  *
  * PREEMPT_MASK: 0x000000ff
  * SOFTIRQ_MASK: 0x0000ff00
