Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbTBKRhe>; Tue, 11 Feb 2003 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTBKRgM>; Tue, 11 Feb 2003 12:36:12 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:182 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267366AbTBKRf5>;
	Tue, 11 Feb 2003 12:35:57 -0500
Message-ID: <3E4936BF.3050809@colorfullife.com>
Date: Tue, 11 Feb 2003 18:45:35 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Zephaniah E. Hull" <warp@mercury.d2dc.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-eata@i-connect.net
Subject: eata irq abuse (was: Re: Linux 2.5.60)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zephaniah wrote:

>kernel BUG at mm/slab.c:1102!

Slab notices that a function that expects enabled local interrupts is called with disabled local interrupts.


>Call Trace:
> [<c014a3b3>] do_tune_cpucache+0x83/0x240

do_tune_cpucache:
the function call smp_call_function(), and that is only permitted with enabled local interrupts. The complain is correct.


> [<c014a300>] do_ccpupdate_local+0x0/0x30
> [<c014a5c1>] enable_cpucache+0x51/0x80
> [<c0148ea5>] kmem_cache_create+0x4a5/0x560

Within kmem_cache_create. kmem_cache_create checks for in_interrupt(), thus someone probably does

	spin_lock_irqsave();
	kmem_cache_create();


> [<c0285dd2>] scsi_setup_command_freelist+0xa2/0x130

calls kmem_cache_create()

> [<c02887e0>] scsi_register+0x3c0/0x660

calls scsi_setup_command_freelist


> [<c02919a1>] get_pci_dev+0x31/0x50

?? probably stale

> [<c0291df2>] port_detect+0x3c2/0xe50

Do you have an eata scsi controller?

Ugs.
eata2x_detect():
* spin_lock_irqsave();
* calls port_detect();
* * spin_unlock();
* * scsi_register.

Eata maintainers: Is that necessary?
Why do the interrupts remain disabled across scsi_register?
Is that a bug workaround, or an oversight?
I'd use

	spin_unlock_irq();
	scsi_register();
	spin_lock_irq();

--
	Manfred


