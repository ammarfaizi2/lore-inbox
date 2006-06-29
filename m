Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbWF2LLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbWF2LLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932881AbWF2LLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:11:41 -0400
Received: from [141.84.69.5] ([141.84.69.5]:14604 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932742AbWF2LLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:11:40 -0400
Date: Thu, 29 Jun 2006 13:10:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] [2.6 patch] fix the SND_FM801_TEA575X dependencies
Message-ID: <20060629111058.GB29056@stusta.de>
References: <20060629094944.GA29056@stusta.de> <s5hzmfwns9e.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzmfwns9e.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 12:57:49PM +0200, Takashi Iwai wrote:
> At Thu, 29 Jun 2006 11:49:44 +0200,
> Adrian Bunk wrote:
> > 
> > CONFIG_SND_FM801=y, CONFIG_SND_FM801_TEA575X=m resulted in the following 
> > compile error:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      vmlinux
> > sound/built-in.o: In function `snd_fm801_free':
> > fm801.c:(.text+0x3c15b): undefined reference to `snd_tea575x_exit'
> > sound/built-in.o: In function `snd_card_fm801_probe':
> > fm801.c:(.text+0x3cfde): undefined reference to `snd_tea575x_init'
> > make: *** [vmlinux] Error 1
> > 
> > <--  snip  -->
> > 
> > This patch fixes kernel Bugzilla #6458.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Could it be a simplier one like below?


Your patch would in the case of SND_FM801=m:
- build snd-tea575x-tuner.o statically into the kernel
- set VIDEO_DEV=y


> Takashi
> 
> 
> diff -r cd7256009b28 sound/pci/Kconfig
> --- a/sound/pci/Kconfig	Wed Jun 28 16:39:36 2006 +0200
> +++ b/sound/pci/Kconfig	Thu Jun 29 12:54:08 2006 +0200
> @@ -461,16 +461,13 @@ config SND_FM801
>  	  will be called snd-fm801.
>  
>  config SND_FM801_TEA575X
> -	tristate "ForteMedia FM801 + TEA5757 tuner"
> +	bool "TEA5757 tuner support on ForteMedia FM801"
>  	depends on SND_FM801
>          select VIDEO_DEV
>  	help
>  	  Say Y here to include support for soundcards based on the ForteMedia
>  	  FM801 chip with a TEA5757 tuner connected to GPIO1-3 pins (Media
>  	  Forte SF256-PCS-02).
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called snd-fm801-tea575x.
>  
>  config SND_HDA_INTEL
>  	tristate "Intel HD Audio"
> diff -r cd7256009b28 sound/pci/fm801.c
> --- a/sound/pci/fm801.c	Wed Jun 28 16:39:36 2006 +0200
> +++ b/sound/pci/fm801.c	Thu Jun 29 12:54:08 2006 +0200
> @@ -35,7 +35,7 @@
>  
>  #include <asm/io.h>
>  
> -#if (defined(CONFIG_SND_FM801_TEA575X) || defined(CONFIG_SND_FM801_TEA575X_MODULE)) && (defined(CONFIG_VIDEO_DEV) || defined(CONFIG_VIDEO_DEV_MODULE))
> +#ifdef CONFIG_SND_FM801_TEA575X
>  #include <sound/tea575x-tuner.h>
>  #define TEA575X_RADIO 1
>  #endif

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

