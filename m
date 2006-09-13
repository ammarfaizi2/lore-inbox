Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWIMNDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWIMNDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIMNDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:03:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750777AbWIMNDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:03:10 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/6] Alter roundup_pow_of_two() so that it can make use of long_log2() on a constant
Date: Wed, 13 Sep 2006 14:03:04 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913130304.32022.10732.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Alter roundup_pow_of_two() so that it can make use of long_log2() on a constant
to produce a constant value, retaining the ability for an arch to override it
in the non-const case.

This permits the function to be used to initialise variables.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/kernel.h |    6 ------
 include/linux/log2.h   |   23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e8c6c66..e5947fb 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -155,12 +155,6 @@ #endif
 
 unsigned long int_sqrt(unsigned long);
 
-static inline unsigned long
-__attribute_const__ roundup_pow_of_two(unsigned long x)
-{
-	return 1UL << fls_long(x - 1);
-}
-
 extern int printk_ratelimit(void);
 extern int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst);
 
diff --git a/include/linux/log2.h b/include/linux/log2.h
index a2f6858..2b55af0 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -74,6 +74,15 @@ #endif
 #endif
 
 /*
+ * round up to nearest power of two
+ */
+static inline __attribute__((const))
+unsigned long __roundup_pow_of_two(unsigned long n)
+{
+	return 1UL << fls_long(n - 1);
+}
+
+/*
  * constant-capable 32-bit log of base 2 calculation
  * - this can be used to initialise global variables from constant data, hence
  *   the massive ternary operator construction
@@ -218,4 +227,18 @@ (									\
 	__get_order(n, PAGE_SHIFT)					\
  )
 
+/*
+ * round up to nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two(n)				\
+(							\
+	__builtin_constant_p(n) ? (			\
+		(n == 1) ? 0 :				\
+		(1UL << (long_log2((n) - 1) + 1))	\
+				   ) :			\
+	__roundup_pow_of_two(n)				\
+ )
+
 #endif /* _LINUX_LOG2_H */
