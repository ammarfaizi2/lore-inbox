Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTGKViP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTGKViP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:38:15 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:26030 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264067AbTGKViN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:38:13 -0400
Date: Fri, 11 Jul 2003 23:52:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
Subject: Re: [2.5.75] S3 and S4
Message-ID: <20030711215240.GA335@elf.ucw.cz>
References: <20030711193611.GA824@dreamland.darkstar.lan> <20030711200053.GA402@elf.ucw.cz> <20030711134833.1adeceb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711134833.1adeceb1.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Suspending devices
> > > Badness in local_bh_enable at kernel/softirq.c:113
> > > Call Trace:
> > >  [<c0130078>] local_bh_enable+0x88/0x90
> > >  [<f0a44fa4>] e100_do_wol+0x14/0x60 [e100]
> > >  [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
> > >  [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
> > >  [<c0212577>] pci_device_suspend+0x47/0x70
> > >  [<c029bc99>] device_suspend+0xd9/0x100
> > >  [<c023e047>] acpi_system_save_state+0x42/0x8c
> > >  [<c023e153>] acpi_suspend+0x5e/0xb3
> > >  [<c023e394>] acpi_system_write_sleep+0xe3/0x132
> > >  [<c0177de0>] filp_open+0x60/0x70
> > >  [<c017952d>] vfs_write+0xad/0x120
> > >  [<c017963f>] sys_write+0x3f/0x60
> > >  [<c010b10f>] syscall_call+0x7/0xb
> > > 
> > 
> > If e100. You have the hardware...
> 
> No, it's acpi_system_save_state() illegally calling device_suspend() under
> local_irq_disable().

Oops, I failed to see this is S3.

I can see that device_suspend( ..., SUSPEND_POWER_DOWN) is called with
interrupts disabled. But thats okay: (driver.txt) All calls are made
with interrupts enabled, except for the SUSPEND_POWER_DOWN level.

I fail to see a bug in ACPI code.

> > > S4  suspends fine,  but  it seems  that it  doesn't  like preemption  on
> > > resume:
> > > 
> > > ......[lots of dots]......[nosave c041c000]Enabling SEP on CPU 0
> > > Freeing prev allocated pagedir
> > > bad: scheduling while atomic!
> > > Call Trace:
> > >  [<c012419e>] schedule+0x6ce/0x6e0
> > >  [<c02ded7b>] pci_read+0x3b/0x40
> > >  [<c01358e8>] schedule_timeout+0x88/0xe0
> > >  [<c02dedbc>] pci_write+0x3c/0x40
> > >  [<c0135850>] process_timeout+0x0/0x10
> > >  [<c020f9e4>] pci_set_power_state+0xe4/0x190
> > >  [<f0a46278>] e100_resume+0x28/0x70 [e100]
> > >  [<c02125cd>] pci_device_resume+0x2d/0x30
> > >  [<c029bd76>] device_resume+0xb6/0xd0
> > >  [<c014e60c>] drivers_resume+0x8c/0xa0
> > >  [<c014ea15>] do_magic_resume_2+0xc5/0x170
> > >  [<c011d410>] restore_processor_state+0x70/0x90
> > >  [<c011ff5f>] do_magic+0x11f/0x140
> > >  [<c014ef1d>] do_software_suspend+0x6d/0xa0
> > >  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
> > >  [<c0177de0>] filp_open+0x60/0x70
> > >  [<c017952d>] vfs_write+0xad/0x120
> > >  [<c017963f>] sys_write+0x3f/0x60
> > >  [<c010b10f>] syscall_call+0x7/0xb
> > 
> > That's e100 driver, again. Fix it.
> 
> No, e100_resume() looks OK to me.  Something seems to have corrupted
> preempt_count().

I have no idea what is wrong. It works for me...

> This will have the same cause as the earlier "scheduling while atomic"
> problem.

Yep, and I can't reproduce that :-(.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
