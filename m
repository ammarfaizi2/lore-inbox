Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTIEFkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTIEFkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:40:31 -0400
Received: from tosh.netlab.uky.edu ([204.198.76.200]:57058 "EHLO
	tosh.netlab.uky.edu") by vger.kernel.org with ESMTP id S262275AbTIEFk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:40:28 -0400
Date: Fri, 5 Sep 2003 01:40:27 -0400 (EDT)
From: Najati Imam <najati@netlab.uky.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pktgen divides by zero on short runs
Message-ID: <Pine.LNX.4.21.0309050130360.31252-100000@kenai.netlab.uky.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On very short runs when computing the packets per second the time that is
used can be zero. For small packets this can happen with as many as 100,
maybe more, packets. The patch below checks the denominator before
dividing and if it is zero puts a notice in the results output that
explains why pbs, bps and mbps are all zero, like so

Result: OK: 10(c10+d0) usec, 1 (64byte,0frags) 0pps 0Mb/sec (0bps) \
  (Time too short to measure) errors: 0

Hope this hasn't already been addressed (it was present in 2.6.0-test4,
which is what I generated the patch from), also this is my first
submission, so if I did it all wrong, I will accept the appropriate
punishment.

Najati Imam




diff -urN linux-2.6.0-test4/net/core/pktgen.c linux-2.6.0-test4-nri/net/core/pktgen.c
--- linux-2.6.0-test4/net/core/pktgen.c 2003-08-22 19:57:49.000000000 -0400
+++ linux-2.6.0-test4-nri/net/core/pktgen.c     2003-09-05 01:15:20.000000000 -0400
@@ -50,6 +50,9 @@
  * Fix refcount off by one if first packet fails, potential null deref, 
  * memleak 030710- KJP
  *
+ * Check for potential div by zero in the event of a really short send time
+ * 030905 NRI 
+ *
  * See Documentation/networking/pktgen.txt for how to use this.
  */
 
@@ -720,9 +723,10 @@
 
        {
                char *p = info->result;
-               __u64 pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);
+               __u32 tt = ((__u32)(total) / 1000);
+               __u64 pps = (tt) ? (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000) : 0;
                __u64 bps = pps * 8 * (info->pkt_size + 4); /* take 32bit ethernet CRC into account */
-               p += sprintf(p, "OK: %llu(c%llu+d%llu) usec, %llu (%dbyte,%dfrags) %llupps %lluMb/sec (%llubps)  errors: %llu",
+               p += sprintf(p, "OK: %llu(c%llu+d%llu) usec, %llu (%dbyte,%dfrags) %llupps %lluMb/sec (%llubps) %s errors: %llu",
                             (unsigned long long) total,
                             (unsigned long long) (total - idle),
                             (unsigned long long) idle,
@@ -732,6 +736,7 @@
                             (unsigned long long) pps,
                             (unsigned long long) (bps / (u64) 1024 / (u64) 1024),
                             (unsigned long long) bps,
+                            (tt) ? "" : "(Time too short to measure)",
                             (unsigned long long) info->errors
                             );
        }


