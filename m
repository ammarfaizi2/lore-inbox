Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316231AbSEKPPP>; Sat, 11 May 2002 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316232AbSEKPPO>; Sat, 11 May 2002 11:15:14 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:31237 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316231AbSEKPPO>; Sat, 11 May 2002 11:15:14 -0400
Date: Sat, 11 May 2002 17:15:08 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: george anzinger <george@mvista.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1a/6: get_jiffies64() for George Anzinger's approach
Message-ID: <Pine.LNX.4.33.0205111711390.28376-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dooh.
George Anzinger just started a new thread on how to do 64 bit jiffies
while I prepared my split-up patch for Linus.
Well, since the patch is split up we just have to replace part 1/6,
patches 2/6 - 5/6 still apply. The debug option 6/6 needs to be
redone, though.

This patch is supposed to be applied on top of George Anzinger's patch.
It just introduces a get_jiffies64() function that exports 64 bit jiffies
with correct locking, which is needed on 32 bit platforms but superfluous
on 64 bit. Patches 2/6 - 5/6 use this interface only.


--- linux-2.5.15-j64/include/linux/sched.h	Sat May 11 14:27:12 2002
+++ linux-2.5.15-j66/include/linux/sched.h	Sat May 11 16:07:59 2002
@@ -461,10 +461,22 @@
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock)
+ * without holding read_lock_irq(&xtime_lock).
+ * get_jiffies64() will do this for you as appropriate.
  */
 extern u64 jiffies_64;
 extern unsigned long volatile jiffies;
+#if BITS_PER_LONG < 48
+#define NEEDS_JIFFIES64
+	extern u64 get_jiffies64(void);
+#else
+	/* jiffies is wide enough to not wrap for 8716 years at HZ==1024 */
+	static inline u64 get_jiffies64(void)
+	{
+		return (u64)jiffies;
+	}
+#endif
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);

--- linux-2.5.15-j64/kernel/timer.c	Sat May 11 14:27:12 2002
+++ linux-2.5.15-j66/kernel/timer.c	Sat May 11 16:03:56 2002
@@ -680,6 +680,19 @@
 		mark_bh(TQUEUE_BH);
 }
 
+#ifdef NEEDS_JIFFIES64
+u64 get_jiffies64(void)
+{
+	u64 j64;
+	unsigned long flags;
+	
+	read_lock_irqsave(&xtime_lock, flags);
+	j64 = jiffies_64;
+	read_unlock_irqrestore(&xtime_lock, flags);
+	return j64;
+}
+#endif
+
 #if !defined(__alpha__) && !defined(__ia64__)
 
 /*

