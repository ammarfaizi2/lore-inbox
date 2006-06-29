Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWF2LOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWF2LOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbWF2LOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:14:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:39400 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932671AbWF2LOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:14:54 -0400
Date: Thu, 29 Jun 2006 13:14:51 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i4l make PCMCIA for all cards working with shared IRQ
Message-ID: <20060629111451.GA9501@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.13-4-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

most current laptops do not work without allowing shared cardbus IRQs.
This patch enables IRQ sharing, so these cards work again.
This was tested with shared and none shared cardbus IRQs on different laptops
without problems.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hardware/avm/b1pcmcia.c |    2 +-
 drivers/isdn/hisax/sedlbauer_cs.c    |    2 +-
 drivers/isdn/hisax/teles3.c          |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

2a8cbb08c1dacd5acffb6c16df03b48e9e74c361
diff --git a/drivers/isdn/hardware/avm/b1pcmcia.c b/drivers/isdn/hardware/avm/b1pcmcia.c
index 9746cc5..ad50251 100644
--- a/drivers/isdn/hardware/avm/b1pcmcia.c
+++ b/drivers/isdn/hardware/avm/b1pcmcia.c
@@ -82,7 +82,7 @@ static int b1pcmcia_add_card(unsigned in
 	card->irq = irq;
 	card->cardtype = cardtype;
 
-	retval = request_irq(card->irq, b1_interrupt, 0, card->name, card);
+	retval = request_irq(card->irq, b1_interrupt, SA_SHIRQ, card->name, card);
 	if (retval) {
 		printk(KERN_ERR "b1pcmcia: unable to get IRQ %d.\n",
 		       card->irq);
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index 9bb18f3..f9c14a2 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -164,7 +164,7 @@ static int sedlbauer_probe(struct pcmcia
     link->priv = local;
 
     /* Interrupt setup */
-    link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+    link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING|IRQ_FIRST_SHARED;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->irq.Handler = NULL;
 
diff --git a/drivers/isdn/hisax/teles3.c b/drivers/isdn/hisax/teles3.c
index a3eaf4d..090abd1 100644
--- a/drivers/isdn/hisax/teles3.c
+++ b/drivers/isdn/hisax/teles3.c
@@ -369,6 +369,7 @@ setup_teles3(struct IsdnCard *card)
 			       cs->hw.teles3.hscx[1] + 96);
 			return (0);
 		}
+		cs->irq_flags |= SA_SHIRQ; /* cardbus can share */
 	} else {
 		if (cs->hw.teles3.cfg_reg) {
 			if (cs->typ == ISDN_CTYPE_COMPAQ_ISA) {
-- 
Karsten Keil
SuSE Labs
ISDN development
