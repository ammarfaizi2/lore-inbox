Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSGST3V>; Fri, 19 Jul 2002 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316965AbSGST3V>; Fri, 19 Jul 2002 15:29:21 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:6628 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315708AbSGST3T>;
	Fri, 19 Jul 2002 15:29:19 -0400
Date: Fri, 19 Jul 2002 21:32:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020719213217.A4663@ucw.cz>
References: <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr> <20020718164536.A30363@ucw.cz> <20020718144838.GC2326@tahoe.alcove-fr> <20020718171531.A30511@ucw.cz> <20020718152829.GD2326@tahoe.alcove-fr> <20020718173132.A30621@ucw.cz> <20020719143602.GH6490@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020719143602.GH6490@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Fri, Jul 19, 2002 at 04:36:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 04:36:02PM +0200, Stelian Pop wrote:
> On Thu, Jul 18, 2002 at 05:31:32PM +0200, Vojtech Pavlik wrote:
> 
> > > > Ok, that's what I wanted to know - I was wondering whether the mouse
> > > > would simply ignore all control commands. And it doesn't not. It needs
> > > > the commands, 
> [...]
> 
> Ok, I've finally found out what's happenning: in i8042_aux_write()
> you restore the CTR value each time. For some obscure reasons, my
> laptop's controller does not like this at all. Disabling this
> section makes the mouse function perfectly.
> 
> Is this CTR restore command really needed ? If it is, we should
> probably add an option like "i8042_noctrrestore=1" to the i8042
> driver...

Thanks a lot for finding this! I thnk we can remove it for now, or
actually add a reverse option to force the restore only if needed - most
machines don't need it.

I'm doing the change immediately.

> Or maybe you have a better idea...
> 
> Stelian.
> 
> ===== drivers/input/serio/i8042.c 1.5 vs edited =====
> --- 1.5/drivers/input/serio/i8042.c	Sat Jul 13 20:31:00 2002
> +++ edited/drivers/input/serio/i8042.c	Fri Jul 19 15:36:09 2002
> @@ -221,12 +221,16 @@
>  
>  	retval  = i8042_command(&c, I8042_CMD_AUX_SEND);
>  
> +#if 0
>  /*
>   * Here we restore the CTR value. I don't know why, but i8042's in half-AT
>   * mode tend to trash their CTR when doing the AUX_SEND command.
> + *
> + * However, for some reasons this breaks (at least) my Sony VAIO C1VE
> + * aux interface.
>   */
> -
>  	retval |= i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
> +#endif
>  
>  /*
>   * Make sure the interrupt happens and the character is received even
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> Alcove - http://www.alcove.com

-- 
Vojtech Pavlik
SuSE Labs
