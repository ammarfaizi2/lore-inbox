Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTBEV15>; Wed, 5 Feb 2003 16:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbTBEV15>; Wed, 5 Feb 2003 16:27:57 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:2322 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S264628AbTBEV1z>;
	Wed, 5 Feb 2003 16:27:55 -0500
Message-ID: <3E41841A.8040006@scssoft.com>
Date: Wed, 05 Feb 2003 22:37:30 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: sven kissner <sven.kissner@t-online.de>
CC: alan@lxorguk.ukuu.org.uk, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt8235 headache
References: <20030203225014$6785@gated-at.bofh.it> <3E407E8A.1010700@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with this patch applied over the 2.4.21-pre4-ac2, the CDROM on IDE1 now
works ok, no more error messages.

The harddrive on /dev/hdc is still choking though...

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: DMA disabled
ide1: reset: master: error (0x00?)
hdc: lost interrupt

Regards,
Petr

sven kissner wrote:

> hi petr,
>
> i had the same errors (although i never experienced any issues with hd,
> but this seems to be because i'm running them on primary while having my
> atapu devices on secondary). i fixed them the following:
>
> - using 2.4.21pre4 (pre3 worked either)
> - applying the following patch from vojteck:
>
> <--
> ChangeSet@1.884, 2002-12-19 11:23:11+01:00, vojtech@suse.cz
>    VIA IDE: Always use slow address setup timings for ATAPI devices.
>
>
> via82cxxx.c |   19 ++++++-------------
> 1 files changed, 6 insertions(+), 13 deletions(-)
>
>
> diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
> --- a/drivers/ide/pci/via82cxxx.c       Thu Dec 19 11:23:42 2002
> +++ b/drivers/ide/pci/via82cxxx.c       Thu Dec 19 11:23:42 2002
> @@ -1,16 +1,5 @@
> /*
> - * $Id: via82cxxx.c,v 3.35-ac2 2002/09/111 Alan Exp $
> - *
> - *  Copyright (c) 2000-2001 Vojtech Pavlik
> - *
> - *  Based on the work of:
> - *     Michel Aubry
> - *     Jeff Garzik
> - *     Andre Hedrick
> - */
> -
> -/*
> - * Version 3.35
> + * Version 3.36
>    *
>    * VIA IDE driver for Linux. Supported southbridges:
>    *
> @@ -152,7 +141,7 @@
>          via_print("----------VIA BusMastering IDE Configuration"
>                  "----------------");
>
> -       via_print("Driver Version:                     3.35-ac");
> +       via_print("Driver Version:                     3.36");
>          via_print("South Bridge:                       VIA %s",
>                  via_config->name);
>
> @@ -351,6 +340,10 @@
>                  ide_timing_compute(peer, peer->current_speed, &p, T, UT);
>                  ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
>          }
> +
> +       /* Always use 4 address setup clocks on ATAPI devices */
> +       if (drive->media != ide_disk)
> +               t.setup = 4;
>
>          via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
> -->



