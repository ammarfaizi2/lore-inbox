Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUB2A6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 19:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUB2A6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 19:58:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261959AbUB2A6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 19:58:30 -0500
Message-ID: <40413927.6010408@pobox.com>
Date: Sat, 28 Feb 2004 19:58:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402290121.30498.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> [ Geert added to cc: ]
> 
> On Sunday 29 of February 2004 00:24, Jeff Garzik wrote:
> 
>>Looking at the function that is used to transfer data when in PIO mode...
>>
>>void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
>>{
>>         if (drive->bswap) {
>>                 ata_bswap_data(buffer, wcount);
>>                 HWIF(drive)->ata_output_data(drive, buffer, wcount);
>>                 ata_bswap_data(buffer, wcount);
>>         } else {
>>                 HWIF(drive)->ata_output_data(drive, buffer, wcount);
>>         }
>>}
>>
>>Swapping the data in-place is very, very wrong...   you don't want to be
>>touching the data that userspace might have mmap'd ...  Additionally,
>>byteswapping back and forth for each PIO sector chews unnecessary CPU.
> 
> 
> This is used for accessing "normal" disks on beasts with byte-swapped IDE
> bus (Atari/Q40/TiVo) and "byteswapped" disks on normal machines.
> 
> [ Hm. actually I don't see how it can be used for accessing "normal" disks,
>   as data is byteswapped by IDE bus and then swapped back by IDE driver. ]

Yeah, just byteswapped disks are affected.


> Manfred noticed the same issue some time ago:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0201.0/0768.html
> but discussion ended without final conclusion.
> 
> I like Alan's idea to use loopback instead of "bswap".

Neat but no more zerocopy that way.  I much prefer a swap-as-you-go...


>>Seems to me the architecture's OUTS[WL] hook (or a new, similar hook)
>>that swaps as it writes would be _much_ preferred, and eliminate this
>>possible data corruption issue.
> 
> I think something similar has been already done
> (grep for insw_swapw/outsw_swapw in ide-iops.c and asm-m68k/ide.h).

Yeah, but this would need to be per-device...  I agree all the other 
pieces are already present.

	Jeff


