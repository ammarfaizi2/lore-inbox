Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVIFNA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVIFNA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVIFNA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:00:28 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:60079 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932456AbVIFNA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:00:28 -0400
Date: Tue, 6 Sep 2005 15:03:28 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/4] s390: ctc driver fixes
Message-ID: <20050906130328.GE9265@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 2/4] s390: ctc driver fixes

From: Peter Tiedemann <ptiedem@de.ibm.com>
	- race condition fixed
	- minor cleanup 
	
Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 ctcmain.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)


diff -Naupr linux-2.6-orig/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6-orig/drivers/s390/net/ctcmain.c	2005-09-05 11:46:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2005-09-05 15:28:46.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.74 2005/03/24 09:04:17 mschwide Exp $
+ * $Id: ctcmain.c,v 1.77 2005/08/29 09:47:04 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -37,7 +37,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.74 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.77 $
  *
  */
 
@@ -249,7 +249,7 @@ static void
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.74 $";
+	char vbuf[] = "$Revision: 1.77 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2209,13 +2209,18 @@ transmit_skb(struct channel *ch, struct 
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
@@ -2231,7 +2236,7 @@ transmit_skb(struct channel *ch, struct 
 		int ccw_idx;
 		struct sk_buff *nskb;
 		unsigned long hi;
-
+		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
 		/**
 		 * Protect skb against beeing free'd by upper
 		 * layers.
@@ -2256,6 +2261,7 @@ transmit_skb(struct channel *ch, struct 
 			if (!nskb) {
 				atomic_dec(&skb->users);
 				skb_pull(skb, LL_HEADER_LENGTH + 2);
+				ctc_clear_busy(ch->netdev);
 				return -ENOMEM;
 			} else {
 				memcpy(skb_put(nskb, skb->len),
@@ -2281,6 +2287,7 @@ transmit_skb(struct channel *ch, struct 
 				 */
 				atomic_dec(&skb->users);
 				skb_pull(skb, LL_HEADER_LENGTH + 2);
+				ctc_clear_busy(ch->netdev);
 				return -EBUSY;
 			}
 
@@ -2327,6 +2334,7 @@ transmit_skb(struct channel *ch, struct 
 		}
 	}
 
+	ctc_clear_busy(ch->netdev);
 	return rc;
 }
 
@@ -2421,7 +2429,6 @@ ctc_tx(struct sk_buff *skb, struct net_d
 	dev->trans_start = jiffies;
 	if (transmit_skb(privptr->channel[WRITE], skb) != 0)
 		rc = 1;
-	ctc_clear_busy(dev);
 	return rc;
 }
