Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVBKAJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVBKAJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBKAJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:09:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45810 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261959AbVBKAJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:09:28 -0500
From: "Sven Dietrich" <sdietrich@mvista.com>
To: <george@mvista.com>, "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'William Weston'" <weston@lysdexia.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Date: Thu, 10 Feb 2005 16:09:28 -0800
Message-ID: <000701c50fcd$f42dc600$bc0a000a@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0008_01C50F8A.E60A8600"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <420BC23F.6030308@mvista.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C50F8A.E60A8600
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi George,

you may want to use this for reference.

This patch adds a config option to allow you to select whether timer IRQ runs in thread or not.

I'm not totally happy with the #ifdefs, but it may make witching back and forth easier.

Sven


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> George Anzinger
> Sent: Thursday, February 10, 2005 12:21 PM
> To: Ingo Molnar
> Cc: William Weston; linux-kernel@vger.kernel.org
> Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
> 
> 
> If I want to write a patch that will work with or without the 
> RT patch applied 
> is the following enough?
> 
> #ifndef RAW_SPIN_LOCK_UNLOCKED
> typedef raw_spinlock_t spinlock_t
> #define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
> #endif
> 
> 
> -- 
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

------=_NextPart_000_0008_01C50F8A.E60A8600
Content-Type: application/octet-stream;
	name="common_timer_irqthread.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="common_timer_irqthread.patch"

Index: linux-2.6.10-Omap1710/include/linux/time.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.10-Omap1710.orig/include/linux/time.h	2005-02-03 =
09:06:40.378530238 +0000=0A=
+++ linux-2.6.10-Omap1710/include/linux/time.h	2005-02-03 =
09:20:37.703894461 +0000=0A=
@@ -80,7 +80,20 @@=0A=
 =0A=
 extern struct timespec xtime;=0A=
 extern struct timespec wall_to_monotonic;=0A=
-extern raw_seqlock_t xtime_lock;=0A=
+=0A=
+#ifndef ARCH_HAVE_XTIME_LOCK=0A=
+=0A=
+ #ifdef PREEMPT_TIMER_IRQ=0A=
+  #define XTIME_LOCK_T seqlock_t=0A=
+  #define DECLARE_XTIME_LOCK DECLARE_SEQLOCK(xtime_lock)=0A=
+ #else=0A=
+  #define XTIME_LOCK_T raw_seqlock_t=0A=
+  #define DECLARE_XTIME_LOCK DECLARE_RAW_SEQLOCK(xtime_lock)=0A=
+ #endif =0A=
+=0A=
+extern XTIME_LOCK_T xtime_lock;=0A=
+=0A=
+#endif=0A=
 =0A=
 static inline unsigned long get_seconds(void)=0A=
 { =0A=
Index: linux-2.6.10-Omap1710/kernel/timer.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.10-Omap1710.orig/kernel/timer.c	2005-02-03 =
09:06:40.379529900 +0000=0A=
+++ linux-2.6.10-Omap1710/kernel/timer.c	2005-02-03 09:52:42.418866172 =
+0000=0A=
@@ -943,7 +943,7 @@=0A=
  * playing with xtime and avenrun.=0A=
  */=0A=
 #ifndef ARCH_HAVE_XTIME_LOCK=0A=
-DECLARE_RAW_SEQLOCK(xtime_lock);=0A=
+DECLARE_XTIME_LOCK;=0A=
 =0A=
 EXPORT_SYMBOL(xtime_lock);=0A=
 #endif=0A=
Index: linux-2.6.10-Omap1710/lib/Kconfig.RT=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.10-Omap1710.orig/lib/Kconfig.RT	2005-02-03 =
09:06:40.379529900 +0000=0A=
+++ linux-2.6.10-Omap1710/lib/Kconfig.RT	2005-02-03 09:06:49.185545306 =
+0000=0A=
@@ -119,6 +119,14 @@=0A=
 =0A=
 	  Say N if you are unsure.=0A=
 =0A=
+config PREEMPT_TIMER_IRQ=0A=
+	bool "Run timer IRQ in a thread"=0A=
+       	default y=0A=
+	depends on PREEMPT_HARDIRQS && ARM=0A=
+	help=0A=
+	This declares the xtime_lock as a mutex and allows =0A=
+        running the timer interrupt in a thread.=0A=
+=0A=
 config SPINLOCK_BKL=0A=
 	bool "Old-Style Big Kernel Lock"=0A=
 	depends on (PREEMPT || SMP) && !PREEMPT_RT=0A=

------=_NextPart_000_0008_01C50F8A.E60A8600--

