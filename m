Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVF3Fxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVF3Fxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 01:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVF3Fxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 01:53:46 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40587 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262854AbVF3Fwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 01:52:54 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] deinline sleep/delay functions
Date: Thu, 30 Jun 2005 08:52:25 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Zi4wCKViZtzYUcQ"
Message-Id: <200506300852.25943.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Zi4wCKViZtzYUcQ
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

Optimizing delay functions for speed is utterly pointless.

This patch turns ssleep(n), mdelay(n), udelay(n) and ndelay(n)
into functions, thus they generate the smallest possible code
at the callsite. Previously they were more or less inlined.

Run tested. Saved a few kb off vmlinux.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_Zi4wCKViZtzYUcQ
Content-Type: text/x-diff;
  charset="koi8-r";
  name="delay.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delay.patch"

diff -urpN linux-2.6.12.src/include/asm-i386/delay.h linux-2.6.12.new/include/asm-i386/delay.h
--- linux-2.6.12.src/include/asm-i386/delay.h	Tue Oct 19 00:53:05 2004
+++ linux-2.6.12.new/include/asm-i386/delay.h	Wed Jun 29 20:29:48 2005
@@ -15,12 +15,8 @@ extern void __ndelay(unsigned long nsecs
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
+#define udelay(n) __udelay(n)
 	
-#define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-	__ndelay(n))
+#define ndelay(n) __ndelay(n)
 
 #endif /* defined(_I386_DELAY_H) */
diff -urpN linux-2.6.12.src/include/linux/delay.h linux-2.6.12.new/include/linux/delay.h
--- linux-2.6.12.src/include/linux/delay.h	Thu Mar  3 09:31:14 2005
+++ linux-2.6.12.new/include/linux/delay.h	Wed Jun 29 20:41:14 2005
@@ -11,40 +11,14 @@ extern unsigned long loops_per_jiffy;
 
 #include <asm/delay.h>
 
-/*
- * Using udelay() for intervals greater than a few milliseconds can
- * risk overflow for high loops_per_jiffy (high bogomips) machines. The
- * mdelay() provides a wrapper to prevent this.  For delays greater
- * than MAX_UDELAY_MS milliseconds, the wrapper is used.  Architecture
- * specific values can be defined in asm-???/delay.h as an override.
- * The 2nd mdelay() definition ensures GCC will optimize away the 
- * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
- */
-
-#ifndef MAX_UDELAY_MS
-#define MAX_UDELAY_MS	5
-#endif
-
-#ifdef notdef
-#define mdelay(n) (\
-	{unsigned long __ms=(n); while (__ms--) udelay(1000);})
-#else
-#define mdelay(n) (\
-	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
-	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
-#endif
-
+void calibrate_delay(void);
+void mdelay(unsigned int msecs);
 #ifndef ndelay
 #define ndelay(x)	udelay(((x)+999)/1000)
 #endif
 
-void calibrate_delay(void);
 void msleep(unsigned int msecs);
+void ssleep(unsigned int secs);
 unsigned long msleep_interruptible(unsigned int msecs);
-
-static inline void ssleep(unsigned int seconds)
-{
-	msleep(seconds * 1000);
-}
 
 #endif /* defined(_LINUX_DELAY_H) */
diff -urpN linux-2.6.12.src/kernel/timer.c linux-2.6.12.new/kernel/timer.c
--- linux-2.6.12.src/kernel/timer.c	Sun Jun 19 16:11:00 2005
+++ linux-2.6.12.new/kernel/timer.c	Wed Jun 29 21:02:26 2005
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -89,6 +90,20 @@ static inline void set_running_timer(tve
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
+/***
+ * Using udelay() for intervals greater than a few milliseconds can
+ * risk overflow for high loops_per_jiffy (high bogomips) machines. The
+ * mdelay() provides a wrapper to prevent this.
+ *
+ * It's not inlined because we do not optimize delays for speed ;)
+ */
+void mdelay(unsigned int msecs)
+{
+	while (msecs--) udelay(1000);
+}
+
+EXPORT_SYMBOL(mdelay);
+
 static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
@@ -1592,6 +1607,13 @@ void msleep(unsigned int msecs)
 }
 
 EXPORT_SYMBOL(msleep);
+
+void ssleep(unsigned int secs)
+{
+        msleep(secs * 1000);
+}
+
+EXPORT_SYMBOL(ssleep);
 
 /**
  * msleep_interruptible - sleep waiting for waitqueue interruptions

--Boundary-00=_Zi4wCKViZtzYUcQ--

