Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUDAIKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUDAIKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:10:15 -0500
Received: from gprs213-219.eurotel.cz ([160.218.213.219]:43136 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262758AbUDAIKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:10:08 -0500
Date: Thu, 1 Apr 2004 10:09:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, Tjeerd.Mulder@fujitsu-siemens.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: via82xx cmd line parsing is evil [was Re: Sound on newer arima notebook...]
Message-ID: <20040401080954.GA464@elf.ucw.cz>
References: <20040331145206.GA384@elf.ucw.cz> <s5h7jx1xdel.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7jx1xdel.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...seems to work okay, except that mixers are strangely renumbered in
> > aumix. PCM2 has to be set to high if I want to hear something. Master
> > volume does not do anything.
> 
> tuning ac97_quirk option will help.
> (perhaps ac97_quirk=1)

via82xx command line parsing code is *evil*. It has completely
different parameters as a module / in kernel, and in-kernel parameters
shift according to the joystick support! (which is config_time option). Ouch.

Is there some easy way to convert MODULE_PARM with an array to some
more modern interface?
								Pavel

static int dxs_support[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)];
....
MODULE_PARM(dxs_support, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 = auto, 1 = enable, 2 = disable, 3 = 48k only, 4 = no VRA)");
MODULE_PARM_SYNTAX(dxs_support, SNDRV_ENABLED ",allows:{{0,4}},dialog:list");
....
#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
#define SUPPORT_JOYSTICK 1
#endif
....
/* format is: snd-via82xx=enable,index,id,
                          mpu_port,joystick,
                          ac97_quirk,ac97_clock,dxs_support */

static int __init alsa_card_via82xx_setup(char *str)
{
        static unsigned __initdata nr_dev = 0;

        if (nr_dev >= SNDRV_CARDS)
                return 0;
        (void)(get_option(&str,&enable[nr_dev]) == 2 &&
               get_option(&str,&index[nr_dev]) == 2 &&
               get_id(&str,&id[nr_dev]) == 2 &&
               get_option_long(&str,&mpu_port[nr_dev]) == 2 &&
#ifdef SUPPORT_JOYSTICK
               get_option(&str,&joystick[nr_dev]) == 2 &&
#endif
               get_option(&str,&ac97_quirk[nr_dev]) == 2 &&
               get_option(&str,&ac97_clock[nr_dev]) == 2 &&
               get_option(&str,&dxs_support[nr_dev]) == 2);
        nr_dev++;
        return 1;
}


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
