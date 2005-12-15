Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVLOG0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVLOG0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVLOG0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:26:50 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:50498 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964933AbVLOG0u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:26:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i5d3U18MMV1WR8B8pqTKePfxVmLrXEiiP47qAsTdLPRhselEcREXEt8MqzR4kzrphvWRboWhmMxbbpb5x7wVd+kTpB9W0UQ+RkwKzl2l7gjvASb6veqdBYPo1/iK8VfGVkfYTLvn0QzrjEBpiGW36PS+ASmnvgYwuhvR7SH2NnQ=
Message-ID: <47f5dce30512142226n18fc4280m26ce5b0bb4b80d3f@mail.gmail.com>
Date: Wed, 14 Dec 2005 22:26:49 -0800
From: jayakumar alsa <jayakumar.alsa@gmail.com>
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: cs5536 ID for cs5535audio
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200512141431.32685.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200512141431.32685.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, René Rebe <rene@exactcode.de> wrote:
> Hi all,
>
> relative to 2.6.15-rc5-mm2 / alsa-cvs, works for me:
>
> Added AMD CS5536 to the cs5535audio driver.
>

René,

Your patch looks fine to me. If possible, could you add an update for
the Kconfig to list cs5536 within the cs5535audio entry. One thing
though, I'm concerned about master mixer control on certain GX3
boards. There was an issue raised by Stefan Schweizer where the
cs5535audio driver on GX3 boards (with at least one that used the
Realtek ALC203 rev 0 ac97 codec) fails to provide functional master
control. John Zulauf mentioned that certain GX3 reference board
designs wire headphone out to the connector rather than main. I still
haven't received the GX3 to test with so perhaps someone else would
like to test an AC97_TUNE_HP_ONLY ac97_quirk. Here's a rough start
that someone could use:

static char *ac97_quirk;
module_param(ac97_quirk, charp, 0444);
MODULE_PARM_DESC(ac97_quirk, "AC'97 board specific workarounds.");

static struct ac97_quirk ac97_quirks[] __devinitdata = {
	{
		.subvendor = use lspci to find out,
		.subdevice = something,
		.name = "boardname",     /* codecname */
		.type = AC97_TUNE_HP_ONLY
	},
	{}
};

then add:

snd_ac97_tune_hardware(cs5535au->ac97, ac97_quirks, ac97_quirk);

after the snd_ac97_mixer call.

Thanks,
jk

> Signed-off-by: René Rebe <rene@exactcode.de>
>
> --- sound/pci/cs5535audio/cs5535audio.c.orig	2005-12-14 14:39:11.000000000
> +0100
> +++ sound/pci/cs5535audio/cs5535audio.c	2005-12-14 14:29:23.000000000 +0100
> @@ -46,8 +46,10 @@
>  static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
>
>  static struct pci_device_id snd_cs5535audio_ids[] = {
> -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
> -		PCI_ANY_ID, 0, 0, 0, },
> +	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
>  	{}
>  };
>
>
>
> --
> René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
>             http://www.exactcode.de | http://www.t2-project.org
>             +49 (0)30  255 897 45
>
>
