Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSIBL2u>; Mon, 2 Sep 2002 07:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSIBL2u>; Mon, 2 Sep 2002 07:28:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9603 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318016AbSIBL2r>;
	Mon, 2 Sep 2002 07:28:47 -0400
Date: Mon, 2 Sep 2002 16:58:53 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-net@vger.kernel.org
Subject: [rfc] [patch] Qdisc drops not being reported
Message-ID: <20020902165853.B21589@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The Qdisc drops does not seem to be reported to user space for the
default queuing discipline -- pfifo_fast_ops.  I ran isic tests on a up
to test if the drops happen at all, and yes there were significant no of
packets dropped under heavy tx load.  Here is a patch which reports just 
the qdisc drops to the /proc/net/dev entry.  Does this sound like a 
good idea?

Comments welcome.  

-Kiran



diff -X dontdiff -ruN linux-2.5.31/include/asm-i386/mmu.h statctr-2.5.31/include/asm-i386/mmu.h
--- linux-2.5.31/include/asm-i386/mmu.h	Sun Aug 11 07:11:42 2002
+++ statctr-2.5.31/include/asm-i386/mmu.h	Wed Aug 21 12:40:35 2002
@@ -1,6 +1,8 @@
 #ifndef __i386_MMU_H
 #define __i386_MMU_H
 
+#include <asm/semaphore.h>
+
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
diff -X dontdiff -ruN linux-2.5.31/net/core/dev.c statctr-2.5.31/net/core/dev.c
--- linux-2.5.31/net/core/dev.c	Sun Aug 11 07:11:30 2002
+++ statctr-2.5.31/net/core/dev.c	Wed Aug 21 17:57:24 2002
@@ -1746,10 +1746,12 @@
 							  NULL;
 	int size;
 
+	struct Qdisc *q = dev->qdisc;
+
 	if (stats)
 		size = sprintf(buffer, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu "
 				       "%10lu %9lu %8lu %7lu %4lu %4lu %4lu "
-				       "%5lu %7lu %10lu\n",
+				       "%5lu %7lu %10lu %10u\n",
  		   dev->name,
 		   stats->rx_bytes,
 		   stats->rx_packets, stats->rx_errors,
@@ -1763,7 +1765,8 @@
 		   stats->tx_fifo_errors, stats->collisions,
 		   stats->tx_carrier_errors + stats->tx_aborted_errors +
 		   	stats->tx_window_errors + stats->tx_heartbeat_errors,
-		   stats->tx_compressed);
+		   stats->tx_compressed,
+		   q->stats.drops);
 	else
 		size = sprintf(buffer, "%6s: No statistics available.\n",
 			       dev->name);
@@ -1785,7 +1788,7 @@
 
 	size = sprintf(buffer,
 		"Inter-|   Receive                                                |  Transmit\n"
-		" face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed\n");
+		" face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed Qdiscdrops\n");
 
 	pos += size;
 	len += size;
