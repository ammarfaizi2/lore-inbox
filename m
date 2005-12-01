Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVK3XzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVK3XzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVK3XzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:55:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27554
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751264AbVK3XzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:55:13 -0500
Subject: [patch 01/43] Move div_long_long_rem out of jiffies.h
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:00:54 +0100
Message-Id: <1133395255.32542.444.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(move-div-long-long-rem-out-of-jiffiesh.patch)

- move div_long_long_rem() from jiffies.h into a new calc64.h include file,
  as it is a general math function useful for other things than the jiffy
  code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/calc64.h  |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/jiffies.h |   11 +----------
 2 files changed, 47 insertions(+), 10 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/calc64.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc2-rework/include/linux/calc64.h
@@ -0,0 +1,46 @@
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
+#define div_long_long_rem(dividend,divisor,remainder)	\
+({							\
+	u64 result = (dividend);			\
+							\
+	*(remainder) = do_div(result, divisor);		\
+	result;						\
+})
+#endif
+
+/*
+ * Sign aware variation of the above. On some architectures a
+ * negative dividend leads to an divide overflow exception, which
+ * is avoided by the sign check.
+ */
+static inline long div_long_long_rem_signed(const long long dividend,
+					    const long divisor,
+					    long *remainder)
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
Index: linux-2.6.15-rc2-rework/include/linux/jiffies.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/jiffies.h
+++ linux-2.6.15-rc2-rework/include/linux/jiffies.h
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

