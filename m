Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265600AbSKAKE5>; Fri, 1 Nov 2002 05:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSKAKE5>; Fri, 1 Nov 2002 05:04:57 -0500
Received: from gate.perex.cz ([194.212.165.105]:10506 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265600AbSKAKE4>;
	Fri, 1 Nov 2002 05:04:56 -0500
Date: Fri, 1 Nov 2002 11:10:47 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: "kernel-janitor-discuss@lists.sourceforge.net" 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
In-Reply-To: <200211011302.05461.arnd@bergmann-dalldorf.de>
Message-ID: <Pine.LNX.4.33.0211011108490.1147-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Arnd Bergmann wrote:

> I have been looking for more places in 2.5 that can be marked 
> might_sleep() and noticed that all the functions in asm/uaccess.h
> are not marked although they sleep if the memory they access
> has to be paged in.
> 
> After adding might_sleep() in ten places in asm-i386/uaccess.h
> and arch/i386/lib/usercopy.c, I have been running this kernel
> for about two weeks. So far, I have found only one place where
> the kernel actually hits this and that one is trivially
> fixable (maintainer cc'd, fix see below).
> 
> The question is if we can expect to find more bugs like
> that if we have might_sleep() in uaccess.h or if the 
> extra cycles and the work of changing ~100 places (for all
> architectures) are just not worth it.
> 
> 	Arnd <><
> 
> ===== sound/core/pcm_native.c 1.17 vs edited =====
> --- 1.17/sound/core/pcm_native.c	Sun Oct 13 21:19:17 2002
> +++ edited/sound/core/pcm_native.c	Fri Nov  1 12:43:38 2002
> @@ -2014,8 +2014,6 @@
>  			n = snd_pcm_playback_hw_avail(runtime);
>  		else
>  			n = snd_pcm_capture_avail(runtime);
> -		if (put_user(n, res))
> -			err = -EFAULT;
>  		break;
>  	case SNDRV_PCM_STATE_XRUN:
>  		err = -EPIPE;
> @@ -2026,6 +2024,9 @@
>  		break;
>  	}
>  	spin_unlock_irq(&runtime->lock);
> +	if (!ret)
        ^^^^^^^^^

Shouldn't be here 'if (!err)' ? The fix is in our CVS. Thanks.

> +		if (put_user(n, res))
> +			err = -EFAULT;
>  	return err;
>  }

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

