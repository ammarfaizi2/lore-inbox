Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314656AbSEKK0E>; Sat, 11 May 2002 06:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEKK0D>; Sat, 11 May 2002 06:26:03 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:19717 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314656AbSEKK0C>; Sat, 11 May 2002 06:26:02 -0400
Date: Sat, 11 May 2002 12:25:48 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1/6: 64 bit jiffies 
Message-ID: <Pine.LNX.4.33.0205111224180.26626-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

since nobody commented on my last post, I think the 64 bit jiffies patch
seems to be mature enough for submission now.
I assume you still prefer the chunks in seperate mails, this way also my 
Bitkeeper stats will look better ;-)

OK, here comes the basic chunk:
Provide a 64 bit jiffies value, updating the high 32 bits with a timer
on 32 bit platforms. Details are encapsulated in the get_jiffies64() call.
Credit for the idea for this lock-free version is due to Albert Cahalan.

Tim


--- linux-2.5.15/include/linux/sched.h	Thu May  9 17:47:15 2002
+++ linux-2.5.15-j64/include/linux/sched.h	Thu May  9 17:48:20 2002
@@ -460,6 +460,18 @@
 #include <asm/current.h>
 
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
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);

--- linux-2.5.15/kernel/timer.c	Mon Mar 18 21:37:09 2002
+++ linux-2.5.15-j64/kernel/timer.c	Thu May  9 17:48:20 2002
@@ -68,6 +68,9 @@
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
 unsigned long volatile jiffies;
+#ifdef NEEDS_JIFFIES64
+static unsigned int volatile jiffies_msb_flips;
+#endif
 
 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -105,6 +108,8 @@
 
 #define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
 
+static inline void init_jiffieswrap_timer(void);
+
 void init_timervecs (void)
 {
 	int i;
@@ -117,6 +122,8 @@
 	}
 	for (i = 0; i < TVR_SIZE; i++)
 		INIT_LIST_HEAD(tv1.vec + i);
+
+	init_jiffieswrap_timer();
 }
 
 static unsigned long timer_jiffies;
@@ -674,6 +681,60 @@
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
+
+
+#ifdef NEEDS_JIFFIES64
+
+u64 get_jiffies64(void)
+{
+	unsigned long j;
+	unsigned int  f;
+
+	f = jiffies_msb_flips; /* avoid races */
+	rmb();
+	j = jiffies;
+	
+	/* account for not yet detected flips */
+	f += (f ^ (j>>(BITS_PER_LONG-1))) & 1;
+	return ((u64) f << (BITS_PER_LONG-1)) | j;
+}
+
+/*
+ * Use a timer to periodically check for jiffies wraparounds.
+ * Instead of overflows we count flips of the highest bit so
+ * that we can easily check whether the latest flip is already
+ * accounted for.
+ * Not racy as invocations are several days apart in time and
+ * jiffies_flips is not modified elsewhere.
+ */
+
+static struct timer_list jiffieswrap_timer;
+#define CHECK_JIFFIESWRAP_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static void check_jiffieswrap(unsigned long data)
+{
+	mod_timer(&jiffieswrap_timer, jiffies + CHECK_JIFFIESWRAP_INTERVAL);
+
+	jiffies_msb_flips += 1 & (jiffies_msb_flips
+	                           ^ (jiffies>>(BITS_PER_LONG-1)));
+}
+
+static inline void init_jiffieswrap_timer(void)
+{
+	init_timer(&jiffieswrap_timer);
+	jiffieswrap_timer.expires = jiffies + CHECK_JIFFIESWRAP_INTERVAL;
+	jiffieswrap_timer.function = check_jiffieswrap;
+	add_timer(&jiffieswrap_timer);
+}
+
+#else
+
+static inline void init_jiffieswrap_timer(void)
+{
+}
+
+#endif /* NEEDS_JIFFIES64 */
+
 
 #if !defined(__alpha__) && !defined(__ia64__)
 


