Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbRLLKND>; Wed, 12 Dec 2001 05:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285137AbRLLKMn>; Wed, 12 Dec 2001 05:12:43 -0500
Received: from mandy.eunet.fi ([193.66.1.129]:56462 "EHLO mandy.eunet.fi")
	by vger.kernel.org with ESMTP id <S285135AbRLLKMb>;
	Wed, 12 Dec 2001 05:12:31 -0500
Date: Wed, 12 Dec 2001 12:12:31 +0200 (EET)
From: Miika Pekkarinen <miipekk@ihme.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] /proc/net/dev counter fix, linux-2.5.0
Message-ID: <Pine.LNX.4.33.0112121210500.972-100000@ihme.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have made a patch to fix the counter values in /proc/net/dev. The
problem was that the tx_bytes and rx_bytes will reset when ~4GB is
transferred. This patch has been tested to work with linux-2.5.0 but it
should work on all 2.4.* kernels. Also it should work with most of the
interface cards but not all yet.

This is the first version of my patch so please give me some comments
about it.
-- 
Miika

Patch to fix /proc/net/dev counters. Patch made by Miika Pekkarinen
<miika@ihme.org> or <miipekk@cc.jyu.fi>.
--- linux-2.5.0or/net/core/dev.c	Thu Nov  8 00:39:36 2001
+++ linux/net/core/dev.c	Tue Dec 11 21:30:49 2001
@@ -1688,7 +1688,7 @@
 	int size;

 	if (stats)
-		size = sprintf(buffer, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu %8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
+		size = sprintf(buffer, "%6s:%14llu %7lu %4lu %4lu %4lu %5lu %10lu %9lu %14llu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
  		   dev->name,
 		   stats->rx_bytes,
 		   stats->rx_packets, stats->rx_errors,
@@ -1724,8 +1724,8 @@


 	size = sprintf(buffer,
-		"Inter-|   Receive                                                |  Transmit\n"
-		" face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed\n");
+		"Inter-| --------------------------- Receive -------------------------- | ------------------------- Transmit --------------------------\n"
+		" face |bytes          packets errs drop fifo frame compressed multicast|bytes          packets errs drop fifo colls carrier compressed\n");

 	pos += size;
 	len += size;
--- linux-2.5.0or/include/linux/netdevice.h	Thu Nov 22 21:47:09 2001
+++ linux/include/linux/netdevice.h	Tue Dec 11 21:24:54 2001
@@ -97,8 +97,9 @@
 {
 	unsigned long	rx_packets;		/* total packets received	*/
 	unsigned long	tx_packets;		/* total packets transmitted	*/
-	unsigned long	rx_bytes;		/* total bytes received 	*/
-	unsigned long	tx_bytes;		/* total bytes transmitted	*/
+        /* rx and tx counters fixed up to 64-bit */
+        long long       rx_bytes;               /* total bytes received         */
+        long long       tx_bytes;               /* total bytes transmitted      */
 	unsigned long	rx_errors;		/* bad packets received		*/
 	unsigned long	tx_errors;		/* packet transmit problems	*/
 	unsigned long	rx_dropped;		/* no space in linux buffers	*/


