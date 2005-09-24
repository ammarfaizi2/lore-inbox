Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVIXTrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVIXTrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIXTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:47:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23302 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750713AbVIXTrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:47:11 -0400
Date: Sat, 24 Sep 2005 21:44:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] 2.6.14-rc2-mm1: fixes for overflow msec_to_jiffies()
Message-ID: <20050924194418.GC26197@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924193839.GB26197@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 09:38:39PM +0200, Willy Tarreau wrote:

msecs_to_jiffies() can compute a wrong timeout limit for some values of HZ :

#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)

static inline unsigned int jiffies_to_msecs(const unsigned long j)
{
#if HZ <= 1000 && !(1000 % HZ)
        return (1000 / HZ) * j;
#elif HZ > 1000 && !(HZ % 1000)
        return (j + (HZ / 1000) - 1)/(HZ / 1000);
#else
        return (j * 1000) / HZ;
#endif
}

static inline unsigned long msecs_to_jiffies(const unsigned int m)
{
        if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
                return MAX_JIFFY_OFFSET;
#if HZ <= 1000 && !(1000 % HZ)
        return (m + (1000 / HZ) - 1) / (1000 / HZ);
#elif HZ > 1000 && !(HZ % 1000)
        return m * (HZ / 1000);
#else
        return (m * HZ + 999) / 1000;
#endif
}

Calling jiffies_to_msecs(MAX_JIFFY_OFFSET) overflows if 1000/HZ >=2 or
if (1000 % HZ != 0 || HZ % 1000 != 0). Eg: for HZ=300, the max is set to
0xda7406 while it is set to 0xfffffff8 for HZ=250 !

The following patch implements two macros MAX_MSEC_OFFSET and MAX_USEC_OFFSET
which are used to fix msecs_to_jiffies() and usecs_to_jiffies() respectively.
They are defined depending on the operation which will be performed by the
function, so that they try to limit to the absolute maximum acceptable value.

If someone has better naming, feel free to update the patch. This patch applies
to 2.6.14-rc2 and 2.6.14-rc2-mm1. Please review and apply.

Signed-off-by: Willy Tarreau <willy@w.ods.org>

- Willy


diff -purN linux-2.6.14-rc2-mm1/include/linux/jiffies.h linux-2.6.14-rc2-mm1-jiffies/include/linux/jiffies.h
--- linux-2.6.14-rc2-mm1/include/linux/jiffies.h	Sat Sep 24 21:11:51 2005
+++ linux-2.6.14-rc2-mm1-jiffies/include/linux/jiffies.h	Sat Sep 24 21:17:28 2005
@@ -246,6 +246,37 @@ static inline u64 get_jiffies_64(void)
 
 #endif
 
+
+/*
+ * We define MAX_MSEC_OFFSET and MAX_USEC_OFFSET as maximal values that can be
+ * accepted by msecs_to_jiffies() and usec_to_jiffies() respectively, without
+ * risking a multiply overflow. Those functions return MAX_JIFFY_OFFSET for
+ * arguments above those values.
+ */
+
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - (MSEC_PER_SEC / HZ) + 1)
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+#  define MAX_MSEC_OFFSET \
+	ULONG_MAX / (HZ / MSEC_PER_SEC)
+#else
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - (MSEC_PER_SEC - 1)) / HZ
+#endif
+
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+#  define MAX_USEC_OFFSET \
+	(ULONG_MAX - (USEC_PER_SEC / HZ) + 1)
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+#  define MAX_USEC_OFFSET \
+	ULONG_MAX / (HZ / USEC_PER_SEC)
+#else
+#  define MAX_USEC_OFFSET \
+	(ULONG_MAX - (USEC_PER_SEC - 1)) / HZ
+#endif
+
+
 /*
  * Convert jiffies to milliseconds and back.
  *
@@ -276,7 +307,7 @@ static inline unsigned int jiffies_to_us
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	if (m > MAX_MSEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
 	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
@@ -289,7 +320,7 @@ static inline unsigned long msecs_to_jif
 
 static inline unsigned long usecs_to_jiffies(const unsigned int u)
 {
-	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
+	if (u > MAX_USEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
 	return (u + (USEC_PER_SEC / HZ) - 1) / (USEC_PER_SEC / HZ);


