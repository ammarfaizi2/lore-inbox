Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWIBDc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWIBDc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 23:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWIBDc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 23:32:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750759AbWIBDc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 23:32:27 -0400
Date: Fri, 1 Sep 2006 20:32:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-Id: <20060901203206.49ab445a.akpm@osdl.org>
In-Reply-To: <20060901201305.f01ec7d2.akpm@osdl.org>
References: <1156927468.29250.113.camel@localhost.localdomain>
	<20060831204612.73ed7f33.akpm@osdl.org>
	<1157100979.29250.319.camel@localhost.localdomain>
	<20060901020404.c8038837.akpm@osdl.org>
	<1157103042.29250.337.camel@localhost.localdomain>
	<20060901201305.f01ec7d2.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 20:13:05 -0700
Andrew Morton <akpm@osdl.org> wrote:

> So I modified it to only trigger if current->mm!=NULL and:

Hey, that worked.


With this patch:

diff -puN include/linux/ktime.h~ktime-debug include/linux/ktime.h
--- a/include/linux/ktime.h~ktime-debug
+++ a/include/linux/ktime.h
@@ -57,6 +57,7 @@ typedef union {
 } ktime_t;
 
 #define KTIME_MAX			(~((u64)1 << 63))
+#define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
 /*
  * ktime_t definitions when using the 64-bit scalar representation:
@@ -64,17 +65,7 @@ typedef union {
 
 #if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
 
-/**
- * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
- * @secs:	seconds to set
- * @nsecs:	nanoseconds to set
- *
- * Return the ktime_t representation of the value
- */
-static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
-{
-	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
-}
+ktime_t ktime_set(const long secs, const unsigned long nsecs);
 
 /* Subtract two ktime_t variables. rem = lhs -rhs: */
 #define ktime_sub(lhs, rhs) \
diff -puN kernel/hrtimer.c~ktime-debug kernel/hrtimer.c
--- a/kernel/hrtimer.c~ktime-debug
+++ a/kernel/hrtimer.c
@@ -870,3 +870,32 @@ void __init hrtimers_init(void)
 	register_cpu_notifier(&hrtimers_nb);
 }
 
+
+#if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
+
+/**
+ * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
+ * @secs:	seconds to set
+ * @nsecs:	nanoseconds to set
+ *
+ * Return the ktime_t representation of the value
+ */
+ktime_t ktime_set(const long secs, const unsigned long nsecs)
+{
+#if (BITS_PER_LONG == 64)
+	static int no88bigabytes = 0;
+
+	if (current->mm && unlikely(secs >= KTIME_SEC_MAX)) {
+		if (!no88bigabytes) {
+			no88bigabytes = 1;
+			printk("ktime_set: %ld : %lu\n", secs, nsecs);
+			WARN_ON(1);
+		}
+		return (ktime_t){ .tv64 = KTIME_MAX };
+	}
+#endif
+	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
+}
+EXPORT_SYMBOL(ktime_set);
+
+#endif
_


It emits that interrupt-time warning and gets to a login prompt.



But with this patch, which is the same thing with the debug stuff removed:

diff -puN include/linux/ktime.h~ktime-debug include/linux/ktime.h
--- a/include/linux/ktime.h~ktime-debug
+++ a/include/linux/ktime.h
@@ -57,6 +57,7 @@ typedef union {
 } ktime_t;
 
 #define KTIME_MAX			(~((u64)1 << 63))
+#define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
 /*
  * ktime_t definitions when using the 64-bit scalar representation:
@@ -64,17 +65,7 @@ typedef union {
 
 #if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
 
-/**
- * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
- * @secs:	seconds to set
- * @nsecs:	nanoseconds to set
- *
- * Return the ktime_t representation of the value
- */
-static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
-{
-	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
-}
+ktime_t ktime_set(const long secs, const unsigned long nsecs);
 
 /* Subtract two ktime_t variables. rem = lhs -rhs: */
 #define ktime_sub(lhs, rhs) \
diff -puN kernel/hrtimer.c~ktime-debug kernel/hrtimer.c
--- a/kernel/hrtimer.c~ktime-debug
+++ a/kernel/hrtimer.c
@@ -870,3 +870,24 @@ void __init hrtimers_init(void)
 	register_cpu_notifier(&hrtimers_nb);
 }
 
+
+#if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
+
+/**
+ * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
+ * @secs:	seconds to set
+ * @nsecs:	nanoseconds to set
+ *
+ * Return the ktime_t representation of the value
+ */
+ktime_t ktime_set(const long secs, const unsigned long nsecs)
+{
+#if (BITS_PER_LONG == 64)
+	if (unlikely(secs >= KTIME_SEC_MAX))
+		return (ktime_t){ .tv64 = KTIME_MAX };
+#endif
+	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
+}
+EXPORT_SYMBOL(ktime_set);
+
+#endif
_


it hangs in udev startup.

How very unpleasant.  gcc-4.0.2.

-- 
VGER BF report: H 0
