Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSIIOCs>; Mon, 9 Sep 2002 10:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSIIOCs>; Mon, 9 Sep 2002 10:02:48 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:660 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316695AbSIIOCq>;
	Mon, 9 Sep 2002 10:02:46 -0400
Date: Mon, 9 Sep 2002 16:07:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.33/drivers/input/keyboard/atkbd.c allow SETLEDS to fail
Message-ID: <20020909160723.A2392@ucw.cz>
References: <20020909065111.A1556@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020909065111.A1556@baldur.yggdrasil.com>; from adam@yggdrasil.com on Mon, Sep 09, 2002 at 06:51:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 06:51:11AM -0700, Adam J. Richter wrote:

> 	I have a computer with an Iwill VD133 motherboard doing
> USB-to-PS/2 keyboard emulation (built into the chipset somewhere)
> for a BTC 7932M USB keyboard.  Under this configuration, the
> SETLEDS command in atkbd_probe fails (the first atkbd_sendbyte
> in atkbd_command fails), but the keyboard otherwise works if
> that failure is ignored.
> 
> 	I noticed this when my keyboard stopped working in 2.5.32.
> I have verified that 2.5.31 (and probably all kernels before it)
> also do not set the LEDs on my USB-emulating-PS/2 keyboard.
> 
> 	I cannot say whether the problem occurs with other USB
> keyboards because I don't have one handy.
> 
> 	One cannot run the USB keyboard "natively" via Linux USB on this
> motherboard because the BIOS does not seem to set an IRQ line for the USB
> controller.  I've tried booting with "pci=biosirq", and I think I've tried
> all the relevant BIOS menu options, and I'm running the latest BIOS,
> and the VD133 product has been terminated.  So the patch does seem to be
> "necessary" to support some configurations, at least for now.

I cannot do that, since then the keyboard identification will give too
many positives.

I assume you have an USB keyboard, and the BIOS emulates a PS/2 keyboard
for non-USB capable OSes.

Well, fix Linux irq router code, instead of damaging the keyboard code.

The mainboard has VIA Apollo Pro133 chipset - it should be fairly easily
possible to change the IRQ routes in the pci-irq.c code for the USB
controller.

> --- linux-2.5.33/drivers/input/keyboard/atkbd.c	2002-08-31 15:05:31.000000000 -0700
> +++ linux/drivers/input/keyboard/atkbd.c	2002-09-09 06:29:04.000000000 -0700
> @@ -359,13 +359,13 @@
>  #endif
>  
>  /*
> - * Next we check we can set LEDs on the keyboard. This should work on every
> - * keyboard out there. It also turns the LEDs off, which we want anyway.
> + * Turn off LEDs.  This command fails on at least a BTC 7932M USB keyboard
> + * connected to an Iwill VD133 motherboard that is configured to emulate
> + * a PS/2 keyboard via USB.
>   */
>  
>  	param[0] = 0;
> -	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
> -		return -1;
> +	atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS);
>  
>  /*
>   * Then we check the keyboard ID. We should get 0xab83 under normal conditions.


-- 
Vojtech Pavlik
SuSE Labs
