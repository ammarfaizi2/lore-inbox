Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266404AbUA2VPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUA2VPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:15:43 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:56481 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266404AbUA2VPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:15:41 -0500
Date: Thu, 29 Jan 2004 22:15:38 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Patch: IPv6/AMD64: bug in net/ipv6/ndisc.c
Message-ID: <20040129221538.J24747@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, all!

while compiling the kernel (2.6.1) I have spotted the following warning:

net/ipv6/ndisc.c: In function `ndisc_router_discovery':
net/ipv6/ndisc.c:1113: warning: comparison is always true due to limited range of data type
net/ipv6/ndisc.c:1121: warning: comparison is always true due to limited range of data type

The corresponding lines are these:

                __u32 rtime = ntohl(ra_msg->retrans_timer);
                                                                                
Here --->       if (rtime && rtime/1000 < (MAX_SCHEDULE_TIMEOUT/HZ)) {
                        rtime = (rtime*HZ)/1000;
                        if (rtime < HZ/10)
                                rtime = HZ/10;
                        in6_dev->nd_parms->retrans_time = rtime;
                }
                                                                                
                rtime = ntohl(ra_msg->reachable_time);
and here -->    if (rtime && rtime/1000 < MAX_SCHEDULE_TIMEOUT/(3*HZ)) {
                        rtime = (rtime*HZ)/1000;


The MAX_SCHEDULE_TIMEOUT is #defined to LONG_MAX in include/linux/sched.h,
which is 2^63-1 or so on AMD64. I propose the following fix:

--- net/ipv6/ndisc.c.orig	2004-01-29 22:03:50.553745520 +0100
+++ net/ipv6/ndisc.c	2004-01-29 22:06:39.973989728 +0100
@@ -995,6 +995,9 @@
 	}
 }
 
+#define MAX_SCHEDULE_TIMEOUT_32 (MAX_SCHEDULE_TIMEOUT/HZ > (1U<<31) ? \
+	 (1U<<31) : MAX_SCHEDULE_TIMEOUT/HZ)
+
 static void ndisc_router_discovery(struct sk_buff *skb)
 {
         struct ra_msg *ra_msg = (struct ra_msg *) skb->h.raw;
@@ -1110,7 +1113,7 @@
 	if (in6_dev->nd_parms) {
 		__u32 rtime = ntohl(ra_msg->retrans_timer);
 
-		if (rtime && rtime/1000 < MAX_SCHEDULE_TIMEOUT/HZ) {
+		if (rtime && rtime/1000 < MAX_SCHEDULE_TIMEOUT_32) {
 			rtime = (rtime*HZ)/1000;
 			if (rtime < HZ/10)
 				rtime = HZ/10;
@@ -1118,7 +1121,7 @@
 		}
 
 		rtime = ntohl(ra_msg->reachable_time);
-		if (rtime && rtime/1000 < MAX_SCHEDULE_TIMEOUT/(3*HZ)) {
+		if (rtime && rtime/1000 < MAX_SCHEDULE_TIMEOUT_32/3) {
 			rtime = (rtime*HZ)/1000;
 
 			if (rtime < HZ/10)

	Do you think this is a correct fix? If so, please apply. Hope
this helps,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
