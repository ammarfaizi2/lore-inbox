Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbVLFAee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbVLFAee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbVLFAed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:34:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21966
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751527AbVLFAec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:32 -0500
Message-Id: <20051206000152.434304000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:27 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 01/21] Move div_long_long_rem out of jiffies.h
Content-Disposition: inline;
	filename=move-div-long-long-rem-out-of-jiffiesh.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- move div_long_long_rem() from jiffies.h into a new calc64.h include file,
  as it is a general math function useful for other things than the jiffy
  code. Convert it to an inline function

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/calc64.h  |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/jiffies.h |   11 ----------
 2 files changed, 51 insertions(+), 10 deletions(-)

Index: linux-2.6.15-rc5/include/linux/calc64.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc5/include/linux/calc64.h
@@ -0,0 +1,49 @@
+#ifndef _LINUX_CALC64_H
+#define _LINUX_CALC64_H
+
+#include <linux/types.h>
+#include <asm/div64.h>
+
+/*
+ * This is a generic macro which is used when the architecture
+ * specific div64.h does not provide a optimized one.
+ *
+ * The 64bit dividend is divided by the divisor (data type long), the
+ * result is returned and the remainder stored in the variable
+ * referenced by remainder (data type long *). In contrast to the
+ * do_div macro the dividend is kept intact.
+ */
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend, divisor, remainder)	\
+	do_div_llr((dividend), divisor, remainder)
+
+static inline unsigned long do_div_llr(const long long dividend,
+				       const long divisor, long *remainder)
+{
+	u64 result = dividend;
+
+	*(remainder) = do_div(result, divisor);
+	return (unsigned long) result;
+}
+#endif
+
+/*
+ * Sign aware variation of the above. On some architectures a
+ * negative dividend leads to an divide overflow exception, which
+ * is avoided by the sign check.
+ */
+static inline long div_long_long_rem_signed(const long long dividend,
+					    const long divisor, long *remainder)
+{
+	long res;
+
+	if (unlikely(dividend < 0)) {
+		res = -div_long_long_rem(-dividend, divisor, remainder);
+		*remainder = -(*remainder);
+	} else
+		res = div_long_long_rem(dividend, divisor, remainder);
+
+	return res;
+}
+
+#endif
Index: linux-2.6.15-rc5/include/linux/jiffies.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/jiffies.h
+++ linux-2.6.15-rc5/include/linux/jiffies.h
@@ -1,21 +1,12 @@
 #ifndef _LINUX_JIFFIES_H
 #define _LINUX_JIFFIES_H
 
+#include <linux/calc64.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <asm/param.h>			/* for HZ */
-#include <asm/div64.h>
-
-#ifndef div_long_long_rem
-#define div_long_long_rem(dividend,divisor,remainder) \
-({							\
-	u64 result = dividend;				\
-	*remainder = do_div(result,divisor);		\
-	result;						\
-})
-#endif
 
 /*
  * The following defines establish the engineering parameters of the PLL

--

