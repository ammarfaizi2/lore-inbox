Return-Path: <linux-kernel-owner+w=401wt.eu-S1422738AbWLUFry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWLUFry (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWLUFry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:47:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40499 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422738AbWLUFrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:47:53 -0500
Date: Wed, 20 Dec 2006 21:47:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Eugene Ilkov" <e.ilkov@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] alsa soc wm8750 fix 2.6.20-rc1-mm1
Message-Id: <20061220214744.c83b5396.akpm@osdl.org>
In-Reply-To: <e13597370612200920k5d593863o6ba8580cf3e3c72e@mail.gmail.com>
References: <e13597370612200920k5d593863o6ba8580cf3e3c72e@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 20:20:45 +0300
"Eugene Ilkov" <e.ilkov@gmail.com> wrote:

>  There was some INIT_WORK related changes, here is patch against
> wm8750 codec driver. Tested on sharp sl-c1000
> 
> 
> --- linux-2.6.20-rc1-mm1/sound/soc/codecs/wm8750.c	2006-12-20
> 19:23:27.000000000 +0300
> +++ linux-2.6.20-rc1-mm.z1/sound/soc/codecs/wm8750.c	2006-12-20
> 19:27:28.000000000 +0300
> @@ -52,7 +52,6 @@
>  	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
>   static struct workqueue_struct *wm8750_workq = NULL;
> -static struct work_struct wm8750_dapm_work;
>   /*
>   * wm8750 register cache
> @@ -1001,9 +1000,11 @@
>  };
>  EXPORT_SYMBOL_GPL(wm8750_dai);
>  -static void wm8750_work(void *data)
> +static void wm8750_work(struct work_struct *work)
>  {
> -	struct snd_soc_codec *codec = (struct snd_soc_codec *)data;
> +	struct snd_soc_device *socdev =
> +		container_of(work, struct snd_soc_device, delayed_work.work);
> +	struct snd_soc_codec *codec = socdev->codec;
>  	wm8750_dapm_event(codec, codec->dapm_state);
>  }
>  @@ -1039,7 +1040,7 @@
>  	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
>  		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
>  		codec->dapm_state = SNDRV_CTL_POWER_D0;
> -		queue_delayed_work(wm8750_workq, &wm8750_dapm_work,
> +		queue_delayed_work(wm8750_workq, &socdev->delayed_work,
>  			 msecs_to_jiffies(1000));
>  	}
>  @@ -1084,7 +1085,7 @@
>  	/* charge output caps */
>  	wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
>  	codec->dapm_state = SNDRV_CTL_POWER_D3hot;
> -	queue_delayed_work(wm8750_workq, &wm8750_dapm_work,
> +	queue_delayed_work(wm8750_workq, &socdev->delayed_work,
>  		msecs_to_jiffies(1000));
>   	/* set the update bits */
> @@ -1227,7 +1228,7 @@
>  	INIT_LIST_HEAD(&codec->dapm_widgets);
>  	INIT_LIST_HEAD(&codec->dapm_paths);
>  	wm8750_socdev = socdev;
> -	INIT_WORK(&wm8750_dapm_work, wm8750_work, codec);
> +	INIT_DELAYED_WORK(&socdev->delayed_work, wm8750_work);
>  	wm8750_workq = create_workqueue("wm8750");
>  	if (wm8750_workq == NULL) {
>  		kfree(codec);
> 

I'm really not sure what's going on here.  Your patch appears to be against
a version of the driver which someone had attempted to fix up.  But the
version of the driver which I see in today's alsa git tree doesn't have
even those fixes.

Shrug.  Oh well, I queued up something which hopefuly will work, but please
retest next -mm, thanks.

