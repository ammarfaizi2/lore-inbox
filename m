Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTAQQHa>; Fri, 17 Jan 2003 11:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTAQQHa>; Fri, 17 Jan 2003 11:07:30 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:59269 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267569AbTAQQH0>;
	Fri, 17 Jan 2003 11:07:26 -0500
Date: Fri, 17 Jan 2003 11:18:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [2.5.58][PnP] Some small points.
Message-ID: <20030117111838.GB26108@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@wildrose.miee.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	Jaroslav Kysela <perex@perex.cz>
References: <1884972299.20030115181611@wr.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1884972299.20030115181611@wr.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruslan,

Thanks for pointing these out. I appreciate your help.


On Wed, Jan 15, 2003 at 06:16:11PM +0300, Ruslan U. Zakirov wrote:
> Hello All.
> 1) __pnp_remove_device(dev) call twice. First time in
> pnpc_remove_device(dev). I think it's wrong.
>

Agreed, I'll apply your patch here.

> _______________________________
> 2) We've forgot to unreg driver on module unload in opl3sa2 driver.
> --- sound/isa/opl3sa2.c~        2003-01-15 17:45:25.000000000 +0300
> +++ sound/isa/opl3sa2.c 2003-01-15 17:47:00.000000000 +0300
> @@ -881,6 +881,9 @@
>
>         for (idx = 0; idx < SNDRV_CARDS; idx++)
>                 snd_card_free(snd_opl3sa2_cards[idx]);
> +#ifdef CONFIG_PNP
> +       pnpc_unregister_driver(&opl3sa2_pnpc_driver);
> +#endif
>  }
>

Yep, it should unregister it there.

>  module_init(alsa_card_opl3sa2_init)
> _________________________________
> 3) Queston: Why we do free in this way?
> static int snd_opl3sa2_free(opl3sa2_t *chip)
> {
> #ifdef CONFIG_PNP
>         chip->dev = NULL;   -> Here. Why NULL? Who realy free resources and how?

The structure that chip->dev points to is freed by the pnp layer on the release call.
Is this what you were asking or are you talking about something else?

> #endif
> #ifdef CONFIG_PM
>         if (chip->pm_dev)
>                 pm_unregister(chip->pm_dev);
> #endif
>         if (chip->irq >= 0)
>                 free_irq(chip->irq, (void *)chip);
>         if (chip->res_port) {
>                 release_resource(chip->res_port);
>                 kfree_nocheck(chip->res_port);
>         }
>         snd_magic_kfree(chip);
>         return 0;
> }



> _______________________________________
> 4) Have we got ALSA driver that work absolutly and use PnP layer in
> right ways?

I believe Jaroslav is working on that now.  Jaroslav, if you would like me to 
convert ALSA drivers please let me know.

Regards,
Adam
