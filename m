Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281253AbRKERUx>; Mon, 5 Nov 2001 12:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281251AbRKERUo>; Mon, 5 Nov 2001 12:20:44 -0500
Received: from gate.mesa.nl ([194.151.5.70]:32010 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281248AbRKERUd>;
	Mon, 5 Nov 2001 12:20:33 -0500
Date: Mon, 5 Nov 2001 18:20:29 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Stephane Jourdois <stephane@tuxfinder.org>
Cc: Massimo Dal Zotto <dz@debian.org>, LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011105182029.C24310@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net> <20011105130954.A24310@joshua.mesa.nl> <20011105180124.B17203@emeraude.kwisatz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011105180124.B17203@emeraude.kwisatz.net>; from stephane@tuxfinder.org on Mon, Nov 05, 2001 at 06:01:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

Thanks for the info. I really believe you :-)
The X keycodes are indeed 129-132. I checked them using xev.
I checked /proc/i8k while pressing the buttons next to the
power button and they work fine. 
So what's left is to tie these buttons to some function so that
I can control the soundvolume/dvd player wherever I am i X...

-Marcel

On Mon, Nov 05, 2001 at 06:01:24PM +0100, Stephane Jourdois wrote:
> On Mon, Nov 05, 2001 at 01:09:54PM +0100, Marcel J.E. Mol wrote:
> > I have an i8000 too. I tried some info to use the 'multimedia' buttons
> > next to the power button. Do you know if these are also managed through
> > smm?  Or are thre other ways/tools to access these buttons?
> In fact, the two buttons next to the power button only are supported by
> the SMM BIOS. The 4 others buttons send e0 keyboard scancodes, and are
> fully supported by every kernel (Respectively e0 01, e0 02, e0 03, and
> e0 04, from left to right).
> Here is a patch to prove what I'm saying :
> 
> 
> --- drivers/char/pc_keyb.c.orig      Mon Nov  5 17:41:54 2001
> +++ drivers/char/pc_keyb.c   Mon Nov  5 17:45:56 2001
> @@ -227,9 +227,18 @@
>  #define E0_MSLW        125
>  #define E0_MSRW        126
>  #define E0_MSTM        127
> +/*
> + * Multimedia Keys on Dell Inspiron i8x00
> + * (from left to right : play, stop, previous, next)
> + */
> +#define E0_DELL_PLAY           120
> +#define E0_DELL_STOP           121
> +#define E0_DELL_PREVIOUS       122
> +#define E0_DELL_NEXT           123
> 
>  static unsigned char e0_keys[128] = {
> -  0, 0, 0, 0, 0, 0, 0, 0,                            /* 0x00-0x07 */
> +  E0_DELL_PLAY, E0_DELL_STOP, E0_DELL_PREVIOUS, E0_DELL_NEXT, /*
> 0x00-0x03 */
> +  0, 0, 0, 0,                                        /* 0x04-0x07 */
>    0, 0, 0, 0, 0, 0, 0, 0,                            /* 0x08-0x0f */
>    0, 0, 0, 0, 0, 0, 0, 0,                            /* 0x10-0x17 */
>    0, 0, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0,            /* 0x18-0x1f */
> 
> 
> 
> Then edit your /etc/console/bootime.kmap.gz (package console-common in
> debian) to add for example :
> ----
> keycode 120 = F70 F71
> keycode 121 = Last_Console
> keycode 122 = Decr_Console
> keycode 123 = Incr_Console
> string F70 = "Hello World !"
> string F71 = "Dell Inspiron Powah !"
> ----
> 
> 
> then issue the command /etc/init.d/keymap.sh (or loadkeys if you do not
> use debian) *under console*, and you'll then believe me :-)
> 
> 
> To support those keys under X, that's more complicated, because AFAIK we
> have to create X keysyms before assigning them to keycodes.
> but try that in your ~/.xmodmap :
> ----
> keycode 129 = a b c d
> keycode 130 = a b c d
> keycode 131 = a b c d
> keycode 132 = a b c d
> ----
> then xmodmap ~/.xmodmap, and try <PLAY>, SHIFT-<PLAY>, ALT-<PLAY>,
> CTRL-<PLAY>, etc.
> (In fact, I really don't remember why I used 129-132 here... try with
> 120-123 if it doesn't work :-) I think I used those values to test if
> keycodes are 8bits clean, they are not.)
> 
> 
> Hope this helps, and if anybody knows how to implement keysyms, I'm
> interested... as long as I don't have to patch XFree86 !
> 
> Please do not hesitate to contact me if you have any other questions.
> 
> To finish, SMM BIOS implements supoprt for the two big buttons next to
> the power button (try to press them both at the same time to have mute
> ;-), and the three blue Fn-keys for sound (PgUp, PgDown, and End)
> 
> 
> Stephane.
> 
> -- 
>  ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
> (((    Ingénieur développement 	\ /    AGAINST HTML MAIL    )))
>  \\\   6, av. de la Belle Image	 X                         ///
>   \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///



-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
