Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVIYW2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVIYW2p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVIYW2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:28:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:34822 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932300AbVIYW2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:28:45 -0400
Date: Mon, 26 Sep 2005 00:25:27 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] Fix jiffies overflow in delay.h
Message-ID: <20050925222527.GB998@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

There are several multiply overflows in delay.h:msecs_to_jiffies(). The
first one is the call to jiffies_to_msecs(MAX_JIFFY_OFFSET) which will
multiply MAX_JIFFY_OFFSET by (1000/HZ) or by 1000 during conversion,
while it was already high (~0UL>>1)-1 ... Needless to say that it's
wrong below 500 HZ and for all values not multiple of 1000 or which
don't divide 1000.

The second overflow can happen a few lines later, but this time on the
argument. The fix consists in defining a constant (macro) which depends
on HZ and fixes the absolute maximal value which we guarantee will not
produce an overflow. Fortunately, I've found no user of msecs_to_jiffies()
in mainline, although sys_poll() could benefit from it in order to avoid
a useless divide in the fast path.

But I think that the code needs be fixed anyway, considering that it
had been inherited by 2.6 for which I proposed the same fix. And it
is possible that some external patches use it.

Please review and apply,

Thanks in advance,
Willy


diff -purN linux-2.4.31-hf6/include/linux/delay.h linux-2.4.31-hf6-jiffies/include/linux/delay.h
--- linux-2.4.31-hf6/include/linux/delay.h	Sun Sep 25 19:55:55 2005
+++ linux-2.4.31-hf6-jiffies/include/linux/delay.h	Sun Sep 25 23:39:47 2005
@@ -14,6 +14,24 @@ extern unsigned long loops_per_jiffy;
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
+	ULONG_MAX / (HZ / 1000)
+#else
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - 999) / HZ
+#endif
+
+
+/*
  * Convert jiffies to milliseconds and back.
  *
  * Avoid unnecessary multiplications/divisions in the
@@ -43,7 +61,7 @@ static inline unsigned int jiffies_to_us
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	if (m > MAX_MSEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= 1000 && !(1000 % HZ)
 	return (m + (1000 / HZ) - 1) / (1000 / HZ);


