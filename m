Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUAQQIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUAQQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:08:38 -0500
Received: from pD9E737C7.dip.t-dialin.net ([217.231.55.199]:26496 "EHLO abc")
	by vger.kernel.org with ESMTP id S266073AbUAQQIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:08:37 -0500
Date: Sat, 17 Jan 2004 17:10:13 +0100
From: Johannes Stezenbach <js@convergence.de>
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Subject: 2.6.1-mm4: ALSA es1968 DMA alloc problem
Message-ID: <20040117161013.GA3303@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the ALSA driver snd_es1968 for my Terratec DMX (ES1978 Maestro 2E)
fails in 2.6.1-mm4 with the following message:

Jan 16 01:59:15 abc vmunix: PCI: Found IRQ 10 for device 0000:00:0e.0
Jan 16 01:59:15 abc vmunix: es1968: not attempting power management.
Jan 16 01:59:16 abc vmunix: es1968: DMA buffer beyond 256MB.
Jan 16 01:59:16 abc vmunix: ES1968 (ESS Maestro): probe of 0000:00:0e.0 failed with error -12

The seems to be caused by the following change:

--- linux-2.6.1/sound/pci/es1968.c      2003-09-27 18:57:48.000000000 -0700
+++ 25/sound/pci/es1968.c       2004-01-15 22:25:44.000000000 -0800
@@ -2538,7 +2567,7 @@ static int __devinit snd_es1968_create(s
                snd_printk("architecture does not support 28bit PCI busmaster DMA\n");
                return -ENXIO;
        }
-       pci_set_dma_mask(pci, 0x0fffffff);
+       pci_set_consistent_dma_mask(pci, 0x0fffffff);
 
        chip = (es1968_t *) snd_magic_kcalloc(es1968_t, 0, GFP_KERNEL);
        if (! chip)

I don't fully understand Documentation/DMA-mapping.txt, and
Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
says to use pci_set_consistent_dma_mask(). I decided to call
both pci_set_dma_mask() and pci_set_consistent_dma_mask(), and
then the driver works again.

Regards,
Johannes
