Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVJAUJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVJAUJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 16:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVJAUJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 16:09:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:52742 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750838AbVJAUJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 16:09:22 -0400
Date: Sat, 1 Oct 2005 22:02:57 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] Fix jiffies overflow in delay.h
Message-ID: <20051001200257.GA28113@alpha.home.local>
References: <20050925222527.GB998@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925222527.GB998@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

please forget my previous patch, it would produce tons of warnings on
64-bit architectures. Moreover, I discovered that it was incomplete
and that it was necessary to explicitly cast to unsigned long in the
multiplies.

This one is fine and the equivalent to the one I sent Andrew for 2.6.
Please use it instead.

Thanks,
Willy



Signed-off-by: Willy Tarreau <willy@w.ods.org>

diff -urN linux-2.4.31/include/linux/delay.h linux-2.4.31-jiffies/include/linux/delay.h
--- linux-2.4.31/include/linux/delay.h	Sun Sep 25 19:55:55 2005
+++ linux-2.4.31-jiffies/include/linux/delay.h	Sat Oct  1 21:25:33 2005
@@ -14,6 +14,24 @@
 #include <asm/delay.h>
 
 /*
+ * We define MAX_MSEC_OFFSET as the maximal value that can be accepted by
+ * msecs_to_jiffies() without risking a multiply overflow. This function
+ * returns MAX_JIFFY_OFFSET for arguments above those values.
+ */
+
+#if HZ <= 1000 && !(1000 % HZ)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - (1000 / HZ) + 1)
+#elif HZ > 1000 && !(HZ % 1000)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX / (HZ / 1000))
+#else
+#  define MAX_MSEC_OFFSET \
+	((ULONG_MAX - 999) / HZ)
+#endif
+
+
+/*
  * Convert jiffies to milliseconds and back.
  *
  * Avoid unnecessary multiplications/divisions in the
@@ -43,14 +61,14 @@
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	if (MAX_MSEC_OFFSET < UINT_MAX && m > (unsigned int)MAX_MSEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= 1000 && !(1000 % HZ)
-	return (m + (1000 / HZ) - 1) / (1000 / HZ);
+	return ((unsigned long)m + (1000 / HZ) - 1) / (1000 / HZ);
 #elif HZ > 1000 && !(HZ % 1000)
-	return m * (HZ / 1000);
+	return (unsigned long)m * (HZ / 1000);
 #else
-	return (m * HZ + 999) / 1000;
+	return ((unsigned long)m * HZ + 999) / 1000;
 #endif
 }
 

