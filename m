Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUCZUfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbUCZUfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:35:43 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:24055 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261205AbUCZUen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:34:43 -0500
Date: Fri, 26 Mar 2004 21:34:30 +0100
From: Armin Schindler <armin@melware.de>
Message-Id: <200403262034.i2QKYUTL004786@phoenix.one.melware.de>
To: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] 2.6 ISDN kernelcapi receive workqueue and locking rework
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus,

with this patch the ISDN kernel CAPI code uses a per application
workqueue with proper locking to prevent message re-ordering
due to the fact a workqueue may run on another CPU at the same time.
Also some locks for internal data is added.

Please apply.

Thanks,
Armin


Name: ISDN Kernel CAPI: receive workqueue and locking rework
Author: Armin Schindler 

D: Removed global recv_queue work, use per application workqueue.
   Added proper locking mechanisms for application, controller and
   application workqueue function.
   Increased max. number of possible applications and controllers.



--- linux-2.5/drivers/isdn/capi/kcapi.c_orig	2004-03-26 21:01:27.000000000 +0100
+++ linux-2.5/drivers/isdn/capi/kcapi.c	2004-03-26 21:03:40.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: kcapi.c,v 1.1.2.7 2004/03/16 08:01:47 armin Exp $
+/* $Id: kcapi.c,v 1.1.2.8 2004/03/26 19:57:20 armin Exp $
  * 
  * Kernel CAPI 2.0 Module
  * 
@@ -31,7 +31,7 @@
 #include <linux/b1lli.h>
 #endif
 
-static char *revision = "$Revision: 1.1.2.7 $";
+static char *revision = "$Revision: 1.1.2.8 $";
 
 /* ------------------------------------------------------------- */
 
@@ -63,13 +63,13 @@
 LIST_HEAD(capi_drivers);
 rwlock_t capi_drivers_list_lock = RW_LOCK_UNLOCKED;
 
+static rwlock_t application_lock = RW_LOCK_UNLOCKED;
+static DECLARE_MUTEX(controller_sem);
+
 struct capi20_appl *capi_applications[CAPI_MAXAPPL];
 struct capi_ctr *capi_cards[CAPI_MAXCONTR];
 
 static int ncards;
-static struct sk_buff_head recv_queue;
-
-static struct work_struct tq_recv_notify;
 
 /* -------- controller ref counting -------------------------------------- */
 
@@ -174,7 +174,7 @@
 
 	for (applid = 1; applid <= CAPI_MAXAPPL; applid++) {
 		ap = get_capi_appl_by_nr(applid);
-		if (ap && ap->callback)
+		if (ap && ap->callback && !ap->release_in_progress)
 			ap->callback(KCI_CONTRUP, contr, &card->profile);
 	}
 }
@@ -192,7 +192,7 @@
 
 	for (applid = 1; applid <= CAPI_MAXAPPL; applid++) {
 		ap = get_capi_appl_by_nr(applid);
-		if (ap && ap->callback)
+		if (ap && ap->callback && !ap->release_in_progress)
 			ap->callback(KCI_CONTRDOWN, contr, 0);
 	}
 }
@@ -237,38 +237,39 @@
 	
 /* -------- Receiver ------------------------------------------ */
 
-static void recv_handler(void *dummy)
+static void recv_handler(void *_ap)
 {
 	struct sk_buff *skb;
-	struct capi20_appl *ap;
+	struct capi20_appl *ap = (struct capi20_appl *) _ap;
 
-	while ((skb = skb_dequeue(&recv_queue)) != 0) {
-		ap = get_capi_appl_by_nr(CAPIMSG_APPID(skb->data));
-		if (!ap) {
-			printk(KERN_ERR "kcapi: recv_handler: applid %d ? (%s)\n",
-				CAPIMSG_APPID(skb->data), capi_message2str(skb->data));
-			kfree_skb(skb);
-			continue;
-		}
+	if ((!ap) || (ap->release_in_progress))
+		return;
 
+	down(&ap->recv_sem);
+	while ((skb = skb_dequeue(&ap->recv_queue))) {
 		if (CAPIMSG_CMD(skb->data) == CAPI_DATA_B3_IND)
 			ap->nrecvdatapkt++;
 		else
 			ap->nrecvctlpkt++;
+
 		ap->recv_message(ap, skb);
 	}
+	up(&ap->recv_sem);
 }
 
 void capi_ctr_handle_message(struct capi_ctr * card, u16 appl, struct sk_buff *skb)
 {
+	struct capi20_appl *ap;
 	int showctl = 0;
 	u8 cmd, subcmd;
+	unsigned long flags;
 
 	if (card->cardstate != CARD_RUNNING) {
 		printk(KERN_INFO "kcapi: controller %d not active, got: %s",
 		       card->cnr, capi_message2str(skb->data));
 		goto error;
 	}
+	
 	cmd = CAPIMSG_COMMAND(skb->data);
         subcmd = CAPIMSG_SUBCOMMAND(skb->data);
 	if (cmd == CAPI_DATA_B3 && subcmd == CAPI_IND) {
@@ -293,8 +294,19 @@
 		}
 
 	}
-	skb_queue_tail(&recv_queue, skb);
-	schedule_work(&tq_recv_notify);
+
+	read_lock_irqsave(&application_lock, flags);
+	ap = get_capi_appl_by_nr(CAPIMSG_APPID(skb->data));
+	if ((!ap) || (ap->release_in_progress)) {
+		read_unlock_irqrestore(&application_lock, flags);
+		printk(KERN_ERR "kcapi: handle_message: applid %d state released (%s)\n",
+			CAPIMSG_APPID(skb->data), capi_message2str(skb->data));
+		goto error;
+	}
+	skb_queue_tail(&ap->recv_queue, skb);
+	schedule_work(&ap->recv_work);
+	read_unlock_irqrestore(&application_lock, flags);
+
 	return;
 
 error:
@@ -310,11 +322,13 @@
 
 	card->cardstate = CARD_RUNNING;
 
+	down(&controller_sem);
 	for (appl = 1; appl <= CAPI_MAXAPPL; appl++) {
 		ap = get_capi_appl_by_nr(appl);
-		if (!ap) continue;
+		if (!ap || ap->release_in_progress) continue;
 		register_appl(card, appl, &ap->rparam);
 	}
+	up(&controller_sem);
 
         printk(KERN_NOTICE "kcapi: card %d \"%s\" ready.\n",
 	       card->cnr, card->name);
@@ -342,7 +356,7 @@
 
 	for (appl = 1; appl <= CAPI_MAXAPPL; appl++) {
 		struct capi20_appl *ap = get_capi_appl_by_nr(appl);
-		if (!ap)
+		if (!ap || ap->release_in_progress)
 			continue;
 
 		capi_ctr_put(card);
@@ -382,16 +396,21 @@
 {
 	int i;
 
+	down(&controller_sem);
+
 	for (i = 0; i < CAPI_MAXCONTR; i++) {
 		if (capi_cards[i] == NULL)
 			break;
 	}
 	if (i == CAPI_MAXCONTR) {
+		up(&controller_sem);
 		printk(KERN_ERR "kcapi: out of controller slots\n");
 	   	return -EBUSY;
 	}
 	capi_cards[i] = card;
 
+	up(&controller_sem);
+
 	card->nrecvctlpkt = 0;
 	card->nrecvdatapkt = 0;
 	card->nsentctlpkt = 0;
@@ -480,18 +499,23 @@
 {
 	int i;
 	u16 applid;
+	unsigned long flags;
 
 	DBG("");
 
 	if (ap->rparam.datablklen < 128)
 		return CAPI_LOGBLKSIZETOSMALL;
 
+	write_lock_irqsave(&application_lock, flags);
+
 	for (applid = 1; applid <= CAPI_MAXAPPL; applid++) {
 		if (capi_applications[applid - 1] == NULL)
 			break;
 	}
-	if (applid > CAPI_MAXAPPL)
+	if (applid > CAPI_MAXAPPL) {
+		write_unlock_irqrestore(&application_lock, flags);
 		return CAPI_TOOMANYAPPLS;
+	}
 
 	ap->applid = applid;
 	capi_applications[applid - 1] = ap;
@@ -501,12 +525,21 @@
 	ap->nsentctlpkt = 0;
 	ap->nsentdatapkt = 0;
 	ap->callback = 0;
+	init_MUTEX(&ap->recv_sem);
+	skb_queue_head_init(&ap->recv_queue);
+	INIT_WORK(&ap->recv_work, recv_handler, (void *)ap);
+	ap->release_in_progress = 0;
+
+	write_unlock_irqrestore(&application_lock, flags);
 	
+	down(&controller_sem);
 	for (i = 0; i < CAPI_MAXCONTR; i++) {
 		if (!capi_cards[i] || capi_cards[i]->cardstate != CARD_RUNNING)
 			continue;
 		register_appl(capi_cards[i], applid, &ap->rparam);
 	}
+	up(&controller_sem);
+
 	if (showcapimsgs & 1) {
 		printk(KERN_DEBUG "kcapi: appl %d up\n", applid);
 	}
@@ -519,15 +552,26 @@
 u16 capi20_release(struct capi20_appl *ap)
 {
 	int i;
+	unsigned long flags;
 
 	DBG("applid %#x", ap->applid);
 
+	write_lock_irqsave(&application_lock, flags);
+	ap->release_in_progress = 1;
+	capi_applications[ap->applid - 1] = NULL;
+	write_unlock_irqrestore(&application_lock, flags);
+
+	down(&controller_sem);
 	for (i = 0; i < CAPI_MAXCONTR; i++) {
 		if (!capi_cards[i] || capi_cards[i]->cardstate != CARD_RUNNING)
 			continue;
 		release_appl(capi_cards[i], ap->applid);
 	}
-	capi_applications[ap->applid - 1] = NULL;
+	up(&controller_sem);
+	
+	flush_scheduled_work();
+	skb_queue_purge(&ap->recv_queue);
+
 	if (showcapimsgs & 1) {
 		printk(KERN_DEBUG "kcapi: appl %d down\n", ap->applid);
 	}
@@ -547,7 +591,7 @@
  
 	if (ncards == 0)
 		return CAPI_REGNOTINSTALLED;
-	if (ap->applid == 0)
+	if ((ap->applid == 0) || ap->release_in_progress)
 		return CAPI_ILLAPPNR;
 	if (skb->len < 12
 	    || !capi_cmd_valid(CAPIMSG_COMMAND(skb->data))
@@ -925,10 +969,6 @@
 	char *p;
 	char rev[32];
 
-	skb_queue_head_init(&recv_queue);
-
-	INIT_WORK(&tq_recv_notify, recv_handler, NULL);
-
         kcapi_proc_init();
 
 	if ((p = strchr(revision, ':')) != 0 && p[1]) {
--- linux-2.5/include/linux/kernelcapi.h_orig	2004-03-26 21:05:37.000000000 +0100
+++ linux-2.5/include/linux/kernelcapi.h	2004-03-26 21:05:49.000000000 +0100
@@ -10,10 +10,8 @@
 #ifndef __KERNELCAPI_H__
 #define __KERNELCAPI_H__
 
-#include <linux/list.h>
-
-#define CAPI_MAXAPPL	128	/* maximum number of applications  */
-#define CAPI_MAXCONTR	16	/* maximum number of controller    */
+#define CAPI_MAXAPPL	240	/* maximum number of applications  */
+#define CAPI_MAXCONTR	32	/* maximum number of controller    */
 #define CAPI_MAXDATAWINDOW	8
 
 
@@ -47,6 +45,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/list.h>
 #include <linux/skbuff.h>
 
 #define	KCI_CONTRUP	0	/* arg: struct capi_profile */
@@ -63,6 +62,10 @@
 	unsigned long nrecvdatapkt;
 	unsigned long nsentctlpkt;
 	unsigned long nsentdatapkt;
+	struct semaphore recv_sem;
+	struct sk_buff_head recv_queue;
+	struct work_struct recv_work;
+	int release_in_progress;
 
 	/* ugly hack to allow for notification of added/removed
 	 * controllers. The Right Way (tm) is known. XXX
