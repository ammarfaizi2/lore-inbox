Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVKOLqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVKOLqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKOLqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:46:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:53240 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932375AbVKOLql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:46:41 -0500
Subject: [PATCH 2.6.14-rt13] Latency Tracing Fix
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset=UTF-8
Organization: MontaVista Software, Inc.
Date: Tue, 15 Nov 2005 03:46:40 -0800
Message-Id: <1132055200.4966.10.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile error with latency tracing and no ktimers on i386:

  CC      kernel/ktimers.o
kernel/ktimers.c: In function ‘enqueue_ktimer’:
kernel/ktimers.c:756: error: incompatible type for argument 1 of
‘trace_special_u64’
make[1]: *** [kernel/ktimers.o] Error 1
make: *** [kernel] Error 2

#diff defconfig .config
#4c4
#< # Tue Nov 15 03:19:31 2005
#---
#> # Tue Nov 15 03:20:21 2005
#163d162
#< # CONFIG_REGPARM is not set
#1434c1433,1434
#< # CONFIG_LATENCY_TRACE is not set
#---
#> CONFIG_LATENCY_TRACE=y
#> CONFIG_MCOUNT=y
#1437a1438
#> CONFIG_FRAME_POINTER=y

Index: linux-rt/include/linux/ktimer.h
===================================================================
--- linux-rt.orig/include/linux/ktimer.h
+++ linux-rt/include/linux/ktimer.h
@@ -167,8 +167,11 @@ static inline int ktimer_interrupt(void)
 	return 0;
 }
 
-#define ktimer_trace(a,b)		trace_special_u64(a,b)
-
+# if (BITS_PER_LONG == 64) 
+#  define ktimer_trace(a,b)		trace_special_u64(a,b)
+# else
+#  define ktimer_trace(a,b)		trace_special(ktime_get_high(a),ktime_get_low(a),b)
+# endif 
 #endif
 
 /* Exported timer functions: */





