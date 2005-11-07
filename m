Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVKGSxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVKGSxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVKGSxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:53:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964925AbVKGSxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:53:20 -0500
Date: Mon, 7 Nov 2005 10:52:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org, n@suse.de,
       Alan Stern <stern@rowland.harvard.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-Id: <20051107105257.333248c0.akpm@osdl.org>
In-Reply-To: <436F3020.1040209@reub.net>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F2452.9020207@reub.net>
	<20051107020905.69c0b6dc.akpm@osdl.org>
	<17263.11214.992300.34384@cse.unsw.edu.au>
	<20051107023723.5cf63393.akpm@osdl.org>
	<436F3020.1040209@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
>  Debug: sleeping function called from invalid context at include/asm/semaphore.h:99
>  in_atomic():1, irqs_disabled():1
>    [<c0103c46>] dump_stack+0x17/0x19
>    [<c011a173>] __might_sleep+0x9c/0xae
>    [<c028f82b>] scsi_disk_get_from_dev+0x15/0x48
>    [<c029006e>] sd_prepare_flush+0x17/0x5a
>    [<c027f8ff>] scsi_prepare_flush_fn+0x30/0x33
>    [<c0259da0>] blk_start_pre_flush+0xd5/0x13f
>    [<c025936b>] elv_next_request+0x113/0x170
>    [<c027fd45>] scsi_request_fn+0x4b/0x2fd
>    [<c025b393>] blk_run_queue+0x2b/0x3c
>    [<c027f0b3>] scsi_run_queue+0xa4/0xb6
>    [<c027f11f>] scsi_next_command+0x16/0x19
>    [<c027f1db>] scsi_end_request+0x93/0xc5
>    [<c027f494>] scsi_io_completion+0x141/0x46b
>    [<c02901e9>] sd_rw_intr+0x117/0x22b
>    [<c027ae5f>] scsi_finish_command+0x7f/0x93
>    [<c027ad43>] scsi_softirq+0xa8/0x11a
>    [<c0121eb8>] __do_softirq+0x88/0x141
>    [<c0104fd9>] do_softirq+0x77/0x81
>    =======================
>    [<c012205a>] irq_exit+0x48/0x4a
>    [<c0104e84>] do_IRQ+0x74/0xa7
>    [<c010374e>] common_interrupt+0x1a/0x20
>    [<f8918c04>] acpi_processor_idle+0x11f/0x2c7 [processor]
>    [<c0100d71>] cpu_idle+0x49/0xa0
>    [<c01002d7>] rest_init+0x37/0x39
>    [<c03fd8c5>] start_kernel+0x166/0x179
>    [<c0100210>] 0xc0100210

ah-hah, that's a different trace.

sd_issue_flush() has been altered to run scsi_disk_get_from_dev(), which
takes a semaphore.  It does this from within spinlock and, as we see here,
from within softirq.

Methinks the people who developed and tested that patch forgot to enable
CONFIG_PREEMPT, CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SLAB,
CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP.

