Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266232AbUFUNiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUFUNiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266228AbUFUNho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:37:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46742 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266232AbUFUNgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:36:44 -0400
Date: Mon, 21 Jun 2004 08:36:35 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Spinlock timeouts
Message-Id: <20040621083635.40094900.moilanen@austin.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the PPC64 add-on to spinlock timeouts.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

diff -Nru a/arch/ppc64/kernel/chrp_setup.c b/arch/ppc64/kernel/chrp_setup.c
--- a/arch/ppc64/kernel/chrp_setup.c	Mon Jun 14 08:07:11 2004
+++ b/arch/ppc64/kernel/chrp_setup.c	Mon Jun 14 08:07:11 2004
@@ -405,10 +405,6 @@
 
 extern void setup_default_decr(void);
 
-/* Some sane defaults: 125 MHz timebase, 1GHz processor */
-#define DEFAULT_TB_FREQ		125000000UL
-#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
-
 void __init pSeries_calibrate_decr(void)
 {
 	struct device_node *cpu;
diff -Nru a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c	Mon Jun 14 08:07:11 2004
+++ b/arch/ppc64/kernel/time.c	Mon Jun 14 08:07:11 2004
@@ -81,7 +81,7 @@
 
 #define XSEC_PER_SEC (1024*1024)
 
-unsigned long tb_ticks_per_jiffy;
+unsigned long tb_ticks_per_jiffy = DEFAULT_TB_FREQ / HZ;
 unsigned long tb_ticks_per_usec;
 unsigned long tb_ticks_per_sec;
 unsigned long next_xtime_sync_tb;
diff -Nru a/include/asm-ppc64/processor.h b/include/asm-ppc64/processor.h
--- a/include/asm-ppc64/processor.h	Mon Jun 14 08:07:11 2004
+++ b/include/asm-ppc64/processor.h	Mon Jun 14 08:07:11 2004
@@ -440,6 +440,9 @@
 
 #endif /* __ASSEMBLY__ */
 
+/* Some sane defaults: 125 MHz timebase, 1GHz processor */
+#define DEFAULT_TB_FREQ		125000000UL
+#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
 
 /* Macros for setting and retrieving special purpose registers */
 
diff -Nru a/include/asm-ppc64/spinlock.h b/include/asm-ppc64/spinlock.h
--- a/include/asm-ppc64/spinlock.h	Mon Jun 14 08:07:11 2004
+++ b/include/asm-ppc64/spinlock.h	Mon Jun 14 08:07:11 2004
@@ -278,5 +278,16 @@
 }
 #endif /* CONFIG_SPINLINE */
 
+#ifdef CONFIG_SPINLOCK_TIMEOUT
+
+#define ARCH_HAS_SPINLOCK_TIMEOUT
+
+extern unsigned long tb_ticks_per_jiffy;
+
+#define get_spinlock_timeout() (mftb() + (tb_ticks_per_jiffy * SPINLOCK_TIMEOUT * HZ))
+#define check_spinlock_timeout(timeout) (mftb() >= timeout ? 1 : 0)
+
+#endif /* CONFIG_SPINLOCK_TIMEOUT */
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
