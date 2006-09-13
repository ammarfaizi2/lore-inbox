Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWIMSfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWIMSfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWIMSfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:35:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63374 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751076AbWIMSff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:35:35 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/7] FRV: Fix fls() to handle bit 31 being set correctly [try #3]
Date: Wed, 13 Sep 2006 19:35:22 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Fix FRV fls() to handle bit 31 being set correctly (it should return 32 not 0).

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/bitops.h |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 980ae1b..97fb746 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -161,16 +161,29 @@ #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/find.h>
 
-/*
- * fls: find last bit set.
+/**
+ * fls - find last bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as ffs:
+ * - return 32..1 to indicate bit 31..0 most significant bit set
+ * - return 0 to indicate no bits set
  */
 #define fls(x)						\
 ({							\
 	int bit;					\
 							\
-	asm("scan %1,gr0,%0" : "=r"(bit) : "r"(x));	\
+	asm("	subcc	%1,gr0,gr0,icc0		\n"	\
+	    "	ckne	icc0,cc4		\n"	\
+	    "	cscan.p	%1,gr0,%0	,cc4,#1	\n"	\
+	    "	csub	%0,%0,%0	,cc4,#0	\n"	\
+	    "   csub    %2,%0,%0	,cc4,#1	\n"	\
+	    : "=&r"(bit)				\
+	    : "r"(x), "r"(32)				\
+	    : "icc0", "cc4"				\
+	    );						\
 							\
-	bit ? 33 - bit : bit;				\
+	bit;						\
 })
 
 #include <asm-generic/bitops/fls64.h>
