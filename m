Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270179AbRHGKgP>; Tue, 7 Aug 2001 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270180AbRHGKgF>; Tue, 7 Aug 2001 06:36:05 -0400
Received: from mail.teraport.de ([195.143.8.72]:13953 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S270179AbRHGKfx>;
	Tue, 7 Aug 2001 06:35:53 -0400
Message-ID: <3B6FC48A.BF526D61@TeraPort.de>
Date: Tue, 07 Aug 2001 12:35:54 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: [PATCH] eepro100.c - Add option to disable power saving in2.4.7-ac7
In-Reply-To: <Pine.LNX.4.33.0108061847110.8689-100000@chaos.tp1.ruhr-uni-bochum.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/07/2001 12:35:54 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/07/2001 12:36:05 PM,
	Serialize complete at 08/07/2001 12:36:05 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Mon, 6 Aug 2001, Martin Knoblauch wrote:
> 
> >  after realizing that my first attempt for this patch was to
> > enthusiastic, I have no a somewhat stripped down version. Compiles
> > against 2.4.7-ac7.
> 
> I have an even smaller version. You can select the D state for sleeping as
> a parameter, 0 should fix Martin's flaky hardware, 2 is the default -
> current behavior.
> 
> --Kai
> 
> --- linux-2.4.7-ac2/drivers/net/eepro100.c      Sat Jul 28 10:24:55 2001
> +++ linux-2.4.7-ac2.work/drivers/net/eepro100.c Mon Aug  6 18:49:11 2001
> @@ -60,6 +60,8 @@
>  static int full_duplex[] = {-1, -1, -1, -1, -1, -1, -1, -1};
>  static int options[] = {-1, -1, -1, -1, -1, -1, -1, -1};
>  static int debug = -1;                 /* The debug level */
> +/* power save D state when device is not open */
> +static unsigned int sleep_state = 2;
> 
>  /* A few values that may be tweaked. */
>  /* The ring sizes should be a power of two for efficiency. */
> @@ -125,6 +127,7 @@
>  MODULE_PARM(rx_copybreak, "i");
>  MODULE_PARM(max_interrupt_work, "i");
>  MODULE_PARM(multicast_filter_limit, "i");
> +MODULE_PARM(sleep_state, "i");
>  MODULE_PARM_DESC(debug, "eepro100 debug level (0-6)");
>  MODULE_PARM_DESC(options, "eepro100: Bits 0-3: tranceiver type, bit 4: full duplex, bit 5: 100Mbps");
>  MODULE_PARM_DESC(full_duplex, "eepro100 full duplex setting(s) (1)");
> @@ -136,6 +139,7 @@
>  MODULE_PARM_DESC(rx_copybreak, "eepro100 copy breakpoint for copy-only-tiny-frames");
>  MODULE_PARM_DESC(max_interrupt_work, "eepro100 maximum events handled per interrupt");
>  MODULE_PARM_DESC(multicast_filter_limit, "eepro100 maximum number of filtered multicast addresses");
> +MODULE_PARM_DESC(sleep_state, "eepro100 power save D state (default 2)");
> 
>  #define RUN_AT(x) (jiffies + (x))
> 
> @@ -777,8 +781,10 @@
>         inl(ioaddr + SCBPort);
>         udelay(10);
> 
> -       /* Put chip into power state D2 until we open() it. */
> -       pci_set_power_state(pdev, 2);
> +       if (sleep_state > 2)
> +               sleep_state = 2;
> +       /* Put chip into power saving state until we open() it. */
> +       pci_set_power_state(pdev, sleep_state);
> 
>         pci_set_drvdata (pdev, dev);
> 
> @@ -1833,7 +1839,7 @@
>         if (speedo_debug > 0)
>                 printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
> 
> -       pci_set_power_state(sp->pdev, 2);
> +       pci_set_power_state(sp->pdev, sleep_state);
> 
>         MOD_DEC_USE_COUNT;
> 


 Great. Will definitely do the job for me and others with "funny" acting
eepro100s.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
