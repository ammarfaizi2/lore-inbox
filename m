Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264204AbUEDCmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbUEDCmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 22:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUEDCmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 22:42:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:48832 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264204AbUEDCmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 22:42:02 -0400
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, george@mvista.com,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org,
       davem@redhat.com
In-Reply-To: <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>
References: <403D0F63.3050101@mvista.com>
	 <1077760348.2857.129.camel@cog.beaverton.ibm.com>
	 <403E7BEE.9040203@mvista.com>
	 <1077837016.2857.171.camel@cog.beaverton.ibm.com>
	 <403E8D5B.9040707@mvista.com>
	 <1081895880.4705.57.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
	 <1081967295.4705.96.camel@cog.beaverton.ibm.com>
	 <20040415103711.GA320@elektroni.ee.tut.fi>
	 <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>
	 <20040415161436.GA21613@elektroni.ee.tut.fi>
	 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de>
	 <20040501184105.2cd1c784.akpm@osdl.org>
	 <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1083638458.9664.134.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 03 May 2004 19:40:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-01 at 18:59, Tim Schmielau wrote:
> On Sat, 1 May 2004, Andrew Morton wrote:
> 
> > Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> > >
> > >  +#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
> > 
> > I think this has an inclusion ordering problem.
>
> Yep, we'd need to include timex.h for it. This get's messy. 

Well, not too messy. Including timex.h looks to resolve the issue
without trouble. Let me know if I somehow stepped over an issue. 

DaveM: Do please note the changes to the TCP code. Having
jiffies_to_clock_t be more then just a #define introduced a few cast
warnings, and I believe the fixes are right, but you can't be too sure.

jiffies-to-clockt-fix_A1:
-------------------------
All, 
	This patch polishes up Tim Schmielau's (tim@physik3.uni-rostock.de) fix
for jiffies_to_clock_t() and jiffies_64_to_clock_t(). The issues
observed was w/ /proc output not matching up to wall time due to
accumulated error caused by HZ not being exactly 1000 on i386 systems.
The solution is to correct that error by using the more accurate
TICK_NSEC in our calculation. 
	
Additionally, this patch corrects 3 warnings in the TCP layer uncovered
by this change. 

***DaveM please review!***

thanks
-john


diff -Nru a/include/linux/times.h b/include/linux/times.h
--- a/include/linux/times.h	Mon May  3 19:24:14 2004
+++ b/include/linux/times.h	Mon May  3 19:24:14 2004
@@ -2,15 +2,21 @@
 #define _LINUX_TIMES_H
 
 #ifdef __KERNEL__
+#include <linux/timex.h>
 #include <asm/div64.h>
 #include <asm/types.h>
 #include <asm/param.h>
 
-#if (HZ % USER_HZ)==0
-# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+static inline clock_t jiffies_to_clock_t(long x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	return x / (HZ / USER_HZ);
 #else
-# define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
+	u64 tmp = (u64)x * TICK_NSEC;
+	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
+	return (long)tmp;
 #endif
+}
 
 static inline unsigned long clock_t_to_jiffies(unsigned long x)
 {
@@ -34,7 +40,7 @@
 
 static inline u64 jiffies_64_to_clock_t(u64 x)
 {
-#if (HZ % USER_HZ)==0
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
 	do_div(x, HZ / USER_HZ);
 #else
 	/*
@@ -42,8 +48,8 @@
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
diff -Nru a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	Mon May  3 19:24:14 2004
+++ b/net/ipv4/tcp_ipv4.c	Mon May  3 19:24:14 2004
@@ -2452,7 +2452,7 @@
 	int ttd = req->expires - jiffies;
 
 	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08X %08X %5d %8d %u %d %p",
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %u %d %p",
 		i,
 		req->af.v4_req.loc_addr,
 		ntohs(inet_sk(sk)->sport),
@@ -2526,7 +2526,7 @@
 	srcp  = ntohs(tw->tw_sport);
 
 	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08X %08X %5d %8d %d %d %p",
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %p",
 		i, src, srcp, dest, destp, tw->tw_substate, 0, 0,
 		3, jiffies_to_clock_t(ttd), 0, 0, 0, 0,
 		atomic_read(&tw->tw_refcnt), tw);
diff -Nru a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
--- a/net/ipv6/tcp_ipv6.c	Mon May  3 19:24:14 2004
+++ b/net/ipv6/tcp_ipv6.c	Mon May  3 19:24:14 2004
@@ -1933,7 +1933,7 @@
 	dest = &req->af.v6_req.rmt_addr;
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08X %08X %5d %8d %d %d %p\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %p\n",
 		   i,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3],
@@ -2019,7 +2019,7 @@
 
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08X %08X %5d %8d %d %d %p\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %p\n",
 		   i,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,




