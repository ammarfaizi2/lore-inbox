Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272314AbTGYSKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272323AbTGYSKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:10:36 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:28065 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272314AbTGYSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:08:56 -0400
Date: Fri, 25 Jul 2003 14:12:52 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>, Sam Bromley <sbromley@cogeco.ca>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725181252.GA607@phunnypharm.org>
References: <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725181303.GO23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give this a try. It converts the abort_timedouts to a timer that runs
every 50ms while packets are pending. I'd bet this will increase
performance a good bit for 1394.

Expect some offsets for this patch, but it should apply without rejects.

Index: linux-2.6/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6/drivers/ieee1394/ieee1394_core.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/ieee1394_core.c	(working copy)
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/bitops.h>
-#include <linux/workqueue.h>
 #include <linux/kdev_t.h>
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -441,7 +440,10 @@
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 
         up(&packet->state_change);
-        schedule_work(&host->timeout_tq);
+	if (!timer_pending(&host->timeout)) {
+		host->timeout.expires = jiffies + IEEE1394_TIMEOUT_INTERVAL;
+		add_timer(&host->timeout);
+	}
 }
 
 /**
@@ -960,36 +957,33 @@
         }
 }
 
-void abort_timedouts(struct hpsb_host *host)
+void abort_timedouts(unsigned long __opaque)
 {
+	struct hpsb_host *host = (struct hpsb_host *)__opaque;
         unsigned long flags;
         struct hpsb_packet *packet;
         unsigned long expire;
-        struct list_head *lh, *next, *tlh;
+        struct list_head *lh, *tlh;
         LIST_HEAD(expiredlist);
 
         spin_lock_irqsave(&host->csr.lock, flags);
-        expire = (host->csr.split_timeout_hi * 8000 
-                  + (host->csr.split_timeout_lo >> 19))
-                * HZ / 8000;
-        /* Avoid shortening of timeout due to rounding errors: */
-        expire++;
+	expire = host->csr.expire;
         spin_unlock_irqrestore(&host->csr.lock, flags);
 
-
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
 
-	for (lh = host->pending_packets.next; lh != &host->pending_packets; lh = next) {
+	list_for_each_safe(lh, tlh, &host->pending_packets) {
                 packet = list_entry(lh, struct hpsb_packet, list);
-		next = lh->next;
                 if (time_before(packet->sendtime + expire, jiffies)) {
                         list_del(&packet->list);
                         list_add(&packet->list, &expiredlist);
                 }
         }
 
-        if (!list_empty(&host->pending_packets))
-		schedule_work(&host->timeout_tq);
+        if (!list_empty(&host->pending_packets)) {
+		host->timeout.expires = jiffies + IEEE1394_TIMEOUT_INTERVAL;
+		add_timer(&host->timeout);
+	}
 
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 
Index: linux-2.6/drivers/ieee1394/ieee1394_core.h
===================================================================
--- linux-2.6/drivers/ieee1394/ieee1394_core.h	(revision 1013)
+++ linux-2.6/drivers/ieee1394/ieee1394_core.h	(working copy)
@@ -87,7 +87,7 @@
 	return list_entry(l, struct hpsb_packet, driver_list);
 }
 
-void abort_timedouts(struct hpsb_host *host);
+void abort_timedouts(unsigned long __opaque);
 void abort_requests(struct hpsb_host *host);
 
 struct hpsb_packet *alloc_hpsb_packet(size_t data_size);
Index: linux-2.6/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6/drivers/ieee1394/hosts.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/hosts.c	(working copy)
@@ -16,7 +16,6 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 
 #include "ieee1394_types.h"
 #include "hosts.h"
@@ -139,7 +138,9 @@
 
 	atomic_set(&h->generation, 0);
 
-	INIT_WORK(&h->timeout_tq, (void (*)(void*))abort_timedouts, h);
+	init_timer(&h->timeout);
+	h->timeout.data = (unsigned long) h;
+	h->timeout.function = abort_timedouts;
 
         h->topology_map = h->csr.topology_map + 3;
         h->speed_map = (u8 *)(h->csr.speed_map + 2);
Index: linux-2.6/drivers/ieee1394/hosts.h
===================================================================
--- linux-2.6/drivers/ieee1394/hosts.h	(revision 1013)
+++ linux-2.6/drivers/ieee1394/hosts.h	(working copy)
@@ -4,7 +4,7 @@
 #include <linux/device.h>
 #include <linux/wait.h>
 #include <linux/list.h>
-#include <linux/workqueue.h>
+#include <linux/timer.h>
 #include <asm/semaphore.h>
 
 #include "ieee1394_types.h"
@@ -19,6 +19,11 @@
 */
 #define CSR_CONFIG_ROM_SIZE       0x100
 
+/* The interval which our timer checks for pending packets that have timed
+ * out. This is pretty much 50ms, which is half our default split_timeout
+ * value. */
+#define IEEE1394_TIMEOUT_INTERVAL (HZ / 20)
+
 struct hpsb_packet;
 struct hpsb_iso;
 
@@ -33,7 +38,7 @@
 
         struct list_head pending_packets;
         spinlock_t pending_pkt_lock;
-        struct work_struct timeout_tq;
+        struct timer_list timeout;
 
         unsigned char iso_listen_count[64];
 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
