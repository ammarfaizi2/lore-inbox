Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSGYNeJ>; Thu, 25 Jul 2002 09:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSGYNdH>; Thu, 25 Jul 2002 09:33:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5117 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313477AbSGYNcb>; Thu, 25 Jul 2002 09:32:31 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251449.g6PEngGW010478@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 Fix other peoples ALSA PCI fixe
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:49:42 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq can be -1 if the card errors during config. synchronize_irq(-1) looks
bad

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/ens1370.c linux-2.5.28-ac1/sound/pci/ens1370.c
--- linux-2.5.28/sound/pci/ens1370.c	Thu Jul 25 11:09:41 2002
+++ linux-2.5.28-ac1/sound/pci/ens1370.c	Thu Jul 25 13:09:40 2002
@@ -1532,7 +1532,8 @@
 	outl(0, ES_REG(ensoniq, CONTROL));	/* switch everything off */
 	outl(0, ES_REG(ensoniq, SERIAL));	/* clear serial interface */
 #endif
-	synchronize_irq(ensoniq->irq);
+	if(ensoniq->irq >= 0)
+		synchronize_irq(ensoniq->irq);
 	pci_set_power_state(ensoniq->pci, 3);
       __hw_end:
 #ifdef CHIP1370
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/ice1712.c linux-2.5.28-ac1/sound/pci/ice1712.c
--- linux-2.5.28/sound/pci/ice1712.c	Thu Jul 25 10:51:01 2002
+++ linux-2.5.28-ac1/sound/pci/ice1712.c	Thu Jul 25 13:09:37 2002
@@ -4070,8 +4070,8 @@
 	/* --- */
       __hw_end:
 	snd_ice1712_proc_done(ice);
-	synchronize_irq();
 	if (ice->irq)
+		synchronize_irq(ice->irq);
 		free_irq(ice->irq, (void *) ice);
 	if (ice->res_port) {
 		release_resource(ice->res_port);
@@ -4143,7 +4143,7 @@
 	pci_write_config_word(ice->pci, 0x40, 0x807f);
 	pci_write_config_word(ice->pci, 0x42, 0x0006);
 	snd_ice1712_proc_init(ice);
-	synchronize_irq();
+	synchronize_irq(ice->irq);
 
 	if ((ice->res_port = request_region(ice->port, 32, "ICE1712 - Controller")) == NULL) {
 		snd_ice1712_free(ice);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/intel8x0.c linux-2.5.28-ac1/sound/pci/intel8x0.c
--- linux-2.5.28/sound/pci/intel8x0.c	Thu Jul 25 11:09:41 2002
+++ linux-2.5.28-ac1/sound/pci/intel8x0.c	Thu Jul 25 13:09:51 2002
@@ -1104,7 +1104,8 @@
 	outb(ICH_RESETREGS, ICHREG(chip, PO_CR));
 	outb(ICH_RESETREGS, ICHREG(chip, MC_CR));
 	/* --- */
-	synchronize_irq(chip->irq);
+	if(chip->irq >= 0)
+		synchronize_irq(chip->irq);
       __hw_end:
 	if (chip->bdbars)
 		snd_free_pci_pages(chip->pci, 3 * sizeof(u32) * ICH_MAX_FRAGS * 2, chip->bdbars, chip->bdbars_addr);
