Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVEAVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVEAVYw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVEAVYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:24:22 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:28435 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262690AbVEAVSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:35 -0400
Message-Id: <200505012113.j41LD353016483@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 19/22] UML - S390 preparation, delay moved to arch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:13:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 has fast read access to realtime clock (nanosecond
resolution).
So it makes sense to have an arch-specific implementation
not only of __delay, but __udelay also.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN arch/um/sys-i386/delay.c~delay-pure-arch arch/um/sys-i386/delay.c
--- linux-2.6.10-rc3-mm1/arch/um/sys-i386/delay.c~delay-pure-arch	2004-12-21 14:46:36.607374692 +0100
+++ linux-2.6.10-rc3-mm1-root/arch/um/sys-i386/delay.c	2004-12-21 15:04:26.368897211 +0100
@@ -1,3 +1,6 @@
+#include "linux/delay.h"
+#include "asm/param.h"
+
 void __delay(unsigned long time)
 {
 	/* Stolen from the i386 __loop_delay */
@@ -12,3 +15,18 @@ void __delay(unsigned long time)
 		:"0" (time));
 }
 
+void __udelay(unsigned long usecs)
+{
+	int i, n;
+
+	n = (loops_per_jiffy * HZ * usecs) / MILLION;
+	for(i=0;i<n;i++) ;
+}
+
+void __const_udelay(unsigned long usecs)
+{
+	int i, n;
+
+	n = (loops_per_jiffy * HZ * usecs) / MILLION;
+	for(i=0;i<n;i++) ;
+}
diff -puN arch/um/sys-x86_64/delay.c~delay-pure-arch arch/um/sys-x86_64/delay.c
--- linux-2.6.10-rc3-mm1/arch/um/sys-x86_64/delay.c~delay-pure-arch	2004-12-21 14:46:46.546304277 +0100
+++ linux-2.6.10-rc3-mm1-root/arch/um/sys-x86_64/delay.c	2004-12-21 15:04:17.460658977 +0100
@@ -5,7 +5,9 @@
  * Licensed under the GPL
  */
 
+#include "linux/delay.h"
 #include "asm/processor.h"
+#include "asm/param.h"
 
 void __delay(unsigned long loops)
 {
@@ -14,6 +16,22 @@ void __delay(unsigned long loops)
 	for(i = 0; i < loops; i++) ;
 }
 
+void __udelay(unsigned long usecs)
+{
+	int i, n;
+
+	n = (loops_per_jiffy * HZ * usecs) / MILLION;
+	for(i=0;i<n;i++) ;
+}
+
+void __const_udelay(unsigned long usecs)
+{
+	int i, n;
+
+	n = (loops_per_jiffy * HZ * usecs) / MILLION;
+	for(i=0;i<n;i++) ;
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -puN arch/um/kernel/time_kern.c~delay-pure-arch arch/um/kernel/time_kern.c
--- linux-2.6.10-rc3-mm1/arch/um/kernel/time_kern.c~delay-pure-arch	2004-12-21 14:46:59.671249612 +0100
+++ linux-2.6.10-rc3-mm1-root/arch/um/kernel/time_kern.c	2004-12-21 14:55:27.352412599 +0100
@@ -48,8 +48,6 @@ static unsigned long long prev_usecs;
 static long long delta;   		/* Deviation per interval */
 #endif
 
-#define MILLION 1000000
-
 void timer_irq(union uml_pt_regs *regs)
 {
 	unsigned long long ticks = 0;
@@ -136,22 +134,6 @@ long um_stime(int * tptr)
 	return 0;
 }
 
-void __udelay(unsigned long usecs)
-{
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
-}
-
-void __const_udelay(unsigned long usecs)
-{
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-	for(i=0;i<n;i++) ;
-}
-
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
 	local_irq_disable();
diff -puN include/asm-um/delay.h~delay-pure-arch include/asm-um/delay.h
--- linux-2.6.10-rc3-mm1/include/asm-um/delay.h~delay-pure-arch	2004-12-21 14:54:43.298022241 +0100
+++ linux-2.6.10-rc3-mm1-root/include/asm-um/delay.h	2004-12-21 14:55:18.551131562 +0100
@@ -4,4 +4,6 @@
 #include "asm/arch/delay.h"
 #include "asm/archparam.h"
 
+#define MILLION 1000000
+
 #endif
diff -puN arch/um/kernel/ksyms.c~delay-pure-arch arch/um/kernel/ksyms.c
--- linux-2.6.10-rc3-mm1/arch/um/kernel/ksyms.c~delay-pure-arch	2004-12-21 14:56:12.790447194 +0100
+++ linux-2.6.10-rc3-mm1-root/arch/um/kernel/ksyms.c	2004-12-21 14:58:24.664870315 +0100
@@ -10,7 +10,6 @@
 #include "linux/spinlock.h"
 #include "linux/highmem.h"
 #include "asm/current.h"
-#include "asm/delay.h"
 #include "asm/processor.h"
 #include "asm/unistd.h"
 #include "asm/pgalloc.h"
@@ -28,8 +27,6 @@ EXPORT_SYMBOL(uml_physmem);
 EXPORT_SYMBOL(set_signals);
 EXPORT_SYMBOL(get_signals);
 EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(__const_udelay);
-EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(sys_waitpid);
 EXPORT_SYMBOL(task_size);
 EXPORT_SYMBOL(flush_tlb_range);
diff -puN arch/um/sys-i386/ksyms.c~delay-pure-arch arch/um/sys-i386/ksyms.c
--- linux-2.6.10-rc3-mm1/arch/um/sys-i386/ksyms.c~delay-pure-arch	2004-12-21 14:56:23.922196611 +0100
+++ linux-2.6.10-rc3-mm1-root/arch/um/sys-i386/ksyms.c	2004-12-21 14:58:33.148835387 +0100
@@ -2,6 +2,7 @@
 #include "linux/in6.h"
 #include "linux/rwsem.h"
 #include "asm/byteorder.h"
+#include "asm/delay.h"
 #include "asm/semaphore.h"
 #include "asm/uaccess.h"
 #include "asm/checksum.h"
@@ -14,3 +15,7 @@ EXPORT_SYMBOL(__up_wakeup);
 
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial);
+
+/* delay core functions */
+EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__udelay);
_

