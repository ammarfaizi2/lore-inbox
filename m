Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUIPKqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUIPKqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUIPKoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:44:20 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:1222 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267701AbUIPKoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:44:05 -0400
Subject: [PATCH]: Suspend2 Merge: Device driver fixes 2/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095331535.3324.135.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 20:45:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Forwarded Message-----
> From: Bernard Blackham <bernard@blackham.com.au>
> To: Michael Frank <mhf@linuxmail.org>
> Cc: softwaresuspend-devel@lists.berlios.de
> Subject: Re: [SoftwareSuspend-devel] ALSA ali5451 and sis PM fundamentally broken?
> Date: Sun, 08 Aug 2004 22:33:54 +0800
> 
> On Fri, Jul 16, 2004 at 01:24:09PM +0800, Michael Frank wrote:
> > Built the current Gentoo ALSA package 1.05a on 2.4.24.
> > 
> > On ali5451 it is difficult to get the driver to work
> > at all - takes several loads. Does not survive suspend.
> 
> With the latest 2.6.7 and swsusp 2.0.0.103, my sound card's
> (ali5451) suspend/resume began eratticaly failing again. So I
> started tinkering some more, and I've come up with this patch (in
> addition to the one liner already in 2.0.0.103-for-2.6.7) that makes
> sound reliably suspend and resume every time *and* playback is not
> interrupted! :)
> 
> The line "snd_pcm_suspend_all(chip->pcm)" was the culprit for
> stopping playback and requiring it to be restarted. It seems common
> to some other alsa drivers too, so removing it may help with similar
> problems experienced by others.
> 
> Bernard.

diff -ruN linux-2.6.9-rc1/sound/core/init.c software-suspend-linux-2.6.9-rc1-rev3/sound/core/init.c
--- linux-2.6.9-rc1/sound/core/init.c	2004-06-18 12:44:25.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/sound/core/init.c	2004-09-09 19:36:24.000000000 +1000
@@ -790,7 +790,7 @@
 	if (card->power_state == SNDRV_CTL_POWER_D3hot)
 		return 0;
 	/* FIXME: correct state value? */
-	return card->pm_suspend(card, 0);
+	return card->pm_suspend(card, SNDRV_CTL_POWER_D3hot);
 }
 
 int snd_card_pci_resume(struct pci_dev *dev)
@@ -801,7 +801,7 @@
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		return 0;
 	/* FIXME: correct state value? */
-	return card->pm_resume(card, 0);
+	return card->pm_resume(card, SNDRV_CTL_POWER_D0);
 }
 #endif
 
diff -ruN linux-2.6.9-rc1/sound/pci/ali5451/ali5451.c software-suspend-linux-2.6.9-rc1-rev3/sound/pci/ali5451/ali5451.c
--- linux-2.6.9-rc1/sound/pci/ali5451/ali5451.c	2004-06-18 12:44:26.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/sound/pci/ali5451/ali5451.c	2004-09-09 19:36:24.000000000 +1000
@@ -286,6 +286,7 @@
 static void snd_ali_clear_voices(ali_t *, unsigned int, unsigned int);
 static unsigned short snd_ali_codec_peek(ali_t *, int, unsigned short);
 static void snd_ali_codec_poke(ali_t *, int, unsigned short, unsigned short);
+static int snd_ali_chip_init(ali_t *codec);
 
 /*
  *  Debug Part
@@ -1915,7 +1916,6 @@
 	if (! im)
 		return 0;
 
-	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 
 	spin_lock_irq(&chip->reg_lock);
@@ -1957,6 +1957,7 @@
 		return 0;
 
 	pci_enable_device(chip->pci);
+	snd_ali_chip_init(chip);
 
 	spin_lock_irq(&chip->reg_lock);
 	
@@ -1981,6 +1982,7 @@
 
 	snd_ac97_resume(chip->ac97);
 	
+	snd_power_change_state(card, state);
 	return 0;
 }
 #endif /* CONFIG_PM */
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

