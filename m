Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTBUABW>; Thu, 20 Feb 2003 19:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTBUABW>; Thu, 20 Feb 2003 19:01:22 -0500
Received: from palrel11.hp.com ([156.153.255.246]:6375 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S267329AbTBUAA3>;
	Thu, 20 Feb 2003 19:00:29 -0500
Date: Thu, 20 Feb 2003 16:10:34 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : IrDA timer fix
Message-ID: <20030221001034.GF26770@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir253_timer_mod.diff :
--------------------
	o [FEATURE] Make IrDA timers use mod_timer instead of add+del_timer



diff -u -p linux/net/irda/timer.d5.c  linux/net/irda/timer.c
--- linux/net/irda/timer.d5.c	Thu Jan  9 13:36:15 2003
+++ linux/net/irda/timer.c	Thu Jan  9 13:51:03 2003
@@ -39,8 +39,8 @@ static void irlap_query_timer_expired(vo
 static void irlap_final_timer_expired(void* data);
 static void irlap_wd_timer_expired(void* data);
 static void irlap_backoff_timer_expired(void* data);
-
 static void irlap_media_busy_expired(void* data); 
+
 /*
  * Function irda_start_timer (timer, timeout)
  *
@@ -50,19 +50,18 @@ static void irlap_media_busy_expired(voi
 void irda_start_timer(struct timer_list *ptimer, int timeout, void *data,
 		      TIMER_CALLBACK callback) 
 {
-	del_timer(ptimer);
- 
-	ptimer->data = (unsigned long) data;
-
 	/* 
 	 * For most architectures void * is the same as unsigned long, but
 	 * at least we try to use void * as long as possible. Since the 
 	 * timer functions use unsigned long, we cast the function here
 	 */
 	ptimer->function = (void (*)(unsigned long)) callback;
-	ptimer->expires = jiffies + timeout;
+	ptimer->data = (unsigned long) data;
 	
-	add_timer(ptimer);
+	/* Set new value for timer (update or add timer).
+	 * We use mod_timer() because it's more efficient and also
+	 * safer with respect to race conditions - Jean II */
+	mod_timer(ptimer, jiffies + timeout);
 }
 
 void irlap_start_slot_timer(struct irlap_cb *self, int timeout)
@@ -136,8 +135,7 @@ void irlmp_start_idle_timer(struct lap_c
 void irlmp_stop_idle_timer(struct lap_cb *self) 
 {
 	/* If timer is activated, kill it! */
-	if(timer_pending(&self->idle_timer))
-		del_timer(&self->idle_timer);
+	del_timer(&self->idle_timer);
 }
 
 /*
