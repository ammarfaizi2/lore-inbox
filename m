Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSKJJXA>; Sun, 10 Nov 2002 04:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSKJJXA>; Sun, 10 Nov 2002 04:23:00 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:35502 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S264766AbSKJJW7>; Sun, 10 Nov 2002 04:22:59 -0500
Date: Sun, 10 Nov 2002 10:29:40 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: [PATCH] use 64 bit jiffies 1/4
Message-ID: <Pine.LNX.4.33.0211101014120.12784-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
 
with HZ=1000 even on 32bit platforms, we really should use the
64 bit jiffies value for exported interfaces like uptime, process start
time etc.
Otherwise innocent users might get quite surprised when ps output goes
berzerk after 49.5 days, showing processes as having started in the
future.
Note that the appended patch does not change any of the exported
interfaces, it just avoids internal overflows.
 
These changes were already discussed on lkml long ago, before George 
Anzinger introduced the current 64 bit jiffies implementation.

In its current form this patch was posted on lkml last month, and has been
in -dj (modulo the HZ=1000 change) since 2.5.20-dj3.

Tim


Part 1/4: "Infrastructure"

Provide a sane way to avoid unneccessary locking on 64 bit platforms,
and a 64 bit analogon to "jiffies_to_clock_t()".
Naming it "jiffies_64_to_user_HZ()" is the only part of these patches I 
expect to be controversial.


--- linux-2.5.46-bk4/include/linux/jiffies.h	Mon Nov  4 23:30:04 2002
+++ linux-2.5.46-bk4-j64a/include/linux/jiffies.h	Sun Nov 10 09:16:35 2002
@@ -2,14 +2,34 @@
 #define _LINUX_JIFFIES_H
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock)
+ * without holding read_lock_irq(&xtime_lock).
+ * get_jiffies_64() will do this for you as appropriate.
  */
 extern u64 jiffies_64;
 extern unsigned long volatile jiffies;
+
+static inline u64 get_jiffies_64(void)
+{
+#if BITS_PER_LONG < 64
+	extern rwlock_t xtime_lock;
+	unsigned long flags;
+	u64 tmp;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	tmp = jiffies_64;
+	read_unlock_irqrestore(&xtime_lock, flags);
+	return tmp;
+#else
+	return (u64)jiffies;
+#endif
+}                                                                             
+
 
 /*
  *	These inlines deal with timer wrapping correctly. You are 

--- linux-2.5.46-bk4/include/linux/times.h	Mon Nov  4 23:30:06 2002
+++ linux-2.5.46-bk4-j64a/include/linux/times.h	Sun Nov 10 09:16:35 2002
@@ -2,7 +2,16 @@
 #define _LINUX_TIMES_H
 
 #ifdef __KERNEL__
+#include <asm/div64.h>
+#include <asm/types.h>
+
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+
+static inline u64 jiffies_64_to_user_HZ(u64 x)
+{
+	do_div(x, HZ / USER_HZ);
+	return x;
+}
 #endif
 
 struct tms {



