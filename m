Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSLSNLz>; Thu, 19 Dec 2002 08:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSLSNLy>; Thu, 19 Dec 2002 08:11:54 -0500
Received: from pullyou.nist.gov ([129.6.16.93]:64910 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id <S264647AbSLSNLx>;
	Thu, 19 Dec 2002 08:11:53 -0500
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Trident/ALi 5451 problem, 2.4.20-ac2
References: <9cf4r9btpk8.fsf@rogue.ncsl.nist.gov>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Thu, 19 Dec 2002 08:19:25 -0500
In-Reply-To: <9cf4r9btpk8.fsf@rogue.ncsl.nist.gov> (Ian Soboroff's message
 of "Wed, 18 Dec 2002 08:38:31 -0500")
Message-ID: <9cfisxqi1sy.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff <ian.soboroff@nist.gov> writes:

> Just tried 2.4.20-ac2 on my Fujitsu P-2040, and it seems to have a
> problem initializing the sound:
>
> (from dmesg)
>
> Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h,
>  17:35:49 Dec 16 2002
> PCI: Found IRQ 9 for device 00:04.0
> trident: ALi Audio Accelerator found at IO 0x1000, IRQ 9
> ALi 5451 did not come out of reset.
> trident_ac97_init: error resetting 5451.

Took a bit of a look... the trident.c part of the patch is pretty
short:

--- linux.vanilla/drivers/sound/trident.c       2002-11-29 21:27:19.000000000 +0
000
+++ linux.20-ac2/drivers/sound/trident.c        2002-11-14 15:24:35.000000000 +0
000
@@ -3936,9 +3936,11 @@
                wReg = ali_ac97_get(card, 0, AC97_POWER_CONTROL);
                if((wReg & 0x000f) == 0x000f)
                        return 0;
-               udelay(500);
+               udelay(5000);
        }
-       return 0;
+
+       printk(KERN_ERR "ALi 5451 did not come out of reset.\n");
+       return 1;
 }

 /* AC97 codec initialisation. */

I guess the loop (which the patch only shows the bottom of) is trying
to reset the AC97, and check the reset witht he ali_ac97_get() call.
The old 2.4.20 code just returned 0 in any case, whether the reset
succeeded or not.  On my laptop, if I change this routine back to
return 0 in all cases, sound works fine.  With this patch, this
routine returns 1, and the trident.c init aborts.

Perhaps the loop check for reset success isn't right?  Or not all ALi
5451's play nice?  I've reached the end of my clue.

Ian

