Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUA0Jbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUA0Jbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:31:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30717 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263101AbUA0Jbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:31:49 -0500
Message-ID: <40162FD8.3090600@mvista.com>
Date: Tue, 27 Jan 2004 01:31:04 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: eric.piel@tremplin-utc.net, Corey Minyard <minyard@acm.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fine tune the time conversion to eliminate conversion errors.
References: <1074979873.4012e421714b1@mailetu.utc.fr>
In-Reply-To: <1074979873.4012e421714b1@mailetu.utc.fr>
Content-Type: multipart/mixed;
 boundary="------------070904000909030406010504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------070904000909030406010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

The time conversion code is erroring on the side of a bit too small.  The 
attached patch forces any error to be on the high side.  The current code will 
convert 1 nanosecond to zero jiffies (standard says that should be 1).  It also 
is around 1 nanosecond late on each roll to the next jiffie.

I have done some error checks with this patch applied and get the following 
errors in PPB ( Parts Per Billion):

HZ     nano sec conversion     microsecond conversion
1000    315                      45
1024    227                      40
100     28                       317

In all cases the error is on the high side, which means that the final shift 
will, most likely, eliminate the error bits.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------070904000909030406010504
Content-Type: text/plain;
 name="time.h-2.6.1-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="time.h-2.6.1-1.0.patch"

--- linux-2.6.1-org/include/linux/time.h	2003-08-11 13:48:55.000000000 -0700
+++ linux/include/linux/time.h	2004-01-27 00:29:12.000000000 -0800
@@ -148,14 +148,14 @@
 #endif
 #define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
 #define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
-#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC))\
-                                         / (u64)TICK_NSEC))
+#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
+                                TICK_NSEC -1) / (u64)TICK_NSEC))
 
-#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC))\
-                                         / (u64)TICK_NSEC))
+#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
 #define USEC_CONVERSION  \
-                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC)) \
-                                         / (u64)TICK_NSEC))
+                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
 /*
  * USEC_ROUND is used in the timeval to jiffie conversion.  See there
  * for more details.  It is the scaled resolution rounding value.  Note

--------------070904000909030406010504--

