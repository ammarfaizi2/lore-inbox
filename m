Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVKGKox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVKGKox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVKGKox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:44:53 -0500
Received: from tornado.reub.net ([202.89.145.182]:34763 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751312AbVKGKow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:44:52 -0500
Message-ID: <436F3020.1040209@reub.net>
Date: Mon, 07 Nov 2005 23:44:48 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051106)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org, n@suse.de
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>	<436F2452.9020207@reub.net>	<20051107020905.69c0b6dc.akpm@osdl.org>	<17263.11214.992300.34384@cse.unsw.edu.au> <20051107023723.5cf63393.akpm@osdl.org>
In-Reply-To: <20051107023723.5cf63393.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2005 11:37 p.m., Andrew Morton wrote:
> Neil Brown <neilb@suse.de> wrote:
>> On Monday November 7, akpm@osdl.org wrote:
>>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>>> Hi again,
>>>>
>>>> On 7/11/2005 3:24 p.m., Andrew Morton wrote:
>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
>>>>>
>>>>> - Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch
>>>>>
>>>>> - Re-added rmk's driver-model tree git-drvmodel.patch
>>>>>
>>>>> - Added davem's sparc64 tree, as git-sparc64.patch
>>>>>
>>>>> - v4l updates
>>>>>
>>>>> - dvb updates
>>>> Just rebooted into 2.6.14-mm1 and now every few seconds I get this spewed up 
>>>> on the console:
>>>>
>>>> Nov  7 22:49:47 tornado kernel: Debug: sleeping function called from invalid 
>>>> context at include/asm/semaphore.h:99
>>>> Nov  7 22:49:47 tornado kernel: in_atomic():0, irqs_disabled():1
>>>> Nov  7 22:49:47 tornado kernel:  [<c0103a50>] dump_stack+0x17/0x19
>>>> Nov  7 22:49:47 tornado kernel:  [<c011971b>] __might_sleep+0x9d/0xad
>>>> Nov  7 22:49:47 tornado kernel:  [<c028aa4b>] scsi_disk_get_from_dev+0x15/0x48
>>>> Nov  7 22:49:47 tornado kernel:  [<c028b28e>] sd_prepare_flush+0x17/0x5a
>>>> Nov  7 22:49:47 tornado kernel:  [<c027abff>] scsi_prepare_flush_fn+0x30/0x33
>>>> Nov  7 22:49:47 tornado kernel:  [<c0255332>] blk_start_pre_flush+0xd5/0x13f
>>>> Nov  7 22:49:47 tornado kernel:  [<c025490b>] elv_next_request+0x112/0x16f
>>>> Nov  7 22:49:47 tornado kernel:  [<c027b045>] scsi_request_fn+0x4b/0x2fd
>>>> Nov  7 22:49:47 tornado kernel:  [<c0254748>] __elv_add_request+0x109/0x176
>>>> Nov  7 22:49:47 tornado kernel:  [<c0257ab4>] __make_request+0x1d0/0x474
>>>> Nov  7 22:49:47 tornado kernel:  [<c0257e96>] generic_make_request+0xb3/0x128
>> ....
>>>> The box has raid-1 and I'm guessing that that may be the culprit here... ?
>>>>
>>> It's not immediately obvious.  Could you enable CONFIG_DEBUG_PREEMPT? 
>>> That'll tell us where the thread went into atomic mode.
>> Quick code inspection:
>>  ll_rw_blk.c:2693 __make_request calls spin_lock_irq - goes atomic
>>    line 2793, calls add_request()
>>       This is before the spin_unlock_irq on line 2798
>>    line 2438, add_request calls __elv_add_request 
>>  and the rest you can get from the stack trace until
>>   scsi_disk_get_from_dev in sd.c calls 
>>     down(&sd_ref_sem);
>>  which causes the message.
>>
>> Note raid-1 at all :-)  (this time).
>>
> 
> Possibly.  But scsi like to undo host->lock in the strangest places.
> 
> Would still like that CONFIG_DEBUG_PREEMPT trace, please.

Sure.

Debug: sleeping function called from invalid context at include/asm/semaphore.h:99
in_atomic():1, irqs_disabled():1
  [<c0103c46>] dump_stack+0x17/0x19
  [<c011a173>] __might_sleep+0x9c/0xae
  [<c028f82b>] scsi_disk_get_from_dev+0x15/0x48
  [<c029006e>] sd_prepare_flush+0x17/0x5a
  [<c027f8ff>] scsi_prepare_flush_fn+0x30/0x33
  [<c0259da0>] blk_start_pre_flush+0xd5/0x13f
  [<c025936b>] elv_next_request+0x113/0x170
  [<c027fd45>] scsi_request_fn+0x4b/0x2fd
  [<c025b393>] blk_run_queue+0x2b/0x3c
  [<c027f0b3>] scsi_run_queue+0xa4/0xb6
  [<c027f11f>] scsi_next_command+0x16/0x19
  [<c027f1db>] scsi_end_request+0x93/0xc5
  [<c027f494>] scsi_io_completion+0x141/0x46b
  [<c02901e9>] sd_rw_intr+0x117/0x22b
  [<c027ae5f>] scsi_finish_command+0x7f/0x93
  [<c027ad43>] scsi_softirq+0xa8/0x11a
  [<c0121eb8>] __do_softirq+0x88/0x141
  [<c0104fd9>] do_softirq+0x77/0x81
  =======================
  [<c012205a>] irq_exit+0x48/0x4a
  [<c0104e84>] do_IRQ+0x74/0xa7
  [<c010374e>] common_interrupt+0x1a/0x20
  [<f8918c04>] acpi_processor_idle+0x11f/0x2c7 [processor]
  [<c0100d71>] cpu_idle+0x49/0xa0
  [<c01002d7>] rest_init+0x37/0x39
  [<c03fd8c5>] start_kernel+0x166/0x179
  [<c0100210>] 0xc0100210
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c0100dc6>] .... cpu_idle+0x9e/0xa0
.....[<c01002d7>] ..   ( <= rest_init+0x37/0x39)
.. [<c031e25d>] .... _spin_lock+0x10/0x6a
.....[<c013a62a>] ..   ( <= __do_IRQ+0x97/0xed)

reuben
