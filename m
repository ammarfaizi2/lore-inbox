Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVBHJAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVBHJAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVBHJAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:00:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:48071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261494AbVBHJAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:00:35 -0500
Date: Tue, 8 Feb 2005 01:00:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.11-rc3-mm1 bad scheduling while atomic + lockup
Message-Id: <20050208010024.7071e5f7.akpm@osdl.org>
In-Reply-To: <1865944987.20050207081532@dns.toxicfilms.tv>
References: <1865944987.20050207081532@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt2@dns.toxicfilms.tv> wrote:
>
> Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
>  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
>  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
>  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
>  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
>  Feb  6 17:07:47 dns kernel: scheduling while atomic: swapper/0x00010001/0
>  Feb  6 17:07:47 dns kernel:  [schedule+1379/1392] schedule+0x563/0x570
>  Feb  6 17:07:47 dns kernel:  [__call_console_drivers+87/96] __call_console_drivers+0x57/0x60
>  Feb  6 17:07:47 dns kernel:  [__mod_timer+350/480] __mod_timer+0x15e/0x1e0
>  Feb  6 17:07:47 dns kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
>  Feb  6 17:07:47 dns kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
>  Feb  6 17:07:47 dns kernel:  [ide_pin_hwgroup+97/208] ide_pin_hwgroup+0x61/0xd0
>  Feb  6 17:07:47 dns kernel:  [ide_set_xfer_rate+28/96] ide_set_xfer_rate+0x1c/0x60
>  Feb  6 17:07:47 dns kernel:  [check_dma_crc+72/112] check_dma_crc+0x48/0x70
>  Feb  6 17:07:47 dns kernel:  [do_reset1+99/544] do_reset1+0x63/0x220
>  Feb  6 17:07:47 dns kernel:  [ide_do_reset+23/32] ide_do_reset+0x17/0x20
>  Feb  6 17:07:47 dns kernel:  [ide_error+143/160] ide_error+0x8f/0xa0
>  Feb  6 17:07:47 dns kernel:  [ide_dma_intr+91/192] ide_dma_intr+0x5b/0xc0
>  Feb  6 17:07:47 dns kernel:  [ide_dma_intr+0/192] ide_dma_intr+0x0/0xc0
>  Feb  6 17:07:47 dns kernel:  [ide_intr+246/432] ide_intr+0xf6/0x1b0
>  Feb  6 17:07:47 dns kernel:  [handle_IRQ_event+48/112] handle_IRQ_event+0x30/0x70
>  Feb  6 17:07:47 dns kernel:  [__do_IRQ+230/352] __do_IRQ+0xe6/0x160
>  Feb  6 17:07:47 dns kernel:  [__do_softirq+120/144] __do_softirq+0x78/0x90
>  Feb  6 17:07:47 dns kernel:  [do_IRQ+35/64] do_IRQ+0x23/0x40
>  Feb  6 17:07:47 dns kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20

The bug is in serialize-access-to-ide-devices.patch, which is only in -mm.

	interrupt
	->IO error
	  ->ide_set_xfer_rate
	    ->ide_pin_hwgroup
	      ->schedule_timeout
	        ->axboe!
