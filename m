Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWGDQu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWGDQu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWGDQu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:50:56 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:59349 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932280AbWGDQuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:50:55 -0400
Date: Tue, 4 Jul 2006 18:50:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: __builtin_trap() and gcc version.
Message-ID: <20060704165056.GA5519@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] __builtin_trap() and gcc version.

__builtin_trap() has the archictecture defined backend in gcc since gcc 3.3.
To make sure the kernel builds with gcc 3.2 as well, use the old style BUG()
statement if compiled with older gcc versions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bug.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/include/asm-s390/bug.h linux-2.6-patched/include/asm-s390/bug.h
--- linux-2.6/include/asm-s390/bug.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/bug.h	2006-07-04 18:31:30.000000000 +0200
@@ -5,9 +5,18 @@
 
 #ifdef CONFIG_BUG
 
+static inline __attribute__((noreturn)) void __do_illegal_op(void)
+{
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
+	__builtin_trap();
+#else
+	asm volatile(".long 0");
+#endif
+}
+
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__builtin_trap(); \
+	__do_illegal_op(); \
 } while (0)
 
 #define HAVE_ARCH_BUG
