Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTAYK3Q>; Sat, 25 Jan 2003 05:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbTAYK3Q>; Sat, 25 Jan 2003 05:29:16 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:11966 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266257AbTAYK3P>;
	Sat, 25 Jan 2003 05:29:15 -0500
Date: Sat, 25 Jan 2003 11:33:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Hiroshi Miura <miura@da-cha.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
Message-ID: <20030125113324.D28292@ucw.cz>
References: <20030124031453.0A29F11775F@triton2> <20030124065741.B19571@ucw.cz> <3E3171FC.FE9139CE@cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E3171FC.FE9139CE@cinet.co.jp>; from tomita@cinet.co.jp on Sat, Jan 25, 2003 at 02:03:56AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 02:03:56AM +0900, Osamu Tomita wrote:
> Please fix atkbd_set2_keycode table in atkbd.c for jp106 keyboard.
> 
> Vojtech Pavlik wrote:
> > 
> > On Fri, Jan 24, 2003 at 12:14:53PM +0900, Hiroshi Miura wrote:
> > 
> > > After re-writting a console layer, a japanese keyboard is not supported (or degraded).
> > > This patch fixs it.
> > 
> > This patch doesn't work, all normal keyboards - not just japanese ones have id of 0xab02.
> I agree this point. It's difficult to detect jp106 keyboard automatically.
> Many venders use common internal circuits with us keyborad.
> 
> > > A USB keyboard driver may have same problem, but I don't have one.
> > >
> > > --- linux-2.5.59/drivers/input/keyboard/atkbd.c       2002-12-03 07:59:41.000000000 +0900
> > > +++ edited/linux-2.5.59/drivers/input/keyboard/atkbd.c        2003-01-24 09:13:11.000000000 +0900
> > > @@ -309,6 +309,12 @@
> > >       if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
> > >               atkbd->oldset = 2;
> > >
> > > +     if (atkbd->id == 0xab02) {
> > > +             printk("atkbd: jp109(106) keyboard found\n");
> > > +             param[0] = atkbd_set;
> > > +             atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
> > > +             return 5;
> > > +     }
> > >  /*
> > >   * For known special keyboards we can go ahead and set the correct set.
> > >   * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
> > > @@ -531,6 +537,12 @@
> > >       else
> > >               memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
> > >
> > > +     if (atkbd->set == 5) {
> > > +             atkbd->keycode[0x13] = 0x70;  /* Hiragana/Katakana */
> > > +             atkbd->keycode[0x6a] = 0x7c;  /* Yen, pipe 124*/
> I think he catches good point. Kernel 2.0-2.4 use keycode 124 (0x7c) for scancode 0x6a.
> 2.5 uses keycode 183. This breaks jp106 keymaps. We cannot type '\' and '|' from jp106
> keyboard on 2.5 kernel.
> I believe there is no impact by changing keycode 183 to 124.

Well, it's not so easy. Fortunately KEY_KPCOMMA can be relatively easily
moved elsewhere, however keys 181 to 198 are 'international and language
keys', defined the same way as USB/HID spec (please take a look at it).
Having a single one of them remapped elsewhere doesn't look so nice.

-- 
Vojtech Pavlik
SuSE Labs
