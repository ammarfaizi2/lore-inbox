Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVKGT1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVKGT1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVKGT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:27:31 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:9107 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965158AbVKGT1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:27:30 -0500
Date: Mon, 7 Nov 2005 14:27:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Reuben Farrelly <reuben-lkml@reub.net>, <neilb@suse.de>,
       <linux-kernel@vger.kernel.org>, <n@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.14-mm1
In-Reply-To: <20051107105257.333248c0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0511071421540.5078-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Andrew Morton wrote:

> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> >  Debug: sleeping function called from invalid context at include/asm/semaphore.h:99
> >  in_atomic():1, irqs_disabled():1
> >    [<c0103c46>] dump_stack+0x17/0x19
> >    [<c011a173>] __might_sleep+0x9c/0xae
> >    [<c028f82b>] scsi_disk_get_from_dev+0x15/0x48
> >    [<c029006e>] sd_prepare_flush+0x17/0x5a
> >    [<c027f8ff>] scsi_prepare_flush_fn+0x30/0x33
> >    [<c0259da0>] blk_start_pre_flush+0xd5/0x13f
> >    [<c025936b>] elv_next_request+0x113/0x170
> >    [<c027fd45>] scsi_request_fn+0x4b/0x2fd
> >    [<c025b393>] blk_run_queue+0x2b/0x3c
> >    [<c027f0b3>] scsi_run_queue+0xa4/0xb6
> >    [<c027f11f>] scsi_next_command+0x16/0x19
> >    [<c027f1db>] scsi_end_request+0x93/0xc5
> >    [<c027f494>] scsi_io_completion+0x141/0x46b
> >    [<c02901e9>] sd_rw_intr+0x117/0x22b
> >    [<c027ae5f>] scsi_finish_command+0x7f/0x93
> >    [<c027ad43>] scsi_softirq+0xa8/0x11a
> >    [<c0121eb8>] __do_softirq+0x88/0x141
> >    [<c0104fd9>] do_softirq+0x77/0x81
> >    =======================
> >    [<c012205a>] irq_exit+0x48/0x4a
> >    [<c0104e84>] do_IRQ+0x74/0xa7
> >    [<c010374e>] common_interrupt+0x1a/0x20
> >    [<f8918c04>] acpi_processor_idle+0x11f/0x2c7 [processor]
> >    [<c0100d71>] cpu_idle+0x49/0xa0
> >    [<c01002d7>] rest_init+0x37/0x39
> >    [<c03fd8c5>] start_kernel+0x166/0x179
> >    [<c0100210>] 0xc0100210
> 
> ah-hah, that's a different trace.
> 
> sd_issue_flush() has been altered to run scsi_disk_get_from_dev(), which
> takes a semaphore.  It does this from within spinlock and, as we see here,
> from within softirq.
> 
> Methinks the people who developed and tested that patch forgot to enable
> CONFIG_PREEMPT, CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SLAB,
> CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP.

No, believe it or not, all those items are enabled in my .config.  What I
didn't do was test the patch with anything that would force a call to
sd_prepare_flush.  In fact, I'm not sure how to do such a thing.

I don't know how this should be fixed.  James will have to come up with 
something.

Alan Stern

