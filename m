Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTFDOQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTFDOQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:16:12 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:55795 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263309AbTFDOQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:16:10 -0400
Subject: Re: IDE Power Management (Was: software suspend in 2.5.70-mm3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: hugang <hugang@soulinfo.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306042210.12468.mflt1@micrologica.com.hk>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	 <1054732481.20839.30.camel@gaston>
	 <200306042151.10611.mflt1@micrologica.com.hk>
	 <200306042210.12468.mflt1@micrologica.com.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054736960.20838.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Jun 2003 16:29:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hda: start_power_step(susp: 1, step: 0)
> hda: start_power_step(susp: 1, step: 1)
> hda: start_power_step(susp: 1, step: 2)
> hda: complete_power_step(susp: 1, step: 2, stat: 50, err: 0)
> hda: completing PM request, suspend: 1
> Suspending devices
> /critical section: Counting pages to copy[nosave c03f7000] (pages needed: 2273+512=2785 free: 14110)
> Alloc pagedir
> ............ 
> [nosave c03f7000]critical section/: done (2273 pages copied)
> hda: Wakeup request inited, waiting for !BSY...
> hda: start_power_step(susp: 0, step: 0)
> hda: start_power_step(susp: 0, step: 101)
> hda: completing PM request, suspend: 0
> Devices Resumed
> Devices Resumed

Hrm... the joy if swsusp putting your disk to sleep just to wake it up
right away... I need to check if I can differenciate suspend-to-disk
from suspend-to-ram here to just not put the drive in STANDBY mode
on suspend-to-disk (just freeze the queues)

> Writing data to swap (2273 pages): .<3>bad: scheduling while atomic!

Here's the real one. However, it doesn't look related to my sleep code,
though I cannot guarantee this for sure right now, it _seems_ it's
a swsusp bug you are hitting.

> Call Trace:
>  [<c011d958>] schedule+0x40/0x388
>  [<c011eb02>] io_schedule+0xe/0x18
>  [<c01384d5>] wait_on_page_bit_wq+0xc9/0xe4
>  [<c011f320>] autoremove_wake_function+0x0/0x3c
>  [<c011f320>] autoremove_wake_function+0x0/0x3c
>  [<c01384fa>] wait_on_page_bit+0xa/0x10
>  [<c014cc34>] rw_swap_page_sync+0x98/0xc6
>  [<c0136afd>] write_suspend_image+0xf1/0x324
>  [<c0246bdf>] device_resume+0x7f/0x88
>  [<c01370e1>] drivers_unsuspend+0x11/0x18
>  [<c013735e>] suspend_save_image+0x12/0x1c
>  [<c013753f>] do_magic_suspend_2+0x17/0xa8
>  [<c011ba9d>] do_magic+0x4d/0x130
>  [<c013763b>] do_software_suspend+0x6b/0x90
>  [<c0137695>] software_suspend+0x35/0x3c
>  [<c012ba97>] sys_reboot+0x2df/0x36c
>  [<c0143830>] unmap_page_range+0x38/0x5c
>  [<c0143959>] unmap_vmas+0x105/0x208
>  [<c01656e4>] dput+0x1c/0x204
>  [<c01656e4>] dput+0x1c/0x204
>  [<c015d367>] path_release+0xf/0x30
>  [<c014fe69>] sys_chdir+0x5d/0x68
>  [<c010af17>] syscall_call+0x7/0xb

