Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVLLUv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLLUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLLUv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:51:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751210AbVLLUv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:51:26 -0500
Date: Mon, 12 Dec 2005 15:51:07 -0500
From: Dave Jones <davej@redhat.com>
To: akpm@osdl.org
Cc: arjanv@infradead.org, linux-kernel@vger.kernel.org
Subject: warn if we sleep in an irq for a long time.
Message-ID: <20051212205107.GA4184@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, akpm@osdl.org,
	arjanv@infradead.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been carrying this in Fedora/RHEL for a dogs age.
It occasionally trips something up (especially in out-of-tree modules)

(Originally by Arjan, with trivial rediffing by me over time)

Cc: Arjan van de Ven <arjanv@infradead.org>
Signed-off-by: Dave Jones <davej@redhat.com>

diff -urNp --exclude-from=/home/davej/.exclude linux-3022/include/linux/delay.h linux-10000/include/linux/delay.h
--- linux-3022/include/linux/delay.h
+++ linux-10000/include/linux/delay.h
@@ -10,7 +10,7 @@
 extern unsigned long loops_per_jiffy;
 
 #include <asm/delay.h>
-
+#include <linux/hardirq.h>
 /*
  * Using udelay() for intervals greater than a few milliseconds can
  * risk overflow for high loops_per_jiffy (high bogomips) machines. The
@@ -25,14 +25,13 @@ extern unsigned long loops_per_jiffy;
 #define MAX_UDELAY_MS	5
 #endif
 
-#ifdef notdef
-#define mdelay(n) (\
-	{unsigned long __ms=(n); while (__ms--) udelay(1000);})
-#else
-#define mdelay(n) (\
-	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
-	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
-#endif
+#define mdelay(n) (					\
+	{						\
+		static int warned=0; 			\
+		unsigned long __ms=(n); 		\
+		WARN_ON(in_irq() && !(warned++)); 	\
+		while (__ms--) udelay(1000);		\
+	})
 
 #ifndef ndelay
 #define ndelay(x)	udelay(((x)+999)/1000)
