Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUBTSPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUBTSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:15:49 -0500
Received: from [61.95.227.64] ([61.95.227.64]:53378 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S261252AbUBTSPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:15:45 -0500
Message-ID: <40364EC2.7000900@gsecone.com>
Date: Fri, 20 Feb 2004 18:15:30 +0000
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.3][NET/HAMRADIO] 6pack.c: timer code cleanups
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch replaces sequence of del_timer, add_timer with mod_timier.
Untested.

Thanks
Vinay

 6pack.c |   38 ++++++++++++--------------------------
 1 files changed, 12 insertions(+), 26 deletions(-)

diff -urN linux-2.6.3-rc1-bk1/drivers/net/hamradio/6pack.c linux-2.6.3-rc1-bk1-nvk/drivers/net/hamradio/6pack.c
--- linux-2.6.3-rc1-bk1/drivers/net/hamradio/6pack.c	2004-02-09 19:22:40.000000000 +0000
+++ linux-2.6.3-rc1-bk1-nvk/drivers/net/hamradio/6pack.c	2004-02-09 20:11:47.000000000 +0000
@@ -140,7 +140,7 @@
 MODULE_PARM(sixpack_maxdev, "i");
 MODULE_PARM_DESC(sixpack_maxdev, "number of 6PACK devices");
 
-static void sp_start_tx_timer(struct sixpack *);
+static inline void sp_start_tx_timer(struct sixpack *);
 static void sp_xmit_on_air(unsigned long);
 static void resync_tnc(unsigned long);
 static void sixpack_decode(struct sixpack *, unsigned char[], int);
@@ -481,7 +481,12 @@
 	netif_start_queue(dev);
 
 	init_timer(&sp->tx_t);
+	sp->tx_t.data = (unsigned long) sp;
+	sp->tx_t.function = sp_xmit_on_air;
+
 	init_timer(&sp->resync_t);
+	sp->resync_t.data = (unsigned long) sp;
+	sp->resync_t.function = resync_tnc;
 	return 0;
 }
 
@@ -800,15 +805,10 @@
 
 
 /* ----> 6pack timer interrupt handler and friends. <---- */
-static void sp_start_tx_timer(struct sixpack *sp)
+static inline void sp_start_tx_timer(struct sixpack *sp)
 {
 	int when = sp->slottime;
-
-	del_timer(&sp->tx_t);
-	sp->tx_t.data = (unsigned long) sp;
-	sp->tx_t.function = sp_xmit_on_air;
-	sp->tx_t.expires = jiffies + ((when+1)*HZ)/100;
-	add_timer(&sp->tx_t);
+	mod_timer(&sp->tx_t, jiffies + ((when+1)*HZ)/100);
 }
 
 
@@ -880,12 +880,7 @@
 
 	sp->tty->driver->write(sp->tty, 0, &inbyte, 1);
 
-	del_timer(&sp->resync_t);
-	sp->resync_t.data = (unsigned long) sp;
-	sp->resync_t.function = resync_tnc;
-	sp->resync_t.expires = jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
-
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 	return 0;
 }
 
@@ -937,13 +932,8 @@
         /* if the state byte has been received, the TNC is present,
            so the resync timer can be reset. */
 
-	if (sp->tnc_ok == 1) {
-		del_timer(&sp->resync_t);
-		sp->resync_t.data = (unsigned long) sp;
-		sp->resync_t.function = resync_tnc;
-		sp->resync_t.expires = jiffies + SIXP_INIT_RESYNC_TIMEOUT;
-		add_timer(&sp->resync_t);
-	}
+	if (sp->tnc_ok == 1)
+		mod_timer(&sp->resync_t, jiffies + SIXP_INIT_RESYNC_TIMEOUT);
 
 	sp->status1 = cmd & SIXP_PRIO_DATA_MASK;
 }
@@ -979,11 +969,7 @@
 
 	/* Start resync timer again -- the TNC might be still absent */
 
-	del_timer(&sp->resync_t);
-	sp->resync_t.data = (unsigned long) sp;
-	sp->resync_t.function = resync_tnc;
-	sp->resync_t.expires = jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 }
 
 

