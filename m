Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUB2AO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 19:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUB2AO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 19:14:29 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14324 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261956AbUB2AOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 19:14:25 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Worrisome IDE PIO transfers...
Date: Sun, 29 Feb 2004 01:21:30 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com>
In-Reply-To: <4041232C.7030305@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402290121.30498.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Geert added to cc: ]

On Sunday 29 of February 2004 00:24, Jeff Garzik wrote:
> Looking at the function that is used to transfer data when in PIO mode...
>
> void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
> {
>          if (drive->bswap) {
>                  ata_bswap_data(buffer, wcount);
>                  HWIF(drive)->ata_output_data(drive, buffer, wcount);
>                  ata_bswap_data(buffer, wcount);
>          } else {
>                  HWIF(drive)->ata_output_data(drive, buffer, wcount);
>          }
> }
>
> Swapping the data in-place is very, very wrong...   you don't want to be
> touching the data that userspace might have mmap'd ...  Additionally,
> byteswapping back and forth for each PIO sector chews unnecessary CPU.

This is used for accessing "normal" disks on beasts with byte-swapped IDE
bus (Atari/Q40/TiVo) and "byteswapped" disks on normal machines.

[ Hm. actually I don't see how it can be used for accessing "normal" disks,
  as data is byteswapped by IDE bus and then swapped back by IDE driver. ]

Manfred noticed the same issue some time ago:
http://www.ussg.iu.edu/hypermail/linux/kernel/0201.0/0768.html
but discussion ended without final conclusion.

I like Alan's idea to use loopback instead of "bswap".

> Seems to me the architecture's OUTS[WL] hook (or a new, similar hook)
> that swaps as it writes would be _much_ preferred, and eliminate this
> possible data corruption issue.

I think something similar has been already done
(grep for insw_swapw/outsw_swapw in ide-iops.c and asm-m68k/ide.h).

Bartlomiej

