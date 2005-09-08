Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVIHHrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVIHHrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVIHHrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:47:09 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47492 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751338AbVIHHrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:47:07 -0400
Date: Thu, 8 Sep 2005 09:50:06 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/4] s390: ctc driver fixes
Message-ID: <20050908075006.GA7724@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
sorry if I have flooded your inbox, I had some problems with the
mail server here yesterday, but it seems to be fixed ...
Ok patch 3-4 have no dependencies on patch 2 since only qeth driver is
affected.Thus I have made a new patch 2 for ctc driver.
Thank you .

[patch 2/4] s390: ctc driver fixes

From: Peter Tiedemann <ptiedem@de.ibm.com>
	- race condition fixed
	- minor cleanup 
	
Signed-off-by: Peter Tiedemann <ptiedem@de.ibm.com>
Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 ctcmain.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

--- linux-2.6/drivers/s390/net/ctcmain.c	2005-09-05 12:38:21.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2005-09-07 14:50:40.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.74 2005/03/24 09:04:17 mschwide Exp $
+ * $Id: ctcmain.c,v 1.78 2005/09/07 12:18:02 pavlic Exp $
  *
  * CTC / ESCON network driver
  *
@@ -37,10 +37,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.74 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.78 $
  *
  */
-
 #undef DEBUG
 #include <linux/module.h>
 #include <linux/init.h>
@@ -135,7 +134,7 @@ static const char *dev_event_names[] = {
 	"TX down",
 	"Restart",
 };
-
+
 /**
  * Events of the channel statemachine
  */
@@ -249,7 +248,7 @@ static void
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.74 $";
+	char vbuf[] = "$Revision: 1.78 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -334,7 +333,7 @@ static const char *ch_state_names[] = {
 	"Restarting",
 	"Not operational",
 };
-
+
 #ifdef DEBUG
 /**
  * Dump header and first 16 bytes of an sk_buff for debugging purposes.
@@ -671,7 +670,7 @@ static void
 fsm_action_nop(fsm_instance * fi, int event, void *arg)
 {
 }
-
+
 /**
  * Actions for channel - statemachines.
  *****************************************************************************/
@@ -1514,7 +1513,6 @@ ch_action_reinit(fsm_instance *fi, int e
  	fsm_addtimer(&privptr->restart_timer, 1000, DEV_EVENT_RESTART, dev);
 }
 
-
 /**
  * The statemachine for a channel.
  */
@@ -1625,7 +1623,7 @@ static const fsm_node ch_fsm[] = {
 };
 
 static const int CH_FSM_LEN = sizeof (ch_fsm) / sizeof (fsm_node);
-
+
 /**
  * Functions related to setup and device detection.
  *****************************************************************************/
@@ -1976,7 +1974,7 @@ ctc_irq_handler(struct ccw_device *cdev,
 		fsm_event(ch->fsm, CH_EVENT_IRQ, ch);
 
 }
-
+
 /**
  * Actions for interface - statemachine.
  *****************************************************************************/
@@ -2209,13 +2207,18 @@ transmit_skb(struct channel *ch, struct 
 	int rc = 0;
 
 	DBF_TEXT(trace, 5, __FUNCTION__);
+	/* we need to acquire the lock for testing the state
+	 * otherwise we can have an IRQ changing the state to 
+	 * TXIDLE after the test but before acquiring the lock.
+	 */
+	spin_lock_irqsave(&ch->collect_lock, saveflags);
 	if (fsm_getstate(ch->fsm) != CH_STATE_TXIDLE) {
 		int l = skb->len + LL_HEADER_LENGTH;
 
-		spin_lock_irqsave(&ch->collect_lock, saveflags);
-		if (ch->collect_len + l > ch->max_bufsize - 2)
-			rc = -EBUSY;
-		else {
+		if (ch->collect_len + l > ch->max_bufsize - 2) {
+			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
+			return -EBUSY;
+		} else {
 			atomic_inc(&skb->users);
 			header.length = l;
 			header.type = skb->protocol;
@@ -2231,7 +2234,7 @@ transmit_skb(struct channel *ch, struct 
 		int ccw_idx;
 		struct sk_buff *nskb;
 		unsigned long hi;
-
+		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
 		/**
 		 * Protect skb against beeing free'd by upper
 		 * layers.
@@ -2256,6 +2259,7 @@ transmit_skb(struct channel *ch, struct 
 			if (!nskb) {
 				atomic_dec(&skb->users);
 				skb_pull(skb, LL_HEADER_LENGTH + 2);
+				ctc_clear_busy(ch->netdev);
 				return -ENOMEM;
 			} else {
 				memcpy(skb_put(nskb, skb->len),
@@ -2281,6 +2285,7 @@ transmit_skb(struct channel *ch, struct 
 				 */
 				atomic_dec(&skb->users);
 				skb_pull(skb, LL_HEADER_LENGTH + 2);
+				ctc_clear_busy(ch->netdev);
 				return -EBUSY;
 			}
 
@@ -2327,9 +2332,10 @@ transmit_skb(struct channel *ch, struct 
 		}
 	}
 
+	ctc_clear_busy(ch->netdev);
 	return rc;
 }
-
+
 /**
  * Interface API for upper network layers
  *****************************************************************************/
@@ -2421,7 +2427,6 @@ ctc_tx(struct sk_buff *skb, struct net_d
 	dev->trans_start = jiffies;
 	if (transmit_skb(privptr->channel[WRITE], skb) != 0)
 		rc = 1;
-	ctc_clear_busy(dev);
 	return rc;
 }
 
@@ -2610,7 +2615,6 @@ stats_write(struct device *dev, struct d
 	return count;
 }
 
-
 static void
 ctc_netdev_unregister(struct net_device * dev)
 {
@@ -2685,7 +2689,6 @@ ctc_proto_store(struct device *dev, stru
 	return count;
 }
 
-
 static ssize_t
 ctc_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {

