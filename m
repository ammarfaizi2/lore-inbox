Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUDOLFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 07:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUDOLFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 07:05:52 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:37297 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262438AbUDOLFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 07:05:50 -0400
Date: Thu, 15 Apr 2004 13:05:17 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
cc: john stultz <johnstul@us.ibm.com>, george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
In-Reply-To: <20040415103711.GA320@elektroni.ee.tut.fi>
Message-ID: <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>
References: <403CCD3A.7080200@mvista.com> <1077725042.8084.482.camel@cube>
 <403D0F63.3050101@mvista.com> <1077760348.2857.129.camel@cog.beaverton.ibm.com>
 <403E7BEE.9040203@mvista.com> <1077837016.2857.171.camel@cog.beaverton.ibm.com>
 <403E8D5B.9040707@mvista.com> <1081895880.4705.57.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
 <1081967295.4705.96.camel@cog.beaverton.ibm.com> <20040415103711.GA320@elektroni.ee.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Petri Kaukasoina wrote:

> If we are still talking about the problem with ps showing process start 
> times in future, I'm sorry neither of the patches helped. The error grows
> here at a rate of 15 seconds in 24 hours as before.

Oops...
sure, it cannot. Maybe this one is better...


--- linux-2.6.5/include/linux/times.h	2004-02-04 04:43:09.000000000 +0100
+++ linux-2.6.5-jfix1/include/linux/times.h	2004-04-15 12:59:05.000000000 +0200
@@ -6,11 +6,16 @@
 #include <asm/types.h>
 #include <asm/param.h>
 
-#if (HZ % USER_HZ)==0
-# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
-#else
-# define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
-#endif
+static inline clock_t jiffies_to_clock_t(long x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	return x / (HZ / USER_HZ);
+#else
+	u64 tmp = (u64)x * TICK_NSEC;
+	 do_div(tmp, (NSEC_PER_SEC / USER_HZ));
+	return (long)tmp;
+#endif
+}
 
 static inline unsigned long clock_t_to_jiffies(unsigned long x)
 {
@@ -34,7 +39,7 @@ static inline unsigned long clock_t_to_j
 
 static inline u64 jiffies_64_to_clock_t(u64 x)
 {
-#if (HZ % USER_HZ)==0
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
 	do_div(x, HZ / USER_HZ);
 #else
 	/*
@@ -42,8 +47,8 @@ static inline u64 jiffies_64_to_clock_t(
 	 * but even this doesn't overflow in hundreds of years
 	 * in 64 bits, so..
 	 */
-	x *= USER_HZ;
-	do_div(x, HZ);
+	x *= TICK_NSEC;
+	do_div(x, (NSEC_PER_SEC / USER_HZ));
 #endif
 	return x;
 }
