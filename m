Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVGaKiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVGaKiz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVGaKiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:38:55 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:26053 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261662AbVGaKiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:38:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.13-rc4-git3: snd_intel8x0: handle irq_request failure on resume
Date: Sun, 31 Jul 2005 12:43:21 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507311243.22375.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds the handling of irq_request() failures during resume to
the snd_intel8x0 driver.

Please consider for applying,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.13-rc4-git3/sound/pci/intel8x0.c	2005-07-31 12:35:00.000000000 +0200
+++ patched/sound/pci/intel8x0.c	2005-07-31 12:36:10.000000000 +0200
@@ -2390,7 +2390,12 @@ static int intel8x0_resume(snd_card_t *c
 
 	pci_enable_device(chip->pci);
 	pci_set_master(chip->pci);
-	request_irq(chip->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ, card->shortname, (void *)chip);
+	if (request_irq(chip->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ, card->shortname, (void *)chip)) {
+		snd_printk("unable to grab IRQ %d\n", chip->irq);
+		chip->irq = -1;
+		pci_disable_device(chip->pci);
+		return -EBUSY;
+	}
 	synchronize_irq(chip->irq);
 	snd_intel8x0_chip_init(chip, 1);
 
