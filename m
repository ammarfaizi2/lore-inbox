Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272155AbTGYPgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272156AbTGYPgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:36:24 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:64671 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272155AbTGYPgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:36:12 -0400
Date: Fri, 25 Jul 2003 11:40:09 -0400
From: Ben Collins <bcollins@debian.org>
To: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725154009.GF1512@phunnypharm.org>
References: <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725142926.GD1512@phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so revert everything and try this patch.

Index: linux-2.6/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6/drivers/ieee1394/ieee1394_core.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/ieee1394_core.c	(working copy)
@@ -421,11 +421,13 @@
 
         if (packet->no_waiter) {
                 /* must not have a tlabel allocated */
+		HPSB_DEBUG("TLABEL: no_waiter, returning");
                 free_hpsb_packet(packet);
                 return;
         }
 
         if (ackcode != ACK_PENDING || !packet->expect_response) {
+		HPSB_DEBUG("TLABEL: not pending or no response expected, returning");
                 packet->state = hpsb_complete;
                 up(&packet->state_change);
                 up(&packet->state_change);
@@ -437,6 +439,7 @@
         packet->sendtime = jiffies;
 
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
+	HPSB_DEBUG("TLABEL: appending packet to pending list");
         list_add_tail(&packet->list, &host->pending_packets);
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 
@@ -609,8 +612,11 @@
 
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
 
+	HPSB_DEBUG("TLABEL: Checking for tlabel %d", tlabel);
+
         list_for_each(lh, &host->pending_packets) {
                 packet = list_entry(lh, struct hpsb_packet, list);
+		HPSB_DEBUG("TLABEL: tlabel %d in list", packet->tlabel);
                 if ((packet->tlabel == tlabel)
                     && (packet->node_id == (data[1] >> 16))){
                         break;
@@ -618,11 +624,12 @@
         }
 
         if (lh == &host->pending_packets) {
-                HPSB_DEBUG("unsolicited response packet received - np");
+                HPSB_DEBUG("unsolicited response packet received - no tlabel match");
                 dump_packet("contents:", data, 16);
                 spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
                 return;
-        }
+        } else
+		HPSB_DEBUG("TLABEL: Found tlabel");
 
         switch (packet->tcode) {
         case TCODE_WRITEQ:
@@ -642,7 +649,7 @@
 
         if (!tcode_match || (packet->tlabel != tlabel)
             || (packet->node_id != (data[1] >> 16))) {
-                HPSB_INFO("unsolicited response packet received");
+                HPSB_INFO("unsolicited response packet received - tcode mismatch");
                 dump_packet("contents:", data, 16);
 
                 spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
@@ -946,6 +953,7 @@
         host->driver->devctl(host, CANCEL_REQUESTS, 0);
 
         spin_lock_irqsave(&host->pending_pkt_lock, flags);
+	HPSB_DEBUG("TLABEL: splicing pending packets for abort_requests");
         list_splice(&host->pending_packets, &llist);
         INIT_LIST_HEAD(&host->pending_packets);
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
@@ -969,20 +977,16 @@
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
 
 	for (lh = host->pending_packets.next; lh != &host->pending_packets; lh = next) {
                 packet = list_entry(lh, struct hpsb_packet, list);
 		next = lh->next;
                 if (time_before(packet->sendtime + expire, jiffies)) {
+			HPSB_DEBUG("TLABEL: packet removed in abort_timedouts");
                         list_del(&packet->list);
                         list_add(&packet->list, &expiredlist);
                 }
Index: linux-2.6/drivers/ieee1394/csr.c
===================================================================
--- linux-2.6/drivers/ieee1394/csr.c	(revision 1013)
+++ linux-2.6/drivers/ieee1394/csr.c	(working copy)
@@ -89,7 +89,36 @@
                                                          0x3f1));
 }
 
+/* 
+ * HI == seconds (bits 0:2)
+ * LO == fraction units of 1/8000 of a second, as per 1394 (bits 19:31)
+ *
+ * Convert to units and then to HZ, for comparison to jiffies.
+ *
+ * BY default this will end up being 800 units, or 100ms (125usec per
+ * unit).
+ *
+ * NOTE: The spec say 1/8000, but also says we can compute based on 1/8192
+ * like CSR specifies. Should make our math less complex.
+ */
+static inline void calculate_expire(struct csr_control *csr)
+{
+	unsigned long units;
+	
+	/* Take the seconds, and convert to units */
+	units = (unsigned long)(csr->split_timeout_hi & 0x07) << 13;
 
+	/* Add in the fractional units */
+	units += (unsigned long)(csr->split_timeout_lo >> 19);
+
+	/* Convert to jiffies */
+	csr->expire = (unsigned long)(units * HZ) >> 13UL;
+
+	/* Just to keep from rounding low */
+	csr->expire++;
+}
+
+
 static void add_host(struct hpsb_host *host)
 {
         host->csr.lock = SPIN_LOCK_UNLOCKED;
@@ -100,6 +129,7 @@
         host->csr.node_ids              = 0;
         host->csr.split_timeout_hi      = 0;
         host->csr.split_timeout_lo      = 800 << 19;
+	calculate_expire(&host->csr);
         host->csr.cycle_time            = 0;
         host->csr.bus_time              = 0;
         host->csr.bus_manager_id        = 0x3f;
@@ -336,10 +366,12 @@
         case CSR_SPLIT_TIMEOUT_HI:
                 host->csr.split_timeout_hi = 
                         be32_to_cpu(*(data++)) & 0x00000007;
+		calculate_expire(&host->csr);
                 out;
         case CSR_SPLIT_TIMEOUT_LO:
                 host->csr.split_timeout_lo = 
                         be32_to_cpu(*(data++)) & 0xfff80000;
+		calculate_expire(&host->csr);
                 out;
 
                 /* address gap */
Index: linux-2.6/drivers/ieee1394/csr.h
===================================================================
--- linux-2.6/drivers/ieee1394/csr.h	(revision 1013)
+++ linux-2.6/drivers/ieee1394/csr.h	(working copy)
@@ -41,6 +41,7 @@
         quadlet_t state;
         quadlet_t node_ids;
         quadlet_t split_timeout_hi, split_timeout_lo;
+	unsigned long expire;	// Calculated from split_timeout
         quadlet_t cycle_time;
         quadlet_t bus_time;
         quadlet_t bus_manager_id;

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
