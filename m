Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUELUpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUELUpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUELUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:45:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62858 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263702AbUELUpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:45:06 -0400
Date: Wed, 12 May 2004 22:35:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Davide Libenzi <davidel@xmailserver.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512203500.GA17999@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu> <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com> <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu> <20040512202807.GA16849@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20040512202807.GA16849@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> the attached patch (against BK-curr) cleans this up and makes the
> defines generic and arch-independent.

new patch attached - this adopts the overflow-safe variant from sctp.h,
removes it from sctp.h and moves it into a generic include file and also
does the HZ=1000 simplification.

	Ingo

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hz-cleanup-2.6.6-A1"

--- linux/include/linux/time.h.orig	
+++ linux/include/linux/time.h	
@@ -177,6 +177,17 @@ struct timezone {
 	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
 
 #endif
+
+#if HZ == 1000
+# define JIFFIES_TO_MSEC(x)	(x)
+# define MSEC_TO_JIFFIES(x)	(x)
+#else
+#define MSECS_TO_JIFFIES(msec) \
+        (((msec / 1000) * HZ) + ((msec % 1000) * HZ) / 1000)
+#define JIFFIES_TO_MSECS(jiff) \
+        (((jiff / HZ) * 1000) + ((jiff % HZ) * 1000) / HZ)
+#endif
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
--- linux/include/net/sctp/sctp.h.orig	
+++ linux/include/net/sctp/sctp.h	
@@ -116,11 +116,6 @@
 #define SCTP_STATIC static
 #endif
 
-#define MSECS_TO_JIFFIES(msec) \
-	(((msec / 1000) * HZ) + ((msec % 1000) * HZ) / 1000)
-#define JIFFIES_TO_MSECS(jiff) \
-	(((jiff / HZ) * 1000) + ((jiff % HZ) * 1000) / HZ)
-
 /*
  * Function declarations.
  */
--- linux/include/asm-i386/param.h.orig	
+++ linux/include/asm-i386/param.h	
@@ -5,8 +5,6 @@
 # define HZ		1000		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
-# define JIFFIES_TO_MSEC(x)	(x)
-# define MSEC_TO_JIFFIES(x)	(x)
 #endif
 
 #ifndef HZ
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -75,13 +75,6 @@
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
-#ifndef JIFFIES_TO_MSEC
-# define JIFFIES_TO_MSEC(x) ((x) * 1000 / HZ)
-#endif
-#ifndef MSEC_TO_JIFFIES
-# define MSEC_TO_JIFFIES(x) ((x) * HZ / 1000)
-#endif
-
 /*
  * These are the 'tuning knobs' of the scheduler:
  *

--ikeVEW9yuYc//A+q--
