Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUKUKZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUKUKZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKUKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:25:30 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:16378
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261413AbUKUKZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:25:13 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Sun, 21 Nov 2004 10:25:11 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411210053.45065.alan@chandlerfamily.org.uk> <20041121085636.GG26240@suse.de>
In-Reply-To: <20041121085636.GG26240@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411211025.11629.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 08:56, Jens Axboe wrote:
> On Sun, Nov 21 2004, Alan Chandler wrote:
...
> > Nov 21 00:44:20 kanger kernel: sg_io command length 6
> > Nov 21 00:44:20 kanger kernel: sg_io command [0] = 0x1b
> > Nov 21 00:44:20 kanger kernel: sg_io command [1] = 0x0
> > Nov 21 00:44:20 kanger kernel: sg_io command [2] = 0x0
> > Nov 21 00:44:20 kanger kernel: sg_io command [3] = 0x0
> > Nov 21 00:44:20 kanger kernel: sg_io command [4] = 0x3
> > Nov 21 00:44:20 kanger kernel: sg_io command [5] = 0x0
> > Nov 21 00:44:20 kanger kernel: sg_io dxfer_len = 0
> > Nov 21 00:45:00 kanger kernel: hdc: lost interrupt
> > Nov 21 00:45:40 kanger kernel: hdc: lost interrupt
> > Nov 21 00:47:00 kanger last message repeated 2 times
> > Nov 21 00:47:40 kanger kernel: hdc: lost interrupt
>
> So the last request is a START_STOP unit, which doesn't transfer any
> data. If the drive has DRQ_STAT stat set here, it looks very odd. Any
> chance you could instrument cdrom_newpc_intr() as well to dump status
> bytes and expected transfer lengths from the drive?

As below - note I have also got a printk in cdrom_timer_expiry () - but 
nothing there.  I have included a couple of commands before the key one, and 
also a few 'lost interrupt' calls after the lock to show how it then doesn't 
recover. (and I made a spelling error in one of the messages the message - 
seld should mean self).

Nov 21 10:13:44 kanger kernel: scsi_cmd_ioctl - cmd = 0x2285
Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io cmd [0] = 0x3c
Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io dxfer_len = 64512
Nov 21 10:13:44 kanger kernel: scsi_ioctl: about to execute cmd 0x3c
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_do_block_pc
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_start_packet_command - xferlen = 
64512 - dma = 1
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (before decode status) 
- dma = 1 dma_error = 0x0
Nov 21 10:13:44 kanger kernel: scsi_ioctl: completed command with status 0x0
Nov 21 10:13:44 kanger kernel: scsi_cmd_ioctl - cmd = 0x2285
Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io cmd [0] = 0x3c
Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io dxfer_len = 64512
Nov 21 10:13:44 kanger kernel: scsi_ioctl: about to execute cmd 0x3c
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_do_block_pc
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_start_packet_command - xferlen = 
64512 - dma = 1
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (before decode status) 
- dma = 1 dma_error = 0x0
Nov 21 10:13:44 kanger kernel: scsi_ioctl: completed command with status 0x0
Nov 21 10:13:44 kanger kernel: scsi_cmd_ioctl - cmd = 0x2285
Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io cmd [0] = 0x0
Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io dxfer_len = 0
Nov 21 10:13:44 kanger kernel: scsi_ioctl: about to execute cmd 0x0
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_do_block_pc
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_start_packet_command - xferlen = 0 
- dma = 0
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (before decode status) 
- dma = 0 dma_error = 0x0
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (in pio after reading 
registers) ireason = 2 len = 0 stat = 0x58
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (DRQ not clear) - rq 
cmd[0] = 0x0 rq len = 0
Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (about to call 
ide_set_handler with seld as rentry) timeout = 40000
Nov 21 10:14:24 kanger kernel: hdc: lost interrupt
Nov 21 10:14:24 kanger kernel: ide-cd:cdrom_newpc_intr (before decode status) 
- dma = 0 dma_error = 0x0
Nov 21 10:14:24 kanger kernel: ide-cd:cdrom_newpc_intr (in pio after reading 
registers) ireason = 2 len = 0 stat = 0x58
Nov 21 10:14:24 kanger kernel: ide-cd:cdrom_newpc_intr (DRQ not clear) - rq 
cmd[0] = 0x0 rq len = 0
Nov 21 10:14:24 kanger kernel: ide-cd:cdrom_newpc_intr (about to call 
ide_set_handler with seld as rentry) timeout = 40000
Nov 21 10:15:04 kanger kernel: hdc: lost interrupt
Nov 21 10:15:04 kanger kernel: ide-cd:cdrom_newpc_intr (before decode status) 
- dma = 0 dma_error = 0x0
Nov 21 10:15:04 kanger kernel: ide-cd:cdrom_newpc_intr (in pio after reading 
registers) ireason = 2 len = 0 stat = 0x58
Nov 21 10:15:04 kanger kernel: ide-cd:cdrom_newpc_intr (DRQ not clear) - rq 
cmd[0] = 0x0 rq len = 0
Nov 21 10:15:04 kanger kernel: ide-cd:cdrom_newpc_intr (about to call 
ide_set_handler with seld as rentry) timeout = 40000



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
