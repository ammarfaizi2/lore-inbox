Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSF3Ub2>; Sun, 30 Jun 2002 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSF3Ub1>; Sun, 30 Jun 2002 16:31:27 -0400
Received: from macker.loria.fr ([152.81.1.70]:53975 "EHLO macker.loria.fr")
	by vger.kernel.org with ESMTP id <S311710AbSF3UbZ>;
	Sun, 30 Jun 2002 16:31:25 -0400
X-Amavix: Anti-spam check done by SpamAssassin
X-Amavix: Anti-virus check done by McAfee
X-Amavix: Scanned by Amavix
Date: Sun, 30 Jun 2002 22:33:43 +0200 (CEST)
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
X-X-Sender: samy@localhost.localdomain
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: zab@zabbo.net, <linux-sound@vger.kernel.org>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.18 drivers/sound/maestro.c
Message-ID: <Pine.LNX.4.44.0206302209370.470-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

maestro.c:3537 takes care about volume button pressing when requesting irq
(maestro_probe) :

	if((ret=request_irq(card->irq, ess_interrupt, SA_SHIRQ, card_names[card_type], card)))
	{
		<snipped>
	}

	/* Turn on hardware volume control interrupt.
	   This has to come after we grab the IRQ above,
	   or a crash will result on installation if a button has been pressed,
	   because in that case we'll get an immediate interrupt. */
	n = inw(iobase+0x18);
	n|=(1<<6);
	outw(n, iobase+0x18);

but not when unloading module : in fact, this bit is never cleared.
Indeed, loading the module, unloading it, and pressing a volume button
immediately crashes.

This cures the problem :

diff -urN linux-2.4.18/drivers/sound/maestro.c linux-2.4.18-cor/drivers/sound/maestro.c
--- linux-2.4.18/drivers/sound/maestro.c	Sun Jun 30 22:00:22 2002
+++ linux-2.4.18-cor/drivers/sound/maestro.c	Sun Jun 30 22:02:11 2002
@@ -3569,9 +3569,18 @@
 static void maestro_remove(struct pci_dev *pcidev) {
 	struct ess_card *card = pci_get_drvdata(pcidev);
 	int i;
+	u32 n;

 	/* XXX maybe should force stop bob, but should be all
 		stopped by _release by now */
+
+	/* Turn off hardware volume control interrupt.
+	   This has to come before we leave the IRQ below,
+	   or a crash results if a button is pressed ! */
+	n = inw(card->iobase+0x18);
+	n&=~(1<<6);
+	outw(n, card->iobase+0x18);
+
 	free_irq(card->irq, card);
 	unregister_sound_mixer(card->dev_mixer);
 	for(i=0;i<NR_DSPS;i++)

This patch also apply to 2.5 series (tested on 2.5.24) in linux/sound/oss
by using -p3.

Best regards,

Samuel Thibault

