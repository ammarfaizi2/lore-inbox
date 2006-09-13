Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWIMSgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWIMSgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWIMSfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:35:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751076AbWIMSfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:35:39 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/7] Alter roundup_pow_of_two() so that it can make use of ilog2() on a constant [try #3]
Date: Wed, 13 Sep 2006 19:35:33 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913183533.22109.85070.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
References: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Alter roundup_pow_of_two() so that it can make use of ilog2() on a constant to
produce a constant value, retaining the ability for an arch to override it in
the non-const case.

This permits the function to be used to initialise variables.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/kernel.h |    6 ------
 include/linux/log2.h   |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

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
index 88b7b0e..c7574a6 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -73,6 +73,15 @@ #endif
 }
 #endif
 
+/*
+ * round up to nearest power of two
+ */
+static inline __attribute__((const))
+unsigned long __roundup_pow_of_two(unsigned long n)
+{
+	return 1UL << fls_long(n - 1);
+}
+
 /**
  * ilog2_u32 - log of base 2 of 32-bit unsigned value
  * @n - parameter
@@ -230,4 +239,21 @@ (									\
 	__get_order(n, PAGE_SHIFT)					\
  )
 
+/**
+ * roundup_pow_of_two - round the given value up to nearest power of two
+ * @n - parameter
+ *
+ * round the given balue up to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two(n)			\
+(						\
+	__builtin_constant_p(n) ? (		\
+		(n == 1) ? 0 :			\
+		(1UL << (ilog2((n) - 1) + 1))	\
+				   ) :		\
+	__roundup_pow_of_two(n)			\
+ )
+
 #endif /* _LINUX_LOG2_H */
