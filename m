Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbULEB3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbULEB3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULEB3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:29:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:45545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261223AbULEB3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:29:10 -0500
Date: Sat, 4 Dec 2004 17:28:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Joshua Kwan <joshk@triplehelix.org>, alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix ALSA resume
Message-Id: <20041204172855.350100d0.akpm@osdl.org>
In-Reply-To: <1102195391.1560.65.camel@tux.rsn.bth.se>
References: <1102195391.1560.65.camel@tux.rsn.bth.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> wrote:
>
> Some time ago, a patch was merged that removed pci_save_state() and
> pci_restore_state() from various ALSA drivers. That patch also added
> pci_restore_state() to sound/core/init.c but didn't add pci_save_state()
> anywhere. This is needed since the core pci handling doesn't do this for
> us anymore.
> 
> My laptop doesn't resume (gets what I assume is an ACPI timeout and
> hangs solid) without this small obvious patch.
> 
> Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>
> Fixed-by: Takashi Iwai <tiwai@suse.de>
> 
> --- linux/sound/core/init.c	8 Nov 2004 11:37:08 -0000	1.48
> +++ linux/sound/core/init.c	12 Nov 2004 13:56:32 -0000
> @@ -782,12 +782,15 @@<br>
>  int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
>  {
>  	snd_card_t *card = pci_get_drvdata(dev);
> +	int err;
>  	if (! card || ! card->pm_suspend)
>  		return 0;
>  	if (card->power_state == SNDRV_CTL_POWER_D3hot)
>  		return 0;
>  	/* FIXME: correct state value? */
> -	return card->pm_suspend(card, 0);
> +	err = card->pm_suspend(card, 0);
> +	pci_save_state(dev);
> +	return err;
>  }
> 
>  int snd_card_pci_resume(struct pci_dev *dev)

OK.  That's a better version of Joshua Kwan's patch:


From: Joshua Kwan <joshk@triplehelix.org>

Fix an intel8x0 problem which is breaking swsusp resumes.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/sound/pci/intel8x0.c  |    2 ++
 25-akpm/sound/pci/intel8x0m.c |    2 ++
 2 files changed, 4 insertions(+)

diff -puN sound/pci/intel8x0.c~intel8x0-pm-fix sound/pci/intel8x0.c
--- 25/sound/pci/intel8x0.c~intel8x0-pm-fix	2004-12-04 00:13:21.801532720 -0800
+++ 25-akpm/sound/pci/intel8x0.c	2004-12-04 00:13:21.808531656 -0800
@@ -2279,6 +2279,8 @@ static int intel8x0_suspend(snd_card_t *
 	for (i = 0; i < 3; i++)
 		if (chip->ac97[i])
 			snd_ac97_suspend(chip->ac97[i]);
+	pci_save_state(chip->pci);
+	pci_disable_device(chip->pci);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	return 0;
 }
diff -puN sound/pci/intel8x0m.c~intel8x0-pm-fix sound/pci/intel8x0m.c
--- 25/sound/pci/intel8x0m.c~intel8x0-pm-fix	2004-12-04 00:13:21.802532568 -0800
+++ 25-akpm/sound/pci/intel8x0m.c	2004-12-04 00:13:21.809531504 -0800
@@ -1091,6 +1091,8 @@ static int intel8x0m_suspend(snd_card_t 
 		snd_pcm_suspend_all(chip->pcm[i]);
 	if (chip->ac97)
 		snd_ac97_suspend(chip->ac97);
+	pci_save_state(chip->pci);
+	pci_disable_device(chip->pci);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	return 0;
 }
_


But Joshua crosses his heart and swears that the pci_disable_device() is
also needed for a successful swsusp resume.

Should snd_card_pci_suspend() be doing the pci_disable_device() as well, or
it that a responsibility of the driver which called snd_card_pci_suspend()?

