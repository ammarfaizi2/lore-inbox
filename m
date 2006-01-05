Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWAEKTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWAEKTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbWAEKTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:19:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751950AbWAEKTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:19:46 -0500
Date: Thu, 5 Jan 2006 02:19:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Debug shared irqs.
Message-Id: <20060105021929.498f45ef.akpm@osdl.org>
In-Reply-To: <1135251766.3557.13.camel@pmac.infradead.org>
References: <1135251766.3557.13.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
>  Drivers registering IRQ handlers with SA_SHIRQ really ought to be able
>  to handle an interrupt happening before request_irq() returns. They also
>  ought to be able to handle an interrupt happening during the start of
>  their call to free_irq(). Let's test that hypothesis....

I don't think I like this patch.

diff -puN sound/oss/i810_audio.c~i810_audio-request_irq-fix sound/oss/i810_audio.c
--- 25/sound/oss/i810_audio.c~i810_audio-request_irq-fix	2006-01-05 02:16:04.000000000 -0800
+++ 25-akpm/sound/oss/i810_audio.c	2006-01-05 02:16:58.000000000 -0800
@@ -3360,12 +3360,6 @@ static int __devinit i810_probe(struct p
 		goto out_region2;
 	}
 
-	if (request_irq(card->irq, &i810_interrupt, SA_SHIRQ,
-			card_names[pci_id->driver_data], card)) {
-		printk(KERN_ERR "i810_audio: unable to allocate irq %d\n", card->irq);
-		goto out_pio;
-	}
-
 	if (card->use_mmio) {
 		if (request_mem_region(card->ac97base_mmio_phys, 512, "ich_audio MMBAR")) {
 			if ((card->ac97base_mmio = ioremap(card->ac97base_mmio_phys, 512))) { /*@FIXME can ioremap fail? don't know (jsaw) */
@@ -3396,10 +3390,8 @@ static int __devinit i810_probe(struct p
 	}
 
 	/* initialize AC97 codec and register /dev/mixer */
-	if (i810_ac97_init(card) <= 0) {
-		free_irq(card->irq, card);
+	if (i810_ac97_init(card) <= 0)
 		goto out_iospace;
-	}
 	pci_set_drvdata(pci_dev, card);
 
 	if(clocking == 0) {
@@ -3411,7 +3403,6 @@ static int __devinit i810_probe(struct p
 	if ((card->dev_audio = register_sound_dsp(&i810_audio_fops, -1)) < 0) {
 		int i;
 		printk(KERN_ERR "i810_audio: couldn't register DSP device!\n");
-		free_irq(card->irq, card);
 		for (i = 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
@@ -3420,6 +3411,13 @@ static int __devinit i810_probe(struct p
 		goto out_iospace;
 	}
 
+	if (request_irq(card->irq, &i810_interrupt, SA_SHIRQ,
+			card_names[pci_id->driver_data], card)) {
+		printk(KERN_ERR "i810_audio: unable to allocate irq %d\n", card->irq);
+		goto out_iospace;
+	}
+
+
  	card->initializing = 0;
 	return 0;
 
_


This is going to cause me a ton of grief.  How's about you put it in
Fedora for a few weeks, get all the drivers debugged first ;)

