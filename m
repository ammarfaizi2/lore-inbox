Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWJAXHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWJAXHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWJAXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:06:49 -0400
Received: from www.osadl.org ([213.239.205.134]:59570 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932470AbWJAXGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:44 -0400
Message-Id: <20061001225723.607534000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:00:51 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 05/21] time: fix msecs_to_jiffies() bug
Content-Disposition: inline; filename=fix-msec-conversion.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

fix multiple conversion bugs in msecs_to_jiffies().

the main problem is that this condition:

       if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))

overflows if HZ is smaller than 1000!

this change is user-visible: for HZ=250 SUS-compliant poll()-timeout
value of -20 is mistakenly converted to 'immediate timeout'.

(the new dyntick code also triggered this, as it frequently creates
'lagging timer wheel' scenarios.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 kernel/time.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/kernel/time.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/time.c	2006-10-02 00:55:50.000000000 +0200
+++ linux-2.6.18-mm2/kernel/time.c	2006-10-02 00:55:51.000000000 +0200
@@ -500,15 +500,56 @@ unsigned int jiffies_to_usecs(const unsi
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
 
+/*
+ * When we convert to jiffies then we interpret incoming values
+ * the following way:
+ *
+ * - negative values mean 'infinite timeout' (MAX_JIFFY_OFFSET)
+ *
+ * - 'too large' values [that would result in larger than
+ *   MAX_JIFFY_OFFSET values] mean 'infinite timeout' too.
+ *
+ * - all other values are converted to jiffies by either multiplying
+ *   the input value by a factor or dividing it with a factor
+ *
+ * We must also be careful about 32-bit overflows.
+ */
 unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	/*
+	 * Negative value, means infinite timeout:
+	 */
+	if ((int)m < 0)
 		return MAX_JIFFY_OFFSET;
+
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+	/*
+	 * HZ is equal to or smaller than 1000, and 1000 is a nice
+	 * round multiple of HZ, divide with the factor between them,
+	 * but round upwards:
+	 */
 	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
 #elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+	/*
+	 * HZ is larger than 1000, and HZ is a nice round multiple of
+	 * 1000 - simply multiply with the factor between them.
+	 *
+	 * But first make sure the multiplication result cannot
+	 * overflow:
+	 */
+	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+
 	return m * (HZ / MSEC_PER_SEC);
 #else
+	/*
+	 * Generic case - multiply, round and divide. But first
+	 * check that if we are doing a net multiplication, that
+	 * we wouldnt overflow:
+	 */
+	if (HZ > MSEC_PER_SEC && m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+
 	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
 #endif
 }

--

