Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVGNUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVGNUoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVGNUoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:44:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43402 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262988AbVGNUn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:43:57 -0400
Date: Thu, 14 Jul 2005 13:28:26 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/4] add jiffies_to_nsecs() helper and fix up size of usecs
Message-ID: <20050714202826.GE28100@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714202629.GD28100@us.ibm.com>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Description: Add a jiffies_to_nsecs() helper function. Make consistent
the size of microseconds (unsigned long) throughout the conversion
functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 jiffies.h |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -urpN 2.6.13-rc3-base/include/linux/jiffies.h 2.6.13-rc3-dev/include/linux/jiffies.h
--- 2.6.13-rc3-base/include/linux/jiffies.h	2005-03-01 23:37:31.000000000 -0800
+++ 2.6.13-rc3-dev/include/linux/jiffies.h	2005-07-14 12:43:44.000000000 -0700
@@ -263,7 +263,7 @@ static inline unsigned int jiffies_to_ms
 #endif
 }
 
-static inline unsigned int jiffies_to_usecs(const unsigned long j)
+static inline unsigned long jiffies_to_usecs(const unsigned long j)
 {
 #if HZ <= 1000000 && !(1000000 % HZ)
 	return (1000000 / HZ) * j;
@@ -274,6 +274,17 @@ static inline unsigned int jiffies_to_us
 #endif
 }
 
+static inline u64 jiffies_to_nsecs(const unsigned long j)
+{
+#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
+	return (NSEC_PER_SEC / HZ) * (u64)j;
+#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
+	return ((u64)j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
+#else
+	return ((u64)j * NSEC_PER_SEC) / HZ;
+#endif
+}
+
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
 	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
@@ -287,7 +298,7 @@ static inline unsigned long msecs_to_jif
 #endif
 }
 
-static inline unsigned long usecs_to_jiffies(const unsigned int u)
+static inline unsigned long usecs_to_jiffies(const unsigned long u)
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
