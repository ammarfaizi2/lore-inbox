Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUI2KdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUI2KdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 06:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268288AbUI2KdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 06:33:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22705 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268011AbUI2KdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 06:33:04 -0400
Date: Wed, 29 Sep 2004 20:36:46 +1000
From: Greg Banks <gnb@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jeremy@sgi.com,
       John Partridge <johnip@sgi.com>, "David S. Miller" <davem@redhat.com>,
       Linux Network Development List <netdev@oss.sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20040929103646.GA4682@sgi.com>
References: <200409271103.39913.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409271103.39913.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

On Mon, Sep 27, 2004 at 11:03:39AM -0700, Jesse Barnes wrote:
> On some platforms (e.g. SGI Challenge, Origin, and Altix machines), writes to 
> I/O space aren't ordered coming from different CPUs.  For the most part, this 
> isn't a problem since drivers generally spinlock around code that does writeX 
> calls, but if the last operation a driver does before it releases a lock is a 
> write and some other CPU takes the lock and immediately does a write, it's 
> possible the second CPU's write could arrive before the first's.
> 
> This patch adds a mmiowb() call to deal with this sort of situation, and 
> adds some documentation describing I/O ordering issues to deviceiobook.tmpl.  
> The idea is to mirror the regular, cacheable memory barrier operation, wmb.  
>[...]
> Patches to use this new primitive in various drivers will come separately, 
> probably via the SCSI tree.

Ok, here's a patch for the tg3 network driver to use mmiowb().  Tests
over the last couple of days has shown that it solves the oopses in
tg3_tx() that I reported and attempted to patch some time ago:

http://marc.theaimsgroup.com/?l=linux-netdev&m=108538612421774&w=2

The CPU usage of the mmiowb() approach is also significantly better
than doing PCI reads to flush the writes (by setting the existing
TG3_FLAG_MBOX_WRITE_REORDER flag).  In an artificial CPU-constrained
test on a ProPack kernel, the same amount of CPU work for the REORDER
solution pushes 85.1 MB/s over 2 NICs compared to 146.5 MB/s for the
mmiowb() solution.


--- linux.orig/drivers/net/tg3.c	2004-09-22 17:20:45.%N +1000
+++ linux/drivers/net/tg3.c	2004-09-29 19:45:16.%N +1000
@@ -44,6 +44,19 @@
 #include <asm/pbm.h>
 #endif
 
+#ifndef mmiowb
+/*
+ * mmiowb() is a memory-mapped I/O write boundary, useful for
+ * preserving send ring update ordering between multiple CPUs
+ * Define it if it doesn't exist.
+ */
+#ifdef CONFIG_IA64_SGI_SN2
+#define mmiowb()    sn_mmiob()
+#else
+#define mmiowb()
+#endif
+#endif
+
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 #define TG3_VLAN_TAG_USED 1
 #else
@@ -2725,6 +2738,7 @@ next_pkt_nopost:
 		tw32_rx_mbox(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW,
 			     sw_idx);
 	}
+	mmiowb();
 
 	return received;
 }
@@ -3172,6 +3186,7 @@ static int tg3_start_xmit(struct sk_buff
 		netif_stop_queue(dev);
 
 out_unlock:
+    	mmiowb();
 	spin_unlock_irqrestore(&tp->tx_lock, flags);
 
 	dev->trans_start = jiffies;


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
