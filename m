Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWIMNDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWIMNDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIMNDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:03:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38342 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750770AbWIMNDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:03:06 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/6] FRV: Optimise ffs()
Date: Wed, 13 Sep 2006 14:02:58 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913130258.32022.85288.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Optimise ffs(x) by using fls(x & x - 1) which we optimise to use the SCAN
instruction.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/bitops.h |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 591eecc..1f70d47 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -157,8 +157,6 @@ (__builtin_constant_p(nr) ? \
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
-#include <asm-generic/bitops/ffs.h>
-#include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/find.h>
 
 /**
@@ -227,6 +225,37 @@ int fls64(u64 n)
 
 }
 
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * - return 32..1 to indicate bit 31..0 most least significant bit set
+ * - return 0 to indicate no bits set
+ */
+static inline __attribute__((const))
+int ffs(int x)
+{
+	/* Note: (x & -x) gives us a mask that is the least significant
+	 * (rightmost) 1-bit of the value in x.
+	 */
+	return fls(x & -x);
+}
+
+/**
+ * __ffs - find first bit set
+ * @x: the word to search
+ *
+ * - return 31..0 to indicate bit 31..0 most least significant bit set
+ * - if no bits are set in x, the result is undefined
+ */
+static inline __attribute__((const))
+int __ffs(unsigned long x)
+{
+	int bit;
+	asm("scan %1,gr0,%0" : "=r"(bit) : "r"(x & -x));
+	return 31 - bit;
+}
+
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 
