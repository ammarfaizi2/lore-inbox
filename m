Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUELU7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUELU7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUELU7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:59:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34242 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265229AbUELU4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:56:54 -0400
Date: Wed, 12 May 2004 22:28:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Davide Libenzi <davidel@xmailserver.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512202807.GA16849@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu> <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com> <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> The problem is that even for the i386 family, there's no inherent
> reason why the value of HZ is nailed to 1000 [...]

The code is 100% correct, but not 100% clean, and definitely not
documented. The reason for the change was to avoid unnecessary integer
multiplications and divisions in sched.c.

the attached patch (against BK-curr) cleans this up and makes the
defines generic and arch-independent.

	Ingo

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hz-cleanup-2.6.6-A0"

--- linux/include/linux/time.h.orig	
+++ linux/include/linux/time.h	
@@ -177,6 +177,15 @@ struct timezone {
 	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
 
 #endif
+
+#if HZ == 1000
+# define JIFFIES_TO_MSEC(x)	(x)
+# define MSEC_TO_JIFFIES(x)	(x)
+#else
+# define JIFFIES_TO_MSEC(x)	((x) * 1000 / HZ)
+# define MSEC_TO_JIFFIES(x)	((x) * HZ / 1000)
+#endif
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
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

--bg08WKrSYDhXBjb5--
