Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWJFNg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWJFNg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJFNg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:36:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932335AbWJFNfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:35:00 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] LOG2: Alter roundup_pow_of_two() so that it can use a ilog2() on a constant [try #4]
Date: Fri, 06 Oct 2006 14:34:17 +0100
To: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061006133417.9972.76941.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
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
index 473101a..67ca3ad 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -156,12 +156,6 @@ #endif
 
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
index 3979c60..d02e1a5 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -43,6 +43,15 @@ int __ilog2_u64(u64 n)
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
  * ilog2 - log of base 2 of 32-bit or a 64-bit unsigned value
  * @n - parameter
@@ -128,4 +137,21 @@ (						\
 	__ilog2_u64(n)				\
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
