Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVEQWqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVEQWqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVEQWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:44:35 -0400
Received: from smtp06.auna.com ([62.81.186.16]:28352 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262047AbVEQWjr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:39:47 -0400
Date: Tue, 17 May 2005 22:39:45 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
	<1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	<1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
	<1116331359l.7364l.0l@werewolf.able.es> <s5hll6eoxhf.wl@alsa2.suse.de>
In-Reply-To: <s5hll6eoxhf.wl@alsa2.suse.de> (from tiwai@suse.de on Tue May
	17 14:20:12 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1116369585l.8840l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Wed, 18 May 2005 00:39:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.17, Takashi Iwai wrote:
...
> > 
> > Example: go into 4ch mode. Check this control. Then switch to 6ch mode.
> > The Center jack has no sound (it should, shouldn't ?). Check it and voilà.
> > It looks that the logic in the channel selection needs to set this flag also...
> 
> Yep, you're right.  Try the patch below.
> 
> 

Thanks, this patch worked. When in 6ch mode, the boolen flag we talk about
still controls if the line jack is input or output. In 4ch mode, it is always
input. If i chech it, switching to 6ch does not toggle it. They are
independent controls.

Anyways. I can't get rid of the flag. It is initialized to on by default.
Isn't strange to have two ways of controlling this ?

Now we have:

Surround jack mode: [Shared/Independent]
Channel mode [2/4/6]
Center/LFE jack as mic [on/off]
Spread Front... [on/off]


Would not be nice something like:

Surround jacks mode: [Shared/Independent]
Line Jack: [in/surround-out/extra-front-out]
Mic Jack: [in/center-out/extra-front-out]

It looks like internally you can control all ouputs independently.
Just an idea that looks more logical/intuitive to me...
Ah, and could the input level controllers for line and mic be forced
to mute when used as inputs ?

TIA

> Takashi
> 
> --- linux/sound/pci/ac97/ac97_patch.c	13 May 2005 09:58:46 -0000	1.83
> +++ linux/sound/pci/ac97/ac97_patch.c	17 May 2005 12:18:24 -0000
> @@ -1526,13 +1526,8 @@
>  		.get = snd_ac97_ad1888_downmix_get,
>  		.put = snd_ac97_ad1888_downmix_put
>  	},
> -#if 0
> -	AC97_SINGLE("Surround Jack as Input", AC97_AD_MISC, 12, 1, 0),
> -	AC97_SINGLE("Center/LFE Jack as Input", AC97_AD_MISC, 11, 1, 0),
> -#else
>  	AC97_SURROUND_JACK_MODE_CTL,
>  	AC97_CHANNEL_MODE_CTL,
> -#endif
>  };
>  
>  static int patch_ad1888_specific(ac97_t *ac97)
> @@ -1601,6 +1596,18 @@
>  	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0)
>  };
>  
> +static void ad1985_update_jacks(ac97_t *ac97)
> +{
> +	/* shared Line-In */
> +	snd_ac97_update_bits(ac97, AC97_AD_MISC, 1 << 12,
> +			     is_shared_linein(ac97) ? 0 : 1 << 12);
> +	/* shared Mic */
> +	snd_ac97_update_bits(ac97, AC97_AD_MISC, 1 << 11,
> +			     is_shared_micin(ac97) ? 0 : 1 << 11);
> +	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 9 << 11,
> +			     is_shared_micin(ac97) ? 0 : 9 << 11);
> +}
> +
>  static int patch_ad1985_specific(ac97_t *ac97)
>  {
>  	int err;
> @@ -1616,7 +1623,7 @@
>  #ifdef CONFIG_PM
>  	.resume = ad18xx_resume,
>  #endif
> -	.update_jacks = ad1888_update_jacks,
> +	.update_jacks = ad1985_update_jacks,
>  };
>  
>  int patch_ad1985(ac97_t * ac97)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam19 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


