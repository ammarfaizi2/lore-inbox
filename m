Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWI2M2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWI2M2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWI2M2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:28:39 -0400
Received: from mout0.freenet.de ([194.97.50.131]:22950 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1750713AbWI2M2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:28:38 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Fri, 29 Sep 2006 14:29:20 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       alsa-devel@lists.sourceforge.net
References: <200609282228.02611.annabellesgarden@yahoo.de> <s5hmz8j3q59.wl%tiwai@suse.de>
In-Reply-To: <s5hmz8j3q59.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609291429.21183.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 29. September 2006 12:48 schrieb Takashi Iwai:
> At Thu, 28 Sep 2006 22:28:02 +0200,
> Karsten Wiese wrote:
> > 
> > Hi
> > 
> > It oopses with 2.6.18-rt4 + alsa-kernel-1.0.13rc3 now.
> > I wrote before, 2.6.18-rt3 + alsa-driver-1.0.13rc3 would be ok,
> > but its not. bug showed again reliably under memory-pressure.
> > 
> >       Karsten
> > 
> > ===
> > 
> > Reset file->f_op in snd_card_file_remove(). Take 2
> > 
> > 
> > i think what happens here is:
> > 
> >   us428control runs, kernel has allocated a struct file for /dev/hwC1D0.
> > 
> >   usb disconnect
> > 
> >   snd_usb_usx2y calls snd_card_disconnect,
> >   tells us428control to exit.
> > 
> >   snd_card_disconnect replaces /dev/hwC1D0's file->f_op
> >   with a kmalloc()ed version, that would only allow releases.
> > 
> >   us428control starts exiting
> > 
> >   __fput is called with struct file for /dev/hwC1D0.
> > 
> >   snd_card_file_remove() is called, alsa notices struct file
> >   for /dev/hwC1D0 is about to be closed.
> >   with patch below, file->f_op would be set NULL now.
> > 
> >   snd_usb_usx2y's free()s snd_card instance and /dev/hwC1D0's
> >   file->f_ops, those that would only allow releases.
> > 
> >   for reason I would like to know,
> >   __fput is called again with struct file for /dev/hwC1D0
> >   from us428control's do_exit().
> >   __fput see's file->f_op is still set.
> >   Without patch and under memory pressure, file->f_op can
> >   point to anything now.
> > 
> > 
> > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
> 
> I guess this bug is fixed by Florin's patch below, juding from your
> explanation.  Could you check it?
> 
Florin's patch fixes it.

This one for immediate consumation by mainline, mm, rt,
and the stable teams, hmm?

      Karsten
> 
> Takashi
> 
> Subject: [PATCH] Dereference after free in snd_hwdep_release()
> From: Florin Malita <fmalita@gmail.com>
> Date: Thu, 28 Sep 2006 19:45:50 -0400
> 
> snd_card_file_remove() may free hw->card so we can't dereference
> hw->card->module after that.
> 
> Coverity ID 1420.
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
> 
> diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
> index 9aa9d94..46b4768 100644
> --- a/sound/core/hwdep.c
> +++ b/sound/core/hwdep.c
> @@ -158,6 +158,7 @@ static int snd_hwdep_release(struct inod
>  {
>  	int err = -ENXIO;
>  	struct snd_hwdep *hw = file->private_data;
> +	struct module *mod = hw->card->module;
>  	mutex_lock(&hw->open_mutex);
>  	if (hw->ops.release) {
>  		err = hw->ops.release(hw, file);
> @@ -167,7 +168,7 @@ static int snd_hwdep_release(struct inod
>  		hw->used--;
>  	snd_card_file_remove(hw->card, file);
>  	mutex_unlock(&hw->open_mutex);
> -	module_put(hw->card->module);
> +	module_put(mod);
>  	return err;
>  }
>  
> 
> 
