Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWGNOsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWGNOsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWGNOsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:48:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:52890 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161116AbWGNOsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:48:55 -0400
Subject: [PATCH] remove volatile from x86 cmos_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:48:43 -0400
Message-Id: <1152888523.27135.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another exercise to understand barriers. Once again, please
review to see if this is indeed correct.

This patch removes the volatile keyword for cmos_lock and tries to make
the code correct using barriers.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/include/asm-i386/mc146818rtc.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-i386/mc146818rtc.h	2006-07-14 09:09:14.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-i386/mc146818rtc.h	2006-07-14 09:22:50.000000000 -0400
@@ -31,7 +31,7 @@
  * atomically claim the lock and set the owner.
  */
 #include <linux/smp.h>
-extern volatile unsigned long cmos_lock;
+extern unsigned long cmos_lock;
 
 /*
  * All of these below must be called with interrupts off, preempt
@@ -43,8 +43,10 @@ static inline void lock_cmos(unsigned ch
 	unsigned long new;
 	new = ((smp_processor_id()+1) << 8) | reg;
 	for (;;) {
-		if (cmos_lock)
+		if (cmos_lock) {
+			cpu_relax();
 			continue;
+		}
 		if (__cmpxchg(&cmos_lock, 0, new, sizeof(cmos_lock)) == 0)
 			return;
 	}
@@ -52,14 +54,16 @@ static inline void lock_cmos(unsigned ch
 
 static inline void unlock_cmos(void)
 {
-	cmos_lock = 0;
+	set_wmb(cmos_lock, 0);
 }
 static inline int do_i_have_lock_cmos(void)
 {
+	barrier();
 	return (cmos_lock >> 8) == (smp_processor_id()+1);
 }
 static inline unsigned char current_lock_cmos_reg(void)
 {
+	barrier();
 	return cmos_lock & 0xff;
 }
 #define lock_cmos_prefix(reg) \
Index: linux-2.6.18-rc1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.18-rc1.orig/arch/i386/kernel/time.c	2006-07-14 09:08:56.000000000 -0400
+++ linux-2.6.18-rc1/arch/i386/kernel/time.c	2006-07-14 09:24:06.000000000 -0400
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(rtc_lock);
  * register we are working with.  It is required for NMI access to the
  * CMOS/RTC registers.  See include/asm-i386/mc146818rtc.h for details.
  */
-volatile unsigned long cmos_lock = 0;
+unsigned long cmos_lock = 0;
 EXPORT_SYMBOL(cmos_lock);
 
 /* Routines for accessing the CMOS RAM/RTC. */


