Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTJFJeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTJFJeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:34:06 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:23006 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S264003AbTJFJ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:28:08 -0400
Date: Mon, 6 Oct 2003 11:27:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/7): qeth driver.
Message-ID: <20031006092718.GB1845@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Remove read, write and data device pointers from card structure. Use
   ccw group array to get the device pointers.

diffstat:
 drivers/s390/net/qeth.c |  870 +++++++++++++++++++-----------------------------
 drivers/s390/net/qeth.h |   34 +
 2 files changed, 375 insertions(+), 529 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Sun Sep 28 02:51:22 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Mon Oct  6 10:59:26 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.154 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.160 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -116,6 +116,7 @@
 #include <asm/ebcdic.h>
 #include <linux/ctype.h>
 #include <asm/semaphore.h>
+#include <asm/timex.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/ip.h>
@@ -164,7 +165,7 @@
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.154 $"
+#define VERSION_QETH_C "$Revision: 1.160 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -245,21 +246,15 @@
 static inline unsigned int
 qeth_get_millis(void)
 {
-	__u64 time;
-
-	asm volatile ("STCK %0":"=m" (time));
-	return (int) (time >> 22);   /* time>>12 is microseconds, we divide it
-					by 1024 */
+	return (int) (get_clock() >> 22);   /* time>>12 is microseconds, we
+					       divide it by 1024 */
 }
 
 #ifdef QETH_PERFORMANCE_STATS
 static inline unsigned int
 qeth_get_micros(void)
 {
-	__u64 time;
-
-	asm volatile ("STCK %0":"=m" (time));
-	return (int) (time >> 12);
+	return (int) (get_clock() >> 12);
 }
 #endif /* QETH_PERFORMANCE_STATS */
 
@@ -591,10 +586,8 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) dev->priv;
-	QETH_DBF_TEXT2(0, trace, "open");
-	QETH_DBF_TEXT2(0, setup, "open");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT2(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "open", card);
+	QETH_DBF_CARD2(0, setup, "open", card);
 
 	qeth_save_dev_flag_state(card);
 
@@ -607,9 +600,10 @@
 static int
 qeth_set_config(struct net_device *dev, struct ifmap *map)
 {
-	QETH_DBF_TEXT3(0, trace, "nscf");
-	QETH_DBF_TEXT3(0, trace,
-		       ((struct qeth_card *)dev->priv)->rdev->dev.bus_id);
+	struct qeth_card *card;
+
+	card = (struct qeth_card *)dev->priv;
+	QETH_DBF_CARD3(0, trace, "nscf", card);
 
 	return -EOPNOTSUPP;
 }
@@ -697,8 +691,7 @@
 static void
 qeth_wakeup(struct qeth_card *card)
 {
-	QETH_DBF_TEXT5(0, trace, "wkup");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "wkup", card);
 
 	atomic_set(&card->data_has_arrived, 1);
 	wake_up(&card->wait_q);
@@ -731,32 +724,27 @@
 	if (dstat & DEV_STAT_UNIT_CHECK) {
 		if (sense[SENSE_RESETTING_EVENT_BYTE] &
 		    SENSE_RESETTING_EVENT_FLAG) {
-			QETH_DBF_TEXT1(0, trace, "REVN");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(0, trace, "REVN", card);
 			problem = PROBLEM_RESETTING_EVENT_INDICATOR;
 			goto out;
 		}
 		if (sense[SENSE_COMMAND_REJECT_BYTE] &
 		    SENSE_COMMAND_REJECT_FLAG) {
-			QETH_DBF_TEXT1(0, trace, "CREJ");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(0, trace, "CREJ", card);
 			problem = PROBLEM_COMMAND_REJECT;
 			goto out;
 		}
 		if ((sense[2] == 0xaf) && (sense[3] == 0xfe)) {
-			QETH_DBF_TEXT1(0, trace, "AFFE");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(0, trace, "AFFE", card);
 			problem = PROBLEM_AFFE;
 			goto out;
 		}
 		if ((!sense[0]) && (!sense[1]) && (!sense[2]) && (!sense[3])) {
-			QETH_DBF_TEXT1(0, trace, "ZSNS");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(0, trace, "ZSNS", card);
 			problem = PROBLEM_ZERO_SENSE_DATA;
 			goto out;
 		}
-		QETH_DBF_TEXT1(0, trace, "GCHK");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "GCHK", card);
 		problem = PROBLEM_GENERAL_CHECK;
 		goto out;
 	}
@@ -764,7 +752,7 @@
 		     SCHN_STAT_CHN_DATA_CHK | SCHN_STAT_CHAIN_CHECK |
 		     SCHN_STAT_PROT_CHECK | SCHN_STAT_PROG_CHECK)) {
 		QETH_DBF_TEXT1(0, trace, "GCHK");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, cdev->dev.bus_id);
 		QETH_DBF_HEX1(0, misc, irb, __max(QETH_DBF_MISC_LEN, 64));
 		PRINT_WARN("check on device %s, dstat=x%x, cstat=x%x, "
 			   "rqparam=x%x\n",
@@ -777,11 +765,10 @@
 	if (qeth_check_idx_response(buffer)) {
 		PRINT_WARN("received an IDX TERMINATE on device %s "
 			   "with cause code 0x%02x%s\n",
-			   card->rdev->dev.bus_id, buffer[4],
+			   CARD_BUS_ID(card), buffer[4],
 			   (buffer[4] ==
 			    0x22) ? " -- try another portname" : "");
-		QETH_DBF_TEXT1(0, trace, "RTRM");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "RTRM", card);
 		problem = PROBLEM_RECEIVED_IDX_TERMINATE;
 		goto out;
 	}
@@ -796,8 +783,7 @@
 				   "pulled the cable or disabled the port."
 				   "Discarding outgoing packets.\n",
 				   card->dev_name, card->chpid);
-			QETH_DBF_TEXT1(0, trace, "CBOT");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(0, trace, "CBOT", card);
 			qeth_set_dev_flag_norunning(card);
 			problem = 0;
 			goto out;
@@ -809,27 +795,21 @@
 			}
 			goto out;
 		}
-		if (*(PDU_ENCAPSULATION(buffer)) == IPA_CMD_REGISTER_LOCAL_ADDR) {
-			QETH_DBF_TEXT3(0, trace, "irla");
-			QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-		}
-		if (*(PDU_ENCAPSULATION(buffer)) ==
-		    IPA_CMD_UNREGISTER_LOCAL_ADDR) {
-			QETH_DBF_TEXT3(0, trace, "irla");
-			QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-		}
+		if (*(PDU_ENCAPSULATION(buffer)) == IPA_CMD_REGISTER_LOCAL_ADDR)
+			QETH_DBF_CARD3(0, trace, "irla", card);
+		if (*(PDU_ENCAPSULATION(buffer)) == 
+		    IPA_CMD_UNREGISTER_LOCAL_ADDR)
+			QETH_DBF_CARD3(0, trace, "irla", card);
 		PRINT_WARN("probably a problem on %s: received data is IPA, "
 			   "but not a reply: command=0x%x\n", card->dev_name,
 			   *(PDU_ENCAPSULATION(buffer) + 1));
-		QETH_DBF_TEXT1(0, trace, "INRP");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "INRP", card);
 		goto out;
 	}
 	/* no probs */
 out:
 	if (problem) {
-		QETH_DBF_TEXT3(0, trace, "gcpr");
-		QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD3(0, trace, "gcpr", card);
 		sprintf(dbf_text, "%2x%2x%4x", dstat, cstat, problem);
 		QETH_DBF_TEXT3(0, trace, dbf_text);
 		sprintf(dbf_text, "%8x", rqparam);
@@ -849,8 +829,7 @@
 	int result, result2;
 	char dbf_text[15];
 
-	QETH_DBF_TEXT5(0, trace, "isnr");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "isnr", card);
 
 	/* set up next read ccw */
 	memcpy(&card->dma_stuff->read_ccw, READ_CCW, sizeof (struct ccw1));
@@ -859,21 +838,20 @@
 	card->dma_stuff->read_ccw.cda = QETH_GET_ADDR(card->dma_stuff->recbuf);
 
 	/* 
-	 * we don't spin_lock_irqsave(get_ccwdev_lock(card->rdev),flags), as
+	 * we don't spin_lock_irqsave(get_ccwdev_lock(CARD_RDEV(card)),flags), as
 	 * we are only called in the interrupt handler
 	 */
-	result = ccw_device_start(card->rdev, &card->dma_stuff->read_ccw,
+	result = ccw_device_start(CARD_RDEV(card), &card->dma_stuff->read_ccw,
 				  MPC_SETUP_STATE, 0, 0);
 	if (result) {
 		qeth_delay_millis(QETH_WAIT_BEFORE_2ND_DOIO);
 		result2 =
-		    ccw_device_start(card->rdev, &card->dma_stuff->read_ccw,
+		    ccw_device_start(CARD_RDEV(card), &card->dma_stuff->read_ccw,
 				     MPC_SETUP_STATE, 0, 0);
 		PRINT_WARN("read handler on device %s, read: ccw_device_start "
 			   "returned %i, next try returns %i\n",
-			   card->rdev->dev.bus_id, result, result2);
-		QETH_DBF_TEXT1(0, trace, "IsNR");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			   CARD_BUS_ID(card), result, result2);
+		QETH_DBF_CARD1(0, trace, "IsNR", card);
 		sprintf(dbf_text, "%04x%04x", (__s16) result, (__s16) result2);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
 	}
@@ -977,8 +955,7 @@
 	int elements, el_m_1;
 	char dbf_text[15];
 
-	QETH_DBF_TEXT6(0, trace, "clib");
-	QETH_DBF_TEXT6(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD6(0, trace, "clib", card);
 	sprintf(dbf_text, "bufno%3x", bufno);
 	QETH_DBF_TEXT6(0, trace, dbf_text);
 
@@ -1010,8 +987,7 @@
 	char dbf_text[15];
 	int no;
 
-	QETH_DBF_TEXT5(0, trace, "qibf");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "qibf", card);
 	sprintf(dbf_text, "%4x%4x", under_int, bufno);
 	QETH_DBF_TEXT5(0, trace, dbf_text);
 	atomic_inc(&card->requeue_counter);
@@ -1019,8 +995,7 @@
 		return;
 
 	if (!spin_trylock(&card->requeue_input_lock)) {
-		QETH_DBF_TEXT5(0, trace, "qibl");
-		QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD5(0, trace, "qibl", card);
 		return;
 	}
 	requeue_counter = atomic_read(&card->requeue_counter);
@@ -1046,8 +1021,7 @@
 					  "be lost! Try increasing the bufcnt "
 					  "parameter\n",
 					  card->dev_name);
-				QETH_DBF_TEXT2(1, trace, "QINB");
-				QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+				QETH_DBF_CARD2(1, trace, "QINB", card);
 				goto out;
 			}
 			card->inbound_buffer_entry_no[pos] =
@@ -1065,8 +1039,7 @@
 	/* stop points to the position after the last element */
 	stop = pos;
 
-	QETH_DBF_TEXT3(0, trace, "qibi");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "qibi", card);
 	sprintf(dbf_text, "%4x", requeue_counter);
 	QETH_DBF_TEXT3(0, trace, dbf_text);
 	sprintf(dbf_text, "%4x%4x", start, stop);
@@ -1093,15 +1066,14 @@
 		for (i = start; i < start + cnt1; i++) {
 			qeth_clear_input_buffer(card, i);
 		}
-		result = do_QDIO(card->ddev,
+		result = do_QDIO(CARD_DDEV(card),
 				 QDIO_FLAG_SYNC_INPUT | under_int,
 				 0, start, cnt1, NULL);
 		if (result) {
 			PRINT_WARN("qeth_queue_input_buffer's "
 				   "do_QDIO returnd %i (device %s)\n",
-				   result, card->ddev->dev.bus_id);
-			QETH_DBF_TEXT1(0, trace, "QIDQ");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+				   result, CARD_DDEV_ID(card));
+			QETH_DBF_CARD1(0, trace, "QIDQ", card);
 			sprintf(dbf_text, "%4x%4x", result, requeue_counter);
 			QETH_DBF_TEXT1(0, trace, dbf_text);
 			sprintf(dbf_text, "%4x%4x", start, cnt1);
@@ -1112,15 +1084,14 @@
 		for (i = 0; i < cnt2; i++) {
 			qeth_clear_input_buffer(card, i);
 		}
-		result = do_QDIO(card->ddev,
+		result = do_QDIO(CARD_DDEV(card),
 				 QDIO_FLAG_SYNC_INPUT | under_int, 0,
 				 0, cnt2, NULL);
 		if (result) {
 			PRINT_WARN("qeth_queue_input_buffer's "
 				   "do_QDIO returnd %i (device %s)\n",
-				   result, card->ddev->dev.bus_id);
-			QETH_DBF_TEXT1(0, trace, "QIDQ");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+				   result, CARD_DDEV_ID(card));
+			QETH_DBF_CARD1(0, trace, "QIDQ", card);
 			sprintf(dbf_text, "%4x%4x", result, requeue_counter);
 			QETH_DBF_TEXT1(0, trace, dbf_text);
 			sprintf(dbf_text, "%4x%4x", 0, cnt2);
@@ -1170,9 +1141,8 @@
 	if (element >= max_elements) {
 		PRINT_WARN("device %s: error in interpreting buffer (data "
 			   "too long), %i elements.\n",
-			   card->rdev->dev.bus_id, element);
-		QETH_DBF_TEXT0(0, trace, "IEDL");
-		QETH_DBF_TEXT0(0, trace, card->rdev->dev.bus_id);
+			   CARD_BUS_ID(card), element);
+		QETH_DBF_CARD0(0, trace, "IEDL", card);
 		sprintf(dbf_text, "%4x%4x", *element_ptr, *pos_in_el_ptr);
 		QETH_DBF_TEXT0(1, trace, dbf_text);
 		QETH_DBF_HEX0(0, misc, buffer, QETH_DBF_MISC_LEN);
@@ -1186,9 +1156,8 @@
 	curr_len = SBALE_LEN(element);
 	if (curr_len > PAGE_SIZE) {
 		PRINT_WARN("device %s: bad element length in element %i: "
-			   "0x%x\n", card->rdev->dev.bus_id, element, curr_len);
-		QETH_DBF_TEXT0(0, trace, "BELN");
-		QETH_DBF_TEXT0(0, trace, card->rdev->dev.bus_id);
+			   "0x%x\n", CARD_BUS_ID(card), element, curr_len);
+		QETH_DBF_CARD0(0, trace, "BELN", card);
 		sprintf(dbf_text, "%4x", curr_len);
 		QETH_DBF_TEXT0(0, trace, dbf_text);
 		sprintf(dbf_text, "%4x%4x", *element_ptr, *pos_in_el_ptr);
@@ -1201,8 +1170,7 @@
 	/* header fits in current element? */
 	if (curr_len < pos_in_el + QETH_HEADER_SIZE) {
 		if (!pos_in_el) {
-			QETH_DBF_TEXT6(0, trace, "gnmh");
-			QETH_DBF_TEXT6(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD6(0, trace, "gnmh", card);
 			return NULL;	/* no more data in buffer */
 		}
 		/* set hdr to next element */
@@ -1211,8 +1179,7 @@
 		curr_len = SBALE_LEN(element);
 		/* does it fit in there? */
 		if (curr_len < QETH_HEADER_SIZE) {
-			QETH_DBF_TEXT6(0, trace, "gdnf");
-			QETH_DBF_TEXT6(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD6(0, trace, "gdnf", card);
 			return NULL;
 		}
 	}
@@ -1221,8 +1188,7 @@
 
 	length = *(__u16 *) ((char *) (*hdr_ptr) + QETH_HEADER_LEN_POS);
 
-	QETH_DBF_TEXT6(0, trace, "gdHd");
-	QETH_DBF_TEXT6(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD6(0, trace, "gdHd", card);
 	QETH_DBF_HEX6(0, trace, hdr_ptr, sizeof (void *));
 
 	pos_in_el += QETH_HEADER_SIZE;
@@ -1234,9 +1200,8 @@
 		if (!curr_len) {
 			PRINT_WARN("device %s: inb. buffer with more headers "
 				   "than data areas (%i elements).\n",
-				   card->rdev->dev.bus_id, element);
-			QETH_DBF_TEXT0(0, trace, "IEMH");
-			QETH_DBF_TEXT0(0, trace, card->rdev->dev.bus_id);
+				   CARD_BUS_ID(card), element);
+			QETH_DBF_CARD0(0, trace, "IEMH", card);
 			sprintf(dbf_text, "%2x%2x%4x", element, *element_ptr,
 				*pos_in_el_ptr);
 			QETH_DBF_TEXT0(1, trace, dbf_text);
@@ -1254,10 +1219,6 @@
 		if (!skb)
 			goto nomem;
 		skb_pull(skb, QETH_FAKE_LL_LEN);
-		if (!skb) {
-			dev_kfree_skb_irq(skb);
-			goto nomem;
-		}
 	} else {
 		skb = qeth_get_skb(length);
 		if (!skb)
@@ -1274,9 +1235,8 @@
 			PRINT_WARN("device %s: unexpected end of buffer, "
 				   "length of element %i is 0. Discarding "
 				   "packet.\n",
-				   card->rdev->dev.bus_id, element);
-			QETH_DBF_TEXT0(0, trace, "IEUE");
-			QETH_DBF_TEXT0(0, trace, card->rdev->dev.bus_id);
+				   CARD_BUS_ID(card), element);
+			QETH_DBF_CARD0(0, trace, "IEUE", card);
 			sprintf(dbf_text, "%2x%2x%4x", element, *element_ptr,
 				*pos_in_el_ptr);
 			QETH_DBF_TEXT0(0, trace, dbf_text);
@@ -1321,8 +1281,7 @@
 	if (net_ratelimit()) {
 		PRINT_WARN("no memory for packet from %s\n", card->dev_name);
 	}
-	QETH_DBF_TEXT0(0, trace, "NOMM");
-	QETH_DBF_TEXT0(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD0(0, trace, "NOMM", card);
 	return NULL;
 }
 
@@ -1426,8 +1385,7 @@
 		break;
 	case QETH_CAST_ANYCAST:
 	case QETH_CAST_NOCAST:
-		QETH_DBF_TEXT2(0, trace, "ribf");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "ribf", card);
 		sprintf(dbf_text, "castan%2x", cast_type);
 		QETH_DBF_TEXT2(1, trace, dbf_text);
 		skb->pkt_type = PACKET_HOST;
@@ -1437,8 +1395,7 @@
 			   "of 0x%x. Using unicasting instead.\n",
 			   cast_type);
 		skb->pkt_type = PACKET_HOST;
-		QETH_DBF_TEXT2(0, trace, "ribf");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "ribf", card);
 		sprintf(dbf_text, "castun%2x", cast_type);
 		QETH_DBF_TEXT2(1, trace, dbf_text);
 	}
@@ -1518,10 +1475,10 @@
 	if (buffer->element[15].flags & 0xff) {
 		PRINT_WARN("on device %s: incoming SBALF 15 on buffer "
 			   "0x%x are 0x%x\n",
-			   card->rdev->dev.bus_id, buffer_no,
+			   CARD_BUS_ID(card), buffer_no,
 			   buffer->element[15].flags & 0xff);
 		sprintf(dbf_text, "SF%s%2x%2x",
-			card->rdev->dev.bus_id, buffer_no,
+			CARD_BUS_ID(card), buffer_no,
 			buffer->element[15].flags & 0xff);
 		QETH_DBF_HEX1(1, trace, dbf_text, QETH_DBF_TRACE_LEN);
 	}
@@ -1536,7 +1493,7 @@
 	card->perf_stats.bufs_rec++;
 #endif /* QETH_PERFORMANCE_STATS */
 
-	sprintf(dbf_text, "ribX%s", card->rdev->dev.bus_id);
+	sprintf(dbf_text, "ribX%s", CARD_BUS_ID(card));
 	dbf_text[3] = buffer_no;
 	QETH_DBF_HEX6(0, trace, dbf_text, QETH_DBF_TRACE_LEN);
 
@@ -1563,8 +1520,7 @@
 			card->perf_stats.inbound_cnt++;
 #endif /* QETH_PERFORMANCE_STATS */
 
-			QETH_DBF_TEXT6(0, trace, "rxpk");
-			QETH_DBF_TEXT6(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD6(0, trace, "rxpk", card);
 
 			netif_rx(skb);
 			dev->last_rx = jiffies;
@@ -1573,8 +1529,7 @@
 		} else {
 			PRINT_WARN("%s: dropped packet, no buffers "
 				   "available.\n", card->dev_name);
-			QETH_DBF_TEXT2(1, trace, "DROP");
-			QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(1, trace, "DROP", card);
 			card->stats->rx_dropped++;
 		}
 	}
@@ -1792,8 +1747,7 @@
 
 	atomic_inc(&card->outbound_used_buffers[queue]);
 
-	QETH_DBF_TEXT5(0, trace, "flsp");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "flsp", card);
 	sprintf(dbf_text, "%4x%2x%2x", position_for_do_qdio, under_int, queue);
 	QETH_DBF_TEXT5(0, trace, dbf_text);
 	QETH_DBF_HEX5(0, misc, buffer, QETH_DBF_MISC_LEN);
@@ -1849,14 +1803,13 @@
 	 * this has to be at the end, otherwise a buffer could be flushed
 	 * twice (see comment in qeth_do_send_packet)
 	 */
-	result = do_QDIO(card->ddev, QDIO_FLAG_SYNC_OUTPUT | under_int, queue,
+	result = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_OUTPUT | under_int, queue,
 			 position_for_do_qdio, 1, NULL);
 
 	if (result) {
 		PRINT_WARN("Outbound do_QDIO returned %i "
-			   "(device %s)\n", result, card->ddev->dev.bus_id);
-		QETH_DBF_TEXT5(0, trace, "FLSP");
-		QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+			   "(device %s)\n", result, CARD_DDEV_ID(card));
+		QETH_DBF_CARD5(0, trace, "FLSP", card);
 		sprintf(dbf_text, "odoQ%4x", result);
 		QETH_DBF_TEXT5(0, trace, dbf_text);
 		sprintf(dbf_text, "%4x%2x%2x", position_for_do_qdio,
@@ -1923,8 +1876,7 @@
 	switch (card->outbound_buffer_send_state[queue][bufno]) {
 	case SEND_STATE_DONT_PACK:	/* fallthrough */
 	case SEND_STATE_PACK:
-		QETH_DBF_TEXT5(0, trace, "frbf");
-		QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD5(0, trace, "frbf", card);
 		sprintf(dbf_text, "%2x%2x%4x", queue, bufno,
 			card->outbound_buffer_send_state[queue][bufno]);
 		QETH_DBF_TEXT5(0, trace, dbf_text);
@@ -1935,7 +1887,7 @@
 		    qeth_determine_send_error(siga_error, qdio_error, sbalf15);
 		if (error == ERROR_KICK_THAT_PUPPY) {
 			sprintf(dbf_text, "KP%s%2x",
-				card->rdev->dev.bus_id, queue);
+				CARD_BUS_ID(card), queue);
 			QETH_DBF_TEXT2(0, trace, dbf_text);
 			QETH_DBF_TEXT2(0, qerr, dbf_text);
 			QETH_DBF_TEXT2(1, setup, dbf_text);
@@ -1946,7 +1898,7 @@
 			PRINT_ERR("Outbound queue x%x on device %s (%s); "
 				  "errs: siga: x%x, qdio: x%x, flags15: "
 				  "x%x. The device will be taken down.\n",
-				  queue, card->rdev->dev.bus_id, card->dev_name,
+				  queue, CARD_BUS_ID(card), card->dev_name,
 				  siga_error, qdio_error, sbalf15);
 			netif_stop_queue(card->dev);
 			qeth_set_dev_flag_norunning(card);
@@ -1957,7 +1909,7 @@
 			retries = card->send_retries[queue][bufno];
 
 			sprintf(dbf_text, "Rt%s%2x",
-				card->rdev->dev.bus_id, queue);
+				CARD_BUS_ID(card), queue);
 			QETH_DBF_TEXT4(0, trace, dbf_text);
 			sprintf(dbf_text, "b%2x:%2x%2x", bufno,
 				sbalf15, retries);
@@ -1971,8 +1923,7 @@
 		} else if (error == ERROR_LINK_FAILURE) {
 			/* we don't want to log failures resulting from
 			 * too many retries */
-			QETH_DBF_TEXT3(1, trace, "Fail");
-			QETH_DBF_TEXT3(1, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD3(1, trace, "Fail", card);
 			QETH_DBF_HEX3(0, misc, buffer, QETH_DBF_MISC_LEN);
 			QETH_DBF_HEX3(0, misc, buffer + QETH_DBF_MISC_LEN,
 				      QETH_DBF_MISC_LEN);
@@ -2009,10 +1960,8 @@
 			   "(line %i). q=%i, bufno=x%x, state=%i\n",
 			   card->dev_name, __LINE__, queue, bufno,
 			   card->outbound_buffer_send_state[queue][bufno]);
-		QETH_DBF_TEXT0(1, trace, "UPSf");
-		QETH_DBF_TEXT0(1, qerr, "UPSf");
-		QETH_DBF_TEXT0(1, trace, card->rdev->dev.bus_id);
-		QETH_DBF_TEXT0(1, qerr, card->rdev->dev.bus_id);
+		QETH_DBF_CARD0(1, trace, "UPSf", card);
+		QETH_DBF_CARD0(1, qerr, "UPSf", card);
 		sprintf(dbf_text, "%2x%2x%4x", queue, bufno,
 			card->outbound_buffer_send_state[queue][bufno]);
 		QETH_DBF_TEXT0(1, trace, dbf_text);
@@ -2038,8 +1987,7 @@
 qeth_flush_buffer(struct qeth_card *card, int queue, int under_int)
 {
 	char dbf_text[15];
-	QETH_DBF_TEXT5(0, trace, "flsb");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "flsb", card);
 	sprintf(dbf_text, "%2x%2x%2x", queue, under_int,
 		card->outbound_buffer_send_state[queue]
 		[card->outbound_first_free_buffer[queue]]);
@@ -2127,8 +2075,7 @@
 		PRINT_STUPID("%s: not enough headroom in skb (missing: %i)\n",
 			     card->dev_name,
 			     QETH_HEADER_SIZE - skb_headroom(skb));
-		QETH_DBF_TEXT3(0, trace, "NHRf");
-		QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD3(0, trace, "NHRf", card);
 		sprintf(dbf_text, "%2x%2x%2x%2x", skb_headroom(skb),
 			version, multicast, queue);
 		QETH_DBF_TEXT3(0, trace, dbf_text);
@@ -2138,8 +2085,7 @@
 		if (!nskb) {
 			PRINT_WARN("%s: could not realloc headroom\n",
 				   card->dev_name);
-			QETH_DBF_TEXT2(0, trace, "CNRf");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "CNRf", card);
 			dev_kfree_skb_irq(skb);
 			return;
 		}
@@ -2162,8 +2108,7 @@
 			  card->dev_name,
 			  QETH_HEADER_SIZE + QETH_IP_HEADER_SIZE);
 		PRINT_ERR("head=%p, data=%p\n", skb->head, skb->data);
-		QETH_DBF_TEXT1(0, trace, "PMAf");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "PMAf", card);
 		sprintf(dbf_text, "%2x%2x%2x%2x", skb_headroom(skb),
 			version, multicast, queue);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
@@ -2220,8 +2165,7 @@
 		PRINT_STUPID("%s: not enough headroom in skb (missing: %i)\n",
 			     card->dev_name,
 			     QETH_HEADER_SIZE - skb_headroom(skb));
-		QETH_DBF_TEXT3(0, trace, "NHRp");
-		QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD3(0, trace, "NHRp", card);
 		sprintf(dbf_text, "%2x%2x%2x%2x", skb_headroom(skb),
 			version, multicast, queue);
 		QETH_DBF_TEXT3(0, trace, dbf_text);
@@ -2231,8 +2175,7 @@
 		if (!nskb) {
 			PRINT_WARN("%s: could not realloc headroom\n",
 				   card->dev_name);
-			QETH_DBF_TEXT2(0, trace, "CNRp");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "CNRp", card);
 			dev_kfree_skb_irq(skb);
 			return;
 		}
@@ -2257,8 +2200,7 @@
 			  "are not in the same page. Discarding packet!\n",
 			  card->dev_name,
 			  QETH_HEADER_SIZE + QETH_IP_HEADER_SIZE);
-		QETH_DBF_TEXT1(0, trace, "PMAp");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "PMAp", card);
 		sprintf(dbf_text, "%2x%2x%2x%2x", skb_headroom(skb),
 			version, multicast, queue);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
@@ -2354,8 +2296,7 @@
 {
 	char dbf_text[15];
 
-	QETH_DBF_TEXT6(0, trace, "dsp:");
-	QETH_DBF_TEXT6(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD6(0, trace, "dsp:", card);
 	sprintf(dbf_text, "%c %c%4x",
 		(version == 4) ? '4' : ((version == 6) ? '6' : '0'),
 		(multicast) ? 'm' : '_', queue);
@@ -2384,8 +2325,7 @@
 	if (atomic_read(&card->outbound_used_buffers[queue])
 	    >= HIGH_WATERMARK_PACK) {
 		card->send_state[queue] = SEND_STATE_PACK;
-		QETH_DBF_TEXT3(0, trace, "stchup");
-		QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD3(0, trace, "stchup", card);
 #ifdef QETH_PERFORMANCE_STATS
 		card->perf_stats.sc_dp_p++;
 #endif /* QETH_PERFORMANCE_STATS */
@@ -2407,8 +2347,7 @@
 
 	if (atomic_read(&card->outbound_used_buffers[queue])
 	    >= QDIO_MAX_BUFFERS_PER_Q - 1) {
-		QETH_DBF_TEXT2(1, trace, "cdbs");
-		QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(1, trace, "cdbs", card);
 		netif_stop_queue(dev);
 		return -EBUSY;
 	}
@@ -2420,13 +2359,11 @@
 	 */
 	if (atomic_compare_and_swap(QETH_LOCK_UNLOCKED, QETH_LOCK_NORMAL,
 				    &card->outbound_ringbuffer_lock[queue])) {
-		QETH_DBF_TEXT2(0, trace, "SPIN");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "SPIN", card);
 		while (atomic_compare_and_swap
 		       (QETH_LOCK_UNLOCKED, QETH_LOCK_NORMAL,
 			&card->outbound_ringbuffer_lock[queue])) ;
-		QETH_DBF_TEXT2(0, trace, "spin");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "spin", card);
 	}
 #ifdef QETH_PERFORMANCE_STATS
 	card->perf_stats.skbs_sent++;
@@ -2445,8 +2382,7 @@
 			break;
 		default:
 			result = -EBUSY;
-			QETH_DBF_TEXT0(1, trace, "UPSs");
-			QETH_DBF_TEXT0(1, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD0(1, trace, "UPSs", card);
 			PRINT_ALL("oops... shouldn't happen (line %i:%i).\n",
 				  __LINE__, card->send_state[queue]);
 		}
@@ -2499,8 +2435,7 @@
 
 	if (!atomic_read(&card->is_startlaned)) {
 		card->stats->tx_carrier_errors++;
-		QETH_DBF_TEXT2(0, trace, "XMNS");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "XMNS", card);
 		dst_link_failure(skb);
 		dev_kfree_skb_irq(skb);
 		return 0;
@@ -2521,8 +2456,7 @@
 
 	card = (struct qeth_card *) (dev->priv);
 
-	QETH_DBF_TEXT3(0, trace, "gtst");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "gtst", card);
 
 	return card->stats;
 }
@@ -2535,8 +2469,7 @@
 
 	card = (struct qeth_card *) (dev->priv);
 
-	QETH_DBF_TEXT2(0, trace, "mtu");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "mtu", card);
 	sprintf(dbf_text, "%8x", new_mtu);
 	QETH_DBF_TEXT2(0, trace, dbf_text);
 
@@ -2555,8 +2488,7 @@
 qeth_start_softsetup_thread(struct qeth_card *card)
 {
 	if (!atomic_read(&card->shutdown_phase)) {
-		QETH_DBF_TEXT2(0, trace, "stss");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "stss", card);
 		up(&card->softsetup_thread_sem);
 	}
 }
@@ -2566,8 +2498,7 @@
 {
 	char dbf_text[15];
 
-	QETH_DBF_TEXT5(0, trace, "slpn");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "slpn", card);
 	sprintf(dbf_text, "%08x", timeout);
 	QETH_DBF_TEXT5(0, trace, dbf_text);
 
@@ -2585,8 +2516,7 @@
 qeth_wakeup_ioctl(struct qeth_card *card)
 {
 
-	QETH_DBF_TEXT5(0, trace, "wkup");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "wkup", card);
 
 	atomic_set(&card->ioctl_data_has_arrived, 1);
 	wake_up(&card->ioctl_wait_q);
@@ -2597,8 +2527,7 @@
 {
 	char dbf_text[15];
 
-	QETH_DBF_TEXT5(0, trace, "ioctlslpn");
-	QETH_DBF_TEXT5(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD5(0, trace, "ioctlslpn", card);
 	sprintf(dbf_text, "%08x", timeout);
 	QETH_DBF_TEXT5(0, trace, dbf_text);
 
@@ -2656,8 +2585,7 @@
 	/* we lock very early to synchronize access to seqnos */
 	if (atomic_swap(&card->write_busy, 1)) {
 		qeth_wait_nonbusy(QETH_IDLE_WAIT_TIME);
-		QETH_DBF_TEXT2(0, trace, "LSCD");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "LSCD", card);
 		goto again;
 	}
 	memcpy(card->dma_stuff->sendbuf, card->send_buf, QETH_BUFSIZE);
@@ -2680,19 +2608,18 @@
 	card->dma_stuff->write_ccw.cda =
 	    QETH_GET_ADDR(card->dma_stuff->sendbuf);
 
-	QETH_DBF_TEXT2(0, trace, "scdw");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "scdw", card);
 	sprintf(dbf_text, "%8x", len);
 	QETH_DBF_TEXT4(0, trace, dbf_text);
 	QETH_DBF_HEX4(0, trace, &intparam, QETH_DBF_TRACE_LEN);
 	QETH_DBF_HEX2(0, control, buffer, QETH_DBF_CONTROL_LEN);
 
-	spin_lock_irqsave(get_ccwdev_lock(card->wdev), flags);
-	result = ccw_device_start(card->wdev, &card->dma_stuff->write_ccw,
+	spin_lock_irqsave(get_ccwdev_lock(CARD_WDEV(card)), flags);
+	result = ccw_device_start(CARD_WDEV(card), &card->dma_stuff->write_ccw,
 				  intparam, 0, 0);
 	if (result) {
 		qeth_delay_millis(QETH_WAIT_BEFORE_2ND_DOIO);
-		result2 = ccw_device_start(card->wdev,
+		result2 = ccw_device_start(CARD_WDEV(card),
 					   &card->dma_stuff->write_ccw,
 					   intparam, 0, 0);
 		if (result2 != -ENODEV)
@@ -2701,7 +2628,7 @@
 				   result, result2);
 		result = result2;
 	}
-	spin_unlock_irqrestore(get_ccwdev_lock(card->wdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_WDEV(card)), flags);
 
 	if (result) {
 		QETH_DBF_TEXT2(0, trace, "scd:doio");
@@ -2718,8 +2645,7 @@
 			return NULL;
 		}
 		rec_buf = card->ipa_buf;
-		QETH_DBF_TEXT2(0, trace, "scro");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "scro", card);
 	} else {
 		if (qeth_sleepon(card, (setip) ? QETH_IPA_TIMEOUT :
 				 QETH_MPC_TIMEOUT)) {
@@ -2729,8 +2655,7 @@
 			return NULL;
 		}
 		rec_buf = card->ipa_buf;
-		QETH_DBF_TEXT2(0, trace, "scri");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "scri", card);
 	}
 	QETH_DBF_HEX2(0, control, rec_buf, QETH_DBF_CONTROL_LEN);
 
@@ -2832,16 +2757,14 @@
 	int result;
 	char dbf_text[15];
 
-	QETH_DBF_TEXT4(0, trace, "stln");
-	QETH_DBF_TEXT4(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD4(0, trace, "stln", card);
 
 	result = qeth_send_startstoplan(card, IPA_CMD_STARTLAN, ip_vers);
 	if (!result)
 		atomic_set(&card->is_startlaned, 1);
 
 	if (result) {
-		QETH_DBF_TEXT2(0, trace, "STRTLNFL");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "STRTLNFL", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 	}
@@ -2858,14 +2781,12 @@
 
 	atomic_set(&card->is_startlaned, 0);
 
-	QETH_DBF_TEXT4(0, trace, "spln");
-	QETH_DBF_TEXT4(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD4(0, trace, "spln", card);
 
 	result = qeth_send_startstoplan(card, IPA_CMD_STOPLAN, 4);
 
 	if (result) {
-		QETH_DBF_TEXT2(0, trace, "STPLNFLD");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "STPLNFLD", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 	}
@@ -3443,8 +3364,7 @@
 
 	retries = (use_retries) ? QETH_SETIP_RETRIES : 1;
 	if (qeth_is_ipa_covered_by_ipato_entries(ip_vers, ip, card)) {
-		QETH_DBF_TEXT2(0, trace, "ipto");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "ipto", card);
 		if (ip_vers == 4) {
 			*((__u32 *) (&dbf_text[0])) = *((__u32 *) ip);
 			*((__u32 *) (&dbf_text[4])) = *((__u32 *) netmask);
@@ -3467,15 +3387,13 @@
 	PRINT_SETIP_ERROR(' ');
 
 	if (result) {
-		QETH_DBF_TEXT2(0, trace, "SETIPFLD");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "SETIPFLD", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 	}
 
 	if (((result == -1) || (result == 0xe080)) && (retries--)) {
-		QETH_DBF_TEXT2(0, trace, "sipr");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "sipr", card);
 		if (ip_vers == 4) {
 			*((__u32 *) (&dbf_text[0])) = *((__u32 *) ip);
 			*((__u32 *) (&dbf_text[4])) = *((__u32 *) netmask);
@@ -3513,8 +3431,7 @@
 
 	retries = (use_retries) ? QETH_SETIP_RETRIES : 1;
 	if (qeth_is_ipa_covered_by_ipato_entries(ip_vers, ip, card)) {
-		QETH_DBF_TEXT2(0, trace, "imto");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "imto", card);
 		if (ip_vers == 4) {
 			*((__u32 *) (&dbf_text[0])) = *((__u32 *) ip);
 			QETH_DBF_HEX2(0, trace, dbf_text, QETH_DBF_TRACE_LEN);
@@ -3530,15 +3447,13 @@
 	PRINT_SETIP_ERROR('m');
 
 	if (result) {
-		QETH_DBF_TEXT2(0, trace, "SETIMFLD");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "SETIMFLD", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 	}
 
 	if ((result == -1) && (retries--)) {
-		QETH_DBF_TEXT2(0, trace, "simr");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "simr", card);
 		if (ip_vers == 4) {
 			sprintf(dbf_text, "%08x", *((__u32 *) ip));
 			QETH_DBF_TEXT2(0, trace, dbf_text);
@@ -3726,8 +3641,7 @@
 		PRINT_SETIP_ERROR('s');
 
 		if (result) {
-			QETH_DBF_TEXT2(0, trace, "SETSVFLD");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "SETSVFLD", card);
 			sprintf(dbf_text, "%4x", result);
 			QETH_DBF_TEXT2(0, trace, dbf_text);
 			if (priv_add_list->version == 4) {
@@ -3761,8 +3675,7 @@
 					    priv_del_list->version,
 					    priv_del_list->flag);
 		if (result) {
-			QETH_DBF_TEXT2(0, trace, "DELSVFLD");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "DELSVFLD", card);
 			sprintf(dbf_text, "%4x", result);
 			QETH_DBF_TEXT2(0, trace, dbf_text);
 			if (priv_del_list->version == 4) {
@@ -3943,7 +3856,7 @@
 				  addr6->addr.s6_addr16[6],
 				  addr6->addr.s6_addr16[7],
 				  addr6->prefix_len,
-				  card->rdev->dev.bus_id, result);
+				  CARD_BUS_ID(card), result);
  			sprintf(dbf_text, "std6%4x", result);
  			QETH_DBF_TEXT3(0, trace, dbf_text);
 		}
@@ -3987,7 +3900,7 @@
 			  addr6->addr.s6_addr16[6],
 			  addr6->addr.s6_addr16[7],
 			  addr6->prefix_len,
-			  card->rdev->dev.bus_id, result);
+			  CARD_BUS_ID(card), result);
  		sprintf(dbf_text, "sts6%4x", result);
  		QETH_DBF_TEXT3(0, trace, dbf_text);
 		addr6 = addr6->if_next;
@@ -4002,8 +3915,7 @@
 	int result;
 	char dbf_text[15];
 
-	QETH_DBF_TEXT3(0, trace, "stip");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "stip", card);
 
 	addr = card->ip_current_state.ip_ifa;
 	while (addr) {
@@ -4023,7 +3935,7 @@
 					  "(result: 0x%x), "
 					  "trying to continue\n",
 					  addr->ifa_address, addr->ifa_mask,
-					  card->rdev->dev.bus_id, result);
+					  CARD_BUS_ID(card), result);
  				sprintf(dbf_text, "stdl%4x", result);
  				QETH_DBF_TEXT3(0, trace, dbf_text);
 			}
@@ -4051,7 +3963,7 @@
 		PRINT_ERR("was not able to set ip "
 			  "%08x/%08x on device %s, trying to continue\n",
 			  addr->ifa_address, addr->ifa_mask,
-			  card->rdev->dev.bus_id);
+			  CARD_BUS_ID(card));
  		sprintf(dbf_text, "stst%4x", result);
  		QETH_DBF_TEXT3(0, trace, dbf_text);
 		addr = addr->ifa_next;
@@ -4161,7 +4073,7 @@
 					  addr->mac[0], addr->mac[1],
 					  addr->mac[2], addr->mac[3],
 					  addr->mac[4], addr->mac[5],
-					  card->rdev->dev.bus_id, result);
+					  CARD_BUS_ID(card), result);
  				sprintf(dbf_text, "smd6%4x", result);
  				QETH_DBF_TEXT3(0, trace, dbf_text);
 			}
@@ -4203,7 +4115,7 @@
 				  addr->mac[0], addr->mac[1],
 				  addr->mac[2], addr->mac[3],
 				  addr->mac[4], addr->mac[5],
-				  card->rdev->dev.bus_id, result);
+				  CARD_BUS_ID(card), result);
  			sprintf(dbf_text, "sms6%4x", result);
  			QETH_DBF_TEXT3(0, trace, dbf_text);
 			qeth_remove_mc_ifa_from_list
@@ -4221,8 +4133,7 @@
 	int result;
 	char dbf_text[15];
 
-	QETH_DBF_TEXT3(0, trace, "stim");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "stim", card);
 
 	if (!qeth_is_supported(IPA_MULTICASTING))
 		return 0;
@@ -4252,7 +4163,7 @@
 					  addr->mac[0], addr->mac[1],
 					  addr->mac[2], addr->mac[3],
 					  addr->mac[4], addr->mac[5],
-					  card->rdev->dev.bus_id, result);
+					  CARD_BUS_ID(card), result);
 				sprintf(dbf_text, "smdl%4x", result);
 				QETH_DBF_TEXT3(0, trace, dbf_text);
 			}
@@ -4285,7 +4196,7 @@
 				  addr->mac[0], addr->mac[1],
 				  addr->mac[2], addr->mac[3],
 				  addr->mac[4], addr->mac[5],
-				  card->rdev->dev.bus_id, result);
+				  CARD_BUS_ID(card), result);
 			sprintf(dbf_text, "smst%4x", result);
 			QETH_DBF_TEXT3(0, trace, dbf_text);
 			qeth_remove_mc_ifa_from_list
@@ -4334,8 +4245,7 @@
 
 	PRINT_STUPID("CALL: qeth_do_ioctl called with cmd %i (=0x%x).\n", cmd,
 		     cmd);
-	QETH_DBF_TEXT2(0, trace, "ioct");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "ioct", card);
 	sprintf(dbf_text, "cmd=%4x", cmd);
 	QETH_DBF_TEXT2(0, trace, dbf_text);
 	QETH_DBF_HEX2(0, trace, &rq, sizeof (void *));
@@ -4562,8 +4472,7 @@
 		
 		in6_vdev = in6_dev_get(card_group->vlan_devices[i]);
 		if (!in6_vdev) {
-			QETH_DBF_TEXT2(0, trace, "id26");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "id26", card);
 			continue;
 		}
 
@@ -4625,8 +4534,7 @@
 	in6_dev = in6_dev_get(card->dev);
 
 	if (!in6_dev) {
-		QETH_DBF_TEXT2(0, trace, "id16");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "id16", card);
 		return ERR_PTR(-ENODEV);
 	}
 	read_lock(&in6_dev->lock);
@@ -4702,8 +4610,7 @@
 	int remove;
 	struct inet6_dev *in6_dev;
 
-	QETH_DBF_TEXT3(0, trace, "tip6");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "tip6", card);
 	/* unicast */
 	/* clear ip_current_state */
 	qeth_clear_ifa6_list(&card->ip_current_state.ip6_ifa);
@@ -5003,8 +4910,7 @@
 	int remove;
 	struct in_device *in4_dev;
 
-	QETH_DBF_TEXT3(0, trace, "tips");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "tips", card);
 	/* unicast */
 	/* clear ip_current_state */
 	qeth_clear_ifa4_list(&card->ip_current_state.ip_ifa);
@@ -5083,16 +4989,14 @@
 			   "autoconfig on other lpars may lead to duplicate "
 			   "ip addresses. please use manually "
 			   "configured ones.\n",
-			   card->rdev->dev.bus_id, result);
-		QETH_DBF_TEXT2(0, trace, "unid fld");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			   CARD_BUS_ID(card), result);
+		QETH_DBF_CARD2(0, trace, "unid fld", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 	} else {
 		card->unique_id =
 		    *((__u16 *) & cmd.data.create_destroy_addr.unique_id[6]);
-		QETH_DBF_TEXT2(0, setup, "uniqueid");
-		QETH_DBF_TEXT2(0, setup, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, setup, "uniqueid", card);
 		sprintf(dbf_text, "%4x", card->unique_id);
 		QETH_DBF_TEXT2(0, setup, dbf_text);
 	}
@@ -5123,8 +5027,7 @@
 	result = qeth_send_ipa_cmd(card, &cmd, 1, IPA_CMD_STATE);
 
 	if (result) {
-		QETH_DBF_TEXT2(0, trace, "unibkfld");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "unibkfld", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 	}
@@ -5144,8 +5047,7 @@
 	    (card->link_type != QETH_MPC_LINK_TYPE_LANE_TR))
 		return;
 
-	QETH_DBF_TEXT3(0, trace, "hstr");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "hstr", card);
 	
 	if (qeth_is_adp_supported(IPA_SETADP_SET_BROADCAST_MODE)) {
 		result = qeth_send_setadapterparms_mode
@@ -5154,18 +5056,16 @@
 		if (result) {
 			PRINT_WARN("couldn't set broadcast mode on "
 				   "device %s: x%x\n",
-				   card->rdev->dev.bus_id, result);
-			QETH_DBF_TEXT1(0, trace, "STBRDCST");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+				   CARD_BUS_ID(card), result);
+			QETH_DBF_CARD1(0, trace, "STBRDCST", card);
 			sprintf(dbf_text, "%4x", result);
 			QETH_DBF_TEXT1(1, trace, dbf_text);
 		}
 	} else if (card->options.broadcast_mode) {
 		PRINT_WARN("set adapter parameters not available "
 			   "to set broadcast mode, using ALLRINGS "
-			   "on device %s:\n", card->rdev->dev.bus_id);
-		QETH_DBF_TEXT1(0, trace, "NOBC");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			   "on device %s:\n", CARD_BUS_ID(card));
+		QETH_DBF_CARD1(0, trace, "NOBC", card);
 	}
 	
 	if (qeth_is_adp_supported(IPA_SETADP_SET_BROADCAST_MODE)) {
@@ -5174,19 +5074,17 @@
 			 card->options.macaddr_mode);
 		if (result) {
 			PRINT_WARN("couldn't set macaddr mode on "
-				   "device %s: x%x\n", card->rdev->dev.bus_id,
+				   "device %s: x%x\n", CARD_BUS_ID(card),
 				   result);
-			QETH_DBF_TEXT1(0, trace, "STMACMOD");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(0, trace, "STMACMOD", card);
 			sprintf(dbf_text, "%4x", result);
 			QETH_DBF_TEXT1(1, trace, dbf_text);
 		}
 	} else if (card->options.macaddr_mode) {
 		PRINT_WARN("set adapter parameters not available "
 			   "to set macaddr mode, using NONCANONICAL "
-			   "on device %s:\n", card->rdev->dev.bus_id);
-		QETH_DBF_TEXT1(0, trace, "NOMA");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			   "on device %s:\n", CARD_BUS_ID(card));
+		QETH_DBF_CARD1(0, trace, "NOMA", card);
 	}
 }
 
@@ -5200,16 +5098,14 @@
 		return;
 	}
 
-	QETH_DBF_TEXT4(0, trace, "stap");
-	QETH_DBF_TEXT4(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD4(0, trace, "stap", card);
 
 	result = qeth_send_setadapterparms_query(card);
 
 	if (result) {
 		PRINT_WARN("couldn't set adapter parameters on device %s: "
-			   "x%x\n", card->rdev->dev.bus_id, result);
-		QETH_DBF_TEXT1(0, trace, "SETADPFL");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+			   "x%x\n", CARD_BUS_ID(card), result);
+		QETH_DBF_CARD1(0, trace, "SETADPFL", card);
 		sprintf(dbf_text, "%4x", result);
 		QETH_DBF_TEXT1(1, trace, dbf_text);
 		return;
@@ -5219,10 +5115,8 @@
 	QETH_DBF_TEXT2(0, trace, dbf_text);
 
 	if (qeth_is_adp_supported(IPA_SETADP_ALTER_MAC_ADDRESS)) {
-		QETH_DBF_TEXT3(0, trace, "rdmc");
-		QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-		QETH_DBF_TEXT2(0, setup, "rdmc");
-		QETH_DBF_TEXT2(0, setup, card->rdev->dev.bus_id);
+		QETH_DBF_CARD3(0, trace, "rdmc", card);
+		QETH_DBF_CARD2(0, setup, "rdmc", card);
 
 		result = qeth_send_setadapterparms_change_addr(card,
 							       IPA_SETADP_ALTER_MAC_ADDRESS,
@@ -5233,9 +5127,8 @@
 		if (result) {
 			PRINT_WARN("couldn't get MAC address on "
 				   "device %s: x%x\n",
-				   card->rdev->dev.bus_id, result);
-			QETH_DBF_TEXT1(0, trace, "NOMACADD");
-			QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+				   CARD_BUS_ID(card), result);
+			QETH_DBF_CARD1(0, trace, "NOMACADD", card);
 			sprintf(dbf_text, "%4x", result);
 			QETH_DBF_TEXT1(1, trace, dbf_text);
 		} else {
@@ -5701,8 +5594,7 @@
 
 	qeth_save_dev_flag_state(card);
 
-	QETH_DBF_TEXT1(0, trace, wait_for_lock?"sscw":"sscn");
-	QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD1(0, trace, wait_for_lock?"sscw":"sscn", card);
 
 	result = __qeth_softsetup_start_assists(card);
 	if (result)
@@ -5753,19 +5645,17 @@
 	struct qeth_card *card = (struct qeth_card *) param;
 
 	/* set a nice name ... */
-	sprintf(name, "qethsoftd%s", card->rdev->dev.bus_id);
+	sprintf(name, "qethsoftd%s", CARD_BUS_ID(card));
 	daemonize(name);
 
-	QETH_DBF_TEXT2(0, trace, "ssth");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "ssth", card);
 
 	atomic_set(&card->softsetup_thread_is_running, 1);
 	for (;;) {
 		if (atomic_read(&card->shutdown_phase))
 			goto out;
 		down_interruptible(&card->softsetup_thread_sem);
-		QETH_DBF_TEXT2(0, trace, "ssst");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "ssst", card);
 		if (atomic_read(&card->shutdown_phase))
 			goto out;
 		while (qeth_softsetup_card(card, QETH_DONT_WAIT_FOR_LOCK)
@@ -5774,15 +5664,13 @@
 				goto out;
 			qeth_wait_nonbusy(QETH_IDLE_WAIT_TIME);
 		}
-		QETH_DBF_TEXT2(0, trace, "sssd");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "sssd", card);
 		netif_wake_queue(card->dev);
 	}
 out:
 	atomic_set(&card->softsetup_thread_is_running, 0);
 
-	QETH_DBF_TEXT2(0, trace, "lsst");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "lsst", card);
 
 	return 0;
 }
@@ -5792,8 +5680,7 @@
 {
 	struct qeth_card *card = (struct qeth_card *) data;
 
-	QETH_DBF_TEXT4(0, trace, "ssts");
-	QETH_DBF_TEXT4(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD4(0, trace, "ssts", card);
 	sema_init(&card->softsetup_thread_sem, 0);
 	kernel_thread(qeth_softsetup_thread, card, SIGCHLD);
 }
@@ -5810,8 +5697,7 @@
 			atomic_dec(&card->reinit_counter);
 			return;
 		}
-		QETH_DBF_TEXT2(0, trace, "stri");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "stri", card);
 		PRINT_STUPID("starting reinit-thread\n");
 		kernel_thread(qeth_reinit_thread, card, SIGCHLD);
 	}
@@ -5826,8 +5712,7 @@
 
 	card = (struct qeth_card *) data;
 
-	QETH_DBF_TEXT2(0, trace, "recv");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "recv", card);
 
 	if (atomic_compare_and_swap(0, 1, &card->in_recovery))
 		return;
@@ -5840,7 +5725,7 @@
 	if (i != PROBLEM_TX_TIMEOUT)
 		PRINT_WARN("recovery was scheduled on device %s (%s) with "
 			   "problem 0x%x\n",
-			   card->rdev->dev.bus_id, card->dev_name, i);
+			   CARD_BUS_ID(card), card->dev_name, i);
 	switch (i) {
 	case PROBLEM_RECEIVED_IDX_TERMINATE:
 		if (atomic_read(&card->in_recovery))
@@ -5931,8 +5816,7 @@
 			QETH_DBF_TEXT1(0, trace, dbf_text);
 			sprintf(dbf_text, "%4x%4x", queue, status);
 			QETH_DBF_TEXT1(0, trace, dbf_text);
-			QETH_DBF_TEXT1(1, trace, "qscd");
-			QETH_DBF_TEXT1(1, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(1, trace, "qscd", card);
 			qeth_schedule_recovery(card);
 			return;
 		}
@@ -5948,10 +5832,8 @@
 			     'y' : 'n', siga_error,
 			     (status & QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR) ?
 			     'y' : 'n', sbalf15, first_element);
-		QETH_DBF_TEXT1(0, trace, "IQTI");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
-		QETH_DBF_TEXT1(0, qerr, "IQTI");
-		QETH_DBF_TEXT1(0, qerr, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "IQTI", card);
+		QETH_DBF_CARD1(0, qerr, "IQTI", card);
 		sprintf(dbf_text, "%4x%4x", first_element, count);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
 		QETH_DBF_TEXT1(0, qerr, dbf_text);
@@ -5989,8 +5871,7 @@
 	/* first_element is the last buffer that we got back from hydra */
 	if (!switch_state && !last_pci_hit)
 		return;;
-	QETH_DBF_TEXT3(0, trace, "stchcw");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "stchcw", card);
 	if (atomic_swap(&card->outbound_ringbuffer_lock[queue], QETH_LOCK_FLUSH)
 	    == QETH_LOCK_UNLOCKED) {
 		/* 
@@ -6052,8 +5933,7 @@
 			QETH_DBF_TEXT1(0, trace, dbf_text);
 			sprintf(dbf_text, "%4x%4x", queue, status);
 			QETH_DBF_TEXT1(0, trace, dbf_text);
-			QETH_DBF_TEXT1(1, trace, "qscd");
-			QETH_DBF_TEXT1(1, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD1(1, trace, "qscd", card);
 			qeth_schedule_recovery(card);
 			goto out;
 		}
@@ -6069,10 +5949,8 @@
 			     siga_error, status &
 			     QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR ? 'y' : 'n',
 			     sbalf15, first_element);
-		QETH_DBF_TEXT1(0, trace, "IQTO");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
-		QETH_DBF_TEXT1(0, qerr, "IQTO");
-		QETH_DBF_TEXT1(0, qerr, card->rdev->dev.bus_id);
+		QETH_DBF_CARD1(0, trace, "IQTO", card);
+		QETH_DBF_CARD1(0, qerr, "IQTO", card);
 		sprintf(dbf_text, "%4x%4x", first_element, count);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
 		QETH_DBF_TEXT1(0, qerr, dbf_text);
@@ -6246,8 +6124,7 @@
 
 recover:
 	if (qeth_is_to_recover(card, problem)) {
-		QETH_DBF_TEXT2(1, trace, "rscd");
-		QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(1, trace, "rscd", card);
 		qeth_schedule_recovery(card);
 		goto wakeup_out;
 	}
@@ -6365,8 +6242,7 @@
 
 recover:
 	if (qeth_is_to_recover(card, problem)) {
-		QETH_DBF_TEXT2(1, trace, "wscd");
-		QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(1, trace, "wscd", card);
 		qeth_schedule_recovery(card);
 		goto out;
 	}
@@ -6466,8 +6342,7 @@
 {
 	int result;
 
-	QETH_DBF_TEXT3(0, trace, "rgnd");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "rgnd", card);
 
 	result = register_netdev(card->dev);
 
@@ -6477,8 +6352,7 @@
 static void
 qeth_unregister_netdev(struct qeth_card *card)
 {
-	QETH_DBF_TEXT3(0, trace, "nrgn");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "nrgn", card);
 
 	unregister_netdev(card->dev);
 }
@@ -6489,15 +6363,13 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) dev->priv;
-	QETH_DBF_TEXT2(0, trace, "stop");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT2(0, setup, "stop");
-	QETH_DBF_TEXT2(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "stop", card);
+	QETH_DBF_CARD2(0, setup, "stop", card);
 
 	qeth_save_dev_flag_state(card);
 
 	netif_stop_queue(dev);
-	atomic_set(&((struct qeth_card *) dev->priv)->is_open, 0);
+	atomic_set(&card->is_open, 0);
 
 	return 0;
 }
@@ -6505,8 +6377,7 @@
 static void
 qeth_softshutdown(struct qeth_card *card)
 {
-	QETH_DBF_TEXT3(0, trace, "ssht");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "ssht", card);
 
 	qeth_send_stoplan(card);
 }
@@ -6521,26 +6392,26 @@
 	atomic_set(&card->clear_succeeded1, 0);
 	atomic_set(&card->clear_succeeded2, 0);
 	
-	spin_lock_irqsave(get_ccwdev_lock(card->rdev), flags0);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_RDEV(card)), flags0);
 	if (halt)
-		ret0 = ccw_device_halt(card->rdev, CLEAR_STATE);
+		ret0 = ccw_device_halt(CARD_RDEV(card), CLEAR_STATE);
 	else
-		ret0 = ccw_device_clear(card->rdev, CLEAR_STATE);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->rdev), flags0);
+		ret0 = ccw_device_clear(CARD_RDEV(card), CLEAR_STATE);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_RDEV(card)), flags0);
 	
-	spin_lock_irqsave(get_ccwdev_lock(card->wdev), flags1);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_WDEV(card)), flags1);
 	if (halt)
-		ret1 = ccw_device_halt(card->wdev, CLEAR_STATE);
+		ret1 = ccw_device_halt(CARD_WDEV(card), CLEAR_STATE);
 	else
-		ret1 = ccw_device_clear(card->wdev, CLEAR_STATE);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->wdev), flags1);
+		ret1 = ccw_device_clear(CARD_WDEV(card), CLEAR_STATE);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_WDEV(card)), flags1);
 	
-	spin_lock_irqsave(get_ccwdev_lock(card->ddev), flags2);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_DDEV(card)), flags2);
 	if (halt)
-		ret2 = ccw_device_halt(card->ddev, CLEAR_STATE);
+		ret2 = ccw_device_halt(CARD_DDEV(card), CLEAR_STATE);
 	else
-		ret2 = ccw_device_clear(card->ddev, CLEAR_STATE);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->ddev), flags2);
+		ret2 = ccw_device_clear(CARD_DDEV(card), CLEAR_STATE);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_DDEV(card)), flags2);
 
 	/* The device owns us an interrupt. */
 	if ((ret0 == 0) && (atomic_read(&card->clear_succeeded0) == 0))
@@ -6557,14 +6428,12 @@
 static void
 qeth_clear_card(struct qeth_card *card, int qdio_clean, int use_halt)
 {
-	QETH_DBF_TEXT3(0, trace, qdio_clean?"clrq":"clr");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT1(0, setup, qdio_clean?"clrq":"clr");
-	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, qdio_clean?"clrq":"clr", card);
+	QETH_DBF_CARD1(0, setup, qdio_clean?"clrq":"clr", card);
 
 	atomic_set(&card->write_busy, 0);
 	if (qdio_clean)
-		qdio_cleanup(card->ddev,
+		qdio_cleanup(CARD_DDEV(card),
 			     (card->type == QETH_CARD_TYPE_IQD) ?
 			     QDIO_FLAG_CLEANUP_USING_HALT :
 			     QDIO_FLAG_CLEANUP_USING_CLEAR);
@@ -6584,10 +6453,8 @@
 	if (!card)
 		return;
 
-	QETH_DBF_TEXT3(0, trace, "freest");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT1(0, setup, "freest");
-	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "freest", card);
+	QETH_DBF_CARD1(0, setup, "freest", card);
 
 	write_lock(&card->vipa_list_lock);
 	e = card->vipa_list;
@@ -6626,10 +6493,8 @@
 	if (!card)
 		return;
 
-	QETH_DBF_TEXT3(0, trace, "free");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT1(0, setup, "free");
-	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "free", card);
+	QETH_DBF_CARD1(0, setup, "free", card);
 
 	vfree(card);		/* we checked against NULL already */
 }
@@ -6649,8 +6514,7 @@
 		return;
 	}
 
-	QETH_DBF_TEXT3(0, trace, "rmcl");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "rmcl", card);
 
 	/* check first, if card is in list */
 	if (!firstcard) {
@@ -6661,9 +6525,9 @@
 		return;
 	}
 
-	spin_lock_irqsave(get_ccwdev_lock(card->rdev), flags0);
-	spin_lock_irqsave(get_ccwdev_lock(card->wdev), flags1);
-	spin_lock_irqsave(get_ccwdev_lock(card->ddev), flags2);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_RDEV(card)), flags0);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_WDEV(card)), flags1);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_DDEV(card)), flags2);
 
 	if (firstcard == card)
 		firstcard = card->next;
@@ -6679,9 +6543,9 @@
 		}
 	}
 
-	spin_unlock_irqrestore(get_ccwdev_lock(card->ddev), flags2);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->wdev), flags1);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->rdev), flags0);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_DDEV(card)), flags2);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_WDEV(card)), flags1);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_RDEV(card)), flags0);
 
 	write_unlock(&list_lock);
 
@@ -6718,10 +6582,8 @@
 	if (!card)
 		return;
 
-	QETH_DBF_TEXT2(0, trace, "rmcd");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-	QETH_DBF_TEXT1(0, setup, "rmcd");
-	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "rmcd", card);
+	QETH_DBF_CARD1(0, setup, "rmcd", card);
 
 	if (method == QETH_REMOVE_CARD_PROPER) {
 		atomic_set(&card->shutdown_phase, QETH_REMOVE_CARD_PROPER);
@@ -6762,7 +6624,7 @@
 		/* Remove sysfs symlinks. */
 		sysfs_remove_link(&card->gdev->dev.kobj, card->dev_name);
 		sysfs_remove_link(&card->dev->class_dev.kobj,
-				  card->gdev->dev.bus_id);
+				  CARD_BUS_ID(card));
 		QETH_DBF_TEXT2(0, trace, "unregdev");
 		qeth_unregister_netdev(card);
 		qeth_wait_nonbusy(QETH_REMOVE_WAIT_TIME);
@@ -6790,8 +6652,7 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) (dev->priv);
-	QETH_DBF_TEXT2(0, trace, "dstr");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "dstr", card);
 }
 
 static void
@@ -6799,8 +6660,7 @@
 {
 	struct qeth_card *card = dev->priv;
 
-	QETH_DBF_TEXT2(0, trace, "smcl");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "smcl", card);
 
 	qeth_start_softsetup_thread(card);
 }
@@ -6811,8 +6671,7 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) dev->priv;
-	QETH_DBF_TEXT2(0, trace, "stmc");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "stmc", card);
 
 	return -EOPNOTSUPP;
 }
@@ -6823,8 +6682,7 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) dev->priv;
-	QETH_DBF_TEXT2(0, trace, "ngst");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(0, trace, "ngst", card);
 
 	return 0;
 }
@@ -6883,23 +6741,23 @@
 	memcpy(QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->sendbuf),
 	       &card->func_level, 2);
 
-	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
+	temp = __raw_devno_from_bus_id(CARD_DDEV_ID(card));
 	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(card->dma_stuff->sendbuf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(card->dma_stuff->sendbuf),
 	       &temp, 2);
 
 	QETH_DBF_TEXT2(0, trace, "iarw");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, trace, CARD_RDEV_ID(card));
 	QETH_DBF_HEX2(0, control, card->dma_stuff->sendbuf,
 		      QETH_DBF_CONTROL_LEN);
 
-	spin_lock_irqsave(get_ccwdev_lock(card->rdev), flags);
-	result = ccw_device_start(card->rdev, &card->dma_stuff->write_ccw,
+	spin_lock_irqsave(get_ccwdev_lock(CARD_RDEV(card)), flags);
+	result = ccw_device_start(CARD_RDEV(card), &card->dma_stuff->write_ccw,
 				  IDX_ACTIVATE_WRITE_STATE, 0, 0);
 	if (result) {
 		qeth_delay_millis(QETH_WAIT_BEFORE_2ND_DOIO);
-		result2 = ccw_device_start(card->rdev,
+		result2 = ccw_device_start(CARD_RDEV(card),
 					   &card->dma_stuff->write_ccw,
 					   IDX_ACTIVATE_WRITE_STATE, 0, 0);
 		sprintf(dbf_text, "IRW1%4x", result);
@@ -6909,7 +6767,7 @@
 		PRINT_WARN("qeth_idx_activate_read (write): do_IO returned "
 			   "%i, next try returns %i\n", result, result2);
 	}
-	spin_unlock_irqrestore(get_ccwdev_lock(card->rdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_RDEV(card)), flags);
 
 	if (atomic_read(&card->break_out)) {
 		QETH_DBF_TEXT3(0, trace, "IARWBRKO");
@@ -6918,9 +6776,9 @@
 
 	if (qeth_sleepon(card, QETH_MPC_TIMEOUT)) {
 		QETH_DBF_TEXT1(0, trace, "IRWT");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_RDEV_ID(card));
 		PRINT_ERR("IDX_ACTIVATE(wr) on read channel device %s: "
-			  "timeout\n", card->rdev->dev.bus_id);
+			  "timeout\n", CARD_RDEV_ID(card));
 		return -EIO;
 	}
 
@@ -6929,13 +6787,13 @@
 	card->dma_stuff->read_ccw.count = QETH_BUFSIZE;
 	card->dma_stuff->read_ccw.cda = QETH_GET_ADDR(card->dma_stuff->recbuf);
 
-	spin_lock_irqsave(get_ccwdev_lock(card->rdev), flags);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_RDEV(card)), flags);
 	result2 = 0;
-	result = ccw_device_start(card->rdev, &card->dma_stuff->read_ccw,
+	result = ccw_device_start(CARD_RDEV(card), &card->dma_stuff->read_ccw,
 				  IDX_ACTIVATE_READ_STATE, 0, 0);
 	if (result) {
 		qeth_delay_millis(QETH_WAIT_BEFORE_2ND_DOIO);
-		result2 = ccw_device_start(card->rdev,
+		result2 = ccw_device_start(CARD_RDEV(card),
 					   &card->dma_stuff->read_ccw,
 					   IDX_ACTIVATE_READ_STATE, 0, 0);
 		sprintf(dbf_text, "IRR1%4x", result);
@@ -6946,7 +6804,7 @@
 			   "returned %i, next try returns %i\n",
 			   result, result2);
 	}
-	spin_unlock_irqrestore(get_ccwdev_lock(card->rdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_RDEV(card)), flags);
 
 	if (result2) {
 		result = result2;
@@ -6956,21 +6814,21 @@
 
 	if (qeth_sleepon(card, QETH_MPC_TIMEOUT)) {
 		QETH_DBF_TEXT1(0, trace, "IRRT");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_RDEV_ID(card));
 		PRINT_ERR("IDX_ACTIVATE(rd) on read channel device %s: "
-			  "timeout\n", card->rdev->dev.bus_id);
+			  "timeout\n", CARD_RDEV_ID(card));
 		return -EIO;
 	}
 	QETH_DBF_TEXT2(0, trace, "iarr");
-	QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, trace, CARD_RDEV_ID(card));
 	QETH_DBF_HEX2(0, control, card->dma_stuff->recbuf,
 		      QETH_DBF_CONTROL_LEN);
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(card->dma_stuff->recbuf))) {
 		QETH_DBF_TEXT1(0, trace, "IRNR");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_RDEV_ID(card));
 		PRINT_ERR("IDX_ACTIVATE on read channel device %s: negative "
-			  "reply\n", card->rdev->dev.bus_id);
+			  "reply\n", CARD_RDEV_ID(card));
 		return -EIO;
 	}
 
@@ -6987,12 +6845,12 @@
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->recbuf), 2);
 	if (temp != qeth_peer_func_level(card->func_level)) {
 		QETH_DBF_TEXT1(0, trace, "IRFL");
-		QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_RDEV_ID(card));
 		sprintf(dbf_text, "%4x%4x", card->func_level, temp);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
 		PRINT_WARN("IDX_ACTIVATE on read channel device %s: function "
 			   "level mismatch (sent: 0x%x, received: 0x%x)\n",
-			   card->rdev->dev.bus_id, card->func_level, temp);
+			   CARD_RDEV_ID(card), card->func_level, temp);
 		result = -EIO;
 	}
 
@@ -7031,23 +6889,23 @@
 	memcpy(QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->sendbuf),
 	       &card->func_level, 2);
 
-	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
+	temp = __raw_devno_from_bus_id(CARD_DDEV_ID(card));
 	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(card->dma_stuff->sendbuf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(card->dma_stuff->sendbuf),
 	       &temp, 2);
 
 	QETH_DBF_TEXT2(0, trace, "iaww");
-	QETH_DBF_TEXT2(0, trace, card->wdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, trace, CARD_WDEV_ID(card));
 	QETH_DBF_HEX2(0, control, card->dma_stuff->sendbuf,
 		      QETH_DBF_CONTROL_LEN);
 
-	spin_lock_irqsave(get_ccwdev_lock(card->wdev), flags);
-	result = ccw_device_start(card->wdev, &card->dma_stuff->write_ccw,
+	spin_lock_irqsave(get_ccwdev_lock(CARD_WDEV(card)), flags);
+	result = ccw_device_start(CARD_WDEV(card), &card->dma_stuff->write_ccw,
 				  IDX_ACTIVATE_WRITE_STATE, 0, 0);
 	if (result) {
 		qeth_delay_millis(QETH_WAIT_BEFORE_2ND_DOIO);
-		result2 = ccw_device_start(card->wdev,
+		result2 = ccw_device_start(CARD_WDEV(card),
 					   &card->dma_stuff->write_ccw,
 					   IDX_ACTIVATE_WRITE_STATE, 0, 0);
 		sprintf(dbf_text, "IWW1%4x", result);
@@ -7058,7 +6916,7 @@
 			   "returned %i, next try returns %i\n",
 			   result, result2);
 	}
-	spin_unlock_irqrestore(get_ccwdev_lock(card->wdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_WDEV(card)), flags);
 
 	if (atomic_read(&card->break_out)) {
 		QETH_DBF_TEXT3(0, trace, "IAWWBRKO");
@@ -7067,9 +6925,9 @@
 
 	if (qeth_sleepon(card, QETH_MPC_TIMEOUT)) {
 		QETH_DBF_TEXT1(0, trace, "IWWT");
-		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_WDEV_ID(card));
 		PRINT_ERR("IDX_ACTIVATE(wr) on write channel device %s: "
-			  "timeout\n", card->wdev->dev.bus_id);
+			  "timeout\n", CARD_WDEV_ID(card));
 		return -EIO;
 	}
 
@@ -7081,13 +6939,13 @@
 	   read channel program */
 	card->dma_stuff->read_ccw.cda = QETH_GET_ADDR(card->dma_stuff->recbuf);
 
-	spin_lock_irqsave(get_ccwdev_lock(card->wdev), flags);
+	spin_lock_irqsave(get_ccwdev_lock(CARD_WDEV(card)), flags);
 	result2 = 0;
-	result = ccw_device_start(card->wdev, &card->dma_stuff->read_ccw,
+	result = ccw_device_start(CARD_WDEV(card), &card->dma_stuff->read_ccw,
 				  IDX_ACTIVATE_READ_STATE, 0, 0);
 	if (result) {
 		qeth_delay_millis(QETH_WAIT_BEFORE_2ND_DOIO);
-		result2 = ccw_device_start(card->wdev,
+		result2 = ccw_device_start(CARD_WDEV(card),
 					   &card->dma_stuff->read_ccw,
 					   IDX_ACTIVATE_READ_STATE, 0, 0);
 		sprintf(dbf_text, "IWR1%4x", result);
@@ -7098,7 +6956,7 @@
 			   "%i, next try returns %i\n", result, result2);
 	}
 
-	spin_unlock_irqrestore(get_ccwdev_lock(card->wdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(CARD_WDEV(card)), flags);
 
 	if (result2) {
 		result = result2;
@@ -7108,33 +6966,33 @@
 
 	if (qeth_sleepon(card, QETH_MPC_TIMEOUT)) {
 		QETH_DBF_TEXT1(0, trace, "IWRT");
-		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_WDEV_ID(card));
 		PRINT_ERR("IDX_ACTIVATE(rd) on write channel device %s: "
-			  "timeout\n", card->wdev->dev.bus_id);
+			  "timeout\n", CARD_WDEV_ID(card));
 		return -EIO;
 	}
 	QETH_DBF_TEXT2(0, trace, "iawr");
-	QETH_DBF_TEXT2(0, trace, card->wdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, trace, CARD_WDEV_ID(card));
 	QETH_DBF_HEX2(0, control, card->dma_stuff->recbuf,
 		      QETH_DBF_CONTROL_LEN);
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(card->dma_stuff->recbuf))) {
 		QETH_DBF_TEXT1(0, trace, "IWNR");
-		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_WDEV_ID(card));
 		PRINT_ERR("IDX_ACTIVATE on write channel device %s: negative "
-			  "reply\n", card->wdev->dev.bus_id);
+			  "reply\n", CARD_WDEV_ID(card));
 		return -EIO;
 	}
 
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->recbuf), 2);
 	if ((temp & ~0x0100) != qeth_peer_func_level(card->func_level)) {
 		QETH_DBF_TEXT1(0, trace, "IWFM");
-		QETH_DBF_TEXT1(0, trace, card->wdev->dev.bus_id);
+		QETH_DBF_TEXT1(0, trace, CARD_WDEV_ID(card));
 		sprintf(dbf_text, "%4x%4x", card->func_level, temp);
 		QETH_DBF_TEXT1(0, trace, dbf_text);
 		PRINT_WARN("IDX_ACTIVATE on write channel device %s: function "
 			   "level mismatch (sent: 0x%x, received: 0x%x)\n",
-			   card->wdev->dev.bus_id, card->func_level, temp);
+			   CARD_WDEV_ID(card), card->func_level, temp);
 		result = -EIO;
 	}
 
@@ -7249,8 +7107,7 @@
 		memcpy(&framesize, QETH_ULP_ENABLE_RESP_MAX_MTU(buffer), 2);
 		mtu = qeth_get_mtu_outof_framesize(framesize);
 
-		QETH_DBF_TEXT2(0, trace, "ule");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "ule", card);
 		sprintf(dbf_text, "mtu=%4x", mtu);
 		QETH_DBF_TEXT2(0, trace, dbf_text);
 
@@ -7300,7 +7157,7 @@
 	memcpy(QETH_ULP_SETUP_FILTER_TOKEN(card->send_buf),
 	       &card->token.ulp_filter_r, QETH_MPC_TOKEN_LENGTH);
 
-	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
+	temp = __raw_devno_from_bus_id(CARD_DDEV_ID(card));
 	memcpy(QETH_ULP_SETUP_CUA(card->send_buf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_ULP_SETUP_REAL_DEVADDR(card->send_buf), &temp, 2);
@@ -7375,7 +7232,7 @@
 			ptr++;
 		}
 
-	init_data.cdev = card->ddev;
+	init_data.cdev = CARD_DDEV(card);
 	init_data.q_format = qeth_get_q_format(card->type);
 	init_data.qib_param_field_format = 0;
 	init_data.qib_param_field = adapter_area;
@@ -7413,7 +7270,7 @@
 	int result;
 	char dbf_text[15];
 
-	result = qdio_activate(card->ddev, 0);
+	result = qdio_activate(CARD_DDEV(card), 0);
 
 	sprintf(dbf_text, "qda=%4x", result);
 	QETH_DBF_TEXT3(0, trace, dbf_text);
@@ -7680,8 +7537,7 @@
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) dev->priv;
-	QETH_DBF_TEXT2(1, trace, "XMTO");
-	QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD2(1, trace, "XMTO", card);
 	card->stats->tx_errors++;
 	atomic_set(&card->problem, PROBLEM_TX_TIMEOUT);
 	qeth_schedule_recovery(card);
@@ -7737,8 +7593,7 @@
 
 	card = (struct qeth_card *) dev->priv;
 
-	QETH_DBF_TEXT3(0, trace, "inid");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "inid", card);
 
 	dev->tx_timeout = &qeth_tx_timeout;
 	dev->watchdog_timeo = QETH_TX_TIMEOUT;
@@ -7798,15 +7653,14 @@
 	char dbf_text[15];
 	int length;
 
-	QETH_DBF_TEXT3(0, trace, "gtua");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "gtua", card);
 
-	result = read_conf_data(card->ddev, (void **) &prcd, &length);
+	result = read_conf_data(CARD_DDEV(card), (void **) &prcd, &length);
 	if (result) {
 		sprintf(dbf_text, "rcd%4x", result);
 		QETH_DBF_TEXT3(0, trace, dbf_text);
 		PRINT_ERR("read_conf_data for device %s returned %i\n",
-			  card->ddev->dev.bus_id, result);
+			  CARD_DDEV_ID(card), result);
 		return result;
 	}
 
@@ -7866,9 +7720,9 @@
         } \
 } while (0)
 
-	DO_SEND_NOP(card->rdev);
-	DO_SEND_NOP(card->wdev);
-	DO_SEND_NOP(card->ddev);
+	DO_SEND_NOP(CARD_RDEV(card));
+	DO_SEND_NOP(CARD_WDEV(card));
+	DO_SEND_NOP(CARD_DDEV(card));
 
 exit:
 	return result;
@@ -7884,8 +7738,7 @@
 		return;
 	}
 
-	QETH_DBF_TEXT3(0, trace, "clcs");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "clcs", card);
 
 	atomic_set(&card->is_startlaned, 0);
 
@@ -7955,7 +7808,7 @@
  		if (i < card->options.inbound_buffer_count)
  			qeth_queue_input_buffer(card,i,0);
 	}
-	qdio_synchronize(card->ddev, QDIO_FLAG_SYNC_INPUT, 0);
+	qdio_synchronize(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0);
 }
 
 /* initializes all the structures for a card */
@@ -7974,8 +7827,7 @@
 	atomic_set(&card->shutdown_phase, 0);
 
 	if (atomic_read(&card->is_hardsetup)) {
-		QETH_DBF_TEXT2(1, trace, "hscd");
-		QETH_DBF_TEXT2(1, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(1, trace, "hscd", card);
 		PRINT_ALL("card is already hardsetup.\n");
 		return 0;
 	}
@@ -7990,8 +7842,7 @@
 		if (in_recovery) {
 			PRINT_STUPID("qeth: recovery: quiescing %s...\n",
 				     card->dev_name);
-			QETH_DBF_TEXT2(0, trace, "Rqsc");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "Rqsc", card);
 			qeth_wait_nonbusy(QETH_QUIESCE_WAIT_BEFORE_CLEAR);
 		}
 		clear_laps = QETH_HARDSETUP_CLEAR_LAPS;
@@ -8011,8 +7862,7 @@
 		if (in_recovery) {
 			PRINT_STUPID("qeth: recovery: still quiescing %s...\n",
 				     card->dev_name);
-			QETH_DBF_TEXT2(0, trace, "RQsc");
-			QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+			QETH_DBF_CARD2(0, trace, "RQsc", card);
 			qeth_wait_nonbusy(QETH_QUIESCE_WAIT_AFTER_CLEAR);
 		} else {
 			atomic_set(&card->shutdown_phase, 0);
@@ -8100,9 +7950,9 @@
 
 		QETH_DBF_TEXT2(0, trace, "hsissurd");
 		/* from here, there will always be an outstanding read */
-		spin_lock_irqsave(get_ccwdev_lock(card->rdev), flags);
+		spin_lock_irqsave(get_ccwdev_lock(CARD_RDEV(card)), flags);
 		qeth_issue_next_read(card);
-		spin_unlock_irqrestore(get_ccwdev_lock(card->rdev), flags);
+		spin_unlock_irqrestore(get_ccwdev_lock(CARD_RDEV(card)), flags);
 
 		PRINT_TOKENS;
 		QETH_DBF_TEXT2(0, trace, "hscmenab");
@@ -8141,12 +7991,11 @@
 		CHECK_ERRORS;
 	} while ((laps--) && (breakout == QETH_BREAKOUT_AGAIN));
 	if (breakout == QETH_BREAKOUT_AGAIN) {
-		QETH_DBF_TEXT2(0, trace, "hsnr");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "hsnr", card);
 		PRINT_ERR("qeth: recovery not successful on device "
 			  "%s/%s/%s; giving up.\n",
-			  card->rdev->dev.bus_id,
-			  card->wdev->dev.bus_id, card->ddev->dev.bus_id);
+			  CARD_RDEV_ID(card),
+			  CARD_WDEV_ID(card), CARD_DDEV_ID(card));
 		result = -EIO;
 		goto exit;
 	}
@@ -8212,9 +8061,9 @@
 		QETH_DBF_TEXT1(0, trace, "RECOVSUC");
 		PRINT_INFO("qeth: recovered device %s/%s/%s (%s) "
 			   "successfully.\n",
-			   card->rdev->dev.bus_id,
-			   card->wdev->dev.bus_id,
-			   card->ddev->dev.bus_id, card->dev_name);
+			   CARD_RDEV_ID(card),
+			   CARD_WDEV_ID(card),
+			   CARD_DDEV_ID(card), card->dev_name);
 	} else {
 		QETH_DBF_TEXT2(0, trace, "hrdsetok");
 
@@ -8254,9 +8103,9 @@
 			dbf_text[8] = 0;
 			printk("qeth: Device %s/%s/%s is a%s card%s%s%s\n"
 			       "with link type %s (portname: %s)\n",
-			       card->rdev->dev.bus_id,
-			       card->wdev->dev.bus_id,
-			       card->ddev->dev.bus_id,
+			       CARD_RDEV_ID(card),
+			       CARD_WDEV_ID(card),
+			       CARD_DDEV_ID(card),
 			       qeth_get_cardname(card->type,
 						 card->is_guest_lan),
 			       (card->level[0]) ? " (level: " : "",
@@ -8270,9 +8119,9 @@
 				printk("qeth: Device %s/%s/%s is a%s "
 				       "card%s%s%s\nwith link type %s "
 				       "(no portname needed by interface).\n",
-				       card->rdev->dev.bus_id,
-				       card->wdev->dev.bus_id,
-				       card->ddev->dev.bus_id,
+				       CARD_RDEV_ID(card),
+				       CARD_WDEV_ID(card),
+				       CARD_DDEV_ID(card),
 				       qeth_get_cardname(card->type,
 							 card->is_guest_lan),
 				       (card->level[0]) ? " (level: " : "",
@@ -8283,9 +8132,9 @@
 			else
 				printk("qeth: Device %s/%s/%s is a%s "
 				       "card%s%s%s\nwith link type %s.\n",
-				       card->rdev->dev.bus_id,
-				       card->wdev->dev.bus_id,
-				       card->ddev->dev.bus_id,
+				       CARD_RDEV_ID(card),
+				       CARD_WDEV_ID(card),
+				       CARD_DDEV_ID(card),
 				       qeth_get_cardname(card->type,
 							 card->is_guest_lan),
 				       (card->level[0]) ? " (level: " : "",
@@ -8311,11 +8160,10 @@
 	int result;
 	char name[15];
 
-	QETH_DBF_TEXT1(0, trace, "RINI");
-	QETH_DBF_TEXT1(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD1(0, trace, "RINI", card);
 
 	/* set a nice name ... */
-	sprintf(name, "qethrinid%s", card->rdev->dev.bus_id);
+	sprintf(name, "qethrinid%s", CARD_BUS_ID(card));
 	daemonize(name);
 
 	if (atomic_read(&card->shutdown_phase))
@@ -8391,9 +8239,9 @@
 				  "(%s/%s/%s), GIVING UP, "
 				  "OUTGOING PACKETS WILL BE DISCARDED!\n",
 				  card->dev_name,
-				  card->rdev->dev.bus_id,
-				  card->wdev->dev.bus_id,
-				  card->ddev->dev.bus_id);
+				  CARD_RDEV_ID(card),
+				  CARD_WDEV_ID(card),
+				  CARD_DDEV_ID(card));
 			/* early leave hard_start_xmit! */
 			atomic_set(&card->is_startlaned, 0);
 			qeth_wakeup_procfile();
@@ -8562,8 +8410,7 @@
 {
 	int i, j;
 
-	QETH_DBF_TEXT3(0, trace, "irb1");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "irb1", card);
 
 	for (i = 0; i < card->no_queues; i++) {
 		card->outbound_ringbuffer[i] =
@@ -8590,8 +8437,7 @@
 {
 	int i, j;
 
-	QETH_DBF_TEXT3(0, trace, "irb2");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "irb2", card);
 
 	for (i = 0; i < card->options.inbound_buffer_count; i++) {
 		for (j = 0; j < BUFFER_MAX_ELEMENTS; j++) {
@@ -8630,8 +8476,7 @@
 static void
 qeth_insert_card_into_list(struct qeth_card *card)
 {
-	QETH_DBF_TEXT3(0, trace, "icil");
-	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
+	QETH_DBF_CARD3(0, trace, "icil", card);
 
 	write_lock(&list_lock);
 	card->next = firstcard;
@@ -8646,8 +8491,8 @@
 	char dbf_text[15];
 
 	while (known_devices[i][4]) {
-		if ((card->rdev->id.dev_type == known_devices[i][2]) &&
-		    (card->rdev->id.dev_model == known_devices[i][3])) {
+		if ((CARD_RDEV(card)->id.dev_type == known_devices[i][2]) &&
+		    (CARD_RDEV(card)->id.dev_model == known_devices[i][3])) {
 			card->type = known_devices[i][4];
 			if (card->options.ena_ipat == ENABLE_TAKEOVER)
 				card->func_level = known_devices[i][6];
@@ -8655,7 +8500,7 @@
 				card->func_level = known_devices[i][7];
 			card->no_queues = known_devices[i][8];
 			card->is_multicast_different = known_devices[i][9];
-			QETH_DBF_TEXT2(0, setup, card->rdev->dev.bus_id);
+			QETH_DBF_TEXT2(0, setup, CARD_BUS_ID(card));
 			sprintf(dbf_text, "ctyp%4x", card->type);
 			QETH_DBF_TEXT2(0, setup, dbf_text);
 			return 0;
@@ -8663,10 +8508,10 @@
 		i++;
 	}
 	card->type = QETH_CARD_TYPE_UNKNOWN;
-	QETH_DBF_TEXT2(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_TEXT2(0, setup, CARD_BUS_ID(card));
 	sprintf(dbf_text, "ctypUNKN");
 	QETH_DBF_TEXT2(0, setup, dbf_text);
-	PRINT_ERR("unknown card type on device %s\n", card->rdev->dev.bus_id);
+	PRINT_ERR("unknown card type on device %s\n", CARD_BUS_ID(card));
 	return -ENOENT;
 }
 
@@ -8815,10 +8660,8 @@
 {
 	struct qeth_card *card;
 	struct net_device *dev = (struct net_device *) ptr;
-	char dbf_text[15];
 
-	sprintf(dbf_text, "devevent");
-	QETH_DBF_TEXT3(0, trace, dbf_text);
+	QETH_DBF_TEXT3(0, trace, "devevent");
 	QETH_DBF_HEX3(0, trace, &event, sizeof (unsigned long));
 	QETH_DBF_HEX3(0, trace, &dev, sizeof (void *));
 
@@ -8843,8 +8686,7 @@
 	struct net_device *dev = ifa->ifa_dev->dev;
 	char dbf_text[15];
 
-	sprintf(dbf_text, "ipevent");
-	QETH_DBF_TEXT3(0, trace, dbf_text);
+	QETH_DBF_TEXT3(0, trace, "ipevent");
 	QETH_DBF_HEX3(0, trace, &event, sizeof (unsigned long));
 	QETH_DBF_HEX3(0, trace, &dev, sizeof (void *));
 	sprintf(dbf_text, "%08x", ifa->ifa_address);
@@ -8869,10 +8711,8 @@
 	struct qeth_card *card;
 	struct inet6_ifaddr *ifa = (struct inet6_ifaddr *) ptr;
 	struct net_device *dev = ifa->idev->dev;
-	char dbf_text[15];
 
-	sprintf(dbf_text, "ip6event");
-	QETH_DBF_TEXT3(0, trace, dbf_text);
+	QETH_DBF_TEXT3(0, trace, "ip6event");
 	QETH_DBF_HEX3(0, trace, &event, sizeof (unsigned long));
 	QETH_DBF_HEX3(0, trace, &dev, sizeof (void *));
 	QETH_DBF_HEX3(0, trace, ifa->addr.s6_addr, QETH_DBF_TRACE_LEN);
@@ -8900,14 +8740,14 @@
 		card = firstcard;
 	clear_another_one:
 		if (card->type == QETH_CARD_TYPE_IQD) {
-			ccw_device_halt(card->ddev, 0);
-			ccw_device_clear(card->rdev, 0);
-			ccw_device_clear(card->wdev, 0);
-			ccw_device_clear(card->ddev, 0);
+			ccw_device_halt(CARD_DDEV(card), 0);
+			ccw_device_clear(CARD_RDEV(card), 0);
+			ccw_device_clear(CARD_WDEV(card), 0);
+			ccw_device_clear(CARD_DDEV(card), 0);
 		} else {
-			ccw_device_clear(card->ddev, 0);
-			ccw_device_clear(card->rdev, 0);
-			ccw_device_clear(card->wdev, 0);
+			ccw_device_clear(CARD_DDEV(card), 0);
+			ccw_device_clear(CARD_RDEV(card), 0);
+			ccw_device_clear(CARD_WDEV(card), 0);
 		}
 		if (card->next) {
 			card = card->next;
@@ -9121,9 +8961,9 @@
 			length += sprintf(buffer + length,
 					  "%s/%s/%s x%02X %10s %14s %2i"
 					  "  +++ CABLE PULLED +++\n",
-					  card->rdev->dev.bus_id,
-					  card->wdev->dev.bus_id,
-					  card->ddev->dev.bus_id,
+					  CARD_RDEV_ID(card),
+					  CARD_WDEV_ID(card),
+					  CARD_DDEV_ID(card),
 					  card->chpid,
 					  card->dev_name,
 					  qeth_get_cardname_short
@@ -9134,9 +8974,9 @@
 			length += sprintf(buffer + length,
 					  "%s/%s/%s x%02X %10s %14s %2i"
 					  "     %2s %10s %3s %3s %3i\n",
-					  card->rdev->dev.bus_id,
-					  card->wdev->dev.bus_id,
-					  card->ddev->dev.bus_id,
+					  CARD_RDEV_ID(card),
+					  CARD_WDEV_ID(card),
+					  CARD_DDEV_ID(card),
 					  card->chpid, card->dev_name,
 					  qeth_get_cardname_short
 					  (card->type, card->link_type,
@@ -9175,9 +9015,9 @@
 
 	while (card) {
 		_OUTP_IT("For card with devnos %s/%s/%s (%s):\n",
-			 card->rdev->dev.bus_id,
-			 card->wdev->dev.bus_id,
-			 card->ddev->dev.bus_id, card->dev_name);
+			 CARD_RDEV_ID(card),
+			 CARD_WDEV_ID(card),
+			 CARD_DDEV_ID(card), card->dev_name);
 		_OUTP_IT("  Skb's/buffers received                 : %i/%i\n",
 			 card->perf_stats.skbs_rec, card->perf_stats.bufs_rec);
 		_OUTP_IT("  Skb's/buffers sent                     : %i/%i\n",
@@ -9686,6 +9526,7 @@
 };
 
 static struct file_operations qeth_procfile_fops = {
+	.owner = THIS_MODULE,
 	.ioctl = qeth_procfile_ioctl,
 	.read = qeth_procfile_read,
 	.open = qeth_procfile_open,
@@ -9695,6 +9536,7 @@
 static struct proc_dir_entry *qeth_proc_file;
 
 static struct file_operations qeth_ipato_procfile_fops = {
+	.owner = THIS_MODULE,
 	.read = qeth_procfile_read,	/* same as above! */
 	.write = qeth_ipato_procfile_write,
 	.open = qeth_ipato_procfile_open,
@@ -9937,8 +9779,14 @@
 	.remove = ccwgroup_remove_ccwdev,
 };
 
+static void
+qeth_root_dev_release (struct device *dev)
+{
+}
+
 static struct device qeth_root_dev = {
 	.bus_id = "qeth",
+	.release = qeth_root_dev_release,
 };
 
 static struct ccwgroup_driver qeth_ccwgroup_driver;
@@ -10099,37 +9947,27 @@
 	tmp = strsep((char **) &buf, "\n");
 	cnt = strlen(tmp);
 	if (!strncmp(tmp, "primary_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "pri4");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "pri4", card);
 		card->options.routing_type4 =
 			PRIMARY_ROUTER | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "secondary_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "sec4");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "sec4", card);
 		card->options.routing_type4 =
 			SECONDARY_ROUTER | RESET_ROUTING_FLAG;
 	}  else if (!strncmp(tmp, "multicast_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "mcr4");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-
+		QETH_DBF_CARD2(0, trace, "mcr4", card);
 		card->options.routing_type4 =
 			MULTICAST_ROUTER | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "primary_connector", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "prc4");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-
+		QETH_DBF_CARD2(0, trace, "prc4", card);
 		card->options.routing_type4 =
 			PRIMARY_CONNECTOR | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "secondary_connector", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "scc4");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-
+		QETH_DBF_CARD2(0, trace, "scc4", card);
 		card->options.routing_type4 =
 			SECONDARY_CONNECTOR | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "no_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "nor4");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-		
+		QETH_DBF_CARD2(0, trace, "nor4", card);
 		card->options.routing_type4 = NO_ROUTER | RESET_ROUTING_FLAG;
 	} else {
 		PRINT_WARN("unknown command input in route4 attribute\n");
@@ -10192,37 +10030,28 @@
 	tmp = strsep((char **) &buf, "\n");
 	cnt = strlen(tmp);
 	if (!strncmp(tmp, "primary_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "pri6");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "pri6", card);
 		card->options.routing_type6 =
 			PRIMARY_ROUTER | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "secondary_router", cnt)) {
 				QETH_DBF_TEXT2(0, trace, "sec6");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "sec6", card);
 		card->options.routing_type6 =
 			SECONDARY_ROUTER | RESET_ROUTING_FLAG;
 	}  else if (!strncmp(tmp, "multicast_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "mcr6");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-
+		QETH_DBF_CARD2(0, trace, "mcr6", card);
 		card->options.routing_type6 =
 			MULTICAST_ROUTER | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "primary_connector", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "prc6");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-
+		QETH_DBF_CARD2(0, trace, "prc6", card);
 		card->options.routing_type6 =
 			PRIMARY_CONNECTOR | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "secondary_connector", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "scc6");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-
+		QETH_DBF_CARD2(0, trace, "scc6", card);
 		card->options.routing_type6 =
 			SECONDARY_CONNECTOR | RESET_ROUTING_FLAG;
 	} else if (!strncmp(tmp, "no_router", cnt)) {
-		QETH_DBF_TEXT2(0, trace, "nor6");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-		
+		QETH_DBF_CARD2(0, trace, "nor6", card);
 		card->options.routing_type6 = NO_ROUTER | RESET_ROUTING_FLAG;
 	} else {
 		PRINT_WARN("unknown command input in route6 attribute\n");
@@ -10663,8 +10492,7 @@
 
 	i = simple_strtoul(buf, &tmp, 16);
 	if (i == 1) {
-		QETH_DBF_TEXT2(0, trace, "UTRC");
-		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
+		QETH_DBF_CARD2(0, trace, "UTRC", card);
 		atomic_set(&card->problem, PROBLEM_USER_TRIGGERED_RECOVERY);
 		qeth_schedule_recovery(card);
 		return count;
@@ -10746,15 +10574,12 @@
 	gdev->dev.driver_data = card;
 	card->gdev = gdev;
 
-	card->rdev = gdev->cdev[0];
 	gdev->cdev[0]->handler = qeth_interrupt_handler_read;
 	gdev->cdev[0]->dev.driver_data = card;
 
-	card->wdev = gdev->cdev[1];
 	gdev->cdev[1]->handler = qeth_interrupt_handler_write;
 	gdev->cdev[1]->dev.driver_data = card;
 
-	card->ddev = gdev->cdev[2];
 	gdev->cdev[2]->handler = qeth_interrupt_handler_qdio;
 	gdev->cdev[2]->dev.driver_data = card;
 
@@ -10779,16 +10604,11 @@
 {
 	int result;
 
-	PRINT_STUPID("%s: got devices %s, %s, %s\n",
-		     __func__,
-		     rdev->dev.bus_id, wdev->dev.bus_id, ddev->dev.bus_id);
-
-	ccw_device_set_online(card->rdev);
-	ccw_device_set_online(card->wdev);
-	ccw_device_set_online(card->ddev);
+	ccw_device_set_online(CARD_RDEV(card));
+	ccw_device_set_online(CARD_WDEV(card));
+	ccw_device_set_online(CARD_DDEV(card));
 
-	QETH_DBF_TEXT1(0, setup, "activ");
-	QETH_DBF_TEXT1(0, setup, card->rdev->dev.bus_id);
+	QETH_DBF_CARD1(0, setup, "activ", card);
 	QETH_DBF_HEX1(0, setup, &card, sizeof (void *));
 	QETH_DBF_HEX1(0, setup, &card->dev, sizeof (void *));
 	QETH_DBF_HEX1(0, setup, &card->stats, sizeof (void *));
@@ -10833,7 +10653,7 @@
 		goto out_remove;
 	}
 	if (sysfs_create_link(&card->dev->class_dev.kobj, &card->gdev->dev.kobj,
-			      card->gdev->dev.bus_id)) {
+			      CARD_BUS_ID(card))) {
 		sysfs_remove_link(&card->gdev->dev.kobj, card->dev_name);
 		qeth_unregister_netdev(card);
 		goto out_remove;
@@ -10847,9 +10667,9 @@
 out:
 	QETH_DBF_TEXT4(0, trace, "freecard");
 
-	ccw_device_set_offline(card->ddev);
-	ccw_device_set_offline(card->wdev);
-	ccw_device_set_offline(card->rdev);
+	ccw_device_set_offline(CARD_DDEV(card));
+	ccw_device_set_offline(CARD_WDEV(card));
+	ccw_device_set_offline(CARD_RDEV(card));
 
 	return -ENODEV;
 }
@@ -10894,9 +10714,9 @@
 
 	QETH_DBF_TEXT4(0, trace, "freecard");
 
-	ccw_device_set_offline(card->ddev);
-	ccw_device_set_offline(card->wdev);
-	ccw_device_set_offline(card->rdev);
+	ccw_device_set_offline(CARD_DDEV(card));
+	ccw_device_set_offline(CARD_WDEV(card));
+	ccw_device_set_offline(CARD_RDEV(card));
 
 	qeth_free_card_stuff(card);
 
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Sun Sep 28 02:50:05 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Mon Oct  6 10:59:26 2003
@@ -14,7 +14,7 @@
 
 #define QETH_NAME " qeth"
 
-#define VERSION_QETH_H "$Revision: 1.56 $"
+#define VERSION_QETH_H "$Revision: 1.58 $"
 
 /******************** CONFIG STUFF ***********************/
 //#define QETH_DBF_LIKE_HELL
@@ -106,6 +106,12 @@
                 debug_text_event(qeth_dbf_##name,level,text); \
         } while (0)
 
+#define QETH_DBF_CARD(ex,name,level,text,card) \
+	do { \
+		QETH_DBF_TEXT(ex,name,level,text); \
+		QETH_DBF_TEXT(ex,name,level,card->gdev->dev.bus_id); \
+	} while (0)
+
 #define QETH_DBF_HEX0(ex,name,addr,len) QETH_DBF_HEX(ex,name,0,addr,len)
 #define QETH_DBF_HEX1(ex,name,addr,len) QETH_DBF_HEX(ex,name,1,addr,len)
 #define QETH_DBF_HEX2(ex,name,addr,len) QETH_DBF_HEX(ex,name,2,addr,len)
@@ -136,6 +142,21 @@
 #define QETH_DBF_TEXT6(ex,name,text) do {} while (0)
 #endif /* QETH_DBF_LIKE_HELL */
 
+#define QETH_DBF_CARD0(ex,name,text,card) QETH_DBF_CARD(ex,name,0,text,card)
+#define QETH_DBF_CARD1(ex,name,text,card) QETH_DBF_CARD(ex,name,1,text,card)
+#define QETH_DBF_CARD2(ex,name,text,card) QETH_DBF_CARD(ex,name,2,text,card)
+#ifdef QETH_DBF_LIKE_HELL
+#define QETH_DBF_CARD3(ex,name,text,card) QETH_DBF_CARD(ex,name,3,text,card)
+#define QETH_DBF_CARD4(ex,name,text,card) QETH_DBF_CARD(ex,name,4,text,card)
+#define QETH_DBF_CARD5(ex,name,text,card) QETH_DBF_CARD(ex,name,5,text,card)
+#define QETH_DBF_CARD6(ex,name,text,card) QETH_DBF_CARD(ex,name,6,text,card)
+#else /* QETH_DBF_LIKE_HELL */
+#define QETH_DBF_CARD3(ex,name,text,card) do {} while (0)
+#define QETH_DBF_CARD4(ex,name,text,card) do {} while (0)
+#define QETH_DBF_CARD5(ex,name,text,card) do {} while (0)
+#define QETH_DBF_CARD6(ex,name,text,card) do {} while (0)
+#endif /* QETH_DBF_LIKE_HELL */
+
 #define QETH_DBF_SETUP_NAME "qeth_setup"
 #define QETH_DBF_SETUP_LEN 8
 #define QETH_DBF_SETUP_INDEX 3
@@ -662,6 +683,14 @@
 #define PROBLEM_MACHINE_CHECK 11
 #define PROBLEM_TX_TIMEOUT 12
 
+#define CARD_RDEV(card) card->gdev->cdev[0]
+#define CARD_WDEV(card) card->gdev->cdev[1]
+#define CARD_DDEV(card) card->gdev->cdev[2]
+#define CARD_BUS_ID(card) card->gdev->dev.bus_id
+#define CARD_RDEV_ID(card) card->gdev->cdev[0]->dev.bus_id
+#define CARD_WDEV_ID(card) card->gdev->cdev[1]->dev.bus_id
+#define CARD_DDEV_ID(card) card->gdev->cdev[2]->dev.bus_id
+
 #define SENSE_COMMAND_REJECT_BYTE 0
 #define SENSE_COMMAND_REJECT_FLAG 0x80
 #define SENSE_RESETTING_EVENT_BYTE 1
@@ -926,9 +955,6 @@
 
 	/* device and I/O data */
 	struct ccwgroup_device *gdev;
-	struct ccw_device *rdev;
-	struct ccw_device *wdev;
-	struct ccw_device *ddev;
 	unsigned short unit_addr2;
 	unsigned short cula;
 	unsigned short chpid;
