Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263107AbTCYR3l>; Tue, 25 Mar 2003 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263111AbTCYR2k>; Tue, 25 Mar 2003 12:28:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64123 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263118AbTCYR2b>; Tue, 25 Mar 2003 12:28:31 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHde7s006907@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 5/8] 2.4: Add less-severe assert-failure form for ext3.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new form of assert failure in ext3 which allows us to flag events
which are *usually* bugs, but which can be legally triggered in the
presence of IO failures.  Don't panic the kernel on such errors unless
we've defined #JBD_PARANOID_IOFAIL, which will normally be set only for
testing purposes.

--- linux-2.4-ext3push/include/linux/jbd.h.=K0004=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/include/linux/jbd.h	2003-03-25 10:59:15.000000000 +0000
@@ -40,6 +40,15 @@
  */
 #undef JBD_PARANOID_WRITES
 
+/*
+ * Define JBD_PARANIOD_IOFAIL to cause a kernel BUG() if ext3 finds
+ * certain classes of error which can occur due to failed IOs.  Under
+ * normal use we want ext3 to continue after such errors, because
+ * hardware _can_ fail, but for debugging purposes when running tests on
+ * known-good hardware we may want to trap these errors.
+ */
+#undef JBD_PARANOID_IOFAIL
+
 #ifdef CONFIG_JBD_DEBUG
 /*
  * Define JBD_EXPENSIVE_CHECKING to enable more expensive internal
@@ -263,6 +272,23 @@ void buffer_assertion_failure(struct buf
 #define J_ASSERT(assert)	do { } while (0)
 #endif		/* JBD_ASSERTIONS */
 
+#if defined(JBD_PARANOID_IOFAIL)
+#define J_EXPECT(expr, why...)		J_ASSERT(expr)
+#define J_EXPECT_BH(bh, expr, why...)	J_ASSERT_BH(bh, expr)
+#define J_EXPECT_JH(jh, expr, why...)	J_ASSERT_JH(jh, expr)
+#else
+#define __journal_expect(expr, why...)					     \
+	do {								     \
+		if (!(expr)) {						     \
+			printk(KERN_ERR "EXT3-fs unexpected failure: %s;\n", # expr); \
+			printk(KERN_ERR ## why);			     \
+		}							     \
+	} while (0)
+#define J_EXPECT(expr, why...)		__journal_expect(expr, ## why)
+#define J_EXPECT_BH(bh, expr, why...)	__journal_expect(expr, ## why)
+#define J_EXPECT_JH(jh, expr, why...)	__journal_expect(expr, ## why)
+#endif
+
 enum jbd_state_bits {
 	BH_JWrite
 	  = BH_PrivateStart,	/* 1 if being written to log (@@@ DEBUGGING) */
