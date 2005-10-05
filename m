Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVJEMET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVJEMET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVJEMET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:04:19 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:65287 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965133AbVJEMES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:04:18 -0400
Date: Wed, 05 Oct 2005 21:06:21 +0900 (JST)
Message-Id: <20051005.210621.101429755.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] TIMERS: add missing compensation for HZ == 250.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Add missing compensation for (HZ == 250) != (1 << SHIFT_HZ) in
second_overflow().

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -752,6 +752,15 @@ static void second_overflow(void)
     else
 	time_adj += (time_adj >> 2) + (time_adj >> 5);
 #endif
+#if HZ == 250
+    /* Compensate for (HZ==250) != (1 << SHIFT_HZ).
+     * Add 1.5625% and 0.78125% to get 255.85938; => only 0.05% error (p. 14)
+     */
+    if (time_adj < 0)
+	time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
+    else
+	time_adj += (time_adj >> 6) + (time_adj >> 7);
+#endif
 #if HZ == 1000
     /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
      * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
