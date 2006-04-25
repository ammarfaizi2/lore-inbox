Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWDYPK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWDYPK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWDYPK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:10:27 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25763 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932247AbWDYPK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:10:27 -0400
Date: Tue, 25 Apr 2006 17:10:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch] s390: futex atomic operations part 2.
Message-ID: <20060425151029.GA16531@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: futex atomic operations part 2.

Add missing primitive futex_atomic_cmpxchg_inatomic. Remove incorrect
type cast of uaddr memory constraint from __futex_atomic_op.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/asm-s390/futex.h |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/futex.h linux-2.6-patched/include/asm-s390/futex.h
--- linux-2.6/include/asm-s390/futex.h	2006-04-25 13:41:36.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/futex.h	2006-04-25 15:24:01.000000000 +0200
@@ -30,9 +30,9 @@
 		     "2:\n"						\
 		     __futex_atomic_fixup				\
 		     : "=d" (ret), "=&d" (oldval), "=&d" (newval),	\
-		       "=m" (*(unsigned long __user *) uaddr)		\
+		       "=m" (*uaddr)					\
 		     : "0" (-EFAULT), "d" (oparg), "a" (uaddr),		\
-		       "m" (*(unsigned long __user *) uaddr) : "cc" );
+		       "m" (*uaddr) : "cc" );
 
 static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
 {
@@ -90,5 +90,32 @@ static inline int futex_atomic_op_inuser
 	return ret;
 }
 
+static inline int
+futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
+{
+	int ret;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+	asm volatile("   cs   %1,%4,0(%5)\n"
+		     "0: lr   %0,%1\n"
+		     "1:\n"
+#ifndef __s390x__
+		     ".section __ex_table,\"a\"\n"
+		     "   .align 4\n"
+		     "   .long  0b,1b\n"
+		     ".previous"
+#else /* __s390x__ */
+		     ".section __ex_table,\"a\"\n"
+		     "   .align 8\n"
+		     "   .quad  0b,1b\n"
+		     ".previous"
+#endif /* __s390x__ */
+		     : "=d" (ret), "+d" (oldval), "=m" (*uaddr)
+		     : "0" (-EFAULT), "d" (newval), "a" (uaddr), "m" (*uaddr)
+		     : "cc", "memory" );
+	return oldval;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_S390_FUTEX_H */
