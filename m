Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264001AbTJFRyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTJFRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:54:22 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17337 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264001AbTJFRyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:54:19 -0400
Date: Mon, 6 Oct 2003 13:54:16 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       Florian La Roche <laroche@redhat.com>
Subject: Re: s390 test6 patches: descriptions.
Message-ID: <20031006135416.B16665@devserv.devel.redhat.com>
References: <mailman.1065432601.831.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <mailman.1065432601.831.linux-kernel2news@redhat.com>; from schwidefsky@de.ibm.com on Mon, Oct 06, 2003 at 11:23:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> more patches for s390. 7 this time, one is big and another one is VERY big.

This is all fine, but the removal of dst_link_failure is missing.
Why is that? We agreed about it several update cycles before.
I am not doing because I'm bored, we hit actual oopses (ok, on 2.4).

-- Pete

diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/net/ctcmain.c linux-2.6.0-test6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6.0-test6/drivers/s390/net/ctcmain.c	2003-10-01 15:17:54.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/net/ctcmain.c	2003-10-01 15:31:17.000000000 -0700
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
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/net/netiucv.c linux-2.6.0-test6-s390/drivers/s390/net/netiucv.c
--- linux-2.6.0-test6/drivers/s390/net/netiucv.c	2003-10-01 15:17:54.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/net/netiucv.c	2003-10-01 15:31:17.000000000 -0700
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
diff -urN -X dontdiff linux-2.6.0-test6/drivers/s390/net/qeth.c linux-2.6.0-test6-s390/drivers/s390/net/qeth.c
--- linux-2.6.0-test6/drivers/s390/net/qeth.c	2003-10-01 15:17:54.000000000 -0700
+++ linux-2.6.0-test6-s390/drivers/s390/net/qeth.c	2003-10-01 15:36:16.000000000 -0700
@@ -1996,7 +1996,6 @@
 			case ERROR_LINK_FAILURE:
 			case ERROR_KICK_THAT_PUPPY:
 				QETH_DBF_TEXT4(0, trace, "endeglnd");
-				dst_link_failure(skb);
 				atomic_dec(&skb->users);
 				dev_kfree_skb_irq(skb);
 				break;
@@ -2489,7 +2488,6 @@
 
 	if (!card) {
 		QETH_DBF_TEXT2(0, trace, "XMNSNOCD");
-		dst_link_failure(skb);
 		dev_kfree_skb_irq(skb);
 		return 0;
 	}
@@ -2501,7 +2499,6 @@
 		card->stats->tx_carrier_errors++;
 		QETH_DBF_TEXT2(0, trace, "XMNS");
 		QETH_DBF_TEXT2(0, trace, card->rdev->dev.bus_id);
-		dst_link_failure(skb);
 		dev_kfree_skb_irq(skb);
 		return 0;
 	}
