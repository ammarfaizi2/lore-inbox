Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUGFVRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUGFVRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUGFVRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:17:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53231 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264610AbUGFVQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:16:51 -0400
Date: Tue, 6 Jul 2004 16:16:41 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Spinlock timeout ppc64 addon
Message-Id: <20040706161641.2e66d63c.moilanen@austin.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the PPC64 add-on to spinlock timeouts.

Please comment or apply.

Thanks,
Jake

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN arch/ppc64/kernel/chrp_setup.c~spinlock-timeout-ppc64 arch/ppc64/kernel/chrp_setup.c
--- linux-2.6/arch/ppc64/kernel/chrp_setup.c~spinlock-timeout-ppc64	Tue Jul  6 15:18:16 2004
+++ linux-2.6-moilanen/arch/ppc64/kernel/chrp_setup.c	Tue Jul  6 15:18:16 2004
@@ -405,10 +405,6 @@ chrp_progress(char *s, unsigned short he
 
 extern void setup_default_decr(void);
 
-/* Some sane defaults: 125 MHz timebase, 1GHz processor */
-#define DEFAULT_TB_FREQ		125000000UL
-#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
-
 void __init pSeries_calibrate_decr(void)
 {
 	struct device_node *cpu;
diff -puN arch/ppc64/kernel/time.c~spinlock-timeout-ppc64 arch/ppc64/kernel/time.c
--- linux-2.6/arch/ppc64/kernel/time.c~spinlock-timeout-ppc64	Tue Jul  6 15:18:16 2004
+++ linux-2.6-moilanen/arch/ppc64/kernel/time.c	Tue Jul  6 15:18:16 2004
@@ -81,7 +81,7 @@ static unsigned long first_settimeofday 
 
 #define XSEC_PER_SEC (1024*1024)
 
-unsigned long tb_ticks_per_jiffy;
+unsigned long tb_ticks_per_jiffy = DEFAULT_TB_FREQ / HZ;
 unsigned long tb_ticks_per_usec;
 unsigned long tb_ticks_per_sec;
 unsigned long next_xtime_sync_tb;
diff -puN include/asm-ppc64/processor.h~spinlock-timeout-ppc64 include/asm-ppc64/processor.h
--- linux-2.6/include/asm-ppc64/processor.h~spinlock-timeout-ppc64	Tue Jul  6 15:18:16 2004
+++ linux-2.6-moilanen/include/asm-ppc64/processor.h	Tue Jul  6 15:18:16 2004
@@ -438,6 +438,9 @@ GLUE(.,name):
 
 #endif /* __ASSEMBLY__ */
 
+/* Some sane defaults: 125 MHz timebase, 1GHz processor */
+#define DEFAULT_TB_FREQ		125000000UL
+#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
 
 /* Macros for setting and retrieving special purpose registers */
 
diff -puN include/asm-ppc64/spinlock.h~spinlock-timeout-ppc64 include/asm-ppc64/spinlock.h
--- linux-2.6/include/asm-ppc64/spinlock.h~spinlock-timeout-ppc64	Tue Jul  6 15:18:16 2004
+++ linux-2.6-moilanen/include/asm-ppc64/spinlock.h	Tue Jul  6 15:18:16 2004
@@ -216,5 +216,16 @@ static __inline__ int is_write_locked(rw
 
 #define rwlock_is_locked(x)	((x)->lock)
 
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

_
