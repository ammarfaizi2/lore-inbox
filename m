Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263165AbUKTTsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUKTTsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUKTTsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:48:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9692 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263165AbUKTTse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:48:34 -0500
Date: Sat, 20 Nov 2004 20:47:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041120194756.GU26240@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411201842.15091.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20 2004, Alan Chandler wrote:
> I have been trying to track down why all attempts to burn a cd on my
> ide cdrw fails (see bug #3741 on bugzilla ), with a subprocess of
> cdrecord ending up hanging in uninterruptable sleep state.
> 
> I think I understand what is happening, I just don't know what to do
> about it.
> 
> Inside drivers/ide/ide-cd.c
> 
> the ide_do_rw_cdrom routine has been called via a request with the
> request flags having the REQ_BLOCK_PC flag set.  The request->data_len
> of this request is set to 0.
> 
> This request is sent to the device and it generates interrupts to
> eventually land it up inside the routine cdrom_newpc_intr.
> 
> At this point the status register on the hardware is set to 0x58 -
> implying, I think that the DRQ_STAT bit is set and that something
> should be sent to the device.
> 
> Normally, because the requested data_len is not zero, the data is
> sent.  In this case however, because the original request had nothing
> to send, the while/if clauses to initiate a new transfer are skipped
> and the routine ends up setting a new interrupt handler address and
> returning to await an interrupt that will never come.

The big question is - what does the original command look like? Just
dumping rq->cmd[0] would be a big help, but really just put code in
sg_io() in block/scsi_ioctl.c to dump the completed sg_io_hdr_t and send
that.

> Question: should something validate that the request length is not
> zero earlier, or should there be a check in ide-cd.c, or is it my
> hardware (its a generic cd read/rewriter which announces itself as
> 'CW078D CD-R/RW')

It's hard to know, you would have to parse every command type to verify
if the dxfer_len made sense or not. It's perfectly possible to generate
a command that would hang the drive as you describe above, only to be
aborted after it times out.

-- 
Jens Axboe

