Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUAFRML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAFRML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:12:11 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:16264 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264505AbUAFRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:12:06 -0500
Date: Tue, 6 Jan 2004 18:11:57 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>, johnstul@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
Message-ID: <Pine.LNX.4.53.0401061807070.9108@gockel.physik3.uni-rostock.de>
References: <1073405053.2047.28.camel@mulgrave> <20040106081947.3d51a1d5.akpm@osdl.org>
 <Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Linus Torvalds wrote:

> Augh. If you cast it to "unsigned long long" anyway, why not just use the 
> right value? It's "jiffies_64".

Lessons in straight thinking...

We then need to make jiffies_64 volatile, since we violate the rule to 
never read it.

Tim 


--- linux-2.6.1-rc1/arch/i386/kernel/timers/timer_tsc.c	2003-12-31 14:21:19.000000000 +0100
+++ linux-2.6.1-rc1-j64/arch/i386/kernel/timers/timer_tsc.c	2004-01-06 18:05:24.000000000 +0100
@@ -140,7 +140,8 @@
 #ifndef CONFIG_NUMA
 	if (!use_tsc)
 #endif
-		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
+		/* no locking but a rare wrong value is not a big deal */
+		return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);

--- linux-2.6.1-rc1/include/linux/jiffies.h	2003-12-31 14:22:05.000000000 +0100
+++ linux-2.6.1-rc1-j64/include/linux/jiffies.h	2004-01-06 17:56:15.000000000 +0100
@@ -9,11 +9,11 @@
 #include <asm/param.h>			/* for HZ */
 
 /*
- * The 64-bit value is not volatile - you MUST NOT read it
- * without sampling the sequence number in xtime_lock.
+ * NEVER EVER read jiffies_64 without sampling the sequence number
+ * in xtime_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
-extern u64 jiffies_64;
+extern u64 volatile jiffies_64;
 extern unsigned long volatile jiffies;
 
 #if (BITS_PER_LONG < 64)
@@ -21,7 +21,7 @@
 #else
 static inline u64 get_jiffies_64(void)
 {
-	return (u64)jiffies;
+	return jiffies_64;
 }
 #endif
 
