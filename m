Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUBJAXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUBJATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:19:53 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25568 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265681AbUBJAS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 19:18:59 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Athol Mullen <me@privacy.net>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Date: Tue, 10 Feb 2004 01:24:13 +0100
User-Agent: KMail/1.5.3
References: <1mLsS-6Oq-7@gated-at.bofh.it> <1mRHV-4Xn-7@gated-at.bofh.it> <c06jlm$13ju4j$1@ID-215292.news.uni-berlin.de>
In-Reply-To: <c06jlm$13ju4j$1@ID-215292.news.uni-berlin.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402100124.13627.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of February 2004 03:50, Athol Mullen wrote:
> Willy Tarreau <willy@w.ods.org> wrote:
> > On Sun, Feb 08, 2004 at 11:45:18AM +1100, Athol Mullen wrote:
> >
> > I captured dmesg and /proc/ide/piix, but forgot to post them. They're at
> > work now. But I did the change, by commenting out the call to
> > eighty_ninety_three() in piix.c, and my disks came back to 54 MB/s each,
> > and 64 MB/s cumulated.  dmesg showed UDMA33 before and now displays
> > UDMA100 again. But I obviously cannot let it like that because if I
> > install this kernel in a 40-pin machine, I will get some surprizes !
>
> That's what worries me...
>
> > I understand. But could you please post your ICH5 detection code so that
> > I can try it on this machine. I still can play with it for a few days
> > before it gets racked. And I can try with both 40 and 80-pin cables.
>
> This patch inserts the piix code into eighty_ninty_three() - obviously
> this is for testing purposes only.  The patch was diff'd against 2.4.22,
> but patches okay to 2.6.1 with:
>     Hunk #1 succeeded at 719 (offset -10 lines).
>
> --- ide-iops.c.orig	2004-01-18 15:04:24.000000000 +1100
> +++ ide-iops.c	2004-01-18 16:41:16.000000000 +1100
> @@ -729,6 +729,34 @@
>
>  #else
>
> +#ifdef CONFIG_BLK_DEV_PIIX
> +	/* ICH BIOSes are supposed to set a bit flags for us */
> +
> +	ide_hwif_t *hwif	= HWIF(drive);
> +	struct pci_dev *dev	= hwif->pci_dev;
> +	u16 cr_flag		= 0x10 << drive->dn;
> +	u16			reg54;
> +
> +	if (hwif->pci_dev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch(hwif->pci_dev->device) {
> +			case PCI_DEVICE_ID_INTEL_82801BA_8:
> +	    		case PCI_DEVICE_ID_INTEL_82801BA_9:
> +	    		case PCI_DEVICE_ID_INTEL_82801CA_10:
> +	    		case PCI_DEVICE_ID_INTEL_82801CA_11:
> +	    		case PCI_DEVICE_ID_INTEL_82801E_11:
> +	    		case PCI_DEVICE_ID_INTEL_82801DB_10:
> +			case PCI_DEVICE_ID_INTEL_82801DB_11:
> +			case PCI_DEVICE_ID_INTEL_82801EB_11:
> +			case PCI_DEVICE_ID_INTEL_82801AA_1:
> +			case PCI_DEVICE_ID_INTEL_82372FB_1:
> +			    {
> +			    pci_read_config_word(dev, 0x54, &reg54);
> +			    return ((reg54 & cr_flag) ? 1 : 0);
> +			    }
> +		}
> +	}
> +#endif /* CONFIG_BLK_DEV_PIIX */
> +

This is plain wrong, piix.c already does it for you.
piix.c:init_hwif_piix():

(...)
	u8 mask = hwif->channel ? 0xc0 : 0x30;
(...)
			pci_read_config_byte(hwif->pci_dev, 0x54, &reg54h);
			pci_read_config_byte(hwif->pci_dev, 0x55, &reg55h);
			ata66 = (reg54h & mask) ? 1 : 0;
(...)
	if (!(hwif->udma_four))
		hwif->udma_four = ata66;

So you could just add:
	return hwif->udma_four;
for testing purposes.

>  	return ((u8) ((HWIF(drive)->udma_four) &&

Therefore this will be true.

>  #ifndef CONFIG_IDEDMA_IVB
>  			(drive->id->hw_config & 0x4000) &&

Here is your problem.

Please make sure you have CONFIG_IDEDMA_IVB=n in your config.
If it is okay, please send me a copy of /proc/ide/hdX/identify.

--bart

