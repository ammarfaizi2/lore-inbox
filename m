Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbTJ0CFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTJ0CFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:05:20 -0500
Received: from CPE-203-51-33-174.nsw.bigpond.net.au ([203.51.33.174]:17295
	"EHLO gaston") by vger.kernel.org with ESMTP id S263153AbTJ0CFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:05:12 -0500
Subject: Re: [PPC] Mac mouse emulate buttons
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Daniele Pala <dandario@libero.it>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, paulus@cs.anu.edu.au
In-Reply-To: <20031026174853.GA350@SuperSoul>
References: <20031026174853.GA350@SuperSoul>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067220294.4154.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 27 Oct 2003 03:04:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-26 at 18:48, Daniele Pala wrote:
> Mouse button emulation doesn't work in the console, because the expression
> 
> if ((raw_mode = (kbd->kbdmode == VC_RAW)))
> 
> never gets true. So i moved the call to mac_hid_mouse_emulate_buttons
> outside the emulate_raw function. Mouse emulation
> sucks, but i'm too poor to buy a 3-buttons mouse :)
> 
> I'm not subscribed to the list, please CC me privately

Thanks, Can you CC me further Mac related issues ?

That code should be moved to a separate module, afaik, the input
layer allows stacking of such "filtering" modules now, though
I haven't looked at the details.

Ben.

> Cheers,
> 	Daniele
> 
> 
> --- linux-2.6.0-test8/drivers/char/keyboard.c	Tue Sep 30 18:43:22 2003
> +++ linux-2.6.0-test8_mod/drivers/char/keyboard.c	Sun Oct 26 09:31:50 2003
> @@ -964,11 +964,6 @@
>  static int emulate_raw(struct vc_data *vc, unsigned int keycode, 
>  		       unsigned char up_flag)
>  {
> -#ifdef CONFIG_MAC_EMUMOUSEBTN
> -	if (mac_hid_mouse_emulate_buttons(1, keycode, !up_flag))
> -		return 0;
> -#endif /* CONFIG_MAC_EMUMOUSEBTN */
> -
>  	if (keycode > 255 || !x86_keycodes[keycode])
>  		return -1; 
>  
> @@ -1039,6 +1034,11 @@
>  #endif
>  
>  	rep = (down == 2);
> +
> +#ifdef CONFIG_MAC_EMUMOUSEBTN
> +        if(mac_hid_mouse_emulate_buttons(1, keycode, down << 7))
> +		return;
> +#endif /* CONFIG_MAC_EMUMOUSEBTN */
>  
>  	if ((raw_mode = (kbd->kbdmode == VC_RAW)))
>  		if (emulate_raw(vc, keycode, !down << 7))
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
