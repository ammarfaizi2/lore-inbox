Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVBHJhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVBHJhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVBHJhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:37:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6529 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261495AbVBHJhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:37:22 -0500
Date: Tue, 8 Feb 2005 10:37:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 bad scheduling while atomic + lockup
Message-ID: <20050208093713.GC15985@suse.de>
References: <1865944987.20050207081532@dns.toxicfilms.tv> <20050208010024.7071e5f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208010024.7071e5f7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08 2005, Andrew Morton wrote:
> Maciej Soltysiak <solt2@dns.toxicfilms.tv> wrote:
> >
> > Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >  Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >  Feb  6 17:07:47 dns kernel: ide: failed opcode was: unknown
> >  Feb  6 17:07:47 dns kernel: scheduling while atomic: swapper/0x00010001/0
> >  Feb  6 17:07:47 dns kernel:  [schedule+1379/1392] schedule+0x563/0x570
> >  Feb  6 17:07:47 dns kernel:  [__call_console_drivers+87/96] __call_console_drivers+0x57/0x60
> >  Feb  6 17:07:47 dns kernel:  [__mod_timer+350/480] __mod_timer+0x15e/0x1e0
> >  Feb  6 17:07:47 dns kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
> >  Feb  6 17:07:47 dns kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
> >  Feb  6 17:07:47 dns kernel:  [ide_pin_hwgroup+97/208] ide_pin_hwgroup+0x61/0xd0
> >  Feb  6 17:07:47 dns kernel:  [ide_set_xfer_rate+28/96] ide_set_xfer_rate+0x1c/0x60
> >  Feb  6 17:07:47 dns kernel:  [check_dma_crc+72/112] check_dma_crc+0x48/0x70
> >  Feb  6 17:07:47 dns kernel:  [do_reset1+99/544] do_reset1+0x63/0x220
> >  Feb  6 17:07:47 dns kernel:  [ide_do_reset+23/32] ide_do_reset+0x17/0x20
> >  Feb  6 17:07:47 dns kernel:  [ide_error+143/160] ide_error+0x8f/0xa0
> >  Feb  6 17:07:47 dns kernel:  [ide_dma_intr+91/192] ide_dma_intr+0x5b/0xc0
> >  Feb  6 17:07:47 dns kernel:  [ide_dma_intr+0/192] ide_dma_intr+0x0/0xc0
> >  Feb  6 17:07:47 dns kernel:  [ide_intr+246/432] ide_intr+0xf6/0x1b0
> >  Feb  6 17:07:47 dns kernel:  [handle_IRQ_event+48/112] handle_IRQ_event+0x30/0x70
> >  Feb  6 17:07:47 dns kernel:  [__do_IRQ+230/352] __do_IRQ+0xe6/0x160
> >  Feb  6 17:07:47 dns kernel:  [__do_softirq+120/144] __do_softirq+0x78/0x90
> >  Feb  6 17:07:47 dns kernel:  [do_IRQ+35/64] do_IRQ+0x23/0x40
> >  Feb  6 17:07:47 dns kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
> 
> The bug is in serialize-access-to-ide-devices.patch, which is only in -mm.
> 
> 	interrupt
> 	->IO error
> 	  ->ide_set_xfer_rate
> 	    ->ide_pin_hwgroup
> 	      ->schedule_timeout
> 	        ->axboe!

:-)

The thing wants a rewrite. Ideally the serializing point would be a
special request. The patch is still better than nothing right now, it's
really easy to hang the device with hdparm in -linus since it's
impossible to guess when it is safe to issue tuning actions from user
space.

-- 
Jens Axboe

