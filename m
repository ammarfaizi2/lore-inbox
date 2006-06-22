Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932787AbWFVE3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWFVE3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbWFVE3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:29:05 -0400
Received: from mga03.intel.com ([143.182.124.21]:48647 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932787AbWFVE3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:29:03 -0400
X-IronPort-AV: i="4.06,164,1149490800"; 
   d="scan'208"; a="55717734:sNHT20673576"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-mm1 - possible recursive locking detected
Date: Thu, 22 Jun 2006 00:28:56 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6CF0CF1@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm1 - possible recursive locking detected
Thread-Index: AcaVKyDeQkGbGgF/QZSevD39TPJFZwAgHCRw
From: "Brown, Len" <len.brown@intel.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Arjan van de Ven" <arjan@linux.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>
X-OriginalArrivalTime: 22 Jun 2006 04:29:00.0729 (UTC) FILETIME=[62960A90:01C695B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It looks like an ACPI problem.

Thanks for the note, and the .config, I reproduced it here.

CONFIG_LOCKDEP complains about this sequence:

...
	<presumed previous acquire/release acpi_gbl_hardware_lock>
...
acpi_ev_gpe_detect()
	spin_lock_irqsave(acpi_gbl_gpe_lock,)

	spin_lock_irqsave(acpi_gbl_hardware_lock,) <stack trace is on
this acquire>
	spin_lock_irqrestore(acpi_gbl_hardware_lock,)

	...

	spin_lock_irqrestore(acpi_gbl_gpe_lock)

It complains about this only the 1st time, even though
this same code sequence runs for every (subsequent) ACPI interrupt.

The intent of the arrangement is that acpi_gbl_hardware_lock is for very
small critical sections around RMW hardware register access.
It can be acquired with or without other locks held, but
nothing else is acquired when it is held.

Nothing jumps out at me as incorrect above, so 
at this point it looks like a CONFIG_LOCKDEP artifact --
but lets ask the experts:-)

-Len


>Setting up standard PCI resources
>=============================================
>[ INFO: possible recursive locking detected ]
>---------------------------------------------
>idle/1 is trying to acquire lock:
> (lock_ptr){....}, at: [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa
>
>but task is already holding lock:
> (lock_ptr){....}, at: [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa
>
>other info that might help us debug this:
>1 lock held by idle/1:
> #0:  (lock_ptr){....}, at: [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa
>
>stack backtrace:
> [<c0103e89>] show_trace+0xd/0x10
> [<c0104483>] dump_stack+0x19/0x1b
> [<c01395fa>] __lock_acquire+0x7d9/0xa50
> [<c0139a98>] lock_acquire+0x71/0x91
> [<c02f0beb>] _spin_lock_irqsave+0x2c/0x3c
> [<c021cbd2>] acpi_os_acquire_lock+0x8/0xa
> [<c0222d95>] acpi_ev_gpe_detect+0x4d/0x10e
> [<c02215c3>] acpi_ev_sci_xrupt_handler+0x15/0x1d
> [<c021c8b1>] acpi_irq+0xe/0x18
> [<c014d36e>] request_irq+0xbe/0x10c
> [<c021cf33>] acpi_os_install_interrupt_handler+0x59/0x87
> [<c02215e7>] acpi_ev_install_sci_handler+0x1c/0x21
> [<c0220d41>] acpi_ev_install_xrupt_handlers+0x9/0x50
> [<c0231772>] acpi_enable_subsystem+0x7d/0x9a
> [<c0416656>] acpi_init+0x3f/0x170
> [<c01003ae>] _stext+0x116/0x26c
> [<c0101005>] kernel_thread_helper+0x5/0xb
>ACPI: Interpreter enabled
>
>Here is a dmesg log 
>http://www.stardust.webpages.pl/files/mm/2.6.17-mm1/mm-dmesg
>Here is a config file
>http://www.stardust.webpages.pl/files/mm/2.6.17-mm1/mm-config
>
>Regards,
>Michal
>
>-- 
>Michal K. K. Piotrowski
>LTG - Linux Testers Group
>(http://www.stardust.webpages.pl/ltg/wiki/)
>
