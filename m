Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbTA0Vqr>; Mon, 27 Jan 2003 16:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTA0Vqr>; Mon, 27 Jan 2003 16:46:47 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:34437 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263246AbTA0Vqp>;
	Mon, 27 Jan 2003 16:46:45 -0500
Date: Mon, 27 Jan 2003 22:52:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Message-ID: <20030127225243.A25892@ucw.cz>
References: <200301272057.VAA13114@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200301272057.VAA13114@harpo.it.uu.se>; from mikpe@csd.uu.se on Mon, Jan 27, 2003 at 09:57:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 09:57:43PM +0100, Mikael Pettersson wrote:
> On Mon, 27 Jan 2003 13:34:32 +0100, Vojtech Pavlik wrote:
> >> Either removing the SSCANSET from atkbd_cleanup(), or changing
> >> atkbd->oldset from 22 to 2, solves my CPi's keyboard problems.
> >
> >Can you try with the attached atkbd.c? It uses RESET_BAT instead of
> >SSCANSET, which will slow down the reboot a bit, but should be very safe
> >to bring the keyboard to its power-on state, which the BIOS should be
> >able to handle.
> 
> I tried it, and the change to use RESET_BAT in atkbd_cleanup()
> works fine. Tested on my Dell Latitiude CPi and four desktop
> boxes of various vintages. No new problems. A reboot takes maybe
> 1/10 of a second longer, but I don't care.
> 
> However, your version of atkbd.c caused a linkage error due to a
> reference to input_regs() in atkbd_interrupt(). I extracted
> just the changes to atkbd_cleanup() and atkbd_command(), but that
> left me with a dead keyboard on the first test box. In the end
> I kept only the atkbd_cleanup() change and the increased timeout
> for RESET_BAT in atkbd_command() [see below].

Good. I'll do more tests here and find the problem which left you
without the keyboard - the current atkbd.c I sent you is fairly
untested.

> 
> /Mikael
> 
> --- linux-2.5.59/drivers/input/keyboard/atkbd.c.~1~	2002-11-23 17:59:41.000000000 +0100
> +++ linux-2.5.59/drivers/input/keyboard/atkbd.c	2003-01-27 19:54:30.000000000 +0100
> @@ -233,6 +233,9 @@
>  	int i;
>  
>  	atkbd->cmdcnt = receive;
> +
> +	if (command == ATKBD_CMD_RESET_BAT)
> +		timeout = 200000; /* 2 sec */
>  	
>  	if (command & 0xff)
>  		if (atkbd_sendbyte(atkbd, command & 0xff))
> @@ -442,7 +445,7 @@
>  static void atkbd_cleanup(struct serio *serio)
>  {
>  	struct atkbd *atkbd = serio->private;
> -	atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_SSCANSET);
> +	atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT);
>  }
>  
>  /*

-- 
Vojtech Pavlik
SuSE Labs
