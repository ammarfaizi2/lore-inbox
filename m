Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWIVAsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWIVAsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWIVAsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:48:19 -0400
Received: from smtp-out.google.com ([216.239.45.12]:9312 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932146AbWIVAsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:48:18 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=F0HXLd7BTo3Ey23oy3GpJMQ4O2Jcpp9MSdjiDs4+oBbN5trJ7MVcQdQTJcrgVKxFR
	qarXEXtuYWZQ10jIAR5ig==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 2/4] jiffies: Add 64bit jiffies compares (for use with get_jiffies_64)
Date: Thu, 21 Sep 2006 17:48:02 -0700
Message-Id: <11588860853616-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11588860854079-git-send-email-dmitriyz@google.com>
References: <11588860842488-git-send-email-dmitriyz@google.com> <11588860854079-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current time_before/time_after macros will fail typechecks
when passed u64 values (as returned by get_jiffies_64()). On 64bit
systems, this will just result in a warning about mismatching types
without explicit casts, but since unsigned long and u64
(unsigned long long) are of same size, it will still work.
On 32bit systems, a long is 32bits, so the value from get_jiffies_64()
will be truncated by the cast and thus lose all the precision gained by
64bit jiffies.

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>

---
 include/linux/jiffies.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 329ebcf..c8d5f20 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -115,6 +115,21 @@ #define time_after_eq(a,b)	\
 	 ((long)(a) - (long)(b) >= 0))
 #define time_before_eq(a,b)	time_after_eq(b,a)
 
+/* Same as above, but does so with platform independent 64bit types.
+ * These must be used when utilizing jiffies_64 (i.e. return value of
+ * get_jiffies_64() */
+#define time_after64(a,b)	\
+	(typecheck(__u64, a) &&	\
+	 typecheck(__u64, b) && \
+	 ((__s64)(b) - (__s64)(a) < 0))
+#define time_before64(a,b)	time_after64(b,a)
+
+#define time_after_eq64(a,b)	\
+	(typecheck(__u64, a) && \
+	 typecheck(__u64, b) && \
+	 ((__s64)(a) - (__s64)(b) >= 0))
+#define time_before_eq64(a,b)	time_after_eq64(b,a)
+
 /*
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
-- 
1.4.2

