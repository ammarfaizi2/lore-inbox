Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTIJJNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTIJJNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:13:20 -0400
Received: from [203.145.184.221] ([203.145.184.221]:24588 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S264780AbTIJJNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:13:09 -0400
Subject: [PATCh 2.6.0-test5][NET] fix 6pack.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: NatureSoft Private Limited
Message-Id: <1063185237.4418.79.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 14:43:57 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiles fine but untested. The following changes are made:

1. replace sti/cli with spin_lock
2. cleanup timer management code

Vinay

--- /home/nvinay/tmp/6pack.c	2003-09-09 21:08:24.000000000 +0530
+++ linux-2.6.0-test5/drivers/net/hamradio/6pack.c	2003-09-10 13:25:22.000000000 +0530
@@ -122,6 +122,7 @@
 	unsigned char		status2;
 	unsigned char		tx_enable;
 	unsigned char		tnc_ok;
+	spinlock_t		rcv_lock;
 
 	struct timer_list	tx_t;
 	struct timer_list	resync_t;
@@ -140,7 +141,7 @@
 MODULE_PARM(sixpack_maxdev, "i");
 MODULE_PARM_DESC(sixpack_maxdev, "number of 6PACK devices");
 
-static void sp_start_tx_timer(struct sixpack *);
+static inline void sp_start_tx_timer(struct sixpack *);
 static void sp_xmit_on_air(unsigned long);
 static void resync_tnc(unsigned long);
 static void sixpack_decode(struct sixpack *, unsigned char[], int);
@@ -478,10 +479,17 @@
 	sp->tnc_ok      = 0;
 	sp->tx_enable   = 0;
 
+	spin_lock_init(&sp->rcv_lock);
+
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
 
@@ -516,7 +524,6 @@
 static void sixpack_receive_buf(struct tty_struct *tty, const unsigned char *cp, char *fp, int count)
 {
 	unsigned char buf[512];
-	unsigned long flags;
 	int count1;
 
 	struct sixpack *sp = (struct sixpack *) tty->disc_data;
@@ -525,10 +532,9 @@
 	    !netif_running(sp->dev) || !count)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_bh(&sp->rcv_lock);
 	memcpy(buf, cp, count<sizeof(buf)? count:sizeof(buf));
-	restore_flags(flags);
+	spin_unlock_bh(&sp->rcv_lock);
 
 	/* Read the characters out of the buffer */
 
@@ -804,15 +810,10 @@
 
 
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
 
 
@@ -884,12 +885,7 @@
 
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
 
@@ -941,13 +937,8 @@
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
@@ -983,11 +974,7 @@
 
 	/* Start resync timer again -- the TNC might be still absent */
 
-	del_timer(&sp->resync_t);
-	sp->resync_t.data = (unsigned long) sp;
-	sp->resync_t.function = resync_tnc;
-	sp->resync_t.expires = jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 }
 
 


