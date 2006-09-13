Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWIMNDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWIMNDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIMNDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:03:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750771AbWIMNDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:03:08 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/6] FRV: Implement fls64()
Date: Wed, 13 Sep 2006 14:02:56 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913130256.32022.75269.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Implement fls64() for FRV without recource to conditional jumps.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/bitops.h |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 97fb746..591eecc 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -186,7 +186,47 @@ ({							\
 	bit;						\
 })
 
-#include <asm-generic/bitops/fls64.h>
+/**
+ * fls64 - find last bit set in a 64-bit value
+ * @n: the value to search
+ *
+ * This is defined the same way as ffs:
+ * - return 64..1 to indicate bit 63..0 most significant bit set
+ * - return 0 to indicate no bits set
+ */
+static inline __attribute__((const))
+int fls64(u64 n)
+{
+	union {
+		u64 ll;
+		struct { u32 h, l; };
+	} _;
+	int bit, x, y;
+
+	_.ll = n;
+
+	asm("	subcc.p		%3,gr0,gr0,icc0		\n"
+	    "	subcc		%4,gr0,gr0,icc1		\n"
+	    "	ckne		icc0,cc4		\n"
+	    "	ckne		icc1,cc5		\n"
+	    "	norcr		cc4,cc5,cc6		\n"
+	    "	csub.p		%0,%0,%0	,cc6,1	\n"
+	    "	orcr		cc5,cc4,cc4		\n"
+	    "	andcr		cc4,cc5,cc4		\n"
+	    "	cscan.p		%3,gr0,%0	,cc4,0	\n"
+	    "   setlos		#64,%1			\n"
+	    "	cscan.p		%4,gr0,%0	,cc4,1	\n"
+	    "   setlos		#32,%2			\n"
+	    "	csub.p		%1,%0,%0	,cc4,0	\n"
+	    "	csub		%2,%0,%0	,cc4,1	\n"
+	    : "=&r"(bit), "=r"(x), "=r"(y)
+	    : "0r"(_.h), "r"(_.l)
+	    : "icc0", "icc1", "cc4", "cc5", "cc6"
+	    );
+	return bit;
+
+}
+
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 
