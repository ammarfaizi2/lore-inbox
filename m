Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUCITSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUCITRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:17:39 -0500
Received: from palrel10.hp.com ([156.153.255.245]:33984 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262099AbUCITJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:09:00 -0500
Date: Tue, 9 Mar 2004 11:08:59 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (9/14) irda_start_timer inline
Message-ID: <20040309190859.GJ14543@bougret.hpl.hp.com>
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

ir264_irsyms_09_timer.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(9/14) irda_start_timer inline

Make irda_start_timer inline rather than exporting, because
it probably takes more code to call than just put inline



diff -u -p -r linux/include/net/irda.s8/timer.h linux/include/net/irda/timer.h
--- linux/include/net/irda.s8/timer.h	Wed Mar  3 17:01:37 2004
+++ linux/include/net/irda/timer.h	Mon Mar  8 19:15:41 2004
@@ -71,8 +71,18 @@ struct lap_cb;
 
 typedef void (*TIMER_CALLBACK)(void *);
 
-void irda_start_timer(struct timer_list *ptimer, int timeout, void* data,
-		      TIMER_CALLBACK callback);
+static inline void irda_start_timer(struct timer_list *ptimer, int timeout, 
+				    void* data, TIMER_CALLBACK callback)
+{
+	ptimer->function = (void (*)(unsigned long)) callback;
+	ptimer->data = (unsigned long) data;
+	
+	/* Set new value for timer (update or add timer).
+	 * We use mod_timer() because it's more efficient and also
+	 * safer with respect to race conditions - Jean II */
+	mod_timer(ptimer, jiffies + timeout);
+}
+
 
 void irlap_start_slot_timer(struct irlap_cb *self, int timeout);
 void irlap_start_query_timer(struct irlap_cb *self, int timeout);
diff -u -p -r linux/net/irda.s8/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s8/irsyms.c	Mon Mar  8 19:10:29 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:15:41 2004
@@ -97,7 +97,6 @@ EXPORT_SYMBOL(irda_task_execute);
 EXPORT_SYMBOL(irda_task_next_state);
 EXPORT_SYMBOL(irda_task_delete);
 
-EXPORT_SYMBOL(irda_start_timer);
 
 #ifdef CONFIG_IRDA_DEBUG
 __u32 irda_debug = IRDA_DEBUG_LEVEL;
diff -u -p -r linux/net/irda.s8/timer.c linux/net/irda/timer.c
--- linux/net/irda.s8/timer.c	Wed Dec 17 18:58:56 2003
+++ linux/net/irda/timer.c	Mon Mar  8 19:15:41 2004
@@ -41,29 +41,6 @@ static void irlap_wd_timer_expired(void*
 static void irlap_backoff_timer_expired(void* data);
 static void irlap_media_busy_expired(void* data); 
 
-/*
- * Function irda_start_timer (timer, timeout)
- *
- *    Start an IrDA timer
- *
- */
-void irda_start_timer(struct timer_list *ptimer, int timeout, void *data,
-		      TIMER_CALLBACK callback) 
-{
-	/* 
-	 * For most architectures void * is the same as unsigned long, but
-	 * at least we try to use void * as long as possible. Since the 
-	 * timer functions use unsigned long, we cast the function here
-	 */
-	ptimer->function = (void (*)(unsigned long)) callback;
-	ptimer->data = (unsigned long) data;
-	
-	/* Set new value for timer (update or add timer).
-	 * We use mod_timer() because it's more efficient and also
-	 * safer with respect to race conditions - Jean II */
-	mod_timer(ptimer, jiffies + timeout);
-}
-
 void irlap_start_slot_timer(struct irlap_cb *self, int timeout)
 {
 	irda_start_timer(&self->slot_timer, timeout, (void *) self, 
