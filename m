Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUELVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUELVXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUELVSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:18:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42656 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265237AbUELVQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:16:04 -0400
Date: Wed, 12 May 2004 23:17:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, davidel@xmailserver.org, jgarzik@pobox.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512211748.GB20800@elte.hu>
References: <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu> <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com> <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu> <20040512202807.GA16849@elte.hu> <20040512203500.GA17999@elte.hu> <20040512205028.GA18806@elte.hu> <20040512140729.476ace9e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20040512140729.476ace9e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > yet another patch - this time it's: complete, covers irda, accelerates
> >  HZ=100, unifies the slightly differing namespaces and compiles/boots as
> >  well.
> > 
> > ...
> > 
> > [hz-cleanup-2.6.6-A2  text/plain (2657 bytes)]
> 
> This doesn't have the little round up which some implementations had,
> so someone who tries to sleep for 9 millisscondes on a 100HZ box may
> end up in a busywait.  Looks risky.

ok. -A3 attached, it does the roundup in the msec->jiffies conversion. 
(not the other way around though, and that's fine.)

	Ingo

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hz-cleanup-2.6.6-A3"

--- linux/include/linux/time.h.orig	
+++ linux/include/linux/time.h	
@@ -177,6 +177,24 @@ struct timezone {
 	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
 
 #endif
+
+/*
+ * Convert jiffies to milliseconds and back.
+ *
+ * Avoid unnecessary multiplications/divisions in the
+ * two most common HZ cases:
+ */
+#if HZ == 1000
+# define JIFFIES_TO_MSECS(x)	(x)
+# define MSECS_TO_JIFFIES(x)	(x)
+#elif HZ == 100
+# define JIFFIES_TO_MSECS(x)	((x) * 10)
+# define MSECS_TO_JIFFIES(x)	(((x) + 9) / 10)
+#else
+# define JIFFIES_TO_MSECS(x)	(((x) * 1000) / HZ)
+# define MSECS_TO_JIFFIES(x)	(((x) * HZ + 999) / 1000)
+#endif
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
--- linux/include/net/irda/irda.h.orig	
+++ linux/include/net/irda/irda.h	
@@ -83,8 +83,6 @@ if(!(expr)) do { \
 #define MESSAGE(args...) printk(KERN_INFO args)
 #define ERROR(args...)   printk(KERN_ERR args)
 
-#define MSECS_TO_JIFFIES(ms) (((ms)*HZ+999)/1000)
-
 /*
  *  Magic numbers used by Linux-IrDA. Random numbers which must be unique to 
  *  give the best protection
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
@@ -1880,7 +1873,7 @@ static void rebalance_tick(int this_cpu,
 			interval *= sd->busy_factor;
 
 		/* scale ms to jiffies */
-		interval = MSEC_TO_JIFFIES(interval);
+		interval = MSECS_TO_JIFFIES(interval);
 		if (unlikely(!interval))
 			interval = 1;
 

--wRRV7LY7NUeQGEoC--
