Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVGZLDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVGZLDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 07:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGZKwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:52:38 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:18839 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261701AbVGZKv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:51:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Tue, 26 Jul 2005 12:51:47 +0200
User-Agent: KMail/1.8.1
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
References: <200507261247.05684.rjw@sisk.pl>
In-Reply-To: <200507261247.05684.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507261251.48291.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds free_irq() and request_irq() to the suspend and
resume, respectively, routines in the snd_intel8x0 driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.13-rc3-git5/sound/pci/intel8x0.c	2005-07-23 19:26:43.000000000 +0200
+++ patched/sound/pci/intel8x0.c	2005-07-25 18:21:36.000000000 +0200
@@ -2373,6 +2373,8 @@ static int intel8x0_suspend(snd_card_t *
 	for (i = 0; i < 3; i++)
 		if (chip->ac97[i])
 			snd_ac97_suspend(chip->ac97[i]);
+	if (chip->irq >= 0)
+		free_irq(chip->irq, (void *)chip);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -2384,7 +2386,14 @@ static int intel8x0_resume(snd_card_t *c
 
 	pci_enable_device(chip->pci);
 	pci_set_master(chip->pci);
-	snd_intel8x0_chip_init(chip, 0);
+	if (request_irq(chip->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ, card->shortname, (void *)chip)) {
+		snd_printk("unable to grab IRQ %d\n", chip->irq);
+		chip->irq = -1;
+		pci_disable_device(chip->pci);
+		return -EBUSY;
+	}
+	synchronize_irq(chip->irq);
+	snd_intel8x0_chip_init(chip, 1);
 
 	/* refill nocache */
 	if (chip->fix_nocache)
