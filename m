Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWJJRRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWJJRRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWJJRRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:17:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:10634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964816AbWJJRQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:16:08 -0400
Date: Tue, 10 Oct 2006 10:15:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, joerg@hydrops.han.de,
       Daniel Drake <dsd@gentoo.org>, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/19] xirc2ps_cs: Cannot reset card in atomic context
Message-ID: <20061010171531.GP6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="xirc2ps_cs-cannot-reset-card-in-atomic-context.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Joerg Ahrens <joerg@hydrops.han.de>

I am using a Xircom CEM33 pcmcia NIC which has occasional hardware problems.
If the netdev watchdog detects a transmit timeout, do_reset is called which
msleeps - this is illegal in atomic context.

This patch schedules the timeout handling as a workqueue item.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/pcmcia/xirc2ps_cs.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- linux-2.6.17.13.orig/drivers/net/pcmcia/xirc2ps_cs.c
+++ linux-2.6.17.13/drivers/net/pcmcia/xirc2ps_cs.c
@@ -345,6 +345,7 @@ typedef struct local_info_t {
     void __iomem *dingo_ccr; /* only used for CEM56 cards */
     unsigned last_ptr_value; /* last packets transmitted value */
     const char *manf_str;
+    struct work_struct tx_timeout_task;
 } local_info_t;
 
 /****************
@@ -352,6 +353,7 @@ typedef struct local_info_t {
  */
 static int do_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void do_tx_timeout(struct net_device *dev);
+static void xirc2ps_tx_timeout_task(void *data);
 static struct net_device_stats *do_get_stats(struct net_device *dev);
 static void set_addresses(struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
@@ -589,6 +591,7 @@ xirc2ps_probe(struct pcmcia_device *link
 #ifdef HAVE_TX_TIMEOUT
     dev->tx_timeout = do_tx_timeout;
     dev->watchdog_timeo = TX_TIMEOUT;
+    INIT_WORK(&local->tx_timeout_task, xirc2ps_tx_timeout_task, dev);
 #endif
 
     return xirc2ps_config(link);
@@ -1341,17 +1344,24 @@ xirc2ps_interrupt(int irq, void *dev_id,
 /*====================================================================*/
 
 static void
-do_tx_timeout(struct net_device *dev)
+xirc2ps_tx_timeout_task(void *data)
 {
-    local_info_t *lp = netdev_priv(dev);
-    printk(KERN_NOTICE "%s: transmit timed out\n", dev->name);
-    lp->stats.tx_errors++;
+    struct net_device *dev = data;
     /* reset the card */
     do_reset(dev,1);
     dev->trans_start = jiffies;
     netif_wake_queue(dev);
 }
 
+static void
+do_tx_timeout(struct net_device *dev)
+{
+    local_info_t *lp = netdev_priv(dev);
+    lp->stats.tx_errors++;
+    printk(KERN_NOTICE "%s: transmit timed out\n", dev->name);
+    schedule_work(&lp->tx_timeout_task);
+}
+
 static int
 do_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {

--
