Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTEFQ1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTEFQ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:26:19 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:20188 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263938AbTEFQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:20:26 -0400
Message-ID: <3EB7E3DA.C50258A9@Bull.Net>
Date: Tue, 06 May 2003 18:33:30 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]: DELAYTIMER_MAX is defined
Content-Type: multipart/mixed;
 boundary="------------F0755C3E684E745873257678"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F0755C3E684E745873257678
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

Playing around with the posix timers I've noticed that DELAYTIMER_MAX is
not defined. This constant is specified in the POSIX specifications. It
should contain the maximum possible value of overruns on a signal. It is
also said that the overrun shouldn't overflow. cf
http://www.opengroup.org/onlinepubs/007904975/functions/timer_getoverrun.html

So here is a patch to add this constant and a check that the overrun
variable never overflow. It's for 2.5.67 but should apply flawlessly to
2.5.69 too.
Actually one could wonder if the test on the overflow is really needed
has an overrun reaching 2^31 seems very hard to happen. However the
constant definition is not hurting anything and looks necessary for
closer POSIX compliance.

Eric
--------------F0755C3E684E745873257678
Content-Type: text/plain; charset=us-ascii;
 name="delaytimer_max-const.patch"
Content-Disposition: inline;
 filename="delaytimer_max-const.patch"
Content-Transfer-Encoding: 7bit

diff -ur linux-2.5.67-ia64-hrtcore/include/linux/limits.h linux-2.5.67-ia64-hrtimers/include/linux/limits.h
--- linux-2.5.67-ia64-hrtcore/include/linux/limits.h	2003-04-22 11:10:44.000000000 +0200
+++ linux-2.5.67-ia64-hrtimers/include/linux/limits.h	2003-05-06 13:45:48.000000000 +0200
@@ -17,6 +17,8 @@
 #define XATTR_SIZE_MAX 65536	/* size of an extended attribute value (64k) */
 #define XATTR_LIST_MAX 65536	/* size of extended attribute namelist (64k) */
 
+#define DELAYTIMER_MAX INT_MAX	/* # timer expiration overruns a POSIX.1b timer may have */
+
 #define RTSIG_MAX	  32
 
 #endif
diff -ur linux-2.5.67-ia64-hrtcore/include/linux/posix-timers.h linux-2.5.67-ia64-hrtimers/include/linux/posix-timers.h
--- linux-2.5.67-ia64-hrtcore/include/linux/posix-timers.h	2003-04-22 11:10:44.000000000 +0200
+++ linux-2.5.67-ia64-hrtimers/include/linux/posix-timers.h	2003-05-06 16:07:56.000000000 +0200
@@ -25,6 +59,7 @@
 
 #define posix_bump_timer(timr) do { \
                         (timr)->it_timer.expires += (timr)->it_incr; \
-                        (timr)->it_overrun++;               \
+                        if ((timr)->it_overrun < DELAYTIMER_MAX)\
+                            (timr)->it_overrun++;               \
                        }while (0)
 #endif


--------------F0755C3E684E745873257678--

