Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUB1JVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 04:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUB1JVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 04:21:16 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:34950 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261190AbUB1JVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 04:21:07 -0500
Message-ID: <40405D7E.7000404@cyberone.com.au>
Date: Sat, 28 Feb 2004 20:21:02 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: sched domains kernbench improvements
Content-Type: multipart/mixed;
 boundary="------------040004000203070800020707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040004000203070800020707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con,
I was able to reproduce your half-load kernbench problems
on the non-NUMA stp 8-way.

I made a pretty simple "lessidle" patch which tweaks some
sched domain parameters to be more inclined to move tasks,
especially when idle. That brought performance to nearly
exactly the same as 2.6.3.

Context switches are still up, but user and system time
is down a bit. So indicates it is still less balance-happy
but is obviously enough to bring the idle time down.

2.6.3:                http://khack.osdl.org/stp/288459/
2.6.3-mm4-lessidle:   http://khack.osdl.org/stp/288995/

Phew! So it is more a matter of tuning than anything
fundamental. It may be that the patch now makes balancing
too aggressive, but it is probably better to err on the
side that is closer to 2.6 behaviour.

I haven't tested this on much else.


--------------040004000203070800020707
Content-Type: text/plain;
 name="sched-lessidle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-lessidle.patch"

 linux-2.6-npiggin/include/linux/sched.h |   16 ++++++++--------
 linux-2.6-npiggin/kernel/sched.c        |    5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff -puN include/linux/sched.h~sched-lessidle include/linux/sched.h
--- linux-2.6/include/linux/sched.h~sched-lessidle	2004-02-21 10:57:07.000000000 +1100
+++ linux-2.6-npiggin/include/linux/sched.h	2004-02-21 10:59:46.000000000 +1100
@@ -598,11 +598,11 @@ struct sched_domain {
 	.parent			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
-	.max_interval		= 8,			\
-	.busy_factor		= 32,			\
+	.max_interval		= 4,			\
+	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000),		\
-	.cache_nice_tries	= 2,			\
+	.cache_hot_time		= (5*1000000/2),	\
+	.cache_nice_tries	= 1,			\
 	.flags			= SD_FLAG_FASTMIGRATE | SD_FLAG_NEWIDLE,\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
@@ -615,11 +615,11 @@ struct sched_domain {
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
 	.groups			= NULL,			\
-	.min_interval		= 20,			\
-	.max_interval		= 1000*fls(num_online_cpus()),\
-	.busy_factor		= 4,			\
+	.min_interval		= 8,			\
+	.max_interval		= 256*fls(num_online_cpus()),\
+	.busy_factor		= 8,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000),		\
+	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.flags			= SD_FLAG_EXEC,		\
 	.last_balance		= jiffies,		\
diff -puN kernel/sched.c~sched-lessidle kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-lessidle	2004-02-21 10:57:10.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-02-21 16:15:18.000000000 +1100
@@ -1493,6 +1493,11 @@ nextgroup:
 	return busiest;
 
 out_balanced:
+	if (busiest && idle == NEWLY_IDLE) {
+		*imbalance = 1;
+		return busiest;
+	}
+
 	*imbalance = 0;
 	return NULL;
 }

_

--------------040004000203070800020707--
