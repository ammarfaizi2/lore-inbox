Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUEMWip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUEMWip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUEMWip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:38:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:14807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265203AbUEMWim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:38:42 -0400
Date: Thu, 13 May 2004 15:40:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: paul@wagland.net, mingo@elte.hu, wli@holomorphy.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davidel@xmailserver.org, Valdis.Kletnieks@vt.edu
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040513154002.4988b7f2.akpm@osdl.org>
In-Reply-To: <40A3CA34.60202@pobox.com>
References: <40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>
	<200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>
	<20040512202807.GA16849@elte.hu>
	<20040512203500.GA17999@elte.hu>
	<20040512205028.GA18806@elte.hu>
	<20040512140729.476ace9e.akpm@osdl.org>
	<20040512211748.GB20800@elte.hu>
	<20040512221823.GK1397@holomorphy.com>
	<61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net>
	<20040513121141.37f32035.akpm@osdl.org>
	<40A3CA34.60202@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> For whomever winds up doing this work, I have two requests:
> 
> * use a type-safe inline rather than purely a macro, as some drivers do
> * replace msecs_to_jiffies() occurrences as well as MSECS_TO_JIFFIES() 
> (and ditto for jiffies_to_msecs)



Use typesafe inlines for the jiffies-to-millisecond conversion functions.

This means that milliseconds officially takes the type `unsigned int'.  All
current callers seem to be OK with that.

Drivers need to be fixed up to use this instead of their private versions.


---

 25-akpm/include/linux/time.h |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff -puN include/linux/time.h~MSEC_TO_JIFFIES-inline include/linux/time.h
--- 25/include/linux/time.h~MSEC_TO_JIFFIES-inline	Thu May 13 15:13:19 2004
+++ 25-akpm/include/linux/time.h	Thu May 13 15:23:58 2004
@@ -184,16 +184,29 @@ struct timezone {
  * Avoid unnecessary multiplications/divisions in the
  * two most common HZ cases:
  */
+static inline unsigned int jiffies_to_msecs(unsigned long j)
+{
 #if HZ <= 1000 && !(1000 % HZ)
-# define JIFFIES_TO_MSECS(j)	((1000/HZ)*(j))
-# define MSECS_TO_JIFFIES(m)	(((m) + (1000/HZ) - 1)/(1000/HZ))
+	return (1000 / HZ) * j;
 #elif HZ > 1000 && !(HZ % 1000)
-# define JIFFIES_TO_MSECS(j)	(((j) + (HZ/1000) - 1)/(HZ/1000))
-# define MSECS_TO_JIFFIES(m)	((m)*(HZ/1000))
+	return (j + (HZ / 1000) - 1)/(HZ / 1000);
 #else
-# define JIFFIES_TO_MSECS(j)	(((j) * 1000) / HZ)
-# define MSECS_TO_JIFFIES(m)	(((m) * HZ + 999) / 1000)
+	return (j * 1000) / HZ;
 #endif
+}
+static inline unsigned long msecs_to_jiffies(unsigned int m)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (m + (1000 / HZ) - 1) / (1000 / HZ);
+#elif HZ > 1000 && !(HZ % 1000)
+	return m * (HZ / 1000);
+#else
+	return (m * HZ + 999) / 1000;
+#endif
+}
+
+#define JIFFIES_TO_MSECS(j)	jiffies_to_msecs(j)
+#define MSECS_TO_JIFFIES(m)	msecs_to_jiffies(m)
 
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note

_

