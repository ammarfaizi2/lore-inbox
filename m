Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTJUPH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTJUPH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:07:59 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:29853 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263128AbTJUPHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:07:44 -0400
Date: Tue, 21 Oct 2003 17:08:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/8): dst_link_failure calls.
Message-ID: <20031021150801.GA1690@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dst_link_failure calls because they can trigger a BUG in icmp.c.

diffstat:
 drivers/s390/net/ctcmain.c |   10 ++++------
 drivers/s390/net/ctctty.c  |    3 +--
 drivers/s390/net/lcs.c     |    1 -
 drivers/s390/net/netiucv.c |   10 ++++------
 drivers/s390/net/qeth.c    |    7 ++-----
 5 files changed, 11 insertions(+), 20 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Fri Oct 17 23:43:02 2003
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Tue Oct 21 16:36:08 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.47 2003/09/22 13:40:51 cohuck Exp $
+ * $Id: ctcmain.c,v 1.48 2003/10/06 18:35:24 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.47 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.48 $
  *
  */
 
@@ -272,7 +272,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.47 $";
+	char vbuf[] = "$Revision: 1.48 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2441,14 +2441,12 @@
 
 	/**
 	 * If channels are not running, try to restart them
-	 * notify anybody about a link failure and throw
-	 * away packet. 
+	 * and throw away packet. 
 	 */
 	if (fsm_getstate(privptr->fsm) != DEV_STATE_RUNNING) {
 		fsm_event(privptr->fsm, DEV_EVENT_START, dev);
 		if (privptr->protocol == CTC_PROTO_LINUX_TTY)
 			return -EBUSY;
-		dst_link_failure(skb);
 		dev_kfree_skb(skb);
 		privptr->stats.tx_dropped++;
 		privptr->stats.tx_errors++;
diff -urN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-s390/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	Fri Oct 17 23:43:14 2003
+++ linux-2.6-s390/drivers/s390/net/ctctty.c	Tue Oct 21 16:36:08 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.13 2003/09/26 14:48:36 mschwide Exp $
+ * $Id: ctctty.c,v 1.14 2003/10/06 11:33:33 mschwide Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -761,7 +761,6 @@
 			error = put_user(C_CLOCAL(tty) ? 1 : 0, (ulong *) arg);
 			if (error)
 				return error;
-			put_user(C_CLOCAL(tty) ? 1 : 0, (ulong *) arg);
 			return 0;
 		case TIOCSSOFTCAR:
 #ifdef CTC_DEBUG_MODEM_IOCTL
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Fri Oct 17 23:42:54 2003
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Tue Oct 21 16:36:08 2003
@@ -1168,7 +1168,6 @@
 		return -EIO;
 	}
 	if (card->state != DEV_STATE_UP) {
-		dst_link_failure(skb);
 		dev_kfree_skb(skb);
 		card->stats.tx_dropped++;
 		card->stats.tx_errors++;
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Fri Oct 17 23:43:15 2003
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Tue Oct 21 16:36:08 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.26 2003/09/23 16:48:17 mschwide Exp $
+ * $Id: netiucv.c,v 1.27 2003/10/06 18:35:24 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.26 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.27 $
  *
  */
 
@@ -1177,12 +1177,10 @@
 
 	/**
 	 * If connection is not running, try to restart it
-	 * notify anybody about a link failure and throw
-	 * away packet. 
+	 * and throw away packet. 
 	 */
 	if (fsm_getstate(privptr->fsm) != DEV_STATE_RUNNING) {
 		fsm_event(privptr->fsm, DEV_EVENT_START, dev);
-		dst_link_failure(skb);
 		dev_kfree_skb(skb);
 		privptr->stats.tx_dropped++;
 		privptr->stats.tx_errors++;
@@ -1731,7 +1729,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.26 $";
+	char vbuf[] = "$Revision: 1.27 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Fri Oct 17 23:43:46 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Tue Oct 21 16:36:08 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.160 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.161 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -165,7 +165,7 @@
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.160 $"
+#define VERSION_QETH_C "$Revision: 1.161 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -1947,7 +1947,6 @@
 			case ERROR_LINK_FAILURE:
 			case ERROR_KICK_THAT_PUPPY:
 				QETH_DBF_TEXT4(0, trace, "endeglnd");
-				dst_link_failure(skb);
 				atomic_dec(&skb->users);
 				dev_kfree_skb_irq(skb);
 				break;
@@ -2425,7 +2424,6 @@
 
 	if (!card) {
 		QETH_DBF_TEXT2(0, trace, "XMNSNOCD");
-		dst_link_failure(skb);
 		dev_kfree_skb_irq(skb);
 		return 0;
 	}
@@ -2436,7 +2434,6 @@
 	if (!atomic_read(&card->is_startlaned)) {
 		card->stats->tx_carrier_errors++;
 		QETH_DBF_CARD2(0, trace, "XMNS", card);
-		dst_link_failure(skb);
 		dev_kfree_skb_irq(skb);
 		return 0;
 	}
