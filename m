Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUKWXRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUKWXRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUKWXQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:16:33 -0500
Received: from news.suse.de ([195.135.220.2]:39329 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261546AbUKWXOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:14:00 -0500
Date: Wed, 24 Nov 2004 00:13:55 +0100
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix deadlock in CAPI code, reenable SMP
Message-ID: <20041123231355.GA16080@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.5-7.108-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fix a deadlock in CAPI device driver registration code
and reenable SMP for the activ AVM cards., also some minor cleanup and
fixes.

Signed-off-by: Karsten Keil <kkeil@suse.de>

diff -ur linux-2.6.10-rc2-bk7.org/drivers/isdn/capi/capidrv.c linux-2.6.10-rc2-bk7/drivers/isdn/capi/capidrv.c
--- linux-2.6.10-rc2-bk7.org/drivers/isdn/capi/capidrv.c	2004-11-23 15:56:47.048749784 +0100
+++ linux-2.6.10-rc2-bk7/drivers/isdn/capi/capidrv.c	2004-11-23 16:44:31.767040277 +0100
@@ -2058,6 +2058,10 @@
 		return -1;
 	}
 	card->myid = card->interface.channels;
+	memset(card->bchans, 0, sizeof(capidrv_bchan) * card->nbchan);
+	for (i = 0; i < card->nbchan; i++) {
+		card->bchans[i].contr = card;
+	}
 
 	spin_lock_irqsave(&global_lock, flags);
 	card->next = global.contr_list;
@@ -2065,11 +2069,6 @@
 	global.ncontr++;
 	spin_unlock_irqrestore(&global_lock, flags);
 
-	memset(card->bchans, 0, sizeof(capidrv_bchan) * card->nbchan);
-	for (i = 0; i < card->nbchan; i++) {
-		card->bchans[i].contr = card;
-	}
-
 	cmd.command = ISDN_STAT_RUN;
 	cmd.driver = card->myid;
 	card->interface.statcallb(&cmd);
@@ -2077,10 +2076,9 @@
 	card->cipmask = 0x1FFF03FF;	/* any */
 	card->cipmask2 = 0;
 
-	send_listen(card);
-
 	card->listentimer.data = (unsigned long)card;
 	card->listentimer.function = listentimerfunc;
+	send_listen(card);
 	mod_timer(&card->listentimer, jiffies + 60*HZ);
 
 	printk(KERN_INFO "%s: now up (%d B channels)\n",
diff -ur linux-2.6.10-rc2-bk7.org/drivers/isdn/capi/kcapi.c linux-2.6.10-rc2-bk7/drivers/isdn/capi/kcapi.c
--- linux-2.6.10-rc2-bk7.org/drivers/isdn/capi/kcapi.c	2004-11-23 15:56:47.051749385 +0100
+++ linux-2.6.10-rc2-bk7/drivers/isdn/capi/kcapi.c	2004-11-23 16:44:31.781038431 +0100
@@ -150,7 +150,10 @@
 {
 	card = capi_ctr_get(card);
 
-	card->register_appl(card, applid, rparam);
+	if (card)
+		card->register_appl(card, applid, rparam);
+	else
+		printk(KERN_WARNING "%s: cannot get card resources\n", __FUNCTION__);
 }
 
 
@@ -173,10 +176,15 @@
 	if (showcapimsgs & 1) {
 	        printk(KERN_DEBUG "kcapi: notify up contr %d\n", contr);
 	}
-
+	if (!card) {
+		printk(KERN_WARNING "%s: invalid contr %d\n", __FUNCTION__, contr);
+		return;
+	}
 	for (applid = 1; applid <= CAPI_MAXAPPL; applid++) {
 		ap = get_capi_appl_by_nr(applid);
-		if (ap && ap->callback && !ap->release_in_progress)
+		if (!ap || ap->release_in_progress) continue;
+		register_appl(card, applid, &ap->rparam);
+		if (ap->callback && !ap->release_in_progress)
 			ap->callback(KCI_CONTRUP, contr, &card->profile);
 	}
 }
@@ -319,19 +327,8 @@
 
 void capi_ctr_ready(struct capi_ctr * card)
 {
-	u16 appl;
-	struct capi20_appl *ap;
-
 	card->cardstate = CARD_RUNNING;
 
-	down(&controller_sem);
-	for (appl = 1; appl <= CAPI_MAXAPPL; appl++) {
-		ap = get_capi_appl_by_nr(appl);
-		if (!ap || ap->release_in_progress) continue;
-		register_appl(card, appl, &ap->rparam);
-	}
-	up(&controller_sem);
-
         printk(KERN_NOTICE "kcapi: card %d \"%s\" ready.\n",
 	       card->cnr, card->name);
 
diff -ur linux-2.6.10-rc2-bk7.org/drivers/isdn/hardware/avm/c4.c linux-2.6.10-rc2-bk7/drivers/isdn/hardware/avm/c4.c
--- linux-2.6.10-rc2-bk7.org/drivers/isdn/hardware/avm/c4.c	2004-11-23 15:53:57.526313625 +0100
+++ linux-2.6.10-rc2-bk7/drivers/isdn/hardware/avm/c4.c	2004-11-23 16:44:31.803035529 +0100
@@ -662,15 +662,16 @@
 
 static irqreturn_t c4_handle_interrupt(avmcard *card)
 {
+	unsigned long flags;
 	u32 status;
 
-	spin_lock(&card->lock);
+	spin_lock_irqsave(&card->lock, flags);
 	status = c4inmeml(card->mbase+DOORBELL);
 
 	if (status & DBELL_RESET_HOST) {
 		u_int i;
 		c4outmeml(card->mbase+PCI_OUT_INT_MASK, 0x0c);
-		spin_unlock(&card->lock);
+		spin_unlock_irqrestore(&card->lock, flags);
 		if (card->nlogcontr == 0)
 			return IRQ_HANDLED;
 		printk(KERN_ERR "%s: unexpected reset\n", card->name);
@@ -686,7 +687,7 @@
 
 	status &= (DBELL_UP_HOST | DBELL_DOWN_HOST);
 	if (!status) {
-		spin_unlock(&card->lock);
+		spin_unlock_irqrestore(&card->lock, flags);
 		return IRQ_HANDLED;
 	}
 	c4outmeml(card->mbase+DOORBELL, status);
@@ -709,7 +710,7 @@
 			c4_dispatch_tx(card);
 		}
 	}
-	spin_unlock(&card->lock);
+	spin_unlock_irqrestore(&card->lock, flags);
 	return IRQ_HANDLED;
 }
 
diff -ur linux-2.6.10-rc2-bk7.org/drivers/isdn/hardware/avm/Kconfig linux-2.6.10-rc2-bk7/drivers/isdn/hardware/avm/Kconfig
--- linux-2.6.10-rc2-bk7.org/drivers/isdn/hardware/avm/Kconfig	2004-11-23 15:51:59.184033931 +0100
+++ linux-2.6.10-rc2-bk7/drivers/isdn/hardware/avm/Kconfig	2004-11-23 16:46:44.835475108 +0100
@@ -12,13 +12,13 @@
 
 config ISDN_DRV_AVMB1_B1ISA
 	tristate "AVM B1 ISA support"
-	depends on CAPI_AVM && ISDN_CAPI && ISA && BROKEN_ON_SMP
+	depends on CAPI_AVM && ISDN_CAPI && ISA
 	help
 	  Enable support for the ISA version of the AVM B1 card.
 
 config ISDN_DRV_AVMB1_B1PCI
 	tristate "AVM B1 PCI support"
-	depends on CAPI_AVM && ISDN_CAPI && PCI && BROKEN_ON_SMP
+	depends on CAPI_AVM && ISDN_CAPI && PCI
 	help
 	  Enable support for the PCI version of the AVM B1 card.
 
@@ -30,14 +30,14 @@
 
 config ISDN_DRV_AVMB1_T1ISA
 	tristate "AVM T1/T1-B ISA support"
-	depends on CAPI_AVM && ISDN_CAPI && ISA && BROKEN_ON_SMP
+	depends on CAPI_AVM && ISDN_CAPI && ISA
 	help
 	  Enable support for the AVM T1 T1B card.
 	  Note: This is a PRI card and handle 30 B-channels.
 
 config ISDN_DRV_AVMB1_B1PCMCIA
 	tristate "AVM B1/M1/M2 PCMCIA support"
-	depends on CAPI_AVM && ISDN_CAPI && BROKEN_ON_SMP
+	depends on CAPI_AVM && ISDN_CAPI
 	help
 	  Enable support for the PCMCIA version of the AVM B1 card.
 
@@ -50,14 +50,14 @@
 
 config ISDN_DRV_AVMB1_T1PCI
 	tristate "AVM T1/T1-B PCI support"
-	depends on CAPI_AVM && ISDN_CAPI && PCI && BROKEN_ON_SMP
+	depends on CAPI_AVM && ISDN_CAPI && PCI
 	help
 	  Enable support for the AVM T1 T1B card.
 	  Note: This is a PRI card and handle 30 B-channels.
 
 config ISDN_DRV_AVMB1_C4
 	tristate "AVM C4/C2 support"
-	depends on CAPI_AVM && ISDN_CAPI && PCI && BROKEN_ON_SMP
+	depends on CAPI_AVM && ISDN_CAPI && PCI
 	help
 	  Enable support for the AVM C4/C2 PCI cards.
 	  These cards handle 4/2 BRI ISDN lines (8/4 channels).


-- 
Karsten Keil
SuSE Labs
ISDN development
