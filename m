Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWGDQvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWGDQvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWGDQvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:51:13 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:65163 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932281AbWGDQvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:51:11 -0400
Date: Tue, 4 Jul 2006 18:51:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: raw_local_save_flags/raw_local_irq_restore type check
Message-ID: <20060704165112.GB5519@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] raw_local_save_flags/raw_local_irq_restore type check

Make sure that raw_local_save_flags and raw_local_irq_restore always get an
unsigned long parameter. raw_irqs_disabled should call raw_local_save_flags
instead of local_save_flags.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/irqflags.h |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/include/asm-s390/irqflags.h linux-2.6-patched/include/asm-s390/irqflags.h
--- linux-2.6/include/asm-s390/irqflags.h	2006-07-04 18:31:22.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/irqflags.h	2006-07-04 18:31:31.000000000 +0200
@@ -25,16 +25,22 @@
 	__flags; \
 	})
 
-#define raw_local_save_flags(x) \
-	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) )
-
-#define raw_local_irq_restore(x) \
-	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory")
+#define raw_local_save_flags(x)							\
+do {										\
+	typecheck(unsigned long, x);						\
+	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) );	\
+} while (0)
+
+#define raw_local_irq_restore(x)						\
+do {										\
+	typecheck(unsigned long, x);						\
+	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory");	\
+} while (0)
 
 #define raw_irqs_disabled()		\
 ({					\
 	unsigned long flags;		\
-	local_save_flags(flags);	\
+	raw_local_save_flags(flags);	\
 	!((flags >> __FLAG_SHIFT) & 3);	\
 })
 
