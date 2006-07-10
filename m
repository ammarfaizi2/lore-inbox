Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWGJJ20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWGJJ20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWGJJ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:28:25 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:13622 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932513AbWGJJ2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:28:24 -0400
Date: Mon, 10 Jul 2006 11:28:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: cpu_relax() is supposed to have barrier() semantics.
Message-ID: <20060710092831.GC30303@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] cpu_relax() is supposed to have barrier() semantics.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/processor.h |   16 +++++++---------
 include/asm-s390/setup.h     |    3 ++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/include/asm-s390/processor.h linux-2.6-patched/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/processor.h	2006-07-10 10:33:43.000000000 +0200
@@ -199,15 +199,13 @@ unsigned long get_wchan(struct task_stru
 /*
  * Give up the time slice of the virtual PU.
  */
-#ifndef __s390x__
-# define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
-#else /* __s390x__ */
-# define cpu_relax() \
-	do { \
-		if (MACHINE_HAS_DIAG44) \
-			asm volatile ("diag 0,0,68" : : : "memory"); \
-	} while (0)
-#endif /* __s390x__ */
+static inline void cpu_relax(void)
+{
+	if (MACHINE_HAS_DIAG44)
+		asm volatile ("diag 0,0,68" : : : "memory");
+	else
+		barrier();
+}
 
 /*
  * Set PSW to specified value.
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-07-10 10:33:43.000000000 +0200
@@ -40,15 +40,16 @@ extern unsigned long machine_flags;
 #define MACHINE_IS_VM		(machine_flags & 1)
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
-#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
 #define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_DIAG44	(1)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
+#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #endif /* __s390x__ */
 
 
